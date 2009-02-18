From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] disallow providing multiple upstream branches to rebase, 
	pull --rebase
Date: Wed, 18 Feb 2009 08:32:43 -0500
Message-ID: <76718490902180532l1de135ccyd4e58c713e6af2c@mail.gmail.com>
References: <1234932262-63469-1-git-send-email-jaysoffian@gmail.com>
	 <alpine.DEB.1.00.0902181118160.6274@intel-tinevez-2-302>
	 <76718490902180523l6df2067bxc1274a105756d16b@mail.gmail.com>
	 <alpine.DEB.1.00.0902181427030.6274@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 18 14:34:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZmZ3-0004sx-Gm
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 14:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbZBRNcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 08:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbZBRNcp
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 08:32:45 -0500
Received: from rv-out-0506.google.com ([209.85.198.226]:55693 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbZBRNco (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 08:32:44 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2520387rvb.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 05:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6B6rmVmRzr9/TcYL54j6fn/oHiLAwkf4zl3H1SR7/6Y=;
        b=tTTgokE+MLrBbhdWl9hJMVxADQE8KQ34Siv/vD4Obq+hBIWGxKFFaCU4qDx+571wWG
         BBaaIgksdG0RbvRgPqxWbPh2sjzB83Slgbk9D6ch2/LpxQ6Z6cAfI4l38Un8opPYj+yp
         jygItePm2imotuRMZRsnafQOd/GcfKZaVgDAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=akjeeUZhjHEK38B/vRqJrHDNAZikFV2i09qEcu10UrDW5lXyyXYSXIchzUxV8O3ae7
         lXfLgtmcerZlXBHc9MXoHth9kX/SAGX+NT4y4zCyyU4i/0VS1hlBuRfOX1oqMCOqCC/W
         UnCF38/M1RgN93dydqSxeUqnj7eNfaiRUH9MI=
Received: by 10.141.114.15 with SMTP id r15mr3971900rvm.42.1234963963747; Wed, 
	18 Feb 2009 05:32:43 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902181427030.6274@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110537>

On Wed, Feb 18, 2009 at 8:28 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> if test -z "$rebase_root"
>> then
>>       # The upstream head must be given.  Make sure it is valid.
>>       upstream_name="$1"
>>       shift
>>       upstream=`git rev-parse --verify "${upstream_name}^0"` ||
>>       die "invalid upstream $upstream_name"
>>       unset root_flag
>>       upstream_arg="$upstream_name"
>> else
>>       test -z "$newbase" && die "--root must be used with --onto"
>>       unset upstream_name
>>       unset upstream
>>       root_flag="--root"
>>       upstream_arg="$root_flag"
>> fi
>>
>> will do the trick, yes?
>
> Nope.  Note the "shift" in the first arm?  It is so that the code below
> can check for $#, and it indeed does, in a 'case' statement.

The case statement checks $# against 1 and *, not 1 and 0. And I don't
see how > 1 is valid at that point. So I can modify the case statement
to check against 1, 0, and have * emit usage, or I think moving the
"test $# -gt 1 && usage" to where I suggested in the last message
would do the trick. The only difference would be whether a pre-rebase
hook runs in the case of invalid arguments (the case statement is
after that hook runs).

j.

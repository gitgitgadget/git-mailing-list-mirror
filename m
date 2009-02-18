From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] disallow providing multiple upstream branches to rebase, 
	pull --rebase
Date: Wed, 18 Feb 2009 08:23:15 -0500
Message-ID: <76718490902180523l6df2067bxc1274a105756d16b@mail.gmail.com>
References: <1234932262-63469-1-git-send-email-jaysoffian@gmail.com>
	 <alpine.DEB.1.00.0902181118160.6274@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 18 14:24:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZmPs-00016G-6o
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 14:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbZBRNXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 08:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbZBRNXQ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 08:23:16 -0500
Received: from rv-out-0506.google.com ([209.85.198.237]:55719 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbZBRNXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 08:23:16 -0500
Received: by rv-out-0506.google.com with SMTP id g9so2024963rvb.5
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 05:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JIVk0zka0ZQ8E5Sof3JB0EXyY2owd8iCaE66fBXl8oE=;
        b=Jh57YOKjgiMSmjXKu3y5tUqjCb4GWf8O43d9WbwDsOAVuA26c0RJ18anmNHYOlgChZ
         qMIAwFrDkbmpoKA3fxgZDU5JSYdAPxLjNQTLs4bCZw/8tlJMTRpcn4vShlWoLYwh/n2y
         0dpCD2x9P5cIGYgF8EjONjfNy7keHqtVNhTYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=R8e+RSWPZ/M6ujEF95kXnmxC4oS61NF4yzlDFafltQQzuVSuBeva2FqY5fCnIVBUYB
         q4yWw8FEKji4rMNJatlEFhJyPkg0e9NiRK2hUhN3IQly7vp19al7r8RZ4dbFKKx9Jrtv
         hta3dqdOCrWfAsv19hIBYpqdddb4blbskCQxk=
Received: by 10.141.97.5 with SMTP id z5mr4101rvl.212.1234963395492; Wed, 18 
	Feb 2009 05:23:15 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902181118160.6274@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110533>

On Wed, Feb 18, 2009 at 5:18 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> diff --git a/git-rebase.sh b/git-rebase.sh
>> index 5d9a393..ffb6027 100755
>> --- a/git-rebase.sh
>> +++ b/git-rebase.sh
>> @@ -319,6 +319,7 @@ do
>>       esac
>>       shift
>>  done
>> +test $# -gt 1 && usage
>
> Did you just break
>
>        $ git rebase $UPSTREAM $BRANCH_TO_SWITCH_TO

Crap, I missed that usage somehow (and I guess the test suite doesn't
rely on it either...). I think moving the "test $# -gt 1 && usage"
below:

if test -z "$rebase_root"
then
	# The upstream head must be given.  Make sure it is valid.
	upstream_name="$1"
	shift
	upstream=`git rev-parse --verify "${upstream_name}^0"` ||
	die "invalid upstream $upstream_name"
	unset root_flag
	upstream_arg="$upstream_name"
else
	test -z "$newbase" && die "--root must be used with --onto"
	unset upstream_name
	unset upstream
	root_flag="--root"
	upstream_arg="$root_flag"
fi

will do the trick, yes?

j.

From: Paul Eggert <eggert@cs.ucla.edu>
Subject: Re: git format-patch doesn't add Content-type for UTF-8 diffs
Date: Mon, 30 Jun 2014 11:54:03 -0700
Organization: UCLA Computer Science Department
Message-ID: <53B1B24B.2040609@cs.ucla.edu>
References: <53B127DD.8000807@cs.ucla.edu> <20140630173052.GB16747@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 30 20:54:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1giU-00078m-Qy
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 20:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755486AbaF3SyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 14:54:10 -0400
Received: from smtp.cs.ucla.edu ([131.179.128.62]:47908 "EHLO smtp.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752197AbaF3SyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 14:54:09 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.cs.ucla.edu (Postfix) with ESMTP id 7A9F1A60003;
	Mon, 30 Jun 2014 11:54:08 -0700 (PDT)
X-Virus-Scanned: amavisd-new at smtp.cs.ucla.edu
Received: from smtp.cs.ucla.edu ([127.0.0.1])
	by localhost (smtp.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bq+h53FHm05n; Mon, 30 Jun 2014 11:54:03 -0700 (PDT)
Received: from [192.168.1.9] (pool-108-0-233-62.lsanca.fios.verizon.net [108.0.233.62])
	by smtp.cs.ucla.edu (Postfix) with ESMTPSA id AC777A6000D;
	Mon, 30 Jun 2014 11:54:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140630173052.GB16747@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252700>

Jeff King wrote:
> How do you send the mails after they come out of format-patch?

I run a shell command like this (on Solaris 10):

/usr/lib/sendmail -ONoRecipientAction=add-to tz@iana.org < 
0001-whatever.patch

(The "NoRecipientAction" option pacifies the IANA MTA.)

This is an old machine not under my control, with an old 'git' installed 
that I don't use and don't particularly want to worry about porting to. 
  I generate the patch file on a different machine with git 1.9.3, and 
scp it into the email-sending machine.

I suppose that I could work around the problem with this shell command:

(grep -q '^Mime-Version: ' 0001-whatever.patch ||
    printf '%s\n' \
      'MIME-Version: 1.0' \
      'Content-Type: text/plain; charset=UTF-8' \
      'Content-Transfer-Encoding: 8bit'
  cat 0001-whatever.patch) |
/usr/lib/sendmail -ONoRecipientAction=add-to tz@iana.org

but that's less convenient.

> I wonder if it would be enough to do:
>
>   1. Always add a content-type header, even if the commit is utf-8 and
>      contains only ascii characters.

That would help for my case, yes.  We use only UTF-8, and to me it 
feelds weird that patches are mailed properly if the commit log contains 
non-ASCII characters, but don't work if the commit log is ASCII and the 
diff contains non-ASCII.

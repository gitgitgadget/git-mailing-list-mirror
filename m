From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG] attribute "eol" with "crlf"
Date: Fri, 16 Dec 2011 19:21:07 +0100
Message-ID: <vpqr504wf70.fsf@bauges.imag.fr>
References: <CAN0XMO+OOdTJ+aNMSc2G3RVc7Wfypr4+7dU3US9GVAmMiSJ7cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 19:21:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbcPH-0008U5-Kj
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 19:21:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760240Ab1LPSVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 13:21:15 -0500
Received: from mx1.imag.fr ([129.88.30.5]:60181 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760133Ab1LPSVN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 13:21:13 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id pBGIL7Kv009432
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 16 Dec 2011 19:21:07 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RbcP6-00016Q-5h; Fri, 16 Dec 2011 19:21:08 +0100
In-Reply-To: <CAN0XMO+OOdTJ+aNMSc2G3RVc7Wfypr4+7dU3US9GVAmMiSJ7cg@mail.gmail.com>
	(Ralf Thielow's message of "Fri, 16 Dec 2011 18:44:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 16 Dec 2011 19:21:07 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: pBGIL7Kv009432
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1324664471.32944@shHaGwlrrrAZEokOFwWE7w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187295>

Ralf Thielow <ralf.thielow@googlemail.com> writes:

> There's a bug in git-1.7.8 if you use the attribute "eol" with "crlf".
>
> Steps to reproduce:
> - add and commit a text file which uses 0d0a for line breaks
> 7465 7374 0d0a 0d0a 7465 7374 0d0a       test....test..
> - add ".gitattributes" with "*.txt eol=crlf"
> - change a line in the file
> - execute "git checkout [file]"
>
> The result is:
> 7465 7374 0d0d 0a0d 0d0a 7465 7374 0d0d  test......test..

It seems to me to be the expected behavior. You committed a file whose
line endings are not normalized to LF in the repository, and asked for a
conversion LF -> CRLF on checkout, which Git did.

Git can't know exactly the moment when you edit .gitattributes, so it
can't do the conversion at the time you add the eol=crlf attribute. It
does it on checkout.

> 0d0a was replaced by 0d0d0a.

I'd say 0a (LF) was replaced by 0d0a (CRLF).

What behavior would you have expected?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Git commit won't add an untracked file given on the command line
Date: Tue, 18 Nov 2008 23:16:07 +0100
Message-ID: <vpq8wrg7k9k.fsf@bauges.imag.fr>
References: <20081118211237.234d8035@crow>
	<200811182227.20076.fge@one2team.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Burton <markb@ordern.com>, git@vger.kernel.org
To: Francis Galiegue <fge@one2team.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 23:24:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2Yzl-0003Zo-Bm
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 23:24:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735AbYKRWXO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Nov 2008 17:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752814AbYKRWXO
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 17:23:14 -0500
Received: from imag.imag.fr ([129.88.30.1]:36234 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752368AbYKRWXN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 17:23:13 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id mAIMG7uh016435
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Nov 2008 23:16:07 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1L2Yrf-00052F-Mw; Tue, 18 Nov 2008 23:16:07 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1L2Yrf-0003eQ-Ka; Tue, 18 Nov 2008 23:16:07 +0100
In-Reply-To: <200811182227.20076.fge@one2team.com> (Francis Galiegue's message of "Tue\, 18 Nov 2008 22\:27\:19 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 18 Nov 2008 23:16:08 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101290>

=46rancis Galiegue <fge@one2team.com> writes:

> Le Tuesday 18 November 2008 22:12:37 Mark Burton, vous avez =E9crit=A0=
:
>> Hi,
>>
>> When I try:
>>
>> git commit -m "New file." .gitignore
>>
>> Where .gitignore is not yet tracked, I get:
>>
>> error: pathspec '.gitignore' did not match any file(s) known to git.
>>
>> Is that result by design, sloth or bug (or me being stupid)?
>>
>
> You must "git add .gitignore" first. And yes, this is by design.

If it's by design, then it's a documentation bug:

     -o, --only
        Make a commit only from the paths specified on the
        command line, disregarding any contents that have been
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        staged so far. This is the default mode of operation of
        ^^^^^^^^^^^^^
        git-commit if any paths are given on the command line,

We have here a case where having staged content before doing commit -o
actually changes its behavior.

Looking at the code, this happens because the "file" list is actually
a pattern list (so that you can "git commit '*.txt'" or so), and the
pattern is looked for in the index (the error is raised in
"list_paths").

> You could also have done git commit -a -m "themessage".

Well, he could have done that, but then the result would have been
different ;-).

--=20
Matthieu

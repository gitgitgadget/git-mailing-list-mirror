From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: 2.6.0: Comment in rebase instruction has become too rigid
Date: Tue, 29 Sep 2015 19:01:41 +0200
Message-ID: <vpqzj0588i2.fsf@grenoble-inp.fr>
References: <CAEY4ZpN0C96jU4Tgvqt-hWEviR-sapDoyAv88H+opPSr-cs=mg@mail.gmail.com>
	<vpqr3lhb719.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 29 19:01:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgyHn-0001x0-IG
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 19:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbbI2RBr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Sep 2015 13:01:47 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48140 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755147AbbI2RBq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2015 13:01:46 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8TH1dcB001246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 29 Sep 2015 19:01:39 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8TH1fSU026725;
	Tue, 29 Sep 2015 19:01:41 +0200
In-Reply-To: <vpqr3lhb719.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Tue, 29 Sep 2015 17:05:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 29 Sep 2015 19:01:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8TH1dcB001246
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444150901.91434@2JRnMhY6vBc3XuGEF6KYWg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278829>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Nazri Ramliy <ayiehere@gmail.com> writes:
>
>> I'd hit that key in my editor that filters the pick instructions add
>> inserts the list of the modified files in each commit so that the
>> instruction sheet becomes like this:
>>
>>   pick deadbeef some commit message
>>      # M path/to/foo.txt | 15 ++++----------
>>   pick cafebabe another commit message
>>      # M bar.txt | 2 +-
>>
>>
>> IIRC before git 2.6.0 this worked fine.
>
> Confirmed: Git 2.1.4 accepts this, 2.6 doesn't:
>
> Warning: the command isn't recognized in the following line:
>  - # pick dbafac11052a0075233bdcf0b71f54d1503aa82d test
>
> You can fix this with 'git rebase --edit-todo'.
> Or you can abort the rebase with 'git rebase --abort'.
>
> I didn't bisect, but I guess this was introduced in the series
> introducing this check on the todolist before starting the bisection.

Indeed:

804098bb30a5339cccb0be981a3e876245aa0ae5 is the first bad commit
commit 804098bb30a5339cccb0be981a3e876245aa0ae5
Author: Galan R=E9mi <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Date:   Mon Jun 29 22:20:32 2015 +0200

    git rebase -i: add static check for commands and SHA-1
   =20
    Check before the start of the rebasing if the commands exists, and =
for
    the commands expecting a SHA-1, check if the SHA-1 is present and
    corresponds to a commit. In case of error, print the error, stop gi=
t
    rebase and prompt the user to fix with 'git rebase --edit-todo' or =
to
    abort.
   =20
    This allows to avoid doing half of a rebase before finding an error
    and giving back what's left of the todo list to the user and prompt
    him to fix when it might be too late for him to do so (he might hav=
e
    to abort and restart the rebase).
   =20
    Signed-off-by: Galan R=E9mi <remi.galan-alfonso@ensimag.grenoble-in=
p.fr>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

:100644 100644 c26a200a6c0e7edd2b182b71af50df52179d295f dcc3401b5a8c45f=
d9c5ba474416eb4a6c3c9a29e M      git-rebase--interactive.sh
:040000 040000 3a2882c656f4a2ea3cfcba7e5afca79877c61295 522781ff8b31d55=
b76064d27f3d4326026721091 M      t

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/

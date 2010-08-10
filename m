From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Black smoke from git rebase -i exec
Date: Tue, 10 Aug 2010 15:37:29 +0200
Message-ID: <vpqlj8ezizq.fsf@bauges.imag.fr>
References: <AANLkTikCgSNRipTbjiL+uPOqCL3WXwn08_QV=UJ7EwvT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 15:53:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OipGx-0002av-Kd
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 15:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757723Ab0HJNqR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 09:46:17 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56434 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757686Ab0HJNqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 09:46:09 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o7ADQeEc015967
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 10 Aug 2010 15:26:40 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Oip1F-0001KX-FA; Tue, 10 Aug 2010 15:37:29 +0200
In-Reply-To: <AANLkTikCgSNRipTbjiL+uPOqCL3WXwn08_QV=UJ7EwvT@mail.gmail.com>
 (=?iso-8859-1?Q?=22=C6var_Arnfj=F6r=F0?= Bjarmason"'s message of "Tue\, 10
 Aug 2010 13\:08\:02 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 10 Aug 2010 15:26:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o7ADQeEc015967
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1282051602.89684@YOvz/d4a91qimuvM9iHQ3g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153105>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:

> There's some black smoke in pu after the git rebase -i series was
> applied: http://smoke.git.nix.is/app/projects/report_details/14

Strange, I can't reproduce this on my box (tried on RHEL x86_64 and
Debian i686).

>     expecting success:
=2E..
>     	rm -f touch-*
>
>     Switched to a new branch 'master'

At this point, I get=20

rebase -i script before editing:
pick 313fe96 B
pick d0f65f2 C
pick 0547e3f D
pick 8f99a4f E

rebase -i script after editing:
pick 313fe96 B
exec touch touch-one
pick d0f65f2 C
exec touch touch-two
exec false
exec touch touch-three
pick 0547e3f D
pick 8f99a4f E
exec touch "touch-file  name with spaces"; touch touch-after-semicolon

which you don't seem to get on your side. I get the same as you if I
comment out the "set_fake_editor" line at the top of the script. So, I
suspect there's something very wrong that prevents it from doing its
job.

Can you add some debug

echo "$EDITOR"
echo "$FAKE_EDITOR"

somewhere in the test to see what happens?

>     Rebasing (4/4)
> Successfully rebased and updated refs/heads/master.
>     Stopped at wrong revision:
>     (E instead of C)
>     Stopped at wrong revision:
>     (E instead of master)

(here, it's definitely doing as if the todolist had not been edited)

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/

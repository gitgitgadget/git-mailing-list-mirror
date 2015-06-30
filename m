From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 0/3] rebase -i: drop, missing commits and static checks
Date: Tue, 30 Jun 2015 17:06:14 +0200 (CEST)
Message-ID: <1849903896.89424.1435676774069.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1435609232-14232-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <1435655961-31263-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	antoine delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	sunshine@sunshineco.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 30 17:03:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9x4l-00005v-4p
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 17:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754188AbbF3PDv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jun 2015 11:03:51 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:33685 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753835AbbF3PDo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 11:03:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id A8E4E3823;
	Tue, 30 Jun 2015 17:03:41 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3P5N3Ju-wNjD; Tue, 30 Jun 2015 17:03:41 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 97ED83812;
	Tue, 30 Jun 2015 17:03:41 +0200 (CEST)
In-Reply-To: <1435655961-31263-1-git-send-email-Matthieu.Moy@imag.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Win)/8.0.9_GA_6191)
Thread-Topic: rebase -i: drop, missing commits and static checks
Thread-Index: jMOhzhandRaxAksQ9wvVHnHE48qcnA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273069>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:
> Hi,
>=20
> Here are a few fixes to squash into the commits of the series. Other
> than that, the series looks good to me.
>=20
> Junio: do you prefer a reroll or do you want to apply locally?
>=20
> Matthieu Moy (3):
>   fixup! git rebase -i: add static check for commands and SHA-1
>   fixup! git rebase -i: warn about removed commits
>   fixup! git rebase -i: warn about removed commits
>=20
>  git-rebase--interactive.sh    | 32 +++++++++++++++++++++-----------
>  t/t3404-rebase-interactive.sh |  4 ++--
>  2 files changed, 23 insertions(+), 13 deletions(-)

Thanks for the various fixes !

However, I am still wondering about:

Galan R=C3=A9mi <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:
> Shouldn't all the checking also be called in a 'rebase --continue',
> considering that it can be called after a 'rebase --edit-todo' ?
> (Right now it is only called after closing the editor in 'rebase -i')

What's your opinion on it?

Short example:

'git rebase -i HEAD~2'
	pick commit_sha_1 commit_msg_1
	tick commit_sha_2 commit_msg_2
An error is raised before anything is done.
'git rebase --edit-todo'
	pick commit_sha_1 commit_msg_1
	tick commit_sha_2 commit_msg_2
(nothing changed)
'git rebase --continue'
An error is raised after having picked the first commit.

The same is relevent with bad sha and missing commits (in fact even
more relevant with missing commits since that would be silent loss of
information).

Thanks,
R=C3=A9mi

From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 0/3] rebase -i: drop, missing commits and static checks
Date: Tue, 30 Jun 2015 17:39:19 +0200
Message-ID: <vpqegkt434o.fsf@anie.imag.fr>
References: <1435609232-14232-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1435655961-31263-1-git-send-email-Matthieu.Moy@imag.fr>
	<1849903896.89424.1435676774069.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	antoine delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	sunshine@sunshineco.com
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 30 17:39:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9xdJ-00068t-Bo
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 17:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbbF3Pjd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jun 2015 11:39:33 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33783 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753905AbbF3Pjb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 11:39:31 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5UFdH3m029186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Jun 2015 17:39:17 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5UFdJTi028747;
	Tue, 30 Jun 2015 17:39:19 +0200
In-Reply-To: <1849903896.89424.1435676774069.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Galan Alfonso's message of "Tue, 30 Jun 2015 17:06:14 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 30 Jun 2015 17:39:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5UFdH3m029186
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436283562.79508@pfjAltAKxjTIF08VnCy8OQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273070>

Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:

> Galan R=E9mi <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:
>> Shouldn't all the checking also be called in a 'rebase --continue',
>> considering that it can be called after a 'rebase --edit-todo' ?
>> (Right now it is only called after closing the editor in 'rebase -i'=
)
>
> What's your opinion on it?

It would probably be better to run the check when running "git rebase
--continue". This way, we would have a guarantee that the todo-list is
syntactically correct when going through it.

Just checking after --edit-todo would not guarantee that:

  $ git rebase --edit-todo
  # Add some syntax errors, save and quit
  Warning: the command isn't recognized ...
 =20
  # Hmm, let's ignore that warning
  $ git rebase --continue
  Unknown command: ...
  Please fix this using 'git rebase --edit-todo'

But in any case, the most important is the initial edition. It covers
99.9% of use-cases. So, I'd say: if you have time to add the checks at
the other relevant places, good, but not doing it shouldn't block the
inclusion of the series.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/

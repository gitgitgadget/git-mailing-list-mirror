From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv5] rebase [-i --exec | -ix] <CMD>...
Date: Thu, 14 Jun 2012 08:57:26 +0200
Message-ID: <vpqr4ticre1.fsf@bauges.imag.fr>
References: <1339325076-474-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1339488312-6349-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<4FD70A8E.7050502@in.waw.pl> <7vk3zc4mgz.fsf@alter.siamese.dyndns.org>
	<4FD89DD6.1070705@in.waw.pl>
	<20120613200552.Horde.JHFYfHwdC4BP2NaA39-wrmA@webmail.minatec.grenoble-inp.fr>
	<7vipevgjhp.fsf@alter.siamese.dyndns.org>
	<20120613213836.Horde.qI8GQnwdC4BP2Ow8uCTQqgA@webmail.minatec.grenoble-inp.fr>
	<4FD8FF25.6030908@kdbg.org> <7vr4tig7rg.fsf@alter.siamese.dyndns.org>
	<4FD9177A.5030303@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	konglu@minatec.inpg.fr, Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Jun 14 08:58:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf40N-0005aX-G5
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 08:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675Ab2FNG6B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jun 2012 02:58:01 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60026 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751485Ab2FNG6A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jun 2012 02:58:00 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5E6mD7e009452
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 14 Jun 2012 08:48:14 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sf3zj-00052B-ES; Thu, 14 Jun 2012 08:57:27 +0200
In-Reply-To: <4FD9177A.5030303@in.waw.pl> ("Zbigniew \=\?utf-8\?Q\?J\=C4\=99drze\?\=
 \=\?utf-8\?Q\?jewski-Szmek\=22's\?\=
	message of "Thu, 14 Jun 2012 00:43:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 14 Jun 2012 08:48:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5E6mD7e009452
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340261296.89618@HPVAdKdZjTGAiozf+mZpow
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199971>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

>> Shouldn't "rebase --continue" after such a "commit --amend" resume
>> execution from "exec cmd1", which failed in the initial run?

There are use-cases where this would be useful, but that would also be =
a
real pain if the command itself is broken (e.g. does "echo OK; exit 1",
that the user can interpret as correct but that "git rebase" will
consider as a failure). It this case, the user would have no simple way
to get out of the situation (either --abort or --skip).

The current behavior is not that bad: "git rebase --continue" does not
re-check the current commit, but the user did have an opportunity to
check the commit manually before running it. The problem with rebase
(that --exec solves), is that it creates new commits without giving the
user this opportunity. I'm not sure adding one more type of command is
worth the extra-complexity.

> A different proposal would be to add a 'rebase --retry' which would
> inoke the last command again. And then the advice after 'exec' could =
say
> "Use --retry to rerun this command, and --continue to proceed with th=
e
> next one".
>
> --retry could make sense for 'apply' commands too: if a commit fails =
to
> apply, one could do
[...]

That makes sense to me.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/

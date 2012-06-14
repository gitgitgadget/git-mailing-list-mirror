From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCHv5] rebase [-i --exec | -ix] <CMD>...
Date: Thu, 14 Jun 2012 10:08:09 -0400
Message-ID: <4FD9F049.1030808@xiplink.com>
References: <1339325076-474-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <1339488312-6349-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <4FD70A8E.7050502@in.waw.pl> <7vk3zc4mgz.fsf@alter.siamese.dyndns.org> <4FD89DD6.1070705@in.waw.pl> <20120613200552.Horde.JHFYfHwdC4BP2NaA39-wrmA@webmail.minatec.grenoble-inp.fr> <7vipevgjhp.fsf@alter.siamese.dyndns.org> <20120613213836.Horde.qI8GQnwdC4BP2Ow8uCTQqgA@webmail.minatec.grenoble-inp.fr> <4FD8FF25.6030908@kdbg.org> <7vr4tig7rg.fsf@alter.siamese.dyndns.org> <4FD9177A.5030303@in.waw.pl> <vpqr4ticre1.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, konglu@minatec.inpg.fr,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 14 16:09:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfAjN-0004aY-Vd
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 16:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756052Ab2FNOI6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jun 2012 10:08:58 -0400
Received: from smtp142.dfw.emailsrvr.com ([67.192.241.142]:35982 "EHLO
	smtp142.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756039Ab2FNOI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 10:08:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp24.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id B5AA7180DB5
	for <git@vger.kernel.org>; Thu, 14 Jun 2012 10:08:56 -0400 (EDT)
X-Virus-Scanned: OK
Received: from smtp138.ord.emailsrvr.com (smtp138.ord.emailsrvr.com [173.203.6.138])
	by smtp24.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTPS id 9FB6D180D9E
	for <git@vger.kernel.org>; Thu, 14 Jun 2012 10:08:56 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp22.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 3FC7320007D;
	Thu, 14 Jun 2012 10:08:08 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp22.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 1FED420009A;
	Thu, 14 Jun 2012 10:08:07 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <vpqr4ticre1.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200007>

On 12-06-14 02:57 AM, Matthieu Moy wrote:
> Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:
>=20
>>> Shouldn't "rebase --continue" after such a "commit --amend" resume
>>> execution from "exec cmd1", which failed in the initial run?

+1 for Junio's proposal.

Currently the only time --continue moves on to the next insn is in the =
"edit"
case, when everything up to that point (including applying the "edit" c=
ommit)
is fine.  But if the rebase halted due to a problem, --continue ensures=
 the
problem is fixed before moving on to the next insn (e.g. it makes sure =
a
merge conflict is resolved).

I think it makes the most sense for --continue after an exec-failure to=
 try
to re-run the exec.  Furthermore, --skip after an exec failure should j=
ust
skip the exec.

To me that makes --continue's (and --skip's) behaviour consistent with =
what
it does when any other insn operation fails.  In other words, if the re=
base
hits an exec failure, the user is going to want to fix it before contin=
uing
(just like any other failure during a rebase).  If the user decides to =
not
fix the failing exec, they can --skip it.

		M.

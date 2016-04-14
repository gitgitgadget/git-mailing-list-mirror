From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: Ambiguous sha-1 during a rebase
Date: Thu, 14 Apr 2016 19:27:04 +0200 (CEST)
Message-ID: <749683959.3734012.1460654824023.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <20160413222919.GA10474@glandium.org> <xmqqr3e9i10b.fsf@gitster.mtv.corp.google.com> <20160413225234.GA21602@glandium.org> <vpqr3e8wo99.fsf@anie.imag.fr> <20160414093847.GA10852@glandium.org> <vpqa8kwtjbc.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 14 19:22:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqky7-0006Qx-BO
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 19:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282AbcDNRWK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Apr 2016 13:22:10 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:55916 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752399AbcDNRWK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 13:22:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 33A602136;
	Thu, 14 Apr 2016 19:22:05 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WlK2VTkto8f0; Thu, 14 Apr 2016 19:22:05 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 1E57A2134;
	Thu, 14 Apr 2016 19:22:05 +0200 (CEST)
In-Reply-To: <vpqa8kwtjbc.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF45 (Linux)/8.0.9_GA_6191)
Thread-Topic: Ambiguous sha-1 during a rebase
Thread-Index: MiJ4EBA5eG8hGmUWsoaqHJQEe6eYtA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291536>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> Mike Hommey <mh@glandium.org> writes:
>=20
> > Yeah, that definitely is a weird corner case. Interestingly, it was
> > complaining about "error: short SHA1 e34ff55 is ambiguous." when ap=
ply
> > *other* commits that were in the list prior to it,
>=20
> I think it did before: when normalizing the list to long sha1, i.e.
> right after you closed your editor and befor starting anything else.

In that case, I'm surprised that the rebase didn't stop before doing
any action.

I am guessing that the "error: short SHA1 e34ff55 is ambiguous." is
comming from either 'check_commit_sha' called by 'check_todo_list' or
by 'transform_todo_ids' called by 'expand_todo_ids'.

If my guess is correct {

 - If the former, it means that 'check_commit_sha' is not doing its
   job properly (it did not return an error code, which would have
   triggered a 'die' later and stopped the rebase at the beginning).

 - If the latter, it means that 'check_commit_sha' and
   'check_todo_list' missed an occasion to error out.

}

On a side note, is there a way to test for ambiguous SHA1?

Thanks,
R=C3=A9mi

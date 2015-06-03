From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH/RFCv4 2/2] git rebase -i: warn about removed commits
Date: Wed, 3 Jun 2015 14:48:08 +0200 (CEST)
Message-ID: <1592132582.69681.1433335688516.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433331859-24832-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <1433331859-24832-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 03 14:48:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z085n-0002BY-N8
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 14:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755927AbbFCMsR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2015 08:48:17 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:59044 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758721AbbFCMsF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 3 Jun 2015 08:48:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 15F8D3637;
	Wed,  3 Jun 2015 14:48:01 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J-jTyezszXHg; Wed,  3 Jun 2015 14:48:01 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id F0C6A2B27;
	Wed,  3 Jun 2015 14:48:00 +0200 (CEST)
In-Reply-To: <1433331859-24832-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git rebase -i: warn about removed commits
Thread-Index: 3r32SGfbiUuM5zMej/knlEronv7mDw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270681>

Galan R=C3=A9mi <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:
> +                comm -2 -3 "$todo".oldsha1 "$todo".newsha1 >"$todo".=
miss
> +
> +                # Make the list user-friendly
> +                opt=3D"--no-walk=3Dsorted --format=3Doneline --abbre=
v-commit --stdin"
> +                git rev-list $opt <"$todo".miss >"$todo".miss+
> +                mv "$todo".miss+ "$todo".miss
> +
> +                # Check missing commits

=46ound a bug here, got an error message from git rev-list if
"$todo".miss is empty.

Now it looks like:
> 		# Check missing commits
> 		if test -s "$todo".miss
> 		then
> 			# Make the list user-friendly
> 			opt=3D"--no-walk=3Dsorted --format=3Doneline --abbrev-commit --std=
in"
> 			git rev-list $opt <"$todo".miss >"$todo".miss+
> 			mv "$todo".miss+ "$todo".miss
>=20
> 			warn "Warning: some commits may have been dropped" \

Thus the empty case is tested by the test -s of the warnings.

By the way, should I add --quiet to the options of the call to git
rev-list?

R=C3=A9mi

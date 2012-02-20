From: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
Subject: Re: Handle HTTP error 511 Network Authentication Required (standard
 secure proxy authentification/captive portal detection)
Date: Mon, 20 Feb 2012 19:27:08 +0100
Message-ID: <cb81840f853a1d43a7da03ea24c86445.squirrel@arekh.dyndns.org>
References: <4b8f33ba4c870528a82ab85d6dad68bd.squirrel@arekh.dyndns.org>
    <20120220010617.GB4140@sigill.intra.peff.net>
    <9cd657a3c4960a8c496515a03bbf623e.squirrel@arekh.dyndns.org>
    <20120220135639.GA5131@sigill.intra.peff.net>
    <e1d3ddd965eb32717163aaa87fa71e17.squirrel@arekh.dyndns.org>
    <20120220154452.GA27456@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>,
	git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 19:27:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzXxP-00063W-Vr
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 19:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543Ab2BTS1W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Feb 2012 13:27:22 -0500
Received: from smtpout1.laposte.net ([193.253.67.226]:19038 "EHLO
	smtpout.laposte.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535Ab2BTS1V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 13:27:21 -0500
Received: from arekh.dyndns.org ([88.174.226.208])
	by mwinf8501-out with ME
	id cJTB1i0084WQcrc03JTDZR; Mon, 20 Feb 2012 19:27:14 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by arekh.dyndns.org (Postfix) with ESMTP id A1ED11E71;
	Mon, 20 Feb 2012 19:27:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at arekh.dyndns.org
Received: from arekh.dyndns.org ([127.0.0.1])
	by localhost (arekh.okg [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A+uNauyl57X6; Mon, 20 Feb 2012 19:27:08 +0100 (CET)
Received: from arekh.dyndns.org (localhost.localdomain [127.0.0.1])
	by arekh.dyndns.org (Postfix) with ESMTP;
	Mon, 20 Feb 2012 19:27:08 +0100 (CET)
Received: from 192.168.0.4
        (SquirrelMail authenticated user nim)
        by arekh.dyndns.org with HTTP;
        Mon, 20 Feb 2012 19:27:08 +0100
In-Reply-To: <20120220154452.GA27456@sigill.intra.peff.net>
User-Agent: SquirrelMail/1.4.22-4.fc17
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191081>


Le Lun 20 f=C3=A9vrier 2012 16:44, Jeff King a =C3=A9crit :

> In my experience, the captive portal process usually goes like this:
>
>   1. Connect to network.
>
>   2. Try some non-browser command. Wonder why in the world it isn't
>      working.
>
>   3. Open a browser and say "Ah, I see. A captive portal".
>
> The 511 proposal makes step 2 a lot better if the protocol is http[1]=
=2E
> But it pretty much makes it better even without non-browser client
> support, because at least you will get a 511 error instead of having =
git
> complain that the remote repository is corrupted (which happens if th=
e
> captive portal returns a redirect to an html page).
>
> We should already be doing that. Adding more support could make step =
3 a
> little nicer, but like I said, I'd be more interested in seeing a rea=
l
> case first. It may even be a feature that would be more appropriate t=
o
> curl (which git builds on for http access).

Step 3 is a quite less obvious on a corporate network, where Internet a=
ccess
is gated by a filtering proxy, that will let some sites pass transparen=
tly but
require credentials to let you access others. Worst case, there are sev=
eral
load-balanced gateways on different physical sites (to avoid spofs in c=
ase of
planes falling on the wrong place), that do not share authentication (b=
ecause
propagating auth across physical sites is hard). So no, just launching =
a
browser is not sufficient to find the captive portal, you need to actua=
lly
access the URL returned by error 511 in meta information. Git should at
minimum report this URL.

(and no this is not an hypothetical scenario and yes there are git user=
s
trying to pass the gateways there)

--=20
Nicolas Mailhot

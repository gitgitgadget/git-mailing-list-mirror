From: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
Subject: Re: Handle HTTP error 511 Network Authentication Required (standard
 secure proxy authentification/captive portal detection)
Date: Mon, 20 Feb 2012 20:24:15 +0100
Message-ID: <72fbd4155349723da1c3c503c1c9c620.squirrel@arekh.dyndns.org>
References: <4b8f33ba4c870528a82ab85d6dad68bd.squirrel@arekh.dyndns.org>
    <20120220010617.GB4140@sigill.intra.peff.net>
    <9cd657a3c4960a8c496515a03bbf623e.squirrel@arekh.dyndns.org>
    <20120220135639.GA5131@sigill.intra.peff.net>
    <e1d3ddd965eb32717163aaa87fa71e17.squirrel@arekh.dyndns.org>
    <20120220154452.GA27456@sigill.intra.peff.net>
    <cb81840f853a1d43a7da03ea24c86445.squirrel@arekh.dyndns.org>
    <20120220191500.GA29228@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>,
	git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 20:24:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzYqX-0001Le-TT
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 20:24:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602Ab2BTTYV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Feb 2012 14:24:21 -0500
Received: from smtpout1.laposte.net ([193.253.67.226]:35453 "EHLO
	smtpout.laposte.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab2BTTYV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 14:24:21 -0500
Received: from arekh.dyndns.org ([88.174.226.208])
	by mwinf8501-out with ME
	id cKQH1i0084WQcrc03KQHtC; Mon, 20 Feb 2012 20:24:17 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by arekh.dyndns.org (Postfix) with ESMTP id 26CA52B3;
	Mon, 20 Feb 2012 20:24:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at arekh.dyndns.org
Received: from arekh.dyndns.org ([127.0.0.1])
	by localhost (arekh.okg [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HH65cv4RiW0A; Mon, 20 Feb 2012 20:24:15 +0100 (CET)
Received: from arekh.dyndns.org (localhost.localdomain [127.0.0.1])
	by arekh.dyndns.org (Postfix) with ESMTP;
	Mon, 20 Feb 2012 20:24:14 +0100 (CET)
Received: from 192.168.0.4
        (SquirrelMail authenticated user nim)
        by arekh.dyndns.org with HTTP;
        Mon, 20 Feb 2012 20:24:15 +0100
In-Reply-To: <20120220191500.GA29228@sigill.intra.peff.net>
User-Agent: SquirrelMail/1.4.22-4.fc17
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191088>


Le Lun 20 f=C3=A9vrier 2012 20:15, Jeff King a =C3=A9crit :
> On Mon, Feb 20, 2012 at 07:27:08PM +0100, Nicolas Mailhot wrote:
>
>> Step 3 is a quite less obvious on a corporate network, where Interne=
t access
>> is gated by a filtering proxy, that will let some sites pass transpa=
rently
>> but
>> require credentials to let you access others. Worst case, there are =
several
>> load-balanced gateways on different physical sites (to avoid spofs i=
n case
>> of
>> planes falling on the wrong place), that do not share authentication
>> (because
>> propagating auth across physical sites is hard). So no, just launchi=
ng a
>> browser is not sufficient to find the captive portal, you need to ac=
tually
>> access the URL returned by error 511 in meta information. Git should=
 at
>> minimum report this URL.
>>
>> (and no this is not an hypothetical scenario and yes there are git u=
sers
>> trying to pass the gateways there)
>
> This is exactly the sort of information I wanted to get from a
> real-world scenario. From your initial messages, it sounded like a
> purely hypothetical thing.
>
> I think a good first step would be improving the error message for a
> 511, then. Unfortunately, it seems from the rfc draft you sent that
> callers are expected to parse the link out of the HTML given in the b=
ody
> of the response. It seems silly that there is not a Location field
> associated with a 511, similar to redirects.

The URL is not lost in the HTML text, it's in the url meta field

<meta http-equiv=3D"refresh"
       content=3D"0; url=3Dhttps://login.example.net/">

As for while there is no Location field, I think it's because otherwise=
 it
could behave like a redirect, and browser people made it plain they did=
n't
want redirects of https accesses (but I wasn't there when the spec was
written, and only skimmed the workgroup archives, so there may have bee=
n other
reasons for this choice. I'm pretty sure it's deliberate anyway).

Regards,

--=20
Nicolas Mailhot

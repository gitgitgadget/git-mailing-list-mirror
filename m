From: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
Subject: HTTP error 511 [Was: Secure (https) proxy authentification]
Date: Tue, 21 Feb 2012 09:58:16 +0100
Message-ID: <39d91a07ae0beb19a734e52496ab5700.squirrel@arekh.dyndns.org>
References: <009e3177ab4b0f3de7ea47fa17118458.squirrel@arekh.dyndns.org>
    <689660A9-8EAD-4EE6-8B4D-401E73F13941@bblfish.net>
    <4ec05cf797322715a960743aeec0a48b.squirrel@arekh.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: squid3@treenet.co.nz, ietf-http-wg@w3.org,
	"Jeff King" <peff@peff.net>, git@vger.kernel.org,
	"Daniel Stenberg" <daniel@haxx.se>
To: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
X-From: git-owner@vger.kernel.org Tue Feb 21 09:58:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzlYe-0001Gl-QA
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 09:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331Ab2BUI6e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 03:58:34 -0500
Received: from smtpout3.laposte.net ([193.253.67.228]:16183 "EHLO
	smtpout.laposte.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174Ab2BUI6d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 03:58:33 -0500
Received: from arekh.dyndns.org ([88.174.226.208])
	by mwinf8505-out with ME
	id cYyN1i0044WQcrc03YyNNH; Tue, 21 Feb 2012 09:58:28 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by arekh.dyndns.org (Postfix) with ESMTP id 2D3F01D3;
	Tue, 21 Feb 2012 09:58:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at arekh.dyndns.org
Received: from arekh.dyndns.org ([127.0.0.1])
	by localhost (arekh.okg [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zpVJ8M1HQLw2; Tue, 21 Feb 2012 09:58:16 +0100 (CET)
Received: from arekh.dyndns.org (localhost.localdomain [127.0.0.1])
	by arekh.dyndns.org (Postfix) with ESMTP;
	Tue, 21 Feb 2012 09:58:16 +0100 (CET)
Received: from 192.196.142.27
        (SquirrelMail authenticated user nim)
        by arekh.dyndns.org with HTTP;
        Tue, 21 Feb 2012 09:58:16 +0100
In-Reply-To: <4ec05cf797322715a960743aeec0a48b.squirrel@arekh.dyndns.org>
User-Agent: SquirrelMail/1.4.22-4.fc17
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191142>


Le Dim 19 f=C3=A9vrier 2012 11:22, Nicolas Mailhot a =C3=A9crit :

> 511 is exactly what I need. I was not aware of it. Is it simplemented=
 in any
> browser yet? Where should I point the browser writers to get it imple=
mented?
>
> http://tools.ietf.org/id/draft-nottingham-http-new-status-04.txt ?

I take that back. 511 is almost exactly what we need. However, when I p=
ointed
the authors of some of the tools that pass through our proxy to it (cur=
l, git)
they told me they could not parse html code in their tools, so they rea=
lly
need a location (or similar) field containing the address of the
authentication portal to communicate it to the user. Without this field=
, they
can only stop with 'Network authentication is needed' instead of 'Pleas=
e open
<url> in your browser to proceed'.

http://article.gmane.org/gmane.comp.version-control.git/191085
http://article.gmane.org/gmane.comp.version-control.git/191087
http://article.gmane.org/gmane.comp.version-control.git/191086

(the nearest thing there is in the spec is the url in meta, but it's on=
ly in
the example, not mandatory, and no one will write code for something th=
ey can
not be sure will exist)

We'd like to support those tools properly as their users' previous clum=
sy
attempts to navigate our current non-standard redirection method result=
ed in
internal security investigations.

It is a problem in our setup as we only block some URLs (others are all=
owed
transparently without auth), and we use several proxy farms in differen=
t
physical sites (to avoid spofs). So just opening any url in a browser w=
on't
trigger an authentication request (the url may not be blocked, or the b=
rowser
may pass through a gateway where the user IP is already authorized, whi=
le
git/etc tried to access through another one).

Could you please revise the error 511 definition to add such a field ?

Regards,

--=20
Nicolas Mailhot

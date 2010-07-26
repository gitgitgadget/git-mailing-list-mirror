From: "Jasper St. Pierre" <jstpierre@mecheye.net>
Subject: Re: URL decoding changed semantics of + in URLs
Date: Mon, 26 Jul 2010 14:22:42 -0400
Message-ID: <AANLkTimRrpiv7cu=j598K3x4h3UGW7-Hik6-6jA8R_5J@mail.gmail.com>
References: <201007231518.31071.trast@student.ethz.ch> <20100726154041.GA18762@coredump.intra.peff.net> 
	<AANLkTikmFVHeMVEgj_G5h8VMNaw0zIm0Ol-vC1ffc45v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 20:23:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdSKZ-0001CR-9t
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 20:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809Ab0GZSXG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 14:23:06 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58555 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526Ab0GZSXF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jul 2010 14:23:05 -0400
Received: by wyf19 with SMTP id 19so2380364wyf.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 11:23:02 -0700 (PDT)
Received: by 10.216.235.106 with SMTP id t84mr7799814weq.46.1280168582296; 
	Mon, 26 Jul 2010 11:23:02 -0700 (PDT)
Received: by 10.216.79.68 with HTTP; Mon, 26 Jul 2010 11:22:42 -0700 (PDT)
In-Reply-To: <AANLkTikmFVHeMVEgj_G5h8VMNaw0zIm0Ol-vC1ffc45v@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151869>

Where is '+' used in the URL context? I don't see that it's a
replacement for '+'
aside from formencoded, which is from CGI, not HTTP or the URI spec.

I also can't access something called "test 2.txt" from Apache with
"http://localhost/test+2.txt", so I don't think it's unescaping the '+'=
=2E

I don't think we should do anything about the '+' case, except where us=
ed in
formencoded parameters (aka the "query string"), where it is used.

On Mon, Jul 26, 2010 at 1:57 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Jul 26, 2010 at 15:40, Jeff King <peff@peff.net> wrote:
>
>> As Jasper noted, "+" is a reserved character, which means "gtk+"
>> probably _should_ be escaped. But clearly it doesn't happen in pract=
ice,
>> and I am more interested in not breaking current use than in nitpick=
ing
>> with a standard.
>
> Reserved characters only have to be escaped in certain contexts, from
> RFC 2396:
>
> =A0 Many URI include components consisting of or delimited by, certai=
n
> =A0 special characters. =A0These characters are called "reserved", si=
nce
> =A0 their usage within the URI component is limited to their reserved
> =A0 purpose. =A0If the data for a URI component would conflict with t=
he
> =A0 reserved purpose, then the conflicting data must be escaped befor=
e
> =A0 forming the URI.
>
> =A0 =A0 =A0reserved =A0 =A0=3D ";" | "/" | "?" | ":" | "@" | "&" | "=3D=
" | "+" |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"$" | ","
>
> E.g. @ is special in the hostname part (http://user@example.org), but
> writing http://example.org/Git@Big%20companies:%20A%20Study is just
> fine.
>
> Which is why curl passes it along literally, it *can* escape them, an=
d
> real webservers like Apache handle reserved characters equivalently
> (in their unreserved contexts) whether they're escaped or not, but th=
e
> git-daemon at git.gnome.org evidently doesn't implement RFC 2396
> carefully enough.
>
> So we shouldn't escape + for backwards compatibility and because it's
> not necessary, but we should probably also fix git-daemon to accept
> both forms if that hasn't been done already.
>

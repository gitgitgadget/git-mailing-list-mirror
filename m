From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Do not unquote + into ' ' in URLs
Date: Fri, 23 Jul 2010 22:20:25 +0000
Message-ID: <AANLkTil6sD71n1aDrUQf4ATnlE_L7ltJa500cI6bH6X8@mail.gmail.com>
References: <AANLkTinsixPihZRtduuB_0puX_ucC0HYqHPU0UJMX2e-@mail.gmail.com>
	<db9c97908966fa332be07b2a9f5215679e35b9e0.1279920066.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	jstpierre@mecheye.net
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jul 24 00:20:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcQbY-0005oQ-8i
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 00:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756737Ab0GWWU1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jul 2010 18:20:27 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34119 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215Ab0GWWU0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jul 2010 18:20:26 -0400
Received: by iwn7 with SMTP id 7so612392iwn.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 15:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rgwhpNe0uQmplS1xPffSkV7vkuCTwfTajUUQAKcF81g=;
        b=WPpLeI+8IEEjlJbhyIXQfnCUrK9zhHv44imihnIxKWwPgDRHkul7fcTwcugOqbUoo+
         j12T65AyiZM30uZ9R5sV9N7Cno30Mm1ns+gXnpH4BXfpSdfNntEtX36kHpjEUfn4grJK
         FmiLZxGz3ICB/3j7VMZm+F3uUDRz7N/H0y8B0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Pha8NCECeqxZkfcGrOdTugXQ6Wu9stUmf0VPkiUULnogsoO48c2Ylc8s5jvvvmLOjx
         2jodqkbxSdw6Mb0rzLCSc3ZyPitntzud/OYN40CQPPOYpk1freN2SG9s8kkYyUfh/Wc5
         ARApSqLioJUfIHRWfXNF7mf0rz191IzO60As0=
Received: by 10.231.59.83 with SMTP id k19mr4205367ibh.178.1279923625648; Fri, 
	23 Jul 2010 15:20:25 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Fri, 23 Jul 2010 15:20:25 -0700 (PDT)
In-Reply-To: <db9c97908966fa332be07b2a9f5215679e35b9e0.1279920066.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151577>

On Fri, Jul 23, 2010 at 21:23, Thomas Rast <trast@student.ethz.ch> wrot=
e:
> Since 9d2e942 (decode file:// and ssh:// URLs, 2010-05-23) the URL
> logic unquotes escaped URLs. =C2=A0For the %2B type of escape, this i=
s
> conformant with RFC 2396. =C2=A0However, it also unquotes + into a sp=
ace
> character, which is only appropriate for the query strings in HTTP.
> This notably broke fetching from the gtk+ repository.
>
> Remove the corresponding bit of code.
>
> Reported-by: Jasper St. Pierre <jstpierre@mecheye.net>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>
> Jasper St. Pierre wrote:
>> Yep. http://www.ietf.org/rfc/rfc2396.txt defines '+' as a reserved c=
haracter,
>> but doesn't give a purpose for it. www-form-encoded replaces space w=
ith '+'
>> but in a URL it can mean anything it wants.
>
> So let's do this then, instead?
>
> Based on the discussion, I would consider this a bugfix that should g=
o
> in 1.7.2.1.
>
>
> =C2=A0t/t5601-clone.sh | =C2=A0 10 ++++++++--
> =C2=A0url.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A05=
 +----
> =C2=A02 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 8abb71a..4431dfd 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -178,8 +178,14 @@ test_expect_success 'clone respects global branc=
h.autosetuprebase' '
>
> =C2=A0test_expect_success 'respect url-encoding of file://' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git init x+y &&
> - =C2=A0 =C2=A0 =C2=A0 test_must_fail git clone "file://$PWD/x+y" xy-=
url &&
> - =C2=A0 =C2=A0 =C2=A0 git clone "file://$PWD/x%2By" xy-url
> + =C2=A0 =C2=A0 =C2=A0 git clone "file://$PWD/x+y" xy-url-1 &&
> + =C2=A0 =C2=A0 =C2=A0 git clone "file://$PWD/x%2By" xy-url-2
> +'
> +
> +test_expect_success 'do not query-string-decode + in URLs' '
> + =C2=A0 =C2=A0 =C2=A0 rm -rf x+y &&
> + =C2=A0 =C2=A0 =C2=A0 git init "x y" &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git clone "file://$PWD/x+y" xy-=
no-plus
> =C2=A0'
>
> =C2=A0test_expect_success 'do not respect url-encoding of non-url pat=
h' '
> diff --git a/url.c b/url.c
> index 2306236..fa4b8d4 100644
> --- a/url.c
> +++ b/url.c
> @@ -90,10 +90,7 @@ static char *url_decode_internal(const char **quer=
y, const char *stop_at, struct
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (c =3D=3D '+')
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 strbuf_addch(out, ' ');
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 strbuf_addch(out, c);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_addch(out, =
c);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0q++;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} while (1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0*query =3D q;
> --
> 1.7.2.rc3.335.g26d7d
>

This looks good, Ack.

But as icing, it'd be nice to extend these tests to create files /
clone repositories with the rest of the reserved characters:
http://en.wikipedia.org/wiki/Percent-encoding#Percent-encoding_reserved=
_characters

Of course that would have to be wrapped in something that skips the
tests if those paths can't be created. E.g. "/" is a no-no on Unix,
and some of the others will probably cause troubles on other systems.

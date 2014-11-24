From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: handle adjacent RFC 2047-encoded words properly
Date: Sun, 23 Nov 2014 23:27:51 -0800
Message-ID: <CAPc5daVjNDg5CcWsMwfn=DZhwpCBdU2LYXOpFWZwhx2p8hLRww@mail.gmail.com>
References: <1416786604-4988-1-git-send-email-dpb@corrigendum.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Thomas Rast <tr@thomasrast.ch>
To: =?UTF-8?B?0KDQvtC80LDQvSDQlNC+0L3Rh9C10L3QutC+?= 
	<dpb@corrigendum.ru>
X-From: git-owner@vger.kernel.org Mon Nov 24 08:28:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xso4H-00028O-ML
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 08:28:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341AbaKXH2N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Nov 2014 02:28:13 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:65368 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbaKXH2M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Nov 2014 02:28:12 -0500
Received: by mail-pa0-f53.google.com with SMTP id kq14so9017441pab.40
        for <git@vger.kernel.org>; Sun, 23 Nov 2014 23:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=9zBC94RyMxjh2wY3faU5/6oOTIqRt/Csd0apKJqmUeo=;
        b=MWihwVTAbklIyLjxjgujjvJRJrLIJLzJ44Ncl0xBPdT3Bcl3B0E+Y6BF2sB2iAfXlt
         sWS8ZfSuijx3xkHZ/JdyotTcwJhipO3J06P2IeklCFVV34dBT4LyhIDClT8LvVlvcUO6
         GZptwEH1KA0pHu/IuZus6IjOQsd8Gr9LZQz9gA1BiaXn8FVnMwo/o01RUittWSG81AhK
         2D3JZ+diDi804m4WRF9GZ1AsIq+5Po7AV1VKwt+dzR5JlrzN1jyBv5p89vWp4uhs2LS0
         2c4eTsLm7qCewSB5KnQAZO8/eH0wt2LLeIcgtvLO8nWFIbXMpu1m3LbbSxYFD12nJWil
         9KGw==
X-Received: by 10.68.202.1 with SMTP id ke1mr29731220pbc.139.1416814091369;
 Sun, 23 Nov 2014 23:28:11 -0800 (PST)
Received: by 10.66.74.134 with HTTP; Sun, 23 Nov 2014 23:27:51 -0800 (PST)
In-Reply-To: <1416786604-4988-1-git-send-email-dpb@corrigendum.ru>
X-Google-Sender-Auth: Hj6D5TfZpk9MTNINA0m1a4PsDQ8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260115>

On Sun, Nov 23, 2014 at 3:50 PM, =D0=A0=D0=BE=D0=BC=D0=B0=D0=BD =D0=94=D0=
=BE=D0=BD=D1=87=D0=B5=D0=BD=D0=BA=D0=BE <dpb@corrigendum.ru> wrote:
> The RFC says that they are to be concatenated after decoding (i.e. th=
e
> intervening whitespace is ignored).
>
> I change the sender's name to an all-Cyrillic string in the tests so =
that
> its encoded form goes over the 76 characters in a line limit, forcing
> format-patch to split it into multiple encoded words.
>
> Since I have to modify the regular expression for an encoded word any=
way,
> I take the opportunity to bring it closer to the spec, most notably
> disallowing embedded spaces and making it case-insensitive (thus allo=
wing
> the encoding to be specified as both "q" and "Q").
>
> Signed-off-by: =D0=A0=D0=BE=D0=BC=D0=B0=D0=BD =D0=94=D0=BE=D0=BD=D1=87=
=D0=B5=D0=BD=D0=BA=D0=BE <dpb@corrigendum.ru>

This sounds like a worthy thing to do in general.

I wonder if the C implementation we have for mailinfo needs similar
update, though. I vaguely recall that we have case-insensitive start fo=
r
q/b segments, but do not remember the details offhand.

Was the change to the test to use Cyrillic really necessary, or did it
suffice if you simply extended the existsing "Funny Name" spelled with
strange accents, but you substituted the whole string anyway?

Until I found out what the new string says by running web-based
translation on it, I felt somewhat uneasy. As I do not read
Cyrillic/Russian, we may have been adding some profanity without
knowing. It turns out that the string just says "Cyrillic Name", so I a=
m
not against using the new string, but it simply looked odd to replace t=
he
string whole-sale when you merely need a longer string. It made it look
as if a bug was specific to Cyrillic when it wasn't.

As you may notice by reading "git log --no-merges" from recent history,
we tend not to say "I did X, I did Y". If the tone of the above message
were more similar to them, it may have been easier to read.

But other than these minor nits, the change looks good from
a cursory read.

Thanks.

> ---
>  git-send-email.perl   | 21 +++++++++++++++------
>  t/t9001-send-email.sh | 18 +++++++++---------
>  2 files changed, 24 insertions(+), 15 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 9949db0..4bb9f6f 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -913,13 +913,22 @@ $time =3D time - scalar $#files;
>
>  sub unquote_rfc2047 {
>         local ($_) =3D @_;
> +
> +       my $et =3D qr/[!->@-~]+/; # encoded-text from RFC 2047
> +       my $sep =3D qr/[ \t]+/;
> +       my $encoded_word =3D qr/=3D\?($et)\?q\?($et)\?=3D/i;
> +
>         my $encoding;
> -       s{=3D\?([^?]+)\?q\?(.*?)\?=3D}{
> -               $encoding =3D $1;
> -               my $e =3D $2;
> -               $e =3D~ s/_/ /g;
> -               $e =3D~ s/=3D([0-9A-F]{2})/chr(hex($1))/eg;
> -               $e;
> +       s{$encoded_word(?:$sep$encoded_word)+}{
> +               my @words =3D split $sep, $&;
> +               foreach (@words) {
> +                       m/$encoded_word/;
> +                       $encoding =3D $1;
> +                       $_ =3D $2;
> +                       s/_/ /g;
> +                       s/=3D([0-9A-F]{2})/chr(hex($1))/eg;
> +               }
> +               join '', @words;
>         }eg;
>         return wantarray ? ($_, $encoding) : $_;
>  }
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 19a3ced..318b870 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -236,7 +236,7 @@ test_expect_success $PREREQ 'self name with dot i=
s suppressed' "
>  "
>
>  test_expect_success $PREREQ 'non-ascii self name is suppressed' "
> -       test_suppress_self_quoted 'F=C3=BC=C3=B1n=C3=BD N=C3=A2m=C3=A9=
' 'odd_?=3Dmail@example.com' \
> +       test_suppress_self_quoted '=D0=9A=D0=B8=D1=80=D0=B8=D0=BB=D0=BB=
=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=BE=D0=B5 =D0=98=D0=BC=D1=8F' 'odd_?=3D=
mail@example.com' \
>                 'non_ascii_self_suppressed'
>  "
>
> @@ -946,25 +946,25 @@ test_expect_success $PREREQ 'utf8 author is cor=
rectly passed on' '
>         clean_fake_sendmail &&
>         test_commit weird_author &&
>         test_when_finished "git reset --hard HEAD^" &&
> -       git commit --amend --author "F=C3=BC=C3=B1n=C3=BD N=C3=A2m=C3=
=A9 <odd_?=3Dmail@example.com>" &&
> -       git format-patch --stdout -1 >funny_name.patch &&
> +       git commit --amend --author "=D0=9A=D0=B8=D1=80=D0=B8=D0=BB=D0=
=BB=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=BE=D0=B5 =D0=98=D0=BC=D1=8F <odd_?=
=3Dmail@example.com>" &&
> +       git format-patch --stdout -1 >nonascii_name.patch &&
>         git send-email --from=3D"Example <nobody@example.com>" \
>           --to=3Dnobody@example.com \
>           --smtp-server=3D"$(pwd)/fake.sendmail" \
> -         funny_name.patch &&
> -       grep "^From: F=C3=BC=C3=B1n=C3=BD N=C3=A2m=C3=A9 <odd_?=3Dmai=
l@example.com>" msgtxt1
> +         nonascii_name.patch &&
> +       grep "^From: =D0=9A=D0=B8=D1=80=D0=B8=D0=BB=D0=BB=D0=B8=D1=87=
=D0=B5=D1=81=D0=BA=D0=BE=D0=B5 =D0=98=D0=BC=D1=8F <odd_?=3Dmail@example=
=2Ecom>" msgtxt1
>  '
>
>  test_expect_success $PREREQ 'utf8 sender is not duplicated' '
>         clean_fake_sendmail &&
>         test_commit weird_sender &&
>         test_when_finished "git reset --hard HEAD^" &&
> -       git commit --amend --author "F=C3=BC=C3=B1n=C3=BD N=C3=A2m=C3=
=A9 <odd_?=3Dmail@example.com>" &&
> -       git format-patch --stdout -1 >funny_name.patch &&
> -       git send-email --from=3D"F=C3=BC=C3=B1n=C3=BD N=C3=A2m=C3=A9 =
<odd_?=3Dmail@example.com>" \
> +       git commit --amend --author "=D0=9A=D0=B8=D1=80=D0=B8=D0=BB=D0=
=BB=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=BE=D0=B5 =D0=98=D0=BC=D1=8F <odd_?=
=3Dmail@example.com>" &&
> +       git format-patch --stdout -1 >nonascii_name.patch &&
> +       git send-email --from=3D"=D0=9A=D0=B8=D1=80=D0=B8=D0=BB=D0=BB=
=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=BE=D0=B5 =D0=98=D0=BC=D1=8F <odd_?=3D=
mail@example.com>" \
>           --to=3Dnobody@example.com \
>           --smtp-server=3D"$(pwd)/fake.sendmail" \
> -         funny_name.patch &&
> +         nonascii_name.patch &&
>         grep "^From: " msgtxt1 >msgfrom &&
>         test_line_count =3D 1 msgfrom
>  '
> --
> 2.1.1
>

From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [WIP PATCH 0/5] support --exclude for diff/log commands
Date: Wed, 23 Mar 2011 19:10:07 +0700
Message-ID: <AANLkTimeEWOvmNXQV9fJKe23Qe3sipT7q=qHVB2fLq0n@mail.gmail.com>
References: <1299726819-5576-1-git-send-email-pclouds@gmail.com>
 <7vmxl37bdp.fsf@alter.siamese.dyndns.org> <7vvczr5pw6.fsf@alter.siamese.dyndns.org>
 <AANLkTimsv9bO+Go6Mqrrp_1-AZ=sC3ndyAuskPYLVbkv@mail.gmail.com>
 <AANLkTimWPoMEYdLCwTTit6AeuJegOc96gE1JsO8B4fh=@mail.gmail.com>
 <4D871E51.8090106@drmicha.warpmail.net> <7v7hbqk8ox.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 13:10:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Mtj-0005x9-RS
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 13:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794Ab1CWMKj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2011 08:10:39 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61930 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062Ab1CWMKi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 08:10:38 -0400
Received: by wya21 with SMTP id 21so7585086wya.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 05:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=jfwClBRBVmJy3dA175cs5Vs8DyjbccF0YR00teX08vo=;
        b=CQYQ5byvmbvR4tzmULYkHjaKbOOJpCsnA28TEI7m/olu8Sj61HBagPIHG7Q7CStijg
         4io/myfXSg2rInBm8504fpieR7GY3FCmrPfJUxEv+Y753a6MluaTJgbVnVFCPpjWnooi
         qWIGrrI8J6GhuWgtP9vleK6DEEmQkWwutLTXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=UeeS8nYvcY1Z/P6netFMR41X5gJ5r8frJSgOhLbzcrwRoOliZeXyHuJMlA2NPnRUbK
         cLaVCJYtzSeMp35OdFlzJCJnVLyl9wJQVoyW2Jvo7hwqiSsLAB5oQwTY0QePMU8biURd
         8eegjBmebYSreDqSNGa7Kx/9+geL336K9F20M=
Received: by 10.216.242.134 with SMTP id i6mr1097192wer.81.1300882237136; Wed,
 23 Mar 2011 05:10:37 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Wed, 23 Mar 2011 05:10:07 -0700 (PDT)
In-Reply-To: <7v7hbqk8ox.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169821>

On Wed, Mar 23, 2011 at 6:59 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Let's clarify by dumping my understanding of what we aim to achieve.
>
> ...
>
> Both the ":/<path>" proposal (or your ":<path>" proposal) changes onl=
y a
> very small part of the above, namely, "each prefixed with '<prefix>'"=
 is
> changed to if the element in original pathspec has the magic colon pr=
efix,
> the magic is stripped away, and the remainder becomes the element in =
the
> resulting pathspec array without additional <prefix> in front.

Correct.

> If Nguyen's proposal is to also match ":/<path>" (or ":<path>") liter=
ally,
> that part should be scrapped. =C2=A0If somebody wants to match such a=
n unusual
> path component, it can always be expressed by quoting it as a glob,
> i.e. "[:]/<path>" (or "[:]<path").

OK.

> I am slightly in favor of ":<path>" syntax (than ":/<path>"), but I d=
o not
> care too deeply. =C2=A0Either has the same problem that it will be co=
nfusing
> with existing and well-established syntax (the former would conflict =
with
> "name of the blob in the index", the latter with "name of the commit =
that
> match the regexp).

How about ":<path>" for root pathspecs, but reserve ':[^0-9A-Za-z]*'
for future use?

(on top of Michael's patch)

-- 8< --
diff --git a/setup.c b/setup.c
index ef55e5d..1ebe1d2 100644
--- a/setup.c
+++ b/setup.c
@@ -146,8 +146,13 @@ const char **get_pathspec(const char *prefix,
const char **pathspec)
 	while (*src) {
 		const char *p;

-		if ((*src)[0] =3D=3D ':')
+		if ((*src)[0] =3D=3D ':') {
+			const char *reserved =3D "~`!@#$%^&*()-_=3D+[{]}\\|;:'\",<.>/?";
+			if (strchr(reserved, (*src)[1]))
+				die("':%c' syntax is not supported. "
+				    "Quote it to match literally.", (*src)[1]);
 			p =3D prefix_path(NULL, 0, (*src)+1);
+		}
 		else
 			p =3D prefix_path(prefix, prefixlen, *src);
 		*(dst++) =3D p;
-- 8< --
--=20
Duy

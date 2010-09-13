From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] Makefile: only add gettext tests on XGETTEXT_INCLUDE_TESTS=YesPlease
Date: Mon, 13 Sep 2010 12:47:56 +0000
Message-ID: <1284382076-1907-1-git-send-email-avarab@gmail.com>
References: <alpine.DEB.2.00.1009130810580.31516@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 13 14:48:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ov8SH-0002GK-Gh
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 14:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755130Ab0IMMsL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 08:48:11 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33425 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754714Ab0IMMsK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 08:48:10 -0400
Received: by wwb13 with SMTP id 13so57976wwb.1
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 05:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Wm7zTOv08givkr+AgAHZfG6VcHY6Xpddm6KLhWcBKYY=;
        b=p3z0QJ4+ogFUEHuZt3Il+Bep/7vE+kQ6OfAf9u3f4S57Ny3Kt8VhByqKUHSibD9Nyd
         28nN2Lbwv24V+hHp2KzljmWuKwvI+QVArg18jPLQ+KHlq8pPWE1ZzvM8i4k1vYBjIl1w
         9MP4rz3OXygkZpvRUdwG7qNfatQngyGDwSK8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=cvLZnjrnDua0zuiguSBTax4EKWF4LvByyC893SQ/5b+zX4kLyKfDSSLeBKdWIdTFWB
         x1rRs/KDAmoD2l2GlcYZLMscH/lnC5MTRNT9w1cEYbl43CUSe2zXcHse/3d2JBmQ7N+0
         27xsUlhPRfcfiQrsVq9m618K30zLcoXTUHs+M=
Received: by 10.227.135.18 with SMTP id l18mr51039wbt.120.1284382089249;
        Mon, 13 Sep 2010 05:48:09 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm5211340wbe.23.2010.09.13.05.48.07
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Sep 2010 05:48:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <alpine.DEB.2.00.1009130810580.31516@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156086>

Change the "pot" target so that the xgettext(1) invocation no longer
include test files from t/t0200.

These should only be included in the Icelandic is.po file since Git's
own test suite uses them for regression tests, but nobody else should
translate them. Previously I indicated this with a TRANSLATORS comment
for all the strings:

    #. TRANSLATORS: This is a test. You don't need to translate it.
    #, c-format
    msgid "TEST: A C test string %s"
    msgstr ""

But if translators follow those instructions they'll never have 100%
translation coverage. It's much better to add a hidden option so that
is.po now has to use a special git.pot file for msgmerge(1):

    make pot XGETTEXT_INCLUDE_TESTS=3DYesPlease

But everything else can continue to use the documented:

    make pot

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

On Mon, Sep 13, 2010 at 07:15, Peter Krefting <peter@softwolves.pp.se> =
wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> * You're translating the TEST: messages, it's redundant except for
>>  Icelandic (which uses it for git.git tests), but I can see how it
>>  can be painful to have non-100% translation coverage.
>
> I just copied them verbatim, I didn't actually translate them. Withou=
t
> translating them I can't tell if I've translated everything when doin=
g a
> "msgfmt -vvv --check sv.po".

This is a much better solution then. I'll submit this as part of an
updated ab/i18n series.

 Makefile |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 8cec626..680e578 100644
--- a/Makefile
+++ b/Makefile
@@ -2047,9 +2047,15 @@ XGETTEXT_OPTIONS_C =3D $(XGETTEXT_OPTIONS) --key=
word=3D_ --keyword=3DN_ --language=3DC
 XGETTEXT_OPTIONS_SH =3D $(XGETTEXT_OPTIONS) --language=3DShell
 XGETTEXT_OPTIONS_PERL =3D $(XGETTEXT_OPTIONS) --keyword=3D__ --languag=
e=3DPerl
=20
-LOCALIZED_C =3D $(C_OBJ:o=3Dc) t/t0200/test.c
-LOCALIZED_SH =3D $(SCRIPT_SH) t/t0200/test.sh
-LOCALIZED_PERL =3D $(SCRIPT_PERL) t/t0200/test.perl
+LOCALIZED_C =3D $(C_OBJ:o=3Dc)
+LOCALIZED_SH =3D $(SCRIPT_SH)
+LOCALIZED_PERL =3D $(SCRIPT_PERL)
+
+ifdef XGETTEXT_INCLUDE_TESTS
+LOCALIZED_C +=3D t/t0200/test.c
+LOCALIZED_SH +=3D t/t0200/test.sh
+LOCALIZED_PERL +=3D t/t0200/test.perl
+endif
=20
 pot:
 	$(XGETTEXT) $(XGETTEXT_OPTIONS_C) $(LOCALIZED_C)
--=20
1.7.2.3.313.gcd15

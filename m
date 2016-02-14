From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 09/12] grep/pcre: support utf-8
Date: Sun, 14 Feb 2016 18:49:53 +0700
Message-ID: <1455450596-11904-10-git-send-email-pclouds@gmail.com>
References: <1454724190-14063-1-git-send-email-pclouds@gmail.com>
 <1455450596-11904-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 14 12:52:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUvDl-0001YN-EU
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 12:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbcBNLwF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2016 06:52:05 -0500
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35755 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbcBNLwD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 06:52:03 -0500
Received: by mail-pa0-f68.google.com with SMTP id fl4so5964844pad.2
        for <git@vger.kernel.org>; Sun, 14 Feb 2016 03:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=feX+SQnnwe1QQ+CNKTHtN6SDmuQaRO5+XdszdygoA9w=;
        b=KkxDclJt3Q6udfpsD1D88vOsm9G12XDdJ3cIW0snwC+OoMKVqkfwUIsQfqRfgBnCpR
         ysCfKKKf7Yv3sVW4JXo2xQjFndvxG2EbP5cw8xQt64hb1OpB+/R+VJiJkFVmsmn8E+l3
         sAnwDPZeWRmavjjJoHVvUQqBT8NQTzIlA50MKJNC7xYvCblK3v0klVhHkeF+07mRlBPr
         0uGk+Emx45E1irjtYJmGQ5EoYaagK/2LLvIlc6sn6LrQtwYBlGJMdbvjC0jzojr+Ztnd
         kI6lTyBV0Db3zDfxQgi/g1J0iaP/H/9k28v85ZELpQlgkorbgiHkIZR0b1dHM6wQPvnV
         nFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=feX+SQnnwe1QQ+CNKTHtN6SDmuQaRO5+XdszdygoA9w=;
        b=KQvnfKwApcSwiVsbMPqJxMoAUNh4/Nw6/nkU98kmkaOFfXCdq6X6Dpm+MXMERvqbgv
         A1aXgcCX7QHistFbK78uNGLDZf5HlizQgJHbbv476VZ2sW6MDBUiHfeL0Nva8K2aOyiK
         HoXdU9k5h9lHvqWZg+a+iqcvegqLtC7watvWtHMvbyf1TrWPTi9NugkaunX5xo50UVeI
         0/oOjG5LWDHaOZDSL/tnwqTcmwxcm+KI9TNGB+sfjE6rQq4Mg2Gc8LWSYFyIIw5gs3pN
         dY4y14IwfNRLoNZ8hZUdJLCKDbz27c98MkWDyZhVK81NYAvpAesEoi1IjxqVDaYkS//q
         QXXg==
X-Gm-Message-State: AG10YOSMFpY4sqAryBcD54cDxgRmLqKHhJGk42m5CawuXj7DhjtVKnFrIM+oG81YrzG3AA==
X-Received: by 10.66.193.131 with SMTP id ho3mr15479537pac.154.1455450723169;
        Sun, 14 Feb 2016 03:52:03 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id k14sm31324670pfj.0.2016.02.14.03.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Feb 2016 03:52:02 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Feb 2016 18:52:23 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455450596-11904-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286144>

In the previous change in this function, we add locale support for
single-byte encodings only. It looks like pcre only supports utf-* as
multibyte encodings, the others are left in the cold (which is
fine).

We need to enable PCRE_UTF8 so pcre can find character boundary
correctly. It's needed for case folding (when --ignore-case is used)
or '*', '+' or similar syntax is used.

The "has_non_ascii()" check is to be on the conservative side. If
there's non-ascii in the pattern, the searched content could still be
in utf-8, but we can treat it just like a byte stream and everything
should work. If we force utf-8 based on locale only and pcre validates
utf-8 and the file content is in non-utf8 encoding, things break.

Noticed-by: Plamen Totev <plamen.totev@abv.bg>
Helped-by: Plamen Totev <plamen.totev@abv.bg>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 grep.c                          |  2 ++
 t/t7812-grep-icase-non-ascii.sh | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/grep.c b/grep.c
index 22f4d99..6e99b01 100644
--- a/grep.c
+++ b/grep.c
@@ -329,6 +329,8 @@ static void compile_pcre_regexp(struct grep_pat *p,=
 const struct grep_opt *opt)
 			p->pcre_tables =3D pcre_maketables();
 		options |=3D PCRE_CASELESS;
 	}
+	if (is_utf8_locale() && has_non_ascii(p->pattern))
+		options |=3D PCRE_UTF8;
=20
 	p->pcre_regexp =3D pcre_compile(p->pattern, options, &error, &erroffs=
et,
 				      p->pcre_tables);
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-a=
scii.sh
index 5832684..842b26a 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -20,6 +20,21 @@ test_expect_success REGEX_LOCALE 'grep literal strin=
g, no -F' '
 	git grep -i "TILRAUN: HALL=C3=93 HEIMUR!"
 '
=20
+test_expect_success GETTEXT_LOCALE,LIBPCRE 'grep pcre utf-8 icase' '
+	git grep --perl-regexp    "TILRAUN: H.ll=C3=B3 Heimur!" &&
+	git grep --perl-regexp -i "TILRAUN: H.ll=C3=B3 Heimur!" &&
+	git grep --perl-regexp -i "TILRAUN: H.LL=C3=93 HEIMUR!"
+'
+
+test_expect_success GETTEXT_LOCALE,LIBPCRE 'grep pcre utf-8 string wit=
h "+"' '
+	printf "TILRAUN: Hall=C3=B3=C3=B3 Heimur!" >file2 &&
+	git add file2 &&
+	git grep -l --perl-regexp "TILRAUN: H.ll=C3=B3+ Heimur!" >actual &&
+	echo file >expected &&
+	echo file2 >>expected &&
+	test_cmp expected actual
+'
+
 test_expect_success REGEX_LOCALE 'grep literal string, with -F' '
 	git grep --debug -i -F "TILRAUN: Hall=C3=B3 Heimur!"  2>&1 >/dev/null=
 |
 		 grep fixed >debug1 &&
--=20
2.7.0.377.g4cd97dd

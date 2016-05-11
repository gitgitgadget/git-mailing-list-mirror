From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/7] submodule--helper: add valid-label-name
Date: Tue, 10 May 2016 17:59:51 -0700
Message-ID: <1462928397-1708-2-git-send-email-sbeller@google.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com,
	Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com, gitster@pobox.com, Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Wed May 11 03:00:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0IVt-00028Y-QB
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 03:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbcEKBAS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2016 21:00:18 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36438 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbcEKBAH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 21:00:07 -0400
Received: by mail-pa0-f49.google.com with SMTP id bt5so11014838pac.3
        for <git@vger.kernel.org>; Tue, 10 May 2016 18:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a6bk9Iwkc3Y3WwPFIqEKQoeuqxr1tlUVvkcNseU8umA=;
        b=MC+qqda87+Q5SypdpF311tUht6qvL7mkaVqdfoKzmDH8FTjp+Iy9d0zN7Qb4JRAiQZ
         3ovbxZV+THMOTMjOApbACq8/gjoSrTQ9elUAvbsX9w7RXGAkNoJQeaMGvnQke3PZNFzh
         XpiPuOeAMuByzUurBX6M2p84tZVkodvuly3hIo9TBH1PXqVsYowlawDKAxBC1d1zxWoT
         ItrtC5F9AdyFtHJLCzonI08yDdWu5S3lm1XXLGdKgTrNFm40kkD5SQEPUHQPtT9yl22U
         UWb6iZgOQEfHZdtmPbSPekfhBp/468g06GaQqwkU3WVHwRq2BFvYukdnkJytXY5V11ho
         8b6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a6bk9Iwkc3Y3WwPFIqEKQoeuqxr1tlUVvkcNseU8umA=;
        b=Ao7hPXc1kAxOTU8WRo+AjY7IIo4KIcpXYHjrTNw31TAi9eShzu9/NoEERmD8N3JPpS
         /mJKz+b6g2sfx9aA4Kt9Bn9ewtiTS/Ezp1C8OKrH7HWehwYbqGbwiVqmCCDRU1u1cmHF
         K4gNX3UUFkprQ8zQuARccI1m0r27VQeRWQLRN8h8igBqny3KNkAaLxTiwBjFXP/T+sIH
         uRWvnwyNQ/2S1qRc8aFUs8p3JkhRj31a3QwhEpdgwAUYiHNLtjPqnWNwcLB+XsUUFE40
         JxyYFYI4or2g9lF0oBI1L3SOMERP9Q60oUlrIgzGiGJ/0/B4oaRphzluRTHWu/aF7Sho
         bK9g==
X-Gm-Message-State: AOPr4FX2NrLEVI5o+Vywj+MXwoLvLsoYyOgb670Nb6KffBtLrRLr3mhnN0HOXaUqM5d0Fxtj
X-Received: by 10.67.23.161 with SMTP id ib1mr710654pad.156.1462928406077;
        Tue, 10 May 2016 18:00:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:69ac:db78:a0d1:60da])
        by smtp.gmail.com with ESMTPSA id h88sm7264378pfd.10.2016.05.10.18.00.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 10 May 2016 18:00:05 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.35.g58985d9.dirty
In-Reply-To: <1462928397-1708-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294214>

We could allow more than just alphanumeric and dash characters
for submodule labels. As a precaution we'll first allow only this
subset and later on we can extend it once we have more experience
with them.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c  | 30 ++++++++++++++++++++++++++-
 t/t7412-submodule--helper.sh | 49 ++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 78 insertions(+), 1 deletion(-)
 create mode 100755 t/t7412-submodule--helper.sh

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 7f0941d..d3f4684 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -831,6 +831,33 @@ static int update_clone(int argc, const char **arg=
v, const char *prefix)
 	return 0;
 }
=20
+static int submodule_valid_label_name(const char *label)
+{
+	if (!label || !strlen(label))
+		return 0;
+
+	if (!isalnum(*label))
+		return 0;
+
+	while (*label) {
+		if (!(isalnum(*label) ||
+			*label =3D=3D '-'))
+			return 0;
+		label++;
+	}
+
+	return 1;
+}
+
+static int valid_label_name(int argc, const char **argv, const char *p=
refix)
+{
+	if (argc =3D=3D 2 && submodule_valid_label_name(argv[1]))
+		return 0;
+
+	die(_("submodule label must start with an alphanumeric character"
+	      "and must contain alphanumeric characters or dashes only."));
+}
+
 struct cmd_struct {
 	const char *cmd;
 	int (*fn)(int, const char **, const char *);
@@ -843,7 +870,8 @@ static struct cmd_struct commands[] =3D {
 	{"update-clone", update_clone},
 	{"resolve-relative-url", resolve_relative_url},
 	{"resolve-relative-url-test", resolve_relative_url_test},
-	{"init", module_init}
+	{"init", module_init},
+	{"valid-label-name", valid_label_name}
 };
=20
 int cmd_submodule__helper(int argc, const char **argv, const char *pre=
fix)
diff --git a/t/t7412-submodule--helper.sh b/t/t7412-submodule--helper.s=
h
new file mode 100755
index 0000000..3af315c
--- /dev/null
+++ b/t/t7412-submodule--helper.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+
+test_description=3D'Basic plumbing support of submodule--helper
+
+This test verifies the submodule--helper plumbing command used to impl=
ement
+git-submodule.
+'
+
+. ./test-lib.sh
+
+
+test_expect_success 'valid-label-name tests empty label' '
+	test_must_fail git submodule--helper valid-label-name 2>actual &&
+	test_i18ngrep alphanumeric actual &&
+	test_must_fail git submodule--helper valid-label-name "" 2>actual &&
+	test_i18ngrep alphanumeric actual
+'
+
+test_expect_success 'valid-label-name tests correct label asdf' '
+	git submodule--helper valid-label-name asdf 2>actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'valid-label-name tests correct label a' '
+	git submodule--helper valid-label-name a 2>actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'valid-label-name tests correct label a-b' '
+	git submodule--helper valid-label-name a-b 2>actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'valid-label-name fails with multiple arguments' '
+	test_must_fail git submodule--helper valid-label-name a b 2>actual &&
+	test_i18ngrep alphanumeric actual
+'
+
+test_expect_success 'valid-label-name fails with white spaced argument=
s' '
+	test_must_fail git submodule--helper valid-label-name "a b" 2>actual =
&&
+	test_i18ngrep alphanumeric actual
+'
+
+test_expect_success 'valid-label-name fails with utf8 characters' '
+	test_must_fail git submodule--helper valid-label-name =E2=98=BA 2>act=
ual &&
+	test_i18ngrep alphanumeric actual
+'
+
+test_done
--=20
2.8.0.35.g58985d9.dirty

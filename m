Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAC6C433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 09:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJGJaz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 05:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJGJat (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 05:30:49 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8E7B8C3F
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 02:30:47 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bv10so2821714wrb.4
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 02:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWhK8WmwG6YLEC7geu3uZt3J3/uCWguqCGeUj6zNVLo=;
        b=jOJWAtdg2zbU59f+yo9FoMIWovFmefFtxgRO85NVqSAy1LPOsvFiUQWZWK4xEXO2bU
         4jAvyPu8aDqZ1vhW/2YaKr9uAmasw/OJHHge1Smt+5Xa/Cq+wPtoaY2BG0Ju3oXBUB2u
         dk4SvJqf2ciU6mjXm+EuufGgViapGuR6Xmp3hk8QdUL6yMQOo95aomR5Ni5bDMWX8b7r
         jLvPiah73csn2oqoE599QRU8RtNdlGxNC44i+F2BTmueT+4PSmKIRQuhhhFGa1WR5+Oq
         8sgmQ1sIgVL3n+DOwzRCNN5tcJwDsKKQ/L4NhPm/Nl+XZetm36pP1La7+OtxkeheljiG
         HBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWhK8WmwG6YLEC7geu3uZt3J3/uCWguqCGeUj6zNVLo=;
        b=FJiDOA67OIiNk+JUnBvK8LS5py5mgIRq0Upl/n2m75BVOLeKSIWskwpmo6ON1ahh+B
         EuJ308eMjO2nxeeZY7Plos93mVsmlsqlpJDKmFCrxtMNRxjrWA9cdT9QlLYuOaf22ukY
         MYas1JQP4GVSzjQSoVeAyZp/shlOs2pFw/hctqei9ggqoTDIJKaRkdU/Z5OiqX6I4Xro
         6OOSD1/6eKbAxFn9dkGRuCNiucvDdyK1p7+gMGdapIXNUFIOrTNEMSY5ZlKg7af0e9et
         a/IZDeZNtWjPhmXFswQWpLeg2JTwJjSD5kWILOJhNaU6H2NkQtcNEPQbO1iFIxmwtzgH
         CcOQ==
X-Gm-Message-State: ACrzQf0MYWLnT3p45v319zBvETXHSxDTzxd4nVY9kW1ZiKidN74AIoqq
        dTRLi0tqcZdVRoZSgCdJa/ianMHdmBeohQ==
X-Google-Smtp-Source: AMsMyM7uuI8zvC6vsRvBa0eYvxNmoEcEAZ0wPar+vpSNVnh/v3kt3JAl6uysp5yazLiMWkol7XmGLA==
X-Received: by 2002:a5d:558f:0:b0:22e:2fac:d550 with SMTP id i15-20020a5d558f000000b0022e2facd550mr2683421wrv.652.1665135045807;
        Fri, 07 Oct 2022 02:30:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o18-20020a1c7512000000b003b492753826sm1634945wmc.43.2022.10.07.02.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 02:30:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] CodingGuidelines: allow declaring variables in for loops
Date:   Fri,  7 Oct 2022 11:30:32 +0200
Message-Id: <patch-3.5-80afc246666-20221007T092505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-0.5-00000000000-20221007T092505Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20221007T092505Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 44ba10d6712 (revision: use C99 declaration of variable in for()
loop, 2021-11-14) released with v2.35.0 we've had a variable declared
with in a for loop.

Since then we've had inadvertent follow-ups to that with at least
cb2607759e2 (merge-ort: store more specific conflict information,
2022-06-18) released with v2.38.0.

As November 2022 is within the window of this upcoming release let's
update the guideline to allow this, and revert the recent
6983f4e3b20 (test-parse-options.c: don't use for loop initial
declaration, 2022-09-05).

It's better to update the guidelines than to have back & forth churn
like that, we clearly don't have portability issues related to this
syntax.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/CodingGuidelines | 10 ++--------
 revision.c                     |  7 -------
 t/helper/test-parse-options.c  |  3 +--
 3 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 8afda28cfce..f9affc4050a 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -232,18 +232,12 @@ For C programs:
    . since early 2021 with 765dc168882, we have been using variadic
      macros, mostly for printf-like trace and debug macros.
 
-   These used to be forbidden, but we have not heard any breakage
-   report, and they are assumed to be safe.
+   . since late 2021 with 44ba10d6, we have had variables declared in
+     the for loop "for (int i = 0; i < 10; i++)".
 
  - Variables have to be declared at the beginning of the block, before
    the first statement (i.e. -Wdeclaration-after-statement).
 
- - Declaring a variable in the for loop "for (int i = 0; i < 10; i++)"
-   is still not allowed in this codebase.  We are in the process of
-   allowing it by waiting to see that 44ba10d6 (revision: use C99
-   declaration of variable in for() loop, 2021-11-14) does not get
-   complaints.  Let's revisit this around November 2022.
-
  - NULL pointers shall be written as NULL, not as 0.
 
  - When declaring pointers, the star sides with the variable
diff --git a/revision.c b/revision.c
index 36e31942cee..8f2623b3b5a 100644
--- a/revision.c
+++ b/revision.c
@@ -47,13 +47,6 @@ static inline int want_ancestry(const struct rev_info *revs);
 void show_object_with_name(FILE *out, struct object *obj, const char *name)
 {
 	fprintf(out, "%s ", oid_to_hex(&obj->oid));
-	/*
-	 * This "for (const char *p = ..." is made as a first step towards
-	 * making use of such declarations elsewhere in our codebase.  If
-	 * it causes compilation problems on your platform, please report
-	 * it to the Git mailing list at git@vger.kernel.org. In the meantime,
-	 * adding -std=gnu99 to CFLAGS may help if you are with older GCC.
-	 */
 	for (const char *p = name; *p && *p != '\n'; p++)
 		fputc(*p, out);
 	fputc('\n', out);
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 506835521a4..f8a62d892d9 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -195,8 +195,7 @@ int cmd__parse_options(int argc, const char **argv)
 
 static void print_args(int argc, const char **argv)
 {
-	int i;
-	for (i = 0; i < argc; i++)
+	for (int i = 0; i < argc; i++)
 		printf("arg %02d: %s\n", i, argv[i]);
 }
 
-- 
2.38.0.971.ge79ff6d20e7


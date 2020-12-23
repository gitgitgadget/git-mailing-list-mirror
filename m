Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C3FC43219
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F212256F
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbgLWBj1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 20:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgLWBj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 20:39:26 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BF9C0619D2
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:38:02 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d26so16942423wrb.12
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GfJIEFQtBsrB4ifACMYzqyRGiVW7eIAlC5YRbODu2Hg=;
        b=ANc9ptqpyLJ3h9glT6RWDq+A0ckWWyRXPBCI/RcQX+J0CwTqw6RDkHMbMuQW2zo/vb
         p5G3fFp84LpMeVOHus1nDfHsb27wCPp6aIeFAXQKXzzp5OVslobI0duDohCkE6d9gU28
         MV5uyrq61d2xGDOkKYaYQlQK9qZgFNy00RzYnDX/5MEoNHRZY83Qd3Nd3a+0INekEvnQ
         9KiNHuvleb8J6OV16fcFQzy9iqd9cp05qC+ER60U3qHSCB7Ni1YTG6k9Z9LK2uFPfAO1
         Uek62J8del1xSEyJzHtKXcSbNepQuflG3HEikqXm+A2nMbXblbTjcb2/6dY2Upv+IhxV
         5hug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GfJIEFQtBsrB4ifACMYzqyRGiVW7eIAlC5YRbODu2Hg=;
        b=iZGWN5WGaviTVLLwsX/Du8kcgX2i6N17M8yIgvyY+tdvGGTsvQ0Lox3hI0Vjve64JU
         s9wBV4niu94geZubHAd/A7wm3xaNmmiBgaPYlAj84ejKQR8x/6WDUIfWSNxfpxgJx9nb
         qsuUs0+QG+BZWPG/EjUrDtksxr34x1n+s7oyLuRqrakoSltJOO9zz65RK66sP5kQyheX
         WkqW3Tj29mdHLqtHOfu+wCG6O65iC/o6lVaePdWNVdvXUe3mm2GjpEfuTDcFUVCnS0Rw
         1utxW0Jg2OTfcwYNkDTmBq6EgrgQDWsqCNSvnR97xShMmOkokN1/dBtwVD/v+O+xKzeE
         55yg==
X-Gm-Message-State: AOAM5303dXeJ3uv+mOiAnbh52xhIZOQvYvHqrdAWpLAlLwMz3VlT79BK
        DkfowTDNywIZeHo316Tb42Hb2c0iGB9dTQ==
X-Google-Smtp-Source: ABdhPJzj5rIh4jK5UkQJIXP9IqLRmT+Eq9Tyyvf02lz1QRm30KnIkR18YdUJqzBQ9szvhqdX4T6hwA==
X-Received: by 2002:adf:c454:: with SMTP id a20mr26690936wrg.314.1608687481002;
        Tue, 22 Dec 2020 17:38:01 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d191sm28492563wmd.24.2020.12.22.17.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 17:38:00 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 19/20] mktag: mark strings for translation
Date:   Wed, 23 Dec 2020 02:36:04 +0100
Message-Id: <20201223013606.7972-20-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201209200140.29425-1-avarab@gmail.com>
References: <20201209200140.29425-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark the errors mktag might emit for translation. This is a plumbing
command, but the errors it emits are intended to be human-readable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/mktag.c  | 16 ++++++++--------
 t/t3800-mktag.sh |  3 ++-
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index 18b8492f4d..9b04b61c2b 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -31,10 +31,10 @@ static int mktag_fsck_error_func(struct fsck_options *o,
 		 * like missing "tagger" lines are "only" warnings
 		 * under fsck, we've always considered them an error.
 		 */
-		fprintf_ln(stderr, "error: tag input does not pass fsck: %s", message);
+		fprintf_ln(stderr, _("error: tag input does not pass fsck: %s"), message);
 		return 1;
 	default:
-		BUG("%d (FSCK_IGNORE?) should never trigger this callback",
+		BUG(_("%d (FSCK_IGNORE?) should never trigger this callback"),
 		    msg_type);
 	}
 }
@@ -49,10 +49,10 @@ static int verify_object_in_tag(struct object_id *tagged_oid, int *tagged_type)
 
 	buffer = read_object_file(tagged_oid, &type, &size);
 	if (!buffer)
-		die("could not read tagged object '%s'",
+		die(_("could not read tagged object '%s'"),
 		    oid_to_hex(tagged_oid));
 	if (type != *tagged_type)
-		die("object '%s' tagged as '%s', but is a '%s' type",
+		die(_("object '%s' tagged as '%s', but is a '%s' type"),
 		    oid_to_hex(tagged_oid),
 		    type_name(*tagged_type), type_name(type));
 
@@ -79,7 +79,7 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 			     builtin_mktag_usage, 0);
 
 	if (strbuf_read(&buf, 0, 0) < 0)
-		die_errno("could not read from stdin");
+		die_errno(_("could not read from stdin"));
 
 	fsck_options.error_func = mktag_fsck_error_func;
 	fsck_set_msg_type(&fsck_options, "extraheaderentry", "warn");
@@ -87,13 +87,13 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 	git_config(mktag_config, NULL);
 	if (fsck_tag_standalone(NULL, buf.buf, buf.len, &fsck_options,
 				&tagged_oid, &tagged_type))
-		die("tag on stdin did not pass our strict fsck check");
+		die(_("tag on stdin did not pass our strict fsck check"));
 
 	if (verify_object_in_tag(&tagged_oid, &tagged_type))
-		die("tag on stdin did not refer to a valid object");
+		die(_("tag on stdin did not refer to a valid object"));
 
 	if (write_object_file(buf.buf, buf.len, tag_type, &result) < 0)
-		die("unable to write tag file");
+		die(_("unable to write tag file"));
 
 	strbuf_release(&buf);
 	puts(oid_to_hex(&result));
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 177ab1682d..2e8b718379 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -14,7 +14,8 @@ test_description='git mktag: tag object verify test'
 check_verify_failure () {
 	expect="$2"
 	test_expect_success "$1" '
-		test_must_fail git mktag <tag.sig 2>message &&
+		test_must_fail env GIT_TEST_GETTEXT_POISON=false \
+			git mktag <tag.sig 2>message &&
 		grep "$expect" message
 	'
 }
-- 
2.29.2.222.g5d2a92d10f8


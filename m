Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4585C4332E
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD60F22D72
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbhAETpd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730989AbhAETpb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:45:31 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0BDC0617BB
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:43:52 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id q75so630559wme.2
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WuEfYMYzgANieS8+MDhbaNf0sYlKqmE2/d3/ONfyi0M=;
        b=DUJlVr3EgqBeVpz8oyPj2GY76HpIxuWXwlkKsnjhkQzcrWy6iYLb0KG2Wz12ICPTRD
         i/l/M7okHh+jbCJE92Saox4aDTrNPZJyJwQvkVyBr1W0wv/AlqETcyqxln9pqIr/hWXY
         HaGF0dVQwA5dBL/oP4Dq/M75J+IGzY/x5pi9wRVOFPDUOl2HBXXDE4zG7S1Slno2TZa2
         gwN+RQcx8/npbp5t7wbSmKZ5OdmXLbv/rmWRj0UcRN4wof7kzlPtMMjQtAezz/NwMJyP
         cDjxrIq9bMsEeRqVzGf9Nfq82UZ+odK5pnj9cZ/aTK+dwHckKzdHyGvwUMce0wco8Tu+
         oVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WuEfYMYzgANieS8+MDhbaNf0sYlKqmE2/d3/ONfyi0M=;
        b=qyT3e3L+SVgz0L/OjAJzKKzLPZ+nG52+5e2Qo7oBC1NM1BWHKYHgDsYVefBVcc8f5Y
         UxbgkrAH39DwzC6BUm3V6K4mGTiIEbXuBVeRm4EH1WbkQO+WMPs288aGHcd4vfqSyMsr
         LNnHLFsTvrDOoWgvCJE66yPAtOmnYM2Sj0hDLW4OCPOiIuNERbaF9VuSRk+36U2hrrfE
         bXZF8IxW+QkaZxZYQKCC9gDkD+i6+VR6TKnH/TEYKVhbPrpE8t/LONXZ9dKRZfGvjvwF
         jopBwZ/6DEY+iqeYWHEoI6PLHdju7fzIzAAe+YCR1p6/4RmR2/AtTMFAxVGaxVCShgr1
         9bAg==
X-Gm-Message-State: AOAM5323/tDmBQEQZ8XQgkJtkyaJ60crqRCn7uTBwaeDDb8I165sun3S
        jLPyyi0ksn90xJZ8kXeU+xTeK/rdwbVQ2Q==
X-Google-Smtp-Source: ABdhPJzV8Un3ZyxWCuLXu7/B7cyl2P8cvPkewtRzPjsbHe9ExI+3hFw+ZXoyo2E6IDG/N1gRS1JXvw==
X-Received: by 2002:a05:600c:2903:: with SMTP id i3mr608947wmd.41.1609875830535;
        Tue, 05 Jan 2021 11:43:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6sm151113wro.79.2021.01.05.11.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:43:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 22/23] mktag: mark strings for translation
Date:   Tue,  5 Jan 2021 20:42:51 +0100
Message-Id: <20210105194252.627-23-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201223013606.7972-1-avarab@gmail.com>
References: <20201223013606.7972-1-avarab@gmail.com>
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
 builtin/mktag.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index 18b8492f4d4..9b04b61c2bb 100644
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
-- 
2.29.2.222.g5d2a92d10f8


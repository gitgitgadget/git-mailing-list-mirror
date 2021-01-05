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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D04C433E9
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AE6A22DCC
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbhAETpG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730966AbhAETpF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:45:05 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C842FC0617B1
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:43:48 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id m5so328248wrx.9
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FKEzxXyKX4o3YbLhdB1nnTXUORXSqXtuMODL749Iuz0=;
        b=gAv20sfk4PGx6SvS8/qhYrqALDCH9tlUe6wE+z9nDNMvVjjChlmbuUK4eSpiMBxCnq
         bsuI9xc+5sFrRsSi4Twa6w8Lyinfld5Yw/C9OWVjTUDcvqb54yardEoPGez+cVKTYnqZ
         ilkRNyOs/pMBjSmvnOMSSfVqXJcH12wL+EKKwcYDbrsz54ad37KSpN5H9wTucCKEd2wv
         PcOXiUPRb9vv4X64YXfVI7DWapKplOcstple+GP/Y0MsKhga8n/EOd65oom6psLXCr/v
         3ZUktYPWBlg/h513N40us8gUkqfFa6NI5ClpiNaDPaTyz27rKzlSFQ89NlykcMBF8wYq
         fbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FKEzxXyKX4o3YbLhdB1nnTXUORXSqXtuMODL749Iuz0=;
        b=H9VLVwoSx36Va4STUwrKQFb9cSs3K7VXuxJ2BfZsEaJevI/HXc2df2MDXvPUeYWJRl
         UbN+q5Nvb35s5QLLmj9NgsppVaLJiwmZQSovHEhHfDR1jEZKNPd2EuJlk2P6+F8d/KEX
         wbGRfbuss92IiOUbcFIqZE4qT4SOTt9RApz1KATzGf4MoU/+gR69LnE5D8/+f6pcToSS
         XGYeQu311AepNUjonn3kTEq4WsRhyUIWkfpy+TQk6gwiYHOanbCfqV36cSq+CVU5GHdm
         6Wi2+oL6gKr8jdIwbJ8sXz1pceL4oiDdPBhkSH6nWmfknNVNdYjF12LxzNWXvre4s5ef
         QnuQ==
X-Gm-Message-State: AOAM5300ifckK3hcIY5CvxxqN1ERW0UXnBU/7UHYq+NRti5Pim51yR3A
        BpdxKEamo3wP57+jRgLoynAqNhyh4E18vw==
X-Google-Smtp-Source: ABdhPJylmeP8wss6L0oPDLyVvWo3aSWug3u1XzG0rc5byOy54yXVj6/k66OZ9o6h8tdd+vhTW7vdJA==
X-Received: by 2002:adf:fe05:: with SMTP id n5mr1079195wrr.9.1609875827242;
        Tue, 05 Jan 2021 11:43:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6sm151113wro.79.2021.01.05.11.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:43:46 -0800 (PST)
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
Subject: [PATCH v5 19/23] mktag: allow turning off fsck.extraHeaderEntry
Date:   Tue,  5 Jan 2021 20:42:48 +0100
Message-Id: <20210105194252.627-20-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201223013606.7972-1-avarab@gmail.com>
References: <20201223013606.7972-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In earlier commits mktag learned to use the fsck machinery, at which
point we needed to add fsck.extraHeaderEntry so it could be as strict
about extra headers as it's been ever since it was implemented.

But it's not nice to need to switch away from "mktag" to "hash-object"
+ manual "fsck" just because you'd like to have an extra header. So
let's support turning it off by getting "fsck.*" variables from the
config.

Pedantically speaking it's still not possible to make "mktag" behave
just like "hash-object -t tag" does, since we're unconditionally going
to check the referenced object in verify_object_in_tag(), which is our
own check, and not one that exists in fsck.c.

But the spirit of "this works like fsck" is preserved, in that if you
created such a tag with "hash-object" and did a full "fsck" on the
repository it would also error out about that invalid object, it just
wouldn't emit the same message as fsck does.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-mktag.txt |  5 ++++-
 builtin/mktag.c             | 11 ++++++++++-
 t/t3800-mktag.sh            | 14 ++++++++++++++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index fa070e21a0b..79813ff8df0 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -32,7 +32,10 @@ would run by default in that all `fsck.<msg-id>` messages are promoted
 from warnings to errors (so e.g. a missing "tagger" line is an error).
 
 Extra headers in the object are also an error under mktag, but ignored
-by linkgit:git-fsck[1]
+by linkgit:git-fsck[1]. This extra check can be turned off by setting
+the appropriate `fsck.<msg-id>` varible:
+
+    git -c fsck.extraHeaderEntry=ignore mktag <my-tag-with-headers
 
 Tag Format
 ----------
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 4dd35bc79e2..373926d7e0c 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -3,6 +3,14 @@
 #include "replace-object.h"
 #include "object-store.h"
 #include "fsck.h"
+#include "config.h"
+
+static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
+
+static int mktag_config(const char *var, const char *value, void *cb)
+{
+	return fsck_config_internal(var, value, cb, &fsck_options);
+}
 
 static int mktag_fsck_error_func(struct fsck_options *o,
 				 const struct object_id *oid,
@@ -53,7 +61,6 @@ static int verify_object_in_tag(struct object_id *tagged_oid, int *tagged_type)
 int cmd_mktag(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
 	struct object_id tagged_oid;
 	int tagged_type;
 	struct object_id result;
@@ -66,6 +73,8 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 
 	fsck_options.error_func = mktag_fsck_error_func;
 	fsck_set_msg_type(&fsck_options, "extraheaderentry", "warn");
+	/* config might set fsck.extraHeaderEntry=* again */
+	git_config(mktag_config, NULL);
 	if (fsck_tag_standalone(NULL, buf.buf, buf.len, &fsck_options,
 				&tagged_oid, &tagged_type))
 		die("tag on stdin did not pass our strict fsck check");
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 0e2a9a883ba..dccf4503235 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -412,6 +412,20 @@ EOF
 check_verify_failure 'detect invalid header entry' \
 	'^error:.* extraHeaderEntry:'
 
+test_expect_success 'invalid header entry config & fsck' '
+	test_must_fail git mktag <tag.sig &&
+	test_must_fail git -c fsck.extraHeaderEntry=error mktag <tag.sig &&
+	test_must_fail git -c fsck.extraHeaderEntry=warn mktag <tag.sig &&
+	git -c fsck.extraHeaderEntry=ignore mktag <tag.sig &&
+	git fsck &&
+	env GIT_TEST_GETTEXT_POISON=false \
+		git -c fsck.extraHeaderEntry=warn fsck 2>err &&
+	grep "warning .*extraHeaderEntry:" err &&
+	test_must_fail env GIT_TEST_GETTEXT_POISON=false \
+		git -c fsck.extraHeaderEntry=error 2>err fsck &&
+	grep "error .* extraHeaderEntry:" err
+'
+
 cat >tag.sig <<EOF
 object $head
 type commit
-- 
2.29.2.222.g5d2a92d10f8


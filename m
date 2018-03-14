Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D0121F404
	for <e@80x24.org>; Wed, 14 Mar 2018 18:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbeCNSm5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:42:57 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43406 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbeCNSmz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:42:55 -0400
Received: by mail-pl0-f68.google.com with SMTP id f23-v6so2189375plr.10
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=rE9gAUpTYPH6wxHF2mifNFZX6avqJMd6Nn9+78sQ1kw=;
        b=qASrZ38nXPBDMbi4LswldwcUXq6hgFZH4DZrngvnqcFYRmzkKWl1BMO4FqIM17I7vh
         U8zXuWgEZq5hIu6Udjwt+/0B+hTWWFyc1r3SNO7Re6s2QpHccfsfS0sR0zKZAegEeQhW
         XH+bTUCcr/Y6a80y7x6vVRTO4zEUIqM2trE7Tit+d6zBhMEIB02szU/QHFQ1lOGVImIF
         1a/XZbdZQ81M3WeC6Nrm1E9eQ/rUKKm9W8TFrx6lAu9tzDeImLfzDPJpayNNx2EsgrO8
         WAyBQxzZXVQV5GwBA6TtZakhvth+L+PjT9BZd2m/tshCGBv/ZHfn571Ya7MBszW6Luv9
         iUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=rE9gAUpTYPH6wxHF2mifNFZX6avqJMd6Nn9+78sQ1kw=;
        b=oaFDFGOEMBQXnE0xOLrCmiUcBP0L3MCAY1XhVMrmB8tIjWvrScyVQSgLNXs8Vd/ZUl
         C1QTUBqUtyzgGTxJSF4P7AIAFal5qNZnuK058wf0DXTLjHNveBrtWaPaHjY4ldYUvy0m
         76a1/HHYypg4pJY+xRGqCL7rCAOXIV74HddLXNKktZGRtz8sPUgsw/jxIm6DRCERuWUv
         C+QmP0dE85sI9w4dqw4oedCOUk4GoVXYgX4AdmDi/OvE1wKaJNJUQ1ftiRcsqxuHVOYw
         rEpb0iMPJMN+IrwlqqBVC7UPfiTEeXQUyYXgQbWwElmcn0MnIpfzCwhECX0m9TEqTMaX
         g6Xg==
X-Gm-Message-State: AElRT7FIM9y8r1Ydmc8YvXCBETQfRxsAOF+jsRiAsSk6KRMZMkTssY8P
        hCNScyLS6YixW/cjJ435g4dVIIrg9R4=
X-Google-Smtp-Source: AG47ELvMybTjm7WGskJaofZ3ldzkUq6HDR53dNLNetGXqBqr9xbm8jCiU2eJG32AAVYmxkQqm/Lo6g==
X-Received: by 2002:a17:902:9307:: with SMTP id bc7-v6mr4983958plb.29.1521052973854;
        Wed, 14 Mar 2018 11:42:53 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id l22sm6255351pfj.98.2018.03.14.11.42.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Mar 2018 11:42:52 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 1/2] index-pack: support checking objects but not links
Date:   Wed, 14 Mar 2018 11:42:40 -0700
Message-Id: <0ec687d21f69270a07f4bc86dcae6bb40f899755.1521052825.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.16.2.520.gd0db9edba.dirty
In-Reply-To: <cover.1521052825.git.jonathantanmy@google.com>
References: <cover.1521052825.git.jonathantanmy@google.com>
In-Reply-To: <cover.1521052825.git.jonathantanmy@google.com>
References: <cover.1521052825.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The index-pack command currently supports the
--check-self-contained-and-connected argument, for internal use only,
that instructs it to only check for broken links and not broken objects.
For partial clones, we need the inverse, so add a --fsck-objects
argument that checks for broken objects and not broken links, also for
internal use only.

This will be used by fetch-pack in a subsequent patch.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/git-index-pack.txt | 3 +++
 builtin/index-pack.c             | 6 ++++--
 t/t5302-pack-index.sh            | 5 +++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 1b4b65d66..138edb47b 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -77,6 +77,9 @@ OPTIONS
 --check-self-contained-and-connected::
 	Die if the pack contains broken links. For internal use only.
 
+--fsck-objects::
+	Die if the pack contains broken objects. For internal use only.
+
 --threads=<n>::
 	Specifies the number of threads to spawn when resolving
 	deltas. This requires that index-pack be compiled with
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 59878e70b..f46cb5967 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -827,7 +827,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 		free(has_data);
 	}
 
-	if (strict) {
+	if (strict || do_fsck_object) {
 		read_lock();
 		if (type == OBJ_BLOB) {
 			struct blob *blob = lookup_blob(oid);
@@ -853,7 +853,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 			if (do_fsck_object &&
 			    fsck_object(obj, buf, size, &fsck_options))
 				die(_("Error in object"));
-			if (fsck_walk(obj, NULL, &fsck_options))
+			if (strict && fsck_walk(obj, NULL, &fsck_options))
 				die(_("Not all child objects of %s are reachable"), oid_to_hex(&obj->oid));
 
 			if (obj->type == OBJ_TREE) {
@@ -1688,6 +1688,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 			} else if (!strcmp(arg, "--check-self-contained-and-connected")) {
 				strict = 1;
 				check_self_contained_and_connected = 1;
+			} else if (!strcmp(arg, "--fsck-objects")) {
+				do_fsck_object = 1;
 			} else if (!strcmp(arg, "--verify")) {
 				verify = 1;
 			} else if (!strcmp(arg, "--verify-stat")) {
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index c2fc584da..d695a6082 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -262,4 +262,9 @@ EOF
     grep "^warning:.* expected .tagger. line" err
 '
 
+test_expect_success 'index-pack --fsck-objects also warns upon missing tagger in tag' '
+    git index-pack --fsck-objects tag-test-${pack1}.pack 2>err &&
+    grep "^warning:.* expected .tagger. line" err
+'
+
 test_done
-- 
2.16.2.520.gd0db9edba.dirty


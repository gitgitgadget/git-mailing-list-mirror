Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0DCF1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 21:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeJQFvU (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 01:51:20 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:33015 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeJQFvU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 01:51:20 -0400
Received: by mail-io1-f73.google.com with SMTP id c5-v6so23054039ioa.0
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 14:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ogNy3XiSjfKWbFEmTgNDSTgZhju+8i58n5d1ZJT5HJ4=;
        b=BfmJFidWU+25j5V3938N7I8xQioiPRud0yIL8r7LI0eqQ1jh53N7TY58Tz4kW/5r2g
         SsmEGxzkaqUOBz8bb3xWx0AO78YJlX70IYviFrOKa/SCVM5ZDJNq77cS4IwRGjyb1183
         0/LKpACy4Xq/w/nT1EJb1ZKwmvghX6XPYtpXy5xOB8I+pRv/UFcSHlbwszGfXwxjsWJt
         qF0D4F1sft7+CoUhc0D5ZM5GvTd9z7234P7qqVcDAaOJzF2IqxeF32GdUOP4CaB3/zK6
         s8iE43+jX8oC4IHjS7LX4/oji13NByH10TfPgld5TmNyFGqPN1UwPPOKqWQDLA8zb+Mq
         uB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ogNy3XiSjfKWbFEmTgNDSTgZhju+8i58n5d1ZJT5HJ4=;
        b=XokoiGHI9t6GgktSbZftHdlMX+Ls9BA+nHQDgtpo3w1f3NTxfH2NQMLqpJSj8RVCGy
         7QYh1kebNYQ7avrS7oK6n/V5Rapt7gg7nsDFYKYSxsFYXu+D/0zCFmY2GJ6pwgSbdwsO
         PFoSuYJ8avQDIQKjBXa9HixPiswEqQMVmbUZeODx7V9xZysVouf4RDyOBq3VBydZyGiz
         DkU5lyO1eb4Bt5+87NidLeskBPm52k7EiXLY+8Fwy2FheepU4kME0JD9u++a9Xq9el2R
         X/0QvuKD5KuGKGOmy6pXSSJCnlqnHUNrxnYBsFHJm4ERpCEPMrDXTeqOmUd5Y+exHtk9
         fkeA==
X-Gm-Message-State: ABuFfoigd1OavcPv3nIv0wSIdilOluYKh/wzpbHEoCgDcrOsWuGLK2t5
        k2plrD9chvW5THCpIBBRc5hrb/uf0Is8q5l4beH85CGeRbHXA+EWv6Ssl09Eq9qNIk2rRRiEeWS
        xDrcEhH5MxxP3PBeAuNhcAaz7Puu2PSGRVasK68WNSNRIC5Ge3uSAaI7VjmWJ+BvbicfDC7fNl/
        Hj
X-Google-Smtp-Source: ACcGV60xTUnyEcc7E1oShL5hfoz5M7TMvMEIlpWbAhvP7hj44IPTn5FLWlv/1MoEA3OwtZdQkSsKzeet+ggE30LVbPsk
X-Received: by 2002:a24:c7:: with SMTP id 190-v6mr21003ita.2.1539727135262;
 Tue, 16 Oct 2018 14:58:55 -0700 (PDT)
Date:   Tue, 16 Oct 2018 14:58:50 -0700
Message-Id: <20181016215850.47821-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH] upload-pack: clear flags before each v2 request
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, arturas@uber.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Suppose a server has the following commit graph:

 A   B
  \ /
   O

We create a client by cloning A from the server with depth 1, and add
many commits to it (so that future fetches span multiple requests due to
lengthy negotiation). If it then fetches B using protocol v2, the fetch
spanning multiple requests, the resulting packfile does not contain O
even though the client did report that A is shallow.

This is because upload_pack_v2() can be called multiple times while
processing the same session. During the 2nd and all subsequent
invocations, some object flags remain from the previous invocations. In
particular, CLIENT_SHALLOW remains, preventing process_shallow() from
adding client-reported shallows to the "shallows" array, and hence
pack-objects not knowing about these client-reported shallows.

Therefore, teach upload_pack_v2() to clear object flags at the start of
each invocation.

(One alternative is to reduce or eliminate usage of object flags in
protocol v2, but that doesn't seem feasible because almost all 8 flags
are used pervasively in v2 code.)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This was noticed by Arturas Moskvinas <arturas@uber.com> in [1]. The
reproduction steps given were to repeat a shallow fetch twice in
succession, but I found it easier to write a more understandable test if
I made the 2nd fetch an ordinary fetch. In any case, I also reran the
original reproduction steps, and the fetch completes without error.

This patch doesn't cover the negotiation issue that I mentioned in my
previous reply [2].

[1] https://public-inbox.org/git/CAGY-PBgsG-T3JY=awszwGMpFx+jDx-a1FcV0s6vR067bSqgZaA@mail.gmail.com/
[2] https://public-inbox.org/git/20181013004356.257709-1-jonathantanmy@google.com/
---
 t/t5702-protocol-v2.sh | 25 +++++++++++++++++++++++++
 upload-pack.c          |  5 +++++
 2 files changed, 30 insertions(+)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 88a886975d..70b88385ba 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -429,6 +429,31 @@ test_expect_success 'fetch supports include-tag and tag following' '
 	git -C client cat-file -e $(git -C client rev-parse annotated_tag)
 '
 
+test_expect_success 'upload-pack respects client shallows' '
+	rm -rf server client trace &&
+
+	git init server &&
+	test_commit -C server base &&
+	test_commit -C server client_has &&
+
+	git clone --depth=1 "file://$(pwd)/server" client &&
+
+	# Add extra commits to the client so that the whole fetch takes more
+	# than 1 request (due to negotiation)
+	for i in $(seq 1 32)
+	do
+		test_commit -C client c$i
+	done &&
+
+	git -C server checkout -b newbranch base &&
+	test_commit -C server client_wants &&
+
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
+		fetch origin newbranch &&
+	# Ensure that protocol v2 is used
+	grep "git< version 2" trace
+'
+
 # Test protocol v2 with 'http://' transport
 #
 . "$TEST_DIRECTORY"/lib-httpd.sh
diff --git a/upload-pack.c b/upload-pack.c
index 62a1000f44..de7de1de38 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -37,6 +37,9 @@
 #define CLIENT_SHALLOW	(1u << 18)
 #define HIDDEN_REF	(1u << 19)
 
+#define ALL_FLAGS (THEY_HAVE | OUR_REF | WANTED | COMMON_KNOWN | SHALLOW | \
+		NOT_SHALLOW | CLIENT_SHALLOW | HIDDEN_REF)
+
 static timestamp_t oldest_have;
 
 static int deepen_relative;
@@ -1393,6 +1396,8 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 	enum fetch_state state = FETCH_PROCESS_ARGS;
 	struct upload_pack_data data;
 
+	clear_object_flags(ALL_FLAGS);
+
 	git_config(upload_pack_config, NULL);
 
 	upload_pack_data_init(&data);
-- 
2.19.0.271.gfe8321ec05.dirty


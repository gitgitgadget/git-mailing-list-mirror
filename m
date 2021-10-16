Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DE2C433EF
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31DEE60E96
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244124AbhJPJnB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 05:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244020AbhJPJlx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 05:41:53 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A7AC061764
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:44 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i12so30668719wrb.7
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R7CVvVLYDXY5/txJKxXakZ7mSCLstn0BZmE5CGZY2zA=;
        b=hS8QYAu6OLglJ+/KHKtiw/Vd63CZf3s7FX/QItNN4rq5NdmDdu5VCFKdrq/Aa+ngb7
         66JSSfhQyYKRlG5H25MG6kU79/AWDeSgASUZExLYmf3ynIcX/Z4hHCDM0JBTGY7aaMqy
         xAEFvkkPEamdS2KK3L73MeFilHCYZ/YwtPQd/aClZbfq4CkOFf2+8uY4xA7yJcynJIab
         sFa5+ELyTjruXhflFW58TWfuNynHVMrHjX5XmK+ff7OQTFjARX9Yz2GesKxFaUMQV2h2
         9H6mSc/RiNnQA+9aMFT39QLgRy/aa8oc+w4afftNBu2kwtjWDzlxtoGWBWvRypiYRJEl
         WfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R7CVvVLYDXY5/txJKxXakZ7mSCLstn0BZmE5CGZY2zA=;
        b=eLza9VB+sSCUITrgBgzzc47FPrx6+e8YdhLloSwboTgE/RLNP8UbAw3mQdYigOsS/m
         rF3Ijy41JT98v/V1+eJb7TQEm6u/rUcWMa8MFWV/AuqUJU9IkSg///39mNe/0laIWBa3
         UHUGsdxtNeGKEwiRcjLM2HsFZ/Fp1dg7G+mBrIulKjynGATCCt07CqGANj56UICszJbk
         HjT+yDfeGL6rIOTiSS3IBTy+HVlHD3USq9FGvY6JEkXo/6NIAHR9TN/f38oOxqDheo0b
         aDy+ujcrQEcSZAFSNl0+V7nVVPcV8Fg7t1lCIX4b7BZfL9P25PYkFPBtXLKp8XwXCMFe
         EPsw==
X-Gm-Message-State: AOAM533N1AvDfWK9BPY9QM1kDSDTIHr1u4ayyjUV9i+xbI8bKKkEBvJq
        Ak2iTUo5TADYP2FipdK7hTzpG5UcDluSrA==
X-Google-Smtp-Source: ABdhPJxlYCwfQTL3y39Rr4mq7VOp1INwjUulLmd1nbayLSDoVWNjWXYoJgtkjnm7TRKwzxLVPIGk8w==
X-Received: by 2002:adf:9b97:: with SMTP id d23mr20446835wrc.135.1634377182669;
        Sat, 16 Oct 2021 02:39:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k22sm6993492wrd.59.2021.10.16.02.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 02:39:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 17/21] refs API: make resolve_ref_unsafe() not set errno
Date:   Sat, 16 Oct 2021 11:39:23 +0200
Message-Id: <patch-v2-17.21-cae56498b43-20211016T093845Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com> <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the resolve_ref_unsafe() wrapper function to use the underlying
refs_werrres_ref_unsafe() directly.

From a reading of the callers I determined that the only one who cared
about errno was a sequencer.c caller added in e47c6cafcb5 (commit:
move print_commit_summary() to libgit, 2017-11-24), I'm migrating it
to using refs_werrres_ref_unsafe() directly.

This adds another "set errno" instance, but in this case it's OK and
idiomatic. We are setting it just before calling die_errno(). We could
have some hypothetical die_errno_var(&saved_errno, ...) here, but I
don't think it's worth it. The problem with errno is subtle action at
distance, not this sort of thing. We already use this pattern in a
couple of places in wrapper.c

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c      |  6 ++++--
 sequencer.c | 10 ++++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 8d5a76fbf29..b563729782b 100644
--- a/refs.c
+++ b/refs.c
@@ -1785,8 +1785,10 @@ int refs_init_db(struct strbuf *err)
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 			       struct object_id *oid, int *flags)
 {
-	return refs_resolve_ref_unsafe(get_main_ref_store(the_repository), refname,
-				       resolve_flags, oid, flags);
+	int ignore_errno;
+
+	return refs_werrres_ref_unsafe(get_main_ref_store(the_repository), refname,
+				       resolve_flags, oid, flags, &ignore_errno);
 }
 
 int resolve_gitlink_ref(const char *submodule, const char *refname,
diff --git a/sequencer.c b/sequencer.c
index fac0b5162f6..1223dc2d2bf 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1282,6 +1282,8 @@ void print_commit_summary(struct repository *r,
 	struct pretty_print_context pctx = {0};
 	struct strbuf author_ident = STRBUF_INIT;
 	struct strbuf committer_ident = STRBUF_INIT;
+	struct ref_store *refs;
+	int resolve_errno;
 
 	commit = lookup_commit(r, oid);
 	if (!commit)
@@ -1331,9 +1333,13 @@ void print_commit_summary(struct repository *r,
 	rev.diffopt.break_opt = 0;
 	diff_setup_done(&rev.diffopt);
 
-	head = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
-	if (!head)
+	refs = get_main_ref_store(the_repository);
+	head = refs_werrres_ref_unsafe(refs, "HEAD", 0, NULL, NULL,
+				       &resolve_errno);
+	if (!head) {
+		errno = resolve_errno;
 		die_errno(_("unable to resolve HEAD after creating commit"));
+	}
 	if (!strcmp(head, "HEAD"))
 		head = _("detached HEAD");
 	else
-- 
2.33.1.1338.g20da966911a


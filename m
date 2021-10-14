Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6199DC433FE
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49A7E6113B
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhJNAJO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhJNAIx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 20:08:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC8DC06177B
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:48 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v17so13750576wrv.9
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UF0m0fy+FrS7BOfPF9cFoV3A5sGFM+8xFbei8mU2nxM=;
        b=KoMA552J/2dsMAyWfm1g9NXTQK8fLz6xUdhmsIu5Lkx372L0ZiqNZ2fuaBpTXpj47w
         rNDcNwCM+pUprT/G+aqIf9qFqOPiKZpEOu5n/iJTlKXTPBwIoBN/HlFrYDYLtCzNmeBi
         Ga+8IqxZOlzMtif6c6zfKZFcIsv8DzYvcSuCaNj9EcGQci1obVvj9HcURVYYgIv6okHh
         E+4rGqVQ2Awiv8n+Q/i1gBETG3FaLkv/WOoBcSpbkuspztgihevh6UNC0+4CxjrPJBUt
         IpfJ5JVGADmxdDXvbIS0/jM4GJM77mMVQS3AOkPN9sHR8ulTkKQKfuN2c5WsWa0UNHJp
         vvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UF0m0fy+FrS7BOfPF9cFoV3A5sGFM+8xFbei8mU2nxM=;
        b=sULW0JPHopMBszUT/5zFeeXziypLW3U9NtoshBmOgfvARYOGUooom7Kjf5SXw60GXQ
         XtENpGeAPOjN0/HGjJ/Sn/HlXFNnqrgkOxEMSGldvBxTQtz9xJC7kcOKo6Y8Z/uPdXeh
         Jz5cfmNicaf/V0gWc5HZkR4jAp6ct+T3fiTCFAIRfm568fRTuZ2ULSIuqM7AcCXMheBu
         k9T5oiPqYIBge21LG7pL+CEGt9+Q/hntKzEUceSYf8FATi7CoGkopZM8E4QtvTl5vEuh
         5QnP1BSIaJsKlWnoK/w5aRwuZB+LoTXwbq0jWZiOipyfa0Y4U98SfCUNhKTfm83ZQ6Wv
         ZfNQ==
X-Gm-Message-State: AOAM531I2g/t5qDZPuo555+5n0mP/++0disPjuy/o4w1NMHXNhzZQI2r
        DGF9USGdI9/iyN1VWWcvxe0+IHxZXiyLpA==
X-Google-Smtp-Source: ABdhPJw4gAye/TJAJEl+YyTZxX9eGdCUvsvhLoBsx60A8jfdxBSFZQEHgioJ8JqUNaEV1c13Gnp2xA==
X-Received: by 2002:a5d:64cd:: with SMTP id f13mr2865529wri.92.1634170006570;
        Wed, 13 Oct 2021 17:06:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y8sm670711wmi.43.2021.10.13.17.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:06:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 16/20] refs API: make resolve_ref_unsafe() not set errno
Date:   Thu, 14 Oct 2021 02:06:28 +0200
Message-Id: <patch-16.20-888b1884c29-20211013T235900Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
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
index f2a56a216c3..4b0c1a30a18 100644
--- a/refs.c
+++ b/refs.c
@@ -1784,8 +1784,10 @@ int refs_init_db(struct strbuf *err)
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
index 64b1f2e681c..7052f791410 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1281,6 +1281,8 @@ void print_commit_summary(struct repository *r,
 	struct pretty_print_context pctx = {0};
 	struct strbuf author_ident = STRBUF_INIT;
 	struct strbuf committer_ident = STRBUF_INIT;
+	struct ref_store *refs;
+	int resolve_errno;
 
 	commit = lookup_commit(r, oid);
 	if (!commit)
@@ -1330,9 +1332,13 @@ void print_commit_summary(struct repository *r,
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
2.33.1.1346.g48288c3c089


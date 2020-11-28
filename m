Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE4CC63777
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2ED721D40
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjD0307V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388994AbgK1Vts (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Nov 2020 16:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732380AbgK1TAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Nov 2020 14:00:09 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA10C094241
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 22:44:42 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id v14so1146049wml.1
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 22:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/20RZ4uByElgRc3kL6zaVvAcxNYFd//xwDFEk6VI2E8=;
        b=qjD0307VOnz2x1s5GV4OKSYJ7c5sjug8d6pWsJ3wd6vzsbAWCawHz4nStq9Ad5p9h0
         BNPkeAqkyVMskxJwHnBx4rhC7cu4RXASq0HIoYR5vZFmWPn/NDNCTQicKlEX1urRiNqk
         2U9mT1zblRtN82R0L75G2ypnSXMC8bB5KbucZQhQZIyjYGs3csjTpyS9xNrxFBnkL7nw
         bsal2M80iRuv4cDPy3MDIjXaxtZjXBJiEMpZ5gFD68ReJGOKaIQaMJkOfJwQ1rQThqao
         ay5NYhqYEyl9fQRC/nFqPMTPW/stJuokyOiJ6LsUmkfxhBIgwmcfuoZh1DhsHywh5BZ1
         nVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/20RZ4uByElgRc3kL6zaVvAcxNYFd//xwDFEk6VI2E8=;
        b=XCLd0KKs1xIZfuyTvPhnet0DnaCspVtqOUeUCpo3qdo1aqYBc9cIOz5Ymtiy8VYSMb
         cPlBhnLR9VxpoZVag+E1oWDi9GY0UblmIJ9yPc07oCAMyW6/TkeIz5lFW5cTYBpDapzR
         SujsF0LWv+H4yzhe4Ty/v2EvXLCJVZPNbSicv5THHBZc/fQnRjy7ASVA5IIVPMZGcz2i
         txqPtkH+PrhnsGfsgjLkvdlqYexH2YPsC6cmQVfPSCTb34TFEJ1xKEPcEtGQmAlBjMzp
         vZwTior7kNaVkk1M1WfIn3FkhUxKfWlyIai1H0zGAuI+UN4z6B95AgVHm5iFVLTvHj6q
         mHWQ==
X-Gm-Message-State: AOAM530VoA4kouzfAreTGuiXZ16xZdBjuxSAQoyyYj9C40KRNDbfmaDC
        xgFX0dZ/ztsuuhr1JG2CxT8nBM0rnUQ=
X-Google-Smtp-Source: ABdhPJzNnKanwYLtSupLrSRbJ9eyNzOtDngQuaWBFMezE+UCvpm/CU8da/BC5hsRnS1rDnL2aQUzvQ==
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr13030055wmj.169.1606545880749;
        Fri, 27 Nov 2020 22:44:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w186sm16864486wmb.26.2020.11.27.22.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 22:44:40 -0800 (PST)
Message-Id: <878bffcdfe5ca7657f839de8f7993d9098726636.1606545878.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.801.git.1606545878.gitgitgadget@gmail.com>
References: <pull.801.git.1606545878.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 28 Nov 2020 06:44:33 +0000
Subject: [PATCH 1/6] fixup! reftable: rest of library
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Close the file descriptors to obsolete files before trying to delete or
rename them. This is actually required on Windows.

Note: this patch is just a band-aid to get the tests pass on Windows.
The fact that it is needed raises concerns about the overall resource
handling: are file descriptors closed properly whenever appropriate, or
are they closed much later (which can lead to rename() problems on
Windows, and risks running into ulimits)?

Also, a `reftable_stack_destroy()` call had to be moved in
`test_reftable_stack_uptodate()` to avoid the prompt complaining that a
`.ref` file could not be deleted on Windows. This raises the question
whether the code does the right thing when two concurrent processes want
to access the reftable, and one wants to compact it. At the moment, it
does not appear to fail gracefully.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 reftable/stack.c      | 37 ++++++++++++++++++++++++++++---------
 reftable/stack_test.c |  2 +-
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 1d632937d7..02c6a370ba 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -212,7 +212,6 @@ static int reftable_stack_reload_once(struct reftable_stack *st, char **names,
 		goto done;
 
 	new_tables = NULL;
-	st->readers_len = new_readers_len;
 	if (st->merged != NULL) {
 		merged_table_release(st->merged);
 		reftable_merged_table_free(st->merged);
@@ -220,6 +219,7 @@ static int reftable_stack_reload_once(struct reftable_stack *st, char **names,
 	if (st->readers != NULL) {
 		reftable_free(st->readers);
 	}
+	st->readers_len = new_readers_len;
 	st->readers = new_readers;
 	new_readers = NULL;
 	new_readers_len = 0;
@@ -939,14 +939,6 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 	strbuf_addstr(&new_table_path, "/");
 	strbuf_addbuf(&new_table_path, &new_table_name);
 
-	if (!is_empty_table) {
-		err = rename(temp_tab_file_name.buf, new_table_path.buf);
-		if (err < 0) {
-			err = REFTABLE_IO_ERROR;
-			goto done;
-		}
-	}
-
 	for (i = 0; i < first; i++) {
 		strbuf_addstr(&ref_list_contents, st->readers[i]->name);
 		strbuf_addstr(&ref_list_contents, "\n");
@@ -960,6 +952,32 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 		strbuf_addstr(&ref_list_contents, "\n");
 	}
 
+	/*
+	 * Now release the merged tables and readers
+	 */
+	if (st->merged != NULL) {
+		reftable_merged_table_free(st->merged);
+		st->merged = NULL;
+	}
+
+	if (st->readers != NULL) {
+		int i = 0;
+		for (i = 0; i < st->readers_len; i++) {
+			reader_close(st->readers[i]);
+			reftable_reader_free(st->readers[i]);
+		}
+		st->readers_len = 0;
+		FREE_AND_NULL(st->readers);
+	}
+
+	if (!is_empty_table) {
+		err = rename(temp_tab_file_name.buf, new_table_path.buf);
+		if (err < 0) {
+			err = REFTABLE_IO_ERROR;
+			goto done;
+		}
+	}
+
 	err = write(lock_file_fd, ref_list_contents.buf, ref_list_contents.len);
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
@@ -1242,6 +1260,7 @@ static int stack_check_addition(struct reftable_stack *st,
 
 	free(refs);
 	reftable_iterator_destroy(&it);
+	reader_close(rd);
 	reftable_reader_free(rd);
 	return err;
 }
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 11d3d30799..c35abd7301 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -159,12 +159,12 @@ static void test_reftable_stack_uptodate(void)
 	err = reftable_stack_add(st2, &write_test_ref, &ref2);
 	EXPECT(err == REFTABLE_LOCK_ERROR);
 
+	reftable_stack_destroy(st1);
 	err = reftable_stack_reload(st2);
 	EXPECT_ERR(err);
 
 	err = reftable_stack_add(st2, &write_test_ref, &ref2);
 	EXPECT_ERR(err);
-	reftable_stack_destroy(st1);
 	reftable_stack_destroy(st2);
 	clear_dir(dir);
 }
-- 
gitgitgadget


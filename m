Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47605C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 11:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D0320B1F
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 11:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POZvTxTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbgJOLmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 07:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbgJOLmL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 07:42:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2675C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 04:42:10 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z22so1694728wmi.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 04:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=3pLnGx3mJb9b9PGl7eU/qzfaybOfYrReDthWW7/+vnM=;
        b=POZvTxTeLKHnyFz1gWHH/fDnp0k7fmoHnthFh28bzeLFFHY1OxaSuu6p746rSMIabl
         HCHglQK1g+kXfOEf1W35g7MyaMeZN4PxZsZ3+EyrPuNmA+E9PCZCWUjo5DSNVRZfw2os
         lFUAXEkamYFNjlF3AeiV98ddc7hQX+M30l+rHGiJUOf9t05XLyWP1FQ7Csn94e8m1QOx
         T0H0oL3WKQdNsLH47hezBppKCPecjnCUZC+s2SjGjKmYW6O/7OguGuT57OCd/JWur50W
         BRIdZsGmZmGJlngvi7khu/z73tbYYu4aNrEC1gHDI9Vs4pqwbst5dFOqy0K+vMUxh6aE
         hyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3pLnGx3mJb9b9PGl7eU/qzfaybOfYrReDthWW7/+vnM=;
        b=p7f0WAe8tyyfUoiAOvoYrBtzxkNX8QDMlIMPY72oqC3daaF3hGLz304Aa00pRL1uQi
         DcL1QhKzhxavYlrj0V6kFSI5R62uzcPSLBEO4zydcb7w0iCXI3IhqUxxlOnDKRvoYTCW
         jcNyI4zYnoTFbaVV4HeT31U1Z5s4uwKIs9Nf9lPCevaaafFp416Plh+/60yQufQyvKHr
         QEwtPPU8YqtQoXrrgpZjIqFANSahxHuORw57zQoDczx6pX9qOwzNYu0RLmVr81ACrC/O
         g0d/3bLYiZvtJ+ttMU+2IKM7+GPHoXZgqiKv1xf1A/psBPRIsuz8LVfu+nbBGjinUIXJ
         MgeQ==
X-Gm-Message-State: AOAM5311je/she7juxBrLJy5LM1NwdRAZ89eqRvVXOJgIypQLqIgPFfs
        eyItXXydytiL7cJh/NN+vf0so4Z03AQ=
X-Google-Smtp-Source: ABdhPJzNPHbArr3Tz+zgAl8CZaDubROCFVCl/eFWJCE4vr5txqN2CE0yeAj1K6Upazv2jWy7PsRaOQ==
X-Received: by 2002:a1c:e2d5:: with SMTP id z204mr3530488wmg.96.1602762129232;
        Thu, 15 Oct 2020 04:42:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4sm4211398wrv.8.2020.10.15.04.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 04:42:08 -0700 (PDT)
Message-Id: <pull.755.git.1602762128039.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Oct 2020 11:42:07 +0000
Subject: [PATCH] fetch-pack: show detailed error in read_pack_header
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

When fetch-pack fails with a bad pack header, the
provided error globs together several distinct error types -
EOF, Bad Signature, and Pack version unsupported.

Provide the more detailed error
to the user so they can debug their situation further.

Before:
protocol error: bad pack header

After:
protocol error: bad pack header: eof before pack header was fully read

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
    [fetch-pack] Show detailed error in read_pack_header
    
    I saw the "bad pack header" error when using partial clone on v2.28.0
    without allowanysha1inwant flag, but the error failed to include detail
    of why the header was bad. The error message no longer occurs on
    v2.29.0-rc1. Details here
    https://public-inbox.org/git/CAN8Z4-XgctFZxZoTWRpD1V9NFr34ObzG2dxUoAfuJ4NOsBDdtg@mail.gmail.com/
    
    I based my change off of v2.28.0 - writing a test case for the error I
    saw. The test case no longer passes on master - so I removed it from the
    patch - but am including it here in the cover letter as an illustration
    of what is being fixed.
    
    --- a/t/t5616-partial-clone.sh
    +++ b/t/t5616-partial-clone.sh
    @@ -25,7 +25,18 @@ test_expect_success 'setup normal src repo' '
     # bare clone "src" giving "srv.bare" for use as our server.
     test_expect_success 'setup bare clone for server' '
         git clone --bare "file://$(pwd)/src" srv.bare &&
    -    git -C srv.bare config --local uploadpack.allowfilter 1 &&
    +    git -C srv.bare config --local uploadpack.allowfilter 1
    +'
    +
    +# Confirm that partial cloning fails with error when
    +# allowanysha1inwant is not set. Expect checkout to fail
    +# after clone succeeds
    +#
    +# Then set for rest of tests
    +test_expect_success 'error on partial clone when allowanysha1inwant not set' '
    +    test_must_fail git clone --filter=blob:none "file://$(pwd)/srv.bare" pc1 2>err &&
    +    test_i18ngrep "fatal: protocol error: bad pack header: eof before pack header was fully read" err &&
    +    rm -rf pc1 &&
         git -C srv.bare config --local uploadpack.allowanysha1inwant 1
     '
    
    Thank you! Nipunn

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-755%2Fnipunn1313%2Ferror_msg_off_2.28-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-755/nipunn1313/error_msg_off_2.28-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/755

 builtin/receive-pack.c | 22 +---------------------
 fetch-pack.c           |  6 ++++--
 pack.h                 |  1 +
 sha1-file.c            | 21 +++++++++++++++++++++
 4 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index bb9909c52e..c1b572cf7d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2100,26 +2100,6 @@ static void read_push_options(struct packet_reader *reader,
 	}
 }
 
-static const char *parse_pack_header(struct pack_header *hdr)
-{
-	switch (read_pack_header(0, hdr)) {
-	case PH_ERROR_EOF:
-		return "eof before pack header was fully read";
-
-	case PH_ERROR_PACK_SIGNATURE:
-		return "protocol error (pack signature mismatch detected)";
-
-	case PH_ERROR_PROTOCOL:
-		return "protocol error (pack version unsupported)";
-
-	default:
-		return "unknown error in parse_pack_header";
-
-	case 0:
-		return NULL;
-	}
-}
-
 static const char *pack_lockfile;
 
 static void push_header_arg(struct strvec *args, struct pack_header *hdr)
@@ -2140,7 +2120,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 			    ? transfer_fsck_objects
 			    : 0);
 
-	hdr_err = parse_pack_header(&hdr);
+	hdr_err = pack_header_error(read_pack_header(0, &hdr));
 	if (hdr_err) {
 		if (err_fd > 0)
 			close(err_fd);
diff --git a/fetch-pack.c b/fetch-pack.c
index b10c432315..ad9db33e17 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -809,6 +809,7 @@ static int get_pack(struct fetch_pack_args *args,
 	int pass_header = 0;
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	int ret;
+	const char *ph_error;
 
 	memset(&demux, 0, sizeof(demux));
 	if (use_sideband) {
@@ -828,8 +829,9 @@ static int get_pack(struct fetch_pack_args *args,
 
 	if (!args->keep_pack && unpack_limit) {
 
-		if (read_pack_header(demux.out, &header))
-			die(_("protocol error: bad pack header"));
+		ph_error = pack_header_error(read_pack_header(demux.out, &header));
+		if (ph_error)
+			die(_("protocol error: bad pack header: %s"), ph_error);
 		pass_header = 1;
 		if (ntohl(header.hdr_entries) < unpack_limit)
 			do_keep = 0;
diff --git a/pack.h b/pack.h
index 9fc0945ac9..63d060d5c2 100644
--- a/pack.h
+++ b/pack.h
@@ -99,6 +99,7 @@ int encode_in_pack_object_header(unsigned char *hdr, int hdr_len,
 #define PH_ERROR_PACK_SIGNATURE	(-2)
 #define PH_ERROR_PROTOCOL	(-3)
 int read_pack_header(int fd, struct pack_header *);
+const char *pack_header_error(int ph_err);
 
 struct hashfile *create_tmp_packfile(char **pack_tmp_name);
 void finish_tmp_packfile(struct strbuf *name_buffer, const char *pack_tmp_name, struct pack_idx_entry **written_list, uint32_t nr_written, struct pack_idx_option *pack_idx_opts, unsigned char sha1[]);
diff --git a/sha1-file.c b/sha1-file.c
index dd65bd5c68..d711096054 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -2252,6 +2252,27 @@ int read_pack_header(int fd, struct pack_header *header)
 	return 0;
 }
 
+const char *pack_header_error(int err)
+{
+	switch (err) {
+	case PH_ERROR_EOF:
+		return "eof before pack header was fully read";
+
+	case PH_ERROR_PACK_SIGNATURE:
+		return "protocol error (pack signature mismatch detected)";
+
+	case PH_ERROR_PROTOCOL:
+		return "protocol error (pack version unsupported)";
+
+	default:
+		// Should not occur - all errors should be handled
+		die("unknown error in parse_pack_header %d", err);
+
+	case 0:
+		return NULL;
+	}
+}
+
 void assert_oid_type(const struct object_id *oid, enum object_type expect)
 {
 	enum object_type type = oid_object_info(the_repository, oid, NULL);

base-commit: d4a392452e292ff924e79ec8458611c0f679d6d4
-- 
gitgitgadget

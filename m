Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD4AC433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 13:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49CE16191E
	for <git@archiver.kernel.org>; Tue, 11 May 2021 13:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhEKNFl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 09:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbhEKNFk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 09:05:40 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2C3C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 06:04:32 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id s82so11086218wmf.3
        for <git@vger.kernel.org>; Tue, 11 May 2021 06:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/9Bfq2lkVqHOQzhAquOERwwQFOgDUZ3QfltIEt0wqyE=;
        b=W5lfwYvHWJ5b0ySAHQzY4mwO+ntpSVI+elQuOV46wO77bQRQEMR3aZkVRulQCw/Xfl
         he9ZHz9i5IVmvKPThh5TybL46F0blcr4WJ0xKbAALDJXGPEO6D29ufvrYsA9vzxysWt5
         lDtIxpOK1aa/hf8un7sXeSX9LmYKBPmTEjH+gdibWVejq5VsGR+l+POckrA+wagam09h
         Ctj7IEIZGauREI62RlrruBY8JA6BotkzdxwbcltCuHlZfhTxJKAGznpoZzm0RCRjn9YN
         Mx6x4kbydyj7lgnwFpVS0ON61Y+7KsbPX5mN5jR6a+BDeQABnQQwu2pvPo4XBOTvsA49
         +e5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/9Bfq2lkVqHOQzhAquOERwwQFOgDUZ3QfltIEt0wqyE=;
        b=XTuXfEkBbqyuLGCm1VnwjWplcdWsr7qokZR5er/MUAhDXe+o560fNSesB81R0639bJ
         RzK5jWV0UkuGtkgGEXAOCzs4vZ687eGo832cj7wDiX/KYWrZbUGO7HMAyuHZgg1kpgSQ
         8/Z6RD25SECzl7nBj7xF7WpA2TlFyblgcRRhk+xMQCJD8hs8atmwi7a+XiXqUZn5ZKM3
         i32HPjQgCnYQlsvmJZipz6ptxoSWBJdv2QIaz4VNOhyfLwH16AnfCEzon0TODw2DDbDU
         QHQEAxp5xjm7M2C/ktGwgeTfl/K3l1h0oNi6jTyoWtl7ZHLRls7C07roz4x8S0arXsB4
         Wetg==
X-Gm-Message-State: AOAM531BNeF/xBLGpV3khoybxi1GxEBqLFVrGPUoibtRI4JJ68HcWlbF
        tIxrfU3IwTMiNjCTYXlngSy9x4Y/MJ2Xyw==
X-Google-Smtp-Source: ABdhPJyvPgFrZl3VEhYv27kooUnghwwwwzHsUTdII5UgwdfvzI1o7VOIXzysrVTBuc+504wEGmgo6w==
X-Received: by 2002:a1c:20d2:: with SMTP id g201mr2507049wmg.48.1620738271061;
        Tue, 11 May 2021 06:04:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n22sm3256221wmo.12.2021.05.11.06.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 06:04:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] trace2: refactor to avoid gcc warning under -O3
Date:   Tue, 11 May 2021 15:04:28 +0200
Message-Id: <patch-1.1-782555daade-20210511T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.909.g789bb6d90e
In-Reply-To: <patch-1.1-87d9bcf1095-20210505T083951Z-avarab@gmail.com>
References: <patch-1.1-87d9bcf1095-20210505T083951Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor tr2_dst_try_uds_connect() to avoid a gcc warning[1] that
appears under -O3 (but not -O2). This makes the build pass under
DEVELOPER=1 without needing a DEVOPTS=no-error.

This can be reproduced with GCC Debian 8.3.0-6, but not e.g. with
clang 7.0.1-8+deb10u2. We've had this warning since
ee4512ed481 (trace2: create new combined trace facility, 2019-02-22).

As noted in [2] this warning happens because the compiler doesn't
assume that errno must be non-zero after a failed syscall. Let's work
around it as suggested in that analysis. We now return -1 ourselves on
error, and save away the value of errno in a variable the caller
passes in.

See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=61846 for a related
bug report against GCC.

1.

    trace2/tr2_dst.c: In function ‘tr2_dst_get_trace_fd.part.5’:
    trace2/tr2_dst.c:296:10: warning: ‘fd’ may be used uninitialized in this function [-Wmaybe-uninitialized]
      dst->fd = fd;
      ~~~~~~~~^~~~
    trace2/tr2_dst.c:229:6: note: ‘fd’ was declared here
      int fd;
          ^~
2. https://lore.kernel.org/git/20200404142131.GA679473@coredump.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Tue, May 11 2021, Junio C Hamano wrote:

> What's the concensus if any on this topic?

Having read Johannes's comments I think it's still most readable to
just return -1 unconditionally. The resulting code isn't weird, I'd
argue that it's a better pattern to save away errno like this, but the
commit messages notes that we're working around a GCC bug.

> In any case, this needs to be signed off before it gets carved into
> our history.

Done, and also changed the variable name to minimize the size of the
diff. A shorter name allowed for less re-flowing of lines.

Range-diff against v1:
1:  87d9bcf1095 ! 1:  782555daade trace2: refactor to avoid gcc warning under -O3
    @@ Commit message
         error, and save away the value of errno in a variable the caller
         passes in.
     
    +    See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=61846 for a related
    +    bug report against GCC.
    +
         1.
     
             trace2/tr2_dst.c: In function ‘tr2_dst_get_trace_fd.part.5’:
    @@ Commit message
                   ^~
         2. https://lore.kernel.org/git/20200404142131.GA679473@coredump.intra.peff.net/
     
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +
      ## trace2/tr2_dst.c ##
     @@ trace2/tr2_dst.c: static int tr2_dst_try_path(struct tr2_dst *dst, const char *tgt_value)
      #define PREFIX_AF_UNIX_STREAM "af_unix:stream:"
    @@ trace2/tr2_dst.c: static int tr2_dst_try_path(struct tr2_dst *dst, const char *t
      
     -static int tr2_dst_try_uds_connect(const char *path, int sock_type, int *out_fd)
     +static int tr2_dst_try_uds_connect(const char *path, int sock_type,
    -+				   int *out_fd, int *saved_errno)
    ++				   int *out_fd, int *e)
      {
      	int fd;
      	struct sockaddr_un sa;
    @@ trace2/tr2_dst.c: static int tr2_dst_try_path(struct tr2_dst *dst, const char *t
     -	if (fd == -1)
     -		return errno;
     +	if (fd == -1) {
    -+		*saved_errno = errno;
    ++		*e = errno;
     +		return -1;
     +	}
      
    @@ trace2/tr2_dst.c: static int tr2_dst_try_path(struct tr2_dst *dst, const char *t
      
      	if (connect(fd, (struct sockaddr *)&sa, sizeof(sa)) == -1) {
     -		int e = errno;
    -+		*saved_errno = errno;
    ++		*e = errno;
      		close(fd);
     -		return e;
     +		return -1;
      	}
      
      	*out_fd = fd;
    -@@ trace2/tr2_dst.c: static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
    - {
    - 	unsigned int uds_try = 0;
    - 	int fd;
    --	int e;
    -+	int saved_errno;
    - 	const char *path = NULL;
    - 
    - 	/*
     @@ trace2/tr2_dst.c: static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
      	}
      
      	if (uds_try & TR2_DST_UDS_TRY_STREAM) {
     -		e = tr2_dst_try_uds_connect(path, SOCK_STREAM, &fd);
     -		if (!e)
    -+		if (!tr2_dst_try_uds_connect(path, SOCK_STREAM, &fd,
    -+					     &saved_errno))
    ++		if (!tr2_dst_try_uds_connect(path, SOCK_STREAM, &fd, &e))
      			goto connected;
    --		if (e != EPROTOTYPE)
    -+		if (saved_errno != EPROTOTYPE)
    + 		if (e != EPROTOTYPE)
      			goto error;
      	}
      	if (uds_try & TR2_DST_UDS_TRY_DGRAM) {
     -		e = tr2_dst_try_uds_connect(path, SOCK_DGRAM, &fd);
     -		if (!e)
    -+		if (!tr2_dst_try_uds_connect(path, SOCK_DGRAM, &fd,
    -+					     &saved_errno))
    ++		if (!tr2_dst_try_uds_connect(path, SOCK_DGRAM, &fd, &e))
      			goto connected;
      	}
      
    -@@ trace2/tr2_dst.c: static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
    - 	if (tr2_dst_want_warning())
    - 		warning("trace2: could not connect to socket '%s' for '%s' tracing: %s",
    - 			path, tr2_sysenv_display_name(dst->sysenv_var),
    --			strerror(e));
    -+			strerror(saved_errno));
    - 
    - 	tr2_dst_trace_disable(dst);
    - 	return 0;

 trace2/tr2_dst.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
index ae052a07fe2..a44fe6b73e0 100644
--- a/trace2/tr2_dst.c
+++ b/trace2/tr2_dst.c
@@ -197,22 +197,25 @@ static int tr2_dst_try_path(struct tr2_dst *dst, const char *tgt_value)
 #define PREFIX_AF_UNIX_STREAM "af_unix:stream:"
 #define PREFIX_AF_UNIX_DGRAM "af_unix:dgram:"
 
-static int tr2_dst_try_uds_connect(const char *path, int sock_type, int *out_fd)
+static int tr2_dst_try_uds_connect(const char *path, int sock_type,
+				   int *out_fd, int *e)
 {
 	int fd;
 	struct sockaddr_un sa;
 
 	fd = socket(AF_UNIX, sock_type, 0);
-	if (fd == -1)
-		return errno;
+	if (fd == -1) {
+		*e = errno;
+		return -1;
+	}
 
 	sa.sun_family = AF_UNIX;
 	strlcpy(sa.sun_path, path, sizeof(sa.sun_path));
 
 	if (connect(fd, (struct sockaddr *)&sa, sizeof(sa)) == -1) {
-		int e = errno;
+		*e = errno;
 		close(fd);
-		return e;
+		return -1;
 	}
 
 	*out_fd = fd;
@@ -271,15 +274,13 @@ static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
 	}
 
 	if (uds_try & TR2_DST_UDS_TRY_STREAM) {
-		e = tr2_dst_try_uds_connect(path, SOCK_STREAM, &fd);
-		if (!e)
+		if (!tr2_dst_try_uds_connect(path, SOCK_STREAM, &fd, &e))
 			goto connected;
 		if (e != EPROTOTYPE)
 			goto error;
 	}
 	if (uds_try & TR2_DST_UDS_TRY_DGRAM) {
-		e = tr2_dst_try_uds_connect(path, SOCK_DGRAM, &fd);
-		if (!e)
+		if (!tr2_dst_try_uds_connect(path, SOCK_DGRAM, &fd, &e))
 			goto connected;
 	}
 
-- 
2.31.1.909.g789bb6d90e


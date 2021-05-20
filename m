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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9754BC43462
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A8DA61186
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239450AbhETMTE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 08:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbhETMSw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 08:18:52 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101EAC07A834
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:05:58 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i17so17179993wrq.11
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ACtonoFrJe3SSw37PDodXNzyL9q5AEd9pLMJJmaLE0U=;
        b=pXo0PhoMR1e4XZ8xBfqm2Z37vuLgPweeM+qPtFCMQUG9v64Xc9Sy0gazQYpZg0Y2aQ
         P6kN8XBlz29CeSbaYn1XKMaaAViNlzj8qn8fuVZo7XJ+IXCjMGWdlmz1QfzhZK7Y0DO6
         CIwthNs01R3SaBAU8e1PeAc45YO0xUvrQIlmJYn/QaMda+6F9U2jdttEGv7aaSP9ren7
         F94AJulY6cc843X1OjBgWqRI27n8vhzbWloDQCA0Mruliszz2uMegQBfUbLnZEvS8aGR
         30OTgV63y9s2NXKyN9iV33+PEK4oeu4giBNY+fjNvbe26sYTnt6faAl7//Ufnw5SJdXn
         ISLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ACtonoFrJe3SSw37PDodXNzyL9q5AEd9pLMJJmaLE0U=;
        b=GZUPBjQa4DyrV+r6gGMRojNHHKKAps0pH27IQ2Yu6lop1ArX1f2DxFsAn7Ny85FTFV
         kYkJjnU9VClf7eUJfpN1AheWi2egyKxb7aIM+WjOg7LRKQm3t5Wkwf5Q19Aig5kuD9ec
         tiiz78+MwDyDN+nKQHzQVEIW6eumL9Xh5MylOSTmgf/Zf6cYlyTjX1f0RBciTKRvZLU6
         itWtDl/ArrFZjb68Qp4faM3glYaB5akRffd7jMzjMoHbTuLdvxqr6klt2Ylb72/eIHpk
         /7awZWBtxEzoB/YPLNLbSwUykXCT7KSrxgEviN6h2X1YfNZNxuDNillJ2UdqPcjHuo9G
         t7uQ==
X-Gm-Message-State: AOAM5323HX251QwfOEmaz3fX0KPglMxMpa0VNrRzW3HNr5Lne01oaw23
        GIh40V1sRW2VqfwVVr2GHKqg69ppK3UrRw==
X-Google-Smtp-Source: ABdhPJxXtPwToRIkP2FOAXn7XDCgo5d2EyY1yzCLUWoTwGGg/TUAaWXRpgW5+pvfRuvZ7w7npsAyZQ==
X-Received: by 2002:adf:f811:: with SMTP id s17mr3695202wrp.245.1621508756291;
        Thu, 20 May 2021 04:05:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6sm10282058wms.0.2021.05.20.04.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:05:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3] trace2: refactor to avoid gcc warning under -O3
Date:   Thu, 20 May 2021 13:05:45 +0200
Message-Id: <patch-1.1-2e41e3e4cb-20210520T110357Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g73369325f8d
In-Reply-To: <xmqqim3ew905.fsf@gitster.g>
References: <xmqqim3ew905.fsf@gitster.g>
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
assume that errno must be non-zero after a failed syscall.

Let's work around by using the well-established "saved_errno" pattern,
along with returning -1 ourselves instead of "errno". The caller can
thus rely on our "errno" on failure.

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
Signed-off-by: Jeff King <peff@peff.net>
---

On Thu, May 20 2021, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> I also wondered briefly why we needed the out-parameter at all, and not
>> just letting the caller look at errno. The answer is that we need to
>> preserve it across the close() call. The more usual thing in our code
>> base would be to use saved_errno, but not have it as an out-parameter.
>> [...]
> I think this alternative is more readable as well.
>
> I'll mark the topic to be "Expecting a reroll" in the what's cooking
> report.
>
> Thanks.

Here's that re-roll, thanks both.

The patch is entirely Jeff's at this point (from
<YJrIMbr6VkYGQMfs@coredump.intra.peff.net>), with my amended commit
message. So I added his SOB per his recent-ish ML "every patch of mine
can be assumed to have my SOB" message.

Range-diff against v2:
1:  782555daad ! 1:  2e41e3e4cb trace2: refactor to avoid gcc warning under -O3
    @@ Commit message
         ee4512ed481 (trace2: create new combined trace facility, 2019-02-22).
     
         As noted in [2] this warning happens because the compiler doesn't
    -    assume that errno must be non-zero after a failed syscall. Let's work
    -    around it as suggested in that analysis. We now return -1 ourselves on
    -    error, and save away the value of errno in a variable the caller
    -    passes in.
    +    assume that errno must be non-zero after a failed syscall.
    +
    +    Let's work around by using the well-established "saved_errno" pattern,
    +    along with returning -1 ourselves instead of "errno". The caller can
    +    thus rely on our "errno" on failure.
     
         See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=61846 for a related
         bug report against GCC.
    @@ Commit message
         2. https://lore.kernel.org/git/20200404142131.GA679473@coredump.intra.peff.net/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Signed-off-by: Jeff King <peff@peff.net>
     
      ## trace2/tr2_dst.c ##
    -@@ trace2/tr2_dst.c: static int tr2_dst_try_path(struct tr2_dst *dst, const char *tgt_value)
    - #define PREFIX_AF_UNIX_STREAM "af_unix:stream:"
    - #define PREFIX_AF_UNIX_DGRAM "af_unix:dgram:"
    - 
    --static int tr2_dst_try_uds_connect(const char *path, int sock_type, int *out_fd)
    -+static int tr2_dst_try_uds_connect(const char *path, int sock_type,
    -+				   int *out_fd, int *e)
    - {
    - 	int fd;
    - 	struct sockaddr_un sa;
    +@@ trace2/tr2_dst.c: static int tr2_dst_try_uds_connect(const char *path, int sock_type, int *out_fd)
      
      	fd = socket(AF_UNIX, sock_type, 0);
    --	if (fd == -1)
    + 	if (fd == -1)
     -		return errno;
    -+	if (fd == -1) {
    -+		*e = errno;
     +		return -1;
    -+	}
      
      	sa.sun_family = AF_UNIX;
      	strlcpy(sa.sun_path, path, sizeof(sa.sun_path));
      
      	if (connect(fd, (struct sockaddr *)&sa, sizeof(sa)) == -1) {
     -		int e = errno;
    -+		*e = errno;
    ++		int saved_errno = errno;
      		close(fd);
     -		return e;
    ++		errno = saved_errno;
     +		return -1;
      	}
      
      	*out_fd = fd;
    +@@ trace2/tr2_dst.c: static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
    + {
    + 	unsigned int uds_try = 0;
    + 	int fd;
    +-	int e;
    + 	const char *path = NULL;
    + 
    + 	/*
     @@ trace2/tr2_dst.c: static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
      	}
      
      	if (uds_try & TR2_DST_UDS_TRY_STREAM) {
     -		e = tr2_dst_try_uds_connect(path, SOCK_STREAM, &fd);
     -		if (!e)
    -+		if (!tr2_dst_try_uds_connect(path, SOCK_STREAM, &fd, &e))
    ++		if (!tr2_dst_try_uds_connect(path, SOCK_STREAM, &fd))
      			goto connected;
    - 		if (e != EPROTOTYPE)
    +-		if (e != EPROTOTYPE)
    ++		if (errno != EPROTOTYPE)
      			goto error;
      	}
      	if (uds_try & TR2_DST_UDS_TRY_DGRAM) {
     -		e = tr2_dst_try_uds_connect(path, SOCK_DGRAM, &fd);
     -		if (!e)
    -+		if (!tr2_dst_try_uds_connect(path, SOCK_DGRAM, &fd, &e))
    ++		if (!tr2_dst_try_uds_connect(path, SOCK_DGRAM, &fd))
      			goto connected;
      	}
      
    +@@ trace2/tr2_dst.c: static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
    + 	if (tr2_dst_want_warning())
    + 		warning("trace2: could not connect to socket '%s' for '%s' tracing: %s",
    + 			path, tr2_sysenv_display_name(dst->sysenv_var),
    +-			strerror(e));
    ++			strerror(errno));
    + 
    + 	tr2_dst_trace_disable(dst);
    + 	return 0;

 trace2/tr2_dst.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
index ae052a07fe..bda283e7f4 100644
--- a/trace2/tr2_dst.c
+++ b/trace2/tr2_dst.c
@@ -204,15 +204,16 @@ static int tr2_dst_try_uds_connect(const char *path, int sock_type, int *out_fd)
 
 	fd = socket(AF_UNIX, sock_type, 0);
 	if (fd == -1)
-		return errno;
+		return -1;
 
 	sa.sun_family = AF_UNIX;
 	strlcpy(sa.sun_path, path, sizeof(sa.sun_path));
 
 	if (connect(fd, (struct sockaddr *)&sa, sizeof(sa)) == -1) {
-		int e = errno;
+		int saved_errno = errno;
 		close(fd);
-		return e;
+		errno = saved_errno;
+		return -1;
 	}
 
 	*out_fd = fd;
@@ -227,7 +228,6 @@ static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
 {
 	unsigned int uds_try = 0;
 	int fd;
-	int e;
 	const char *path = NULL;
 
 	/*
@@ -271,15 +271,13 @@ static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
 	}
 
 	if (uds_try & TR2_DST_UDS_TRY_STREAM) {
-		e = tr2_dst_try_uds_connect(path, SOCK_STREAM, &fd);
-		if (!e)
+		if (!tr2_dst_try_uds_connect(path, SOCK_STREAM, &fd))
 			goto connected;
-		if (e != EPROTOTYPE)
+		if (errno != EPROTOTYPE)
 			goto error;
 	}
 	if (uds_try & TR2_DST_UDS_TRY_DGRAM) {
-		e = tr2_dst_try_uds_connect(path, SOCK_DGRAM, &fd);
-		if (!e)
+		if (!tr2_dst_try_uds_connect(path, SOCK_DGRAM, &fd))
 			goto connected;
 	}
 
@@ -287,7 +285,7 @@ static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
 	if (tr2_dst_want_warning())
 		warning("trace2: could not connect to socket '%s' for '%s' tracing: %s",
 			path, tr2_sysenv_display_name(dst->sysenv_var),
-			strerror(e));
+			strerror(errno));
 
 	tr2_dst_trace_disable(dst);
 	return 0;
-- 
2.32.0.rc0.406.g73369325f8d


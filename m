Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F09C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238637AbiDMUE7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238582AbiDMUEm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:04:42 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A457C783
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:13 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t1so4174637wra.4
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WPlhHzMJswBQ3YhKnMBPzIwACQU9Gl3Vlv5RvywqdHQ=;
        b=QjJAgBQMdUJK93g+K5ThHWPWcVfcHuZQaudzjsmJhvr60K8PDxrJGChfZ64jVQ7l0T
         Z/yPjhKFjyscb4SeIrwRsQVWWeawfJFUTojqJU4mRtRRMDoe8rL6A6EJHmuCDAvtc1Qd
         cqrj7QvTLu8dj485RDrgNPswM0Wc0WgrBpgdDX/dIXmGYJv2iYkOs4NDf8WjeIlTK5Up
         TTxdaYccLTH7OlstKDvAyfkAEF0MfpBvjg9tEYecOxInAPJc6x1rAks32MetIBft7Xcl
         t7vi4peaSl6JQKdox6cxQaoZBoO+/EiDSbrbMZZGdjRpnEK0iV+XodLXfad9M5fPyprj
         LELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WPlhHzMJswBQ3YhKnMBPzIwACQU9Gl3Vlv5RvywqdHQ=;
        b=CvfKMIcqtektbuSv0bn7O8PeHsglYlq7/xQ/WxR1rxk43s2g/isASpVo83FZivfiK7
         Wn3baQuAGg0qP1492Kg/MCAUqQkve4QuzGm+DjcaBFYf0RGmBIEGy+TWh0ABNQaLWF44
         +qTmEnpGUJFiXR0BHt8G+ceoI4gegANXLJ5wlWVXE+Zy8HmfpSQDUfHrvmfbxd3Te6eD
         mOjyyMgAbk2ZKacTetbhCdiA5lZ8N3Wvql8yZUhZ8hqdYIUVmSYZdhPVcjn7TiG9TYCR
         Ekzw1SSoodHtggU90X7pnHll+9EzK73T3NHIfKlCQbeJd5+FwVmL7m/Odqjul4glcDhQ
         WC+Q==
X-Gm-Message-State: AOAM5313urMWG3dnSrClIfTY0xdXvCUwuw25DP2lUXT3X0hSN5tW7FW1
        4Bgv8sJoM1Rw7TuRggr1Q+r/TvbZi0mR7A==
X-Google-Smtp-Source: ABdhPJzskdlSiK7xaGGiSDmlNmGUCuLZNCZ5uiBVFoArxGGJohQYdUvMPP8WTwmYGy+2eG7BocdhYg==
X-Received: by 2002:a05:6000:11c7:b0:207:b3db:8b80 with SMTP id i7-20020a05600011c700b00207b3db8b80mr376068wrx.110.1649880132208;
        Wed, 13 Apr 2022 13:02:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6484000000b002057ad822d4sm35220498wri.48.2022.04.13.13.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:02:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 12/27] revisions API users: use release_revisions() in http-push.c
Date:   Wed, 13 Apr 2022 22:01:41 +0200
Message-Id: <patch-v6-12.27-2c744ccdbb1-20220413T195935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
References: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com> <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the case of cmd_main() in http-push.c we need to move the
deceleration of the "struct rev-list" into the loop over the
"remote_refs" when adding a release_revisions().

We'd previously set up the "revs" for each remote, but would
potentially leak memory on each one.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 http-push.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/http-push.c b/http-push.c
index f0c044dcf76..01e7c2ac5c8 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1689,7 +1689,6 @@ int cmd_main(int argc, const char **argv)
 	struct refspec rs = REFSPEC_INIT_PUSH;
 	struct remote_lock *ref_lock = NULL;
 	struct remote_lock *info_ref_lock = NULL;
-	struct rev_info revs;
 	int delete_branch = 0;
 	int force_delete = 0;
 	int objects_to_send;
@@ -1825,6 +1824,7 @@ int cmd_main(int argc, const char **argv)
 
 	new_refs = 0;
 	for (ref = remote_refs; ref; ref = ref->next) {
+		struct rev_info revs;
 		struct strvec commit_argv = STRVEC_INIT;
 
 		if (!ref->peer_ref)
@@ -1941,6 +1941,7 @@ int cmd_main(int argc, const char **argv)
 		unlock_remote(ref_lock);
 		check_locks();
 		strvec_clear(&commit_argv);
+		release_revisions(&revs);
 	}
 
 	/* Update remote server info if appropriate */
-- 
2.36.0.rc2.843.g193535c2aa7


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1534C433FE
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353485AbiBKU5T (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:57:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245262AbiBKU4v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:56:51 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE3DD7B
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:40 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id y6-20020a7bc186000000b0037bdc5a531eso3404949wmi.0
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QnYTFJT06s2WCtUgrMhIuhFA85X/15biOf3h9T66odA=;
        b=cPEVUWz8/sq0OS37uXm8VvHuqdAbAEHMK1t6NhUpkddDTPwyreoADwMBmjZZe038qY
         VVquX7P1clu18vNhJkLYpx06ED5XSVGTyr72Mg7maM8j+cW6fUnknnq9LfV+W2TLxPn9
         0gst96fatpvMveaWdfUOZxyW1neyprK/EmAaK+HyFFL6J9dRa4aVWoZVQv/cpFNXyi5I
         wdYmdWGmIJGwMZ3gz9RmLj6mOp+Z48sixNrNxztax2Jz56cmDFFgKWdorlR3p+JOUlwY
         a0DBJTO9wLRgCFDeyUA+WvLJw19UlckoFaw+BbVS2oMUVkxmnnAngYd3KHgsOFzBZTIx
         RREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QnYTFJT06s2WCtUgrMhIuhFA85X/15biOf3h9T66odA=;
        b=Vzbm//UO/3b25jq9QzyqVKkyryC7EUi8Q+iprkLF2/6uzUzi+dtA9TROE0AiS1KoIs
         CQwNYXOOWDS+yElrUPQcDSgVAsZNtRnv6M70/yktif0ugZk8ndn43I+HAkNZEHW6UjdB
         6X0ToH2Z+z43E3aUSgpD6QFOwuWDamN1ueY4Kv93CQLVmH2pPB8/9BkTZ3j7e6xGoZZy
         lusnbruJuPlHsR//Q9YxQy8bn1W0z4uv8Q/tqsYiv/D0piYw6qRwbjajBTjgge3NF+gr
         b7Lf+NftOXPrKlulhouunOT+3fRCzYBaRX9IkAV7GZqh/0eAC/n6FKcJxb5FFUYRzLy3
         1FPQ==
X-Gm-Message-State: AOAM532dxA94PhFowursJ0Pib2MBUL4St5ZABQrh++mgRPKBGc0XKDiU
        uK2GACAVzDOX1ht/aeQbxQv3VC/egr8=
X-Google-Smtp-Source: ABdhPJxZXWV8i9xMjq9kWHAHVsalGyitmysgIvzJ2o8HMU6/m+FkNNtYEdDa2z42VhdYXmZN311dLg==
X-Received: by 2002:a05:600c:1c0e:: with SMTP id j14mr1787848wms.60.1644612999249;
        Fri, 11 Feb 2022 12:56:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b16sm12520078wrj.26.2022.02.11.12.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:56:38 -0800 (PST)
Message-Id: <27e471089083dca302e3e160f7b1a0290046a49b.1644612979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 20:56:11 +0000
Subject: [PATCH v5 22/30] t/perf: avoid copying builtin fsmonitor files into
 test repo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Do not copy any of the various fsmonitor--daemon files from the .git
directory of the (GIT_PREF_REPO or GIT_PERF_LARGE_REPO) source repo
into the test's trash directory.

When perf tests start, they copy the contents of the source repo into
the test's trash directory.  If fsmonitor is running in the source repo,
there may be control files, such as the IPC socket and/or fsmonitor
cookie files.  These should not be copied into the test repo.

Unix domain sockets cannot be copied in the manner used by the test
setup, so if present, the test setup fails.

Cookie files are harmless, but we should avoid them.

The builtin fsmonitor keeps all such control files/sockets in
.git/fsmonitor--daemon*, so it is simple to exclude them.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/perf-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 407252bac70..932105cd12c 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -78,7 +78,7 @@ test_perf_copy_repo_contents () {
 	for stuff in "$1"/*
 	do
 		case "$stuff" in
-		*/objects|*/hooks|*/config|*/commondir|*/gitdir|*/worktrees)
+		*/objects|*/hooks|*/config|*/commondir|*/gitdir|*/worktrees|*/fsmonitor--daemon*)
 			;;
 		*)
 			cp -R "$stuff" "$repo/.git/" || exit 1
-- 
gitgitgadget


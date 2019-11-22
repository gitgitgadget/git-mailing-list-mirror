Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615C5C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F4120658
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmBkj7gH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfKVTnH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:43:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39841 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfKVTnH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 14:43:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so6897450wrt.6
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 11:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VkRpDdWVDg5oNeQLuBh1hylnIR95FotOTWC1L3tP45o=;
        b=ZmBkj7gH9aeB4nMxOEtewoghjLe61PIxLHjlaGSIwNN5JiSCqhEHIqQG98TZ/4oXzp
         RRuTqf3A/Q44b/MM2/Ci6/FAkwPW8srgnI6KajRLGKz+XFmy7wXAGpSd7QcmbNm9/xqB
         0If8WfkwTyIP9Au6IoqD2GR67mWH+YZxPMfGWz9ZXTMIlb1FsSX/yposu0p82QRBJ5o/
         14COPQ7DX1XiXpK/2Ob2y1dvxslAGFx/nFrjBenX/eN/3TvZe3qLtYkLZYn5r/26toGC
         qpWby2qHaA+5H75HmSAdjHwem5kunHwK//7yFXmPXIAkwGXlZRrMI4Fw2ihZSU5lvvzV
         nlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VkRpDdWVDg5oNeQLuBh1hylnIR95FotOTWC1L3tP45o=;
        b=l49so2uXT98lUXpi/8OkiASnY1X3+BaOhc+Y/5WPTMN+vQYsUgO+dOVdZv1WsyVAen
         xbUUT7jJJTxWUGRc2Y50vIXm6AftmWFT9vEohgPOigVAfU5mi77RBBriLAekEcOUQ9I6
         NytvgX2bV9IfVETTTSKciMX5QSdYKUVf05PJl47O17T7H8T4IOFqV5TL4lPOsy/r+x81
         sz8up8qO5n4Zv1sVzzGk3g0J45Y187G9liNviXWM1y9jqSwl92356UoT9sFt8K2t9yT1
         uTFdnbTZm9aibXLDlkRo42hmqz5gGR427qrlv5K1z/Wu/v3cQtiTgCc4L2ADT2q5E/z5
         mqBg==
X-Gm-Message-State: APjAAAVDA5c28R/B2tSu7CUNFELDWNdyBQHWOSgz4QIYxGTsA7g4yLSf
        nuH7o4fMF1GGHt6ZE8lXxS60UUwO
X-Google-Smtp-Source: APXvYqyHeR52JLDFQrN9YQSHEImWOUQiU1R6SyG2+tYQH3Eh8RHVfSiDltvJzcZsp4CkRlYQvAR/MQ==
X-Received: by 2002:adf:ec89:: with SMTP id z9mr19293695wrn.153.1574451785120;
        Fri, 22 Nov 2019 11:43:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3sm8465761wrw.20.2019.11.22.11.43.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 11:43:04 -0800 (PST)
Message-Id: <pull.467.v2.git.1574451783.gitgitgadget@gmail.com>
In-Reply-To: <pull.467.git.1574345181.gitgitgadget@gmail.com>
References: <pull.467.git.1574345181.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Nov 2019 19:43:02 +0000
Subject: [PATCH v2 0/1] sequencer: fix empty commit check when amending
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the comments, I've updated the patch with the style change Junio
suggested

I noticed this while adding some tests for a re-roll of
js/advise-rebase-skip

This patch is based on pw/post-commit-from-sequencer

Phillip Wood (1):
  sequencer: fix empty commit check when amending

 sequencer.c            | 26 +++++++++++++++++++++-----
 t/t3403-rebase-skip.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 5 deletions(-)


base-commit: 4627bc777e9ade5e3a85d6b8e8630fc4b6e2f8f6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-467%2Fphillipwood%2Fwip%2Frebase-fix-empty-commit-check-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-467/phillipwood/wip/rebase-fix-empty-commit-check-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/467

Range-diff vs v1:

 1:  7d34c0ff80 ! 1:  037f2b2975 sequencer: fix empty commit check when amending
     @@ -42,8 +42,10 @@
      +				first_parent = NULL;
      +			}
      +		}
     -+		if (oideq(first_parent ? get_commit_tree_oid(first_parent) :
     -+					 the_hash_algo->empty_tree, &tree)) {
     ++		if (oideq(first_parent
     ++			  ? get_commit_tree_oid(first_parent)
     ++			  : the_hash_algo->empty_tree,
     ++			  &tree)) {
      +			res = 1; /* run 'git commit' to display error message */
      +			goto out;
      +		}

-- 
gitgitgadget

Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F52C55178
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 00:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8B152417F
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 00:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wm2g/hn0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507438AbgJVAVM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 20:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507420AbgJVAVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 20:21:09 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E21DC0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 17:21:09 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b8so5302522wrn.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 17:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WpQnm5yeH/yZ2Bq7RFNDSZUTx3v+IDECaHcUQt1Dq4Y=;
        b=Wm2g/hn0iXfqWcrs0zd0dn7sQiOEdp58Mbjgd3yMyh9kTH0V0LZfOGgMofy2kPNmt3
         q+hVkXQU+6smfzG8lTatUIi2I3mClxBiYiMdTyNLoPyLMfVDecN/Xzu5tZaqO5jNb3dx
         sp2CQ2C7QOL5iV16Z5UxTw0uLaD1pKs4JXNsNmAvCTRd62btf/CvHuWhO/f74dMZ9seC
         KAJAQhwQLAWUT2xR55t3XJr8d7gC3QlXaT5pB+V3oQogk2Z15TNu5p2jyfnXh1B8eFt5
         KNpzD11SRyhg3BYnzDLLDTKiFkHC6GrfyZyJ2ocpX30qOmFcGzBPJMcYroQRL9/6zpI5
         P4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WpQnm5yeH/yZ2Bq7RFNDSZUTx3v+IDECaHcUQt1Dq4Y=;
        b=qvCzFRD4G5uEqbYk7PlH9ZLkt3TsChvIWaGTDj1+4F8vko7lsMpjvRsD3VneQxq4ne
         WX02z/zA7+rqYjKy6EbQv0n5DMf7Q1BWIkzKODXyoGMdRVoW2qLyUuoVnp9Nfsuumld/
         8c8ZPFDzE9SBfCED0DWjaChan0T/QyTt6PDqwrwvuKNtoX2G4f/EuBiWr2scta+uvlpU
         1ufglTyxaaU5IoeFXhy1XPlUyNXJ3vDvwqDzCARgv9+rQbGfwZtr0+CYNRj62s+iH6iS
         zKOQCl+r6lhJ7drQVXY8cKL19k341gn+l/VIUcl4Y+7c543VcfkJtQx2WeEbNgQVvSlH
         W7rA==
X-Gm-Message-State: AOAM533jo9NL5DL32WPJd6+ULFSJpUxsOSgljyepSr4dOo2zDrro10ck
        mN1COqdiBtWyC6YK8Z3ecNNDA/HzpEo=
X-Google-Smtp-Source: ABdhPJySo8BUHmvWxFB8Kbzjxz4pgGv71/bnUCOk55+Y1ALnOegliT7MMQ4NjtcUYt04hnXOQoh6KA==
X-Received: by 2002:adf:9793:: with SMTP id s19mr7237525wrb.139.1603326067700;
        Wed, 21 Oct 2020 17:21:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k203sm82068wmb.37.2020.10.21.17.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 17:21:07 -0700 (PDT)
Message-Id: <pull.767.v2.git.1603326066.gitgitgadget@gmail.com>
In-Reply-To: <pull.767.git.1603303474.gitgitgadget@gmail.com>
References: <pull.767.git.1603303474.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Oct 2020 00:21:04 +0000
Subject: [PATCH v2 0/2] fsmonitor inline / testing cleanup
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

UPDATE SINCE v1

 * Removed include of dir.h from fsmonitor.h as it's no longer needed

Credit to alexmv again - I'm rebasing these changes from a couple years ago
for contribution.

Full comments are available here -
https://public-inbox.org/git/01ad47b4-aa5e-461a-270b-dd60032afbd1@gmail.com/
To summarize the relevant points

Re: Inlining mark_fsmonitor_[in]valid peartben said

I'm fine with these not being inline.  I was attempting to minimize the 
performance impact of the fsmonitor code when it was not even turned on. 
  Inlineing these functions allowed it to be kept to a simple test but I 
suspect (especially with modern optimizing compilers) that the overhead 
of calling a function to do that test is negligible.

Re test-dump-fsmonitor peartben suggested keeping the +- syntax as well as
the summary counts dscho suggested dumping the invalid entries

Alex Vandiver (2):
  fsmonitor: stop inline'ing mark_fsmonitor_valid / _invalid
  fsmonitor: make output of test-dump-fsmonitor more concise

 fsmonitor.c                    | 19 +++++++++++++++++++
 fsmonitor.h                    | 19 ++-----------------
 t/helper/test-dump-fsmonitor.c | 14 ++++++++++++--
 3 files changed, 33 insertions(+), 19 deletions(-)


base-commit: 69986e19ffcfb9af674ae5180689ab7bbf92ed28
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-767%2Fnipunn1313%2Ffsmonitor-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-767/nipunn1313/fsmonitor-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/767

Range-diff vs v1:

 1:  049989652c ! 1:  ab9c330ca8 fsmonitor: stop inline'ing mark_fsmonitor_valid / _invalid
     @@ fsmonitor.c: void refresh_fsmonitor(struct index_state *istate)
       	unsigned int i;
      
       ## fsmonitor.h ##
     +@@
     + #define FSMONITOR_H
     + 
     + #include "cache.h"
     +-#include "dir.h"
     + 
     + extern struct trace_key trace_fsmonitor;
     + 
      @@ fsmonitor.h: void refresh_fsmonitor(struct index_state *istate);
        * called any time the cache entry has been updated to reflect the
        * current state of the file on disk.
 2:  598521091a = 2:  8ff657ded1 fsmonitor: make output of test-dump-fsmonitor more concise

-- 
gitgitgadget

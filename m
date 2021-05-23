Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F22FC4707A
	for <git@archiver.kernel.org>; Sun, 23 May 2021 09:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 252C36128A
	for <git@archiver.kernel.org>; Sun, 23 May 2021 09:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhEWJzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 05:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhEWJzC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 05:55:02 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D93DC061574
        for <git@vger.kernel.org>; Sun, 23 May 2021 02:53:35 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id z19-20020a7bc7d30000b029017521c1fb75so9781461wmk.0
        for <git@vger.kernel.org>; Sun, 23 May 2021 02:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=OaU8B7WJf3tPiGQf9VxUKFjgf1untUOJKFgIAmRoF6c=;
        b=qE5K6AWRuUGdIbJA11Y2Vs2NdfOZaLj0MACykvF2qXRqZiR9sVOv2FhOynW9HehXHR
         GRXk7LhHbST9lraMRj6gJLUScc7piJpTFh3XpDy9f248OptZRKLRpRBz9W59dR53gYV1
         QmkJ558AtH37lYZVQCzxP3xIoGKF6zaQAnsaRy1+EJPAidZvewkdxdCTFAiBlxNy+kn9
         raYKxDZiGyDnqLahYXWXOTUNvrpC2pYgEe/F7YYwinDcqfQ43fycnM2d3yngXJGcSN62
         8S8rphKqqFmTjkuZJZNRfmXsftN11oyXfk+R4Ln7QzgxzuG+0tq2MNm1hxcJFKGwf+AS
         SeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=OaU8B7WJf3tPiGQf9VxUKFjgf1untUOJKFgIAmRoF6c=;
        b=mLOvhov0AWA1b3CfEsWy5ZS9S6rZrX9KSLTLua0rVyAm+0JzkppptU0omhrn9hn16S
         KsjRWqXDngW2i0uCf+PBnOwkFKG9T616yXfWBJ7Q/Ut0f1M7+sZ0A+kxSOPBRnp7h32x
         GctH3Wo6VJIADEXwTi/VDceNPxf/ApW/zxqKsLilSjs1i4p/U4UEQ+h/X/svQLAVz+MA
         ufgzVZmH/n+kZjX+VN6Gd9S9h2uXvv/sTgXYAWAooecYc2lPciq9NOcnKT2UHCxq4Z++
         gcziEgLssKElKRv9yFVl+7FJK5xnaY9FGVv2zX9liQHZlzSLaY3l19ZVBDaHbrnmSktg
         IQcg==
X-Gm-Message-State: AOAM530JA1vqXU4LBYnSVXDM83IGlNITRJMXVma7gS1YRa6X97AUmcLQ
        XubFmlvTMQRpfvvTfY6AfPtPlCOPv7I=
X-Google-Smtp-Source: ABdhPJyIccQuqrKzOTONG4wydSw843245Y+PkHUDJ44Utdwsp2tGMl1tgqZK1MbZ2exm1J/KyH8UxA==
X-Received: by 2002:a1c:cc17:: with SMTP id h23mr15180085wmb.129.1621763613719;
        Sun, 23 May 2021 02:53:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13sm8495898wrt.86.2021.05.23.02.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 02:53:33 -0700 (PDT)
Message-Id: <pull.959.git.1621763612.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 23 May 2021 09:53:29 +0000
Subject: [PATCH 0/3] [GSOC][RFC] ref-filter: add contents:raw atom
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In (a2f3241: [GSOC] ref-filter: add contents:raw atom) I did not notice the
breakage that occurred during the test, In the later remediation, I found a
very serious problem: The output object data of "git cat-file tree foo" or
"git cat-file blob foo" may contain '\0'. However, most of the logic in
ref-filter depends on the atomic output not containing'\0'.

Therefore, we must carry out a series of repairs to ref-filter so that it
can support output of data containing '\0'.

In first patch, I add *.quote_buf_with_size() functions, this can deal with
data with containing'\0'.

In second patch, I add the member s_size in struct atom_value, and protects
the output of the atom from being truncated at '\0', and successfully
supported the %(contents) of blob and tree.

In third patch, I added the%(contents:raw) atom, It can print the original
content of an object.

What needs to be reconsidered:

For a binary object blob, tree,

git for-each-ref --format="%(contents)" --python refs/mytrees/first

will output a string processed by python_quote_buf_with_size(), which
contains'\0'. But the binary files seem to be useless after quoting. Should
we allow these binary files to be output in the default way with
strbuf_add()? If so, we can remove the first patch.

ZheNing Hu (3):
  [GSOC] quote: add *.quote_buf_with_size functions
  [GSOC] ref-filter: support %(contents) for blob, tree
  [GSOC] ref-filter: add contents:raw atom

 Documentation/git-for-each-ref.txt |  19 ++-
 quote.c                            | 116 +++++++++++++++
 quote.h                            |   4 +
 ref-filter.c                       | 229 +++++++++++++++++++++--------
 t/t6300-for-each-ref.sh            | 214 ++++++++++++++++++++++++++-
 5 files changed, 511 insertions(+), 71 deletions(-)


base-commit: 97eea85a0a1ec66d356567808a1e4ca2367e0ce7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-959%2Fadlternative%2Fref-filter-contents-raw-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-959/adlternative/ref-filter-contents-raw-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/959
-- 
gitgitgadget

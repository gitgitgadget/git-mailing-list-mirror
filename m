Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97498C433E0
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 08:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AFDD61924
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 08:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhCUI7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 04:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhCUI65 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 04:58:57 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E03C061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 01:58:57 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so9895081wmq.1
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 01:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jOr7FT2FNF+xJfQavPqQ2BgdEUcYm99hmcWCL08YBgU=;
        b=bpf1c7Bcreczk7l1QfsSBvc53MTvFCwrrTfniDKM4ZDLZQv/QuSdVZdV8fUBd7jhki
         9QygN+/wTbtMkngZI5EBzXZQKh2RiOtv5OuHUm8qTUCtvECxk21ImHPAGQEHPrPuEuCr
         whA+9OJuAAcTKDBqpENkAYZRBiSiqveRSJ5NAS7A0bPAH8MRkMl1KNKxmiJ9DJWz0yWT
         SGNU0WKCXw6HvRMgXVJrJSXPn9KA8oT4dg9BJfFqD3YsJkXDYoQ5vuz8l8ylX5fUZlsr
         g/bIUDIDRF85Qdi6L27upG0kcz+0ff400jR8xSLN36VXRMhjpnBe0p/dOI+8wjh6N+bG
         nC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jOr7FT2FNF+xJfQavPqQ2BgdEUcYm99hmcWCL08YBgU=;
        b=K8fhMzRWUQSL1fVvuF9FjBsosfR8SPeQ12stU8f+c4kQ8zSwhxJRtFMs5E4oWwjf3Q
         xBcXcQHMpe8d35DhC/Cdp7W0qo8yGxv+P/2Ctbpz6E9S+g0Xp309PEf8E1ve5gHlH7cs
         VIcbDiHZTEdVqJIsaTgiOm6N6+N4IqOLfqHgVSZPYRTz2yIcthDkBUDxlr/jdVIuC4sp
         b3pXxgRcFdYYlb3/CivJ/mmPC57hD2QLm1xdf7uMYYUj9a85+7w0zzBFyg/75HEaIYxw
         KJ1Nd+yX/5HI3qBOW5AL+sRn3zOzWn/5uBwjEGHYuoAM6bxBVjY5kCdLvnPISBtpe6Mn
         t+3Q==
X-Gm-Message-State: AOAM532CMBDLlx/j0Ei7AqemJBXINLjg9yjExVFqG2crj4xC/IrzzEru
        OX0mhUCQhoUmM1DsIV4yN+o9zD9QUbQ=
X-Google-Smtp-Source: ABdhPJza90NGnwrlm96vUfprlrHDmZ8kL/mhMyHgI2WxLp3ctPD1xpt4hk1dhXQvwM417qtpxxIeMA==
X-Received: by 2002:a1c:9845:: with SMTP id a66mr10818810wme.156.1616317136302;
        Sun, 21 Mar 2021 01:58:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g9sm16254644wrp.14.2021.03.21.01.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 01:58:55 -0700 (PDT)
Message-Id: <pull.911.v2.git.1616317134.gitgitgadget@gmail.com>
In-Reply-To: <pull.911.git.1616251299.gitgitgadget@gmail.com>
References: <pull.911.git.1616251299.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Mar 2021 08:58:52 +0000
Subject: [PATCH v2 0/2] [GSOC] interpret-trailer: easy parse trailer value
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hope this can help commit --trailer more useful!

Base on https://github.com/gitgitgadget/git/pull/901, The original patch
series was too long so now split it into two.

Helped by Junio and Jeff, Thanks.

ZheNing Hu (2):
  [GSOC] commit: add --trailer option
  [GSOC] interpret-trailer: easy parse trailer value

 Documentation/git-commit.txt             |  14 +-
 Documentation/git-interpret-trailers.txt |  23 ++
 builtin/commit.c                         |  55 ++--
 commit.c                                 |  34 +++
 commit.h                                 |  10 +
 t/t7502-commit-porcelain.sh              | 319 +++++++++++++++++++++++
 t/t7513-interpret-trailers.sh            |  23 ++
 trailer.c                                |  13 +-
 8 files changed, 456 insertions(+), 35 deletions(-)


base-commit: 13d7ab6b5d7929825b626f050b62a11241ea4945
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-911%2Fadlternative%2Ftrailer-easy-ident-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-911/adlternative/trailer-easy-ident-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/911

Range-diff vs v1:

 1:  2378e3b4c1ae = 1:  2378e3b4c1ae [GSOC] commit: add --trailer option
 2:  ca521d3c01d6 ! 2:  8b8b236a4ffb [GSOC] interpret-trailer: easy parse trailer value
     @@ commit.c: int run_commit_hook(int editor_is_used, const char *index_file,
      
       ## commit.h ##
      @@ commit.h: int parse_buffer_signed_by_header(const char *buffer,
     + 				  struct strbuf *payload,
       				  struct strbuf *signature,
       				  const struct git_hash_algo *algop);
     - 
     ++/*
     ++ * Calling `find_author_by_nickname` to find the "author <email>" pair
     ++ * in the most recent commit which matches "--author=name".
     ++ *
     ++ * Note that `find_author_by_nickname` is not reusable, because it haven't
     ++ * reset flags for parsed objects. The only safe way to use `find_author_by_nickname`
     ++ * (without rewriting the revision traversal machinery) is to spawn a
     ++ * subprocess and do find_author_by_nickname() in it.
     ++ */
      +const char *find_author_by_nickname(const char *name);
     -+
     + 
       #endif /* COMMIT_H */
      
       ## t/t7502-commit-porcelain.sh ##

-- 
gitgitgadget

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7100C6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 20:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjCTUlM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 16:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjCTUlK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 16:41:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D167A98
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 13:40:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j11-20020a25230b000000b00b6871c296bdso6995183ybj.5
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 13:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679344843;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C57rkNSlMnfLF0UAyEQtdGK+0QlZ+2KFwgtxQBW/1j8=;
        b=Br6Pp4fanDAnaDhWAcqgEqXivAMYBnvdsd0WkRW/DLsCwbshAcKZAHSyQHVdSClR+h
         uFM9OYt3vSjFXaD26JEVHFijR1kxlHNUosff451MN8kY/rPjNWpidrXzkHpj2sAlbr1V
         bu93RHksFBzR6d+3dHSAqYlwKdJBeApu9NXz7ZXIZvni9afRLxL0l/SIqwklMNNwtFiS
         fk5OGn8TPGI8D4Z03hxS2INWv0V95yhRmK3ynVjzdGvxSOiPc4l/NZyzB0g6LAjSnNY/
         /wVJU74WlCmk3nfWSdD9HlgTiwEnohsy6RNeYxebAp37gZgJDTFHav3CHH3QUvDkeAPp
         YOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679344843;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C57rkNSlMnfLF0UAyEQtdGK+0QlZ+2KFwgtxQBW/1j8=;
        b=LtEXoIoWED3DifjITmHFAoCYE5dgIGv3jUwaBIgU1g+VYOBdkbLxP3G9GManDZp0hz
         XdNbvfdnSGxwYUyUt4aSXxSUfgqsIIljjYkNm4LntX+8JZbZ2ecIhP5uf4LalF4bLZ34
         raduwIcZ0V1a8XW98oZHjhb1V5tF8XKRrE6iusR30O2zGc1Kod86336UymYyM8f/DF+x
         +udwf9HOOb6a4u+sqFnctF/yg5iDp7MOHteZdiPZUUeqHA7rSL86KnDSjggjHiTcK43U
         oq5Kc6IyTJAPShxa+27cpvReDZj3O7FQlLswYymyc2zCU95OB+N+pfR/+6t7JWHYnYYi
         IlKA==
X-Gm-Message-State: AAQBX9c+WxAKN7jwBRUlh3qUP85pm8B7VjJ81SHABg2fNl15hp3dQiBZ
        MftFC67xMpKV0Rw+xwUZsLKC9ZUOSnRVKpQee8cJ
X-Google-Smtp-Source: AKy350aYdRxKvOxr9pwnmVhm2FwOLCqbhrdYasBmZM25RN22i2LNMCszWZX4+VBCDBLVaEyOEODDlKytELyfB2PWMki+
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:5b27:b61c:65e2:5f93])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:124c:b0:b6c:a94:9bf3 with
 SMTP id t12-20020a056902124c00b00b6c0a949bf3mr437612ybu.9.1679344843216; Mon,
 20 Mar 2023 13:40:43 -0700 (PDT)
Date:   Mon, 20 Mar 2023 13:40:40 -0700
In-Reply-To: <5d937184a0eba9176d97423fb450850fc482e4de.1679311616.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230320204040.1446345-1-jonathantanmy@google.com>
Subject: Re: [PATCH v4 7/9] commit-reach: implement ahead_behind() logic
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> Fully implement the commit-counting logic required to determine
> ahead/behind counts for a batch of commit pairs. This is a new library
> method within commit-reach.h. This method will be linked to the
> for-each-ref builtin in the next change.

Thanks. I see that all my review comments have been addressed, so up to
and including this patch looks good. I haven't had time to look at the
last 2 patches, but it seems that other reviewers are already looking
at those.

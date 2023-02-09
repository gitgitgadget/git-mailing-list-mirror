Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C77C636D3
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 21:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjBIVwo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 16:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjBIVwn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 16:52:43 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DFC6310B
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 13:52:43 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-501c3a414acso43780777b3.7
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 13:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hqz4AOOTWQVmhs7a4+RgyCOHBlNhOJAW34bR6iqd4vc=;
        b=sl7HxhK9NZQeqZ0r/CTR/FlsAbckg2wOqe+fWam+AfRJlUYD7n3eRfiRvYjt1ozmbh
         BKjw8uUBvIik6ZInsa+wHmn3F8Si9nL3lYJ7yCsMBVM9MmNKiVa54Ae9PHg5HquLdBdO
         9UOUHpBR8uFCKqw/kdCU9T6a/GsrMoMmY725wN80DbnOMXj7DBK5YihIL7/Lm5+ivzoA
         za8mLqMUAz0ZMAdZTcNewJByV0jj4CKmkwEiaembSK93s12cJUoXOQOB3QJtvfJTIdrh
         NiLms8hsMJic8nYgg8pvNq7FtUwHcZvjpwWfQkN9pTvtbkfYtvRR6qrNekAW8ibL+/4n
         3GuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hqz4AOOTWQVmhs7a4+RgyCOHBlNhOJAW34bR6iqd4vc=;
        b=L+PWek6C9Woat5c2Ok/FAuW6Nr5kDxaIX0qVSV0V9G1gfcjTKpGsrMbqu8Zs7lMpep
         59ZsrLLKZOwH8s7fizrKFZGpuicnIhH3H6ieN6FR4p8JER1TvHCa6UTE7BIqcwOPikxn
         jvDIpCxo4HSYtZtsTw/MNqyt3y7r97nzKDLcvlXFgjOqspiwBQGO0UklUPjzaMuUBuWt
         Tbf6N5PJS5Uwm6Ou/0h55SrGSutwWMi4hzenfGfceoKEd89K5GQYbDXFGtl9i1PpFFC6
         8fbjorzcVAocf/Gzql26hhuXOW0myu6xwvmFXsUKBFDYv5ouoAaB5WIKcC9LjFB7AHqZ
         Mopg==
X-Gm-Message-State: AO0yUKUeLDPXdfFQe4D3GbawYzce843LbOyOaC9aUew7oL1HL2emF6K7
        dvg5lpgF3g1pX1AsCBExvjizUtjB4DW+rkBmEn4La/xTXpV26ymj
X-Google-Smtp-Source: AK7set+xhuLBckMM4f9C2+pAranEy6bJXli9msuB6/6qNwCdfD3W5HgfhZLDlmIl3nYfK6ynBaKu7+NrUAhgu15EZZE=
X-Received: by 2002:a81:5e43:0:b0:4e3:f87:8c24 with SMTP id
 s64-20020a815e43000000b004e30f878c24mr1521525ywb.248.1675979562100; Thu, 09
 Feb 2023 13:52:42 -0800 (PST)
MIME-Version: 1.0
References: <20230207181706.363453-1-calvinwan@google.com> <20230209000212.1892457-1-calvinwan@google.com>
 <xmqqwn4qmxds.fsf@gitster.g>
In-Reply-To: <xmqqwn4qmxds.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Thu, 9 Feb 2023 13:52:31 -0800
Message-ID: <CAFySSZAy=k+hgvg9r2NmroUs=BviZjS_KMW_+yO2nPs1dUsc-A@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] submodule: parallelize diff
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, chooglen@google.com,
        newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> By the way, how are you driving send-email when sending a
> multi-patch series with a cover letter?  It seems that all
> messages in this series including its cover are marked as if they
> are replies to the cover letter of the previous round, which is a
> bit harder to follow than making only [v8 0/6] as a reply to [v7 0/X]
> and all [v8 n/6] (n > 0) to be replies to [v8 0/6].

I'll do that from now on -- didn't realize that make it harder to follow

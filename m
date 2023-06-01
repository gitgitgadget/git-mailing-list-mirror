Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918DFC77B7A
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 23:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjFAXyG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 19:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjFAXyF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 19:54:05 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4408F136
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 16:54:04 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-64d1cbfb240so817536b3a.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 16:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685663644; x=1688255644;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OSGIA6be2ZGP4AsKfDmEdviudUZRQS0r3JXwzdJlzkk=;
        b=sixDPnw4ZnkNRIFZLht66ZTvBnU751pPyzqr4zRLnWt4xfNa4YVx2OgGHvMHqIuAc+
         oLaYzhebBtlgUcjH11h6AOH6G3tgMerFI+Au5Q2yypnrQt2zBZXSh/r1nvB07wyXKkjd
         9iOiNhT24DnefR8Q3npy8WNmDEpnfbEJ/nVv52U6hU8RbZIAZd6hOh88f53L42JDp5rX
         PVZ9TFL3s8X0OXlGZz8Hud8/UQTKR5IJY4Juo2KHoe7QWehOwlezctmzk4VT06aL56Ur
         YMmhwKjE/dTv7vZGQpdMjkxybAdwzRyAc1c8cgcG5FFtjI7kbghwkFiKtNeb2jAvT8L4
         NrLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685663644; x=1688255644;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSGIA6be2ZGP4AsKfDmEdviudUZRQS0r3JXwzdJlzkk=;
        b=NC+AiAxTmpbVTSt9vhnhDynMwcV/Dsrx5su+Ttf1UTgLAnQ66CAHsXwCNLKEVmEOMj
         506J4vKjKQs3Lg0AzaxM1Z8r7B1jWNJF1v7uFYPHSiS8gaK2oi9dpFd6uji6KkV+LCqG
         1ZCEXFS+JHE+zZFjKXWDepy48NAgvgrK9XOPNxxWrgRMyhG3AU5Sp4/S3XtyXH9AWfOe
         AzjabKZunzSzWNR+zVjz6s2Vw838w3r9281UZASZQ73KsDCSu1kKtbVjBn4styONE/fV
         IVNvBj2o/tToGfbbli/UkzO/dg5npwr1mruRrB95eBwDuB1zg0Qx/W6wOor7VEYxTIqv
         VgDw==
X-Gm-Message-State: AC+VfDwMrxwJ4mnhaIM2dWduKdgFcttaEuw06BIrQRRt6PuruM4OE5Zg
        4eWeyOXCgkA+ciQvohWKTGmppmgcpeMpo6iXEXjQ
X-Google-Smtp-Source: ACHHUZ4a3eR1kPKnsd62ARpbcL/taJ4hDC88sbjE9pv82MsWAI8NBf8/dtOzt7y6Oi0CbFmn83bo04ZJsotmdPapRV6d
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:9bd:7d22:5bbe:5b1c])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:88c8:0:b0:643:536b:e764 with
 SMTP id k8-20020aa788c8000000b00643536be764mr3927080pff.4.1685663643749; Thu,
 01 Jun 2023 16:54:03 -0700 (PDT)
Date:   Thu,  1 Jun 2023 16:54:01 -0700
In-Reply-To: <641a56f0b40a88b0127819989ed1f81f844a090e.1685472133.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230601235401.432962-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 07/14] config: provide kvi with config files
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> @@ -963,7 +965,8 @@ static int get_value(struct config_source *cs, config_fn_t fn, void *data,
>  	 * accurate line number in error messages.
>  	 */
>  	cs->linenr--;
> -	ret = fn(name->buf, value, NULL, data);
> +	kvi->linenr = cs->linenr;
> +	ret = fn(name->buf, value, kvi, data);

Forgot to mention in my other email...it's a pity that we have to bump
the kvi->linenr like this because the original kvi generated from the
cs is now out-to-date w.r.t. the cs in terms of line number (you can
see in the context how the cs linenr is also updated), so there are now
2 sources of truth with regards to the line number. I can't think of a
better way to do this, though.
 

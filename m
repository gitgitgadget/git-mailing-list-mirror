Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2919AC64ED6
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 19:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjB0Tlm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 14:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjB0Tlj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 14:41:39 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D285B27485
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 11:41:19 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536bbaeceeaso159851817b3.11
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 11:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPhFd2kOxjhs+siTghRI0eFPo0enNhbXEjMN1BzVcDk=;
        b=mGxJb8AqdrgKCdS+Ci/jiNDarKdaWjFAtU/7n70X0QUwuTrCiuMFa8nxfJLUbxoZ3p
         2eE8y7Xwyds5B0LZ7pPdJsYy/b0JTclaf+LtEwoqcQUbVh9iSbrB91lB/FPtzFfmOhhY
         /MSPlasY9N4205ieH+lIy4RFjSdZQfpJd3WkpqRvjb5V3urgw1p5DKYXEByemS5VY9wh
         JqBbWrscAcEBt870QeCpQvEZgtaPsa8v8rw/R6qgKMGFJ4D5WcQ0TmGYZIxothddLYL1
         Xh0mw5OTeyPQxII9EcUU5mA7bv5Aif9gfdy807J0MWXpASN0f45vwtsAU8+8MnzajB0A
         xLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GPhFd2kOxjhs+siTghRI0eFPo0enNhbXEjMN1BzVcDk=;
        b=IEQ/3N09WhmEUaDQ6bqkKKwb8BvpKF9VdtyZvRqy8eO45DbB4mtVPpiEkFoWlhVze2
         O7wrCp7skNjB7HS54eShngL6L4LymBdKTaL9tKjENEJprdWhJNwrD8FZTnc5cKh3vcAJ
         A5Zjtyhgf4zFCAsCkbHFHdnSScw5sb9kPrx3Wwbs08wyrhmgPV3Po5Q1iRua25+yhgya
         VYIyw0PyeneH0WTtONH45E69EelS9drxkmDxlcghgT9uVfPCKw9bqVWpZc1CPR30rUu5
         7AvgL0Zu+d7rzbLBLXMt6oWcDgZoRgFUEpH5ecTgcuoHyi/SQDJiSqL0isz51atILbCG
         P32w==
X-Gm-Message-State: AO0yUKVdZBklyUigaNl/Jr0Jsd4aPBP5fTMunP64/8D4eYMIhxrvI2aJ
        zYppO7X2GBd+C5kFlCRm4x3SjCX9DuCEZN1yA+6j
X-Google-Smtp-Source: AK7set/I0Y3WtEi/CG1kQL+yRsCor/OLFE2v0bxhQoMImg6LIajh2eF3qOLyongCteVx073e8UebluwSClOp/jr2dsic
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:e547:b66a:7a19:4376])
 (user=jonathantanmy job=sendgmr) by 2002:a25:e805:0:b0:a5f:0:bf12 with SMTP
 id k5-20020a25e805000000b00a5f0000bf12mr3822692ybd.13.1677526879010; Mon, 27
 Feb 2023 11:41:19 -0800 (PST)
Date:   Mon, 27 Feb 2023 11:41:16 -0800
In-Reply-To: <3d567892-bdd0-9ad9-a30e-1a67e7face11@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227194116.2417165-1-jonathantanmy@google.com>
Subject: Re: [PATCH v4 3/3] branch: rename orphan branches in any worktree
From:   Jonathan Tan <jonathantanmy@google.com>
To:     "=?UTF-8?q?Rub=C3=A9n=20Justo?=" <rjusto@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rub=C3=A9n Justo <rjusto@gmail.com> writes:
> @@ -583,7 +587,7 @@ static void copy_or_rename_branch(const char *oldname=
, const char *newname, int
>  				interpreted_oldname);
>  	}
> =20
> -	if (!copy) {
> +	if (!copy && (oldref_usage & IS_HEAD)) {
>  		/*
>  		 * Update all per-worktree HEADs pointing at the old ref to
>  		 * point the new ref.

What is the relevance of this change?

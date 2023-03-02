Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BF9C678D4
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 18:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCBSCQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 13:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCBSCN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 13:02:13 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90F25653A
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 10:02:08 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id i6-20020a170902c94600b0019d16e4ac0bso45491pla.5
        for <git@vger.kernel.org>; Thu, 02 Mar 2023 10:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8bgeEG2Bz44kDSybFqfVjBCjDtC1nvO/OtP/5ZbYQUA=;
        b=tjz+Q1rKh+5NnaRodvchI7a6CmWWB4DpuW2sn1/tswNcJZIOD8GFh7aPjXjM6Yt+ts
         WhUMSVJSwGE2IAafhzWKe4dJCx6vHwZDIe87nH1cXoyOtpmpZSCTpuPdTC3TfsdY7mce
         IO90T6iOWhkgY/lLtMezyne374aWLhW9EdbG4eV/GUPqGeHYHHZEjTZqjEIc0lcSyAyi
         G+taxChKwq/O//Z8+3VIpLOCXz/7rJQXH1HAgM84O39s+qpj+2mL5fN/G2tCZL1WkcW8
         SlBs8oFe1iNPwgH1Kvwav+peo7VsCEMOpx4f0izWnK2MrJRiCTmjNvMwTx2NkrryFoTs
         5ZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8bgeEG2Bz44kDSybFqfVjBCjDtC1nvO/OtP/5ZbYQUA=;
        b=ju/0HGOMsChi1VUzBHDuoI+p2GDRVo1W6+/ljFR+q5U0KKrgdIHTfNW/vMDL203jTa
         fAGriYMJjHUPcoXC0oKXW536U190uMsOIt3FEIGuAs1GTb1kJEIPEF2ZrAerx79Qcd8A
         ngSwZiupTVCy+UbvcFICsRCWdgFUeMcmv1vXHFeYglX6JUuuE2Q9EWzU7oBDI4cQUhVy
         gXMSmqYQW+neAbBD3f2oxHLCquc6T42i6geji/He4Swzr4QQWBNJHjt3Y62vEyWxxch/
         OmxX2Xz7vQAkZ/PygSdOziO1oKo5cfZVNh7qLBD+GQD/Mj7sOt4t1DFMR+WylOq59XUa
         cosg==
X-Gm-Message-State: AO0yUKUeFRkkfnByhsmnSykwcQANcYGSr3aV7pWPFqiuW/jzKWxqKG0a
        whFwPIhGYYqBSv/pLCbjV8OIkYLMsR8J3nY=
X-Google-Smtp-Source: AK7set8ozVR1mNvI5p0ugIyraID4rVkOAKJmAsIZT48xZIZxliIhR3CbIl1bxC8TwfFQr7aXCuqVXu/b2iqowuU=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:be1:b0:5a8:a475:918f with SMTP
 id x33-20020a056a000be100b005a8a475918fmr4385800pfu.4.1677780128144; Thu, 02
 Mar 2023 10:02:08 -0800 (PST)
Date:   Thu,  2 Mar 2023 18:02:00 +0000
In-Reply-To: <20230225180325.796624-3-alexhenrie24@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230302180200.2698729-1-calvinwan@google.com>
Subject: Re: [PATCH v5 2/3] rebase: deprecate --rebase-merges=""
From:   Calvin Wan <calvinwan@google.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        tao@klerks.biz, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        sorganov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -			; /* default mode; do nothing */
> +			warning(_("--rebase-merges with an empty string "
> +				  "argument is deprecated and will stop "
> +				  "working in a future version of Git. Use "
> +				  "--rebase-merges=no-rebase-cousins "
> +				  "instead."));

Just a small nit on the warning message. It should describe to the user
what behavior is happening here and presumably the user wanted
`--rebase-merges` with no argument. For example, "Defaulting to
--rebase-merges instead."

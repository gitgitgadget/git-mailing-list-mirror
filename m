Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EC5C001DB
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 21:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjHGVed (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 17:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjHGVec (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 17:34:32 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D8110CF
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 14:34:31 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-58411e24eefso54266757b3.1
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 14:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691444071; x=1692048871;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hzWtAMNC0L4lyzQ7FGxQNRjkEwKe44KN2zqxoVuzOO8=;
        b=qqX0vgPiMm84t5ThvP+0XcL3ZOYvc0eCo/OxU0jRX/eNMqkDJizlUtVayos/w3Po2n
         B4WjBXJSSztZXWQVLx9ik9Aw4DrOsBVyhI0/RxHu7ZDR6KXGKcrBAzVhlgrfwSwFggyC
         6B0hvgki7FhqXUs7BR4WRQuiVW6GrMpQeAiXF1+hR6V7OYdKb0DqGNKzJBHtnhXDqmH9
         cRW5m640h9bxSZlZu+A/rWKXAJyUTaCyrw0/yi6gxB3dOnfE2OSEDF+8A370brv5B7pZ
         DZ9Z+5AQgC2TwjBvt1sKjQ0ZIIXyppRLF5W/KdfBLrcwlCewmS88LKf2NU1jg8578j6C
         T1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691444071; x=1692048871;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hzWtAMNC0L4lyzQ7FGxQNRjkEwKe44KN2zqxoVuzOO8=;
        b=Eh/ajxbsXkCBa5fSAcO6NL/IiieVHhOIto8cAt4rZJomxUbXLpfhM+M0YesOTlIQED
         N4MYK9XIuBY3qvgEHVjAhZqfUAgiEKN73kSiNXY8dziA1nbqbwLPU0cn057QbSbwMdrT
         l3z3v549viJRXMVXKZpfbWG9IMfzdsmSRQ3oL9j7te4NChA1fvErFrqG7W6Cz7BrkKvJ
         mhjtXIqDT3WZ1OjBNsGZfcde3i73+ip7/bCoqYna7evnppp5JiPqTB1OJSCPo95e/IDF
         6/2HGn9EmxsF8BFr8fa4am5jxGQ69/7HAP1TWHruPZ+4ERG7nxOd8UXxRAhH/nGakQFN
         gANg==
X-Gm-Message-State: AOJu0YycXKU74+Rt4Vtqoqy+4/zZs9Xya1UiiUpHQiqL1Wlo3J2CHCP5
        2eAFl8+R6rcUF2ZiqTD1h3BsRqyfAecpL9Y6O1HOjQ==
X-Google-Smtp-Source: AGHT+IFq7JW+oeyiuswmC0CMIAKsZ11NDKMqTQZA2MgHpz5f8oh5JmCzMvySA2Y9k3dJxCkaUasvvg==
X-Received: by 2002:a0d:d549:0:b0:584:1914:d2 with SMTP id x70-20020a0dd549000000b00584191400d2mr12764528ywd.12.1691444069999;
        Mon, 07 Aug 2023 14:34:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x5-20020a0dee05000000b0057087e7691bsm2970598ywe.56.2023.08.07.14.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 14:34:29 -0700 (PDT)
Date:   Mon, 7 Aug 2023 17:34:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] branch: error message checking out a branch in use
Message-ID: <ZNFjZD4ImMz2mnrT@nand.local>
References: <7710c002-0832-d8f6-59b8-30119bd5efe6@gmail.com>
 <d217d15f-ddef-d9bf-07fa-464b4025ab3c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d217d15f-ddef-d9bf-07fa-464b4025ab3c@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 07, 2023 at 10:42:40PM +0200, Rubén Justo wrote:
> Let's update the error message we show when the user tries to check out
> a branch which is being used in another worktree, following the
> guideline reasoned in 4970bedef2 (branch: update the message to refuse
> touching a branch in-use, 2023-07-21).
>
> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---
>  branch.c                | 2 +-
>  t/t2400-worktree-add.sh | 3 ++-
>  t/t3400-rebase.sh       | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 3e4684f79f..98c199f7b7 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -838,7 +838,7 @@ void die_if_checked_out(const char *branch, int ignore_current_worktree)
>
>  		if (is_shared_symref(worktrees[i], "HEAD", branch)) {
>  			skip_prefix(branch, "refs/heads/", &branch);
> -			die(_("'%s' is already checked out at '%s'"),
> +			die(_("'%s' already used by worktree at '%s'"),

I wonder if "'%s' is already used by ..." (with the additional "is"
between the branch name and "already") would be clearer / more natural.

Thanks,
Taylor

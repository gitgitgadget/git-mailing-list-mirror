Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD7BC433DF
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 10:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED2C4206D5
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 10:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpnqfhEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgFHKRZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 06:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgFHKRY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 06:17:24 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A4BC08C5C3
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 03:17:24 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c12so16599988qkk.13
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 03:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iWn/vHkX2pyWeM/cc8ux98yX/eEUFcDBTgGnIwElw2w=;
        b=fpnqfhEsMTw7nVVPsRDGt4y7tPzx//pCpmSjqap59kmJ6m+QTmCKYmNkhk9Pc2EZ7q
         ijUxpqC6psW/02p96hWXMfdvAK7v9w43Fu6PbRLZQSWymrp348S6IrxZ946eD7W2VOQC
         rQyFHcoog8q8nXyIGtKYBCvR+PyJFuUAmOfQRYkdRYCFx1LMyDsAqbuLmFlx2pAr+tIA
         K/IyRsC6YXDL5NKkhHUmFgz4Xa8pkVNsS6ph3EqIuMOSeol7Dlk/9MdDXgfR0QjlD3z2
         icc5bzSQSc02BvOagVAqhSqERArmwm894n5SlXaZEAW86NG8WUTnqsxsu5miiklSqX/k
         u+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iWn/vHkX2pyWeM/cc8ux98yX/eEUFcDBTgGnIwElw2w=;
        b=gf4QKVCT/HVApL3tI5lMmGg7TuACS5Vwmpu5eTIDjnotIjQxQ0xrLHWDlg/pvj6sOh
         YHlVxERjZ9u836nLWnKtRJIw+T/aP6ZXs7qzKzz4WzqxegHbvDFKQs7CFWTShbJFi0A4
         Zx5YAJcjmZu4d1nWTGR7cf2MuiujaoCdujHcERoMzim5dWXm6qjBZdRou5fSziP6m2UR
         IdmIiDb+nsXYOGY+WQAlYq8/d9fRQod84Erm4rS+qGj+GfmWJeNlMeK1mkL7LCsEJ6zA
         e+bVPw0xJXEikyAk0uP6vqnELIlJMwrkW0ZwRwjtw80392lFsH88vahtVzw4kWP8Ihh7
         UCCw==
X-Gm-Message-State: AOAM533LMF1v4T6D2SMnl5BcEd/4HqHAYNuDHPYgzd8IjwovxvaYsWxB
        879+hH5M0QtKZxvtljLJb1vGh9wy
X-Google-Smtp-Source: ABdhPJyet9IERK5PRaTs37F3nS19cDPIaFlY2NYQiWNkJanWSGm0FmTgOL9XpnsfR1hUF8D8O/JJ+w==
X-Received: by 2002:a05:620a:200a:: with SMTP id c10mr20910326qka.218.1591611444010;
        Mon, 08 Jun 2020 03:17:24 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id x13sm7002030qtq.60.2020.06.08.03.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 03:17:23 -0700 (PDT)
Date:   Mon, 8 Jun 2020 06:17:20 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     John Lin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Lin <johnlinp@gmail.com>
Subject: Re: [PATCH] Recommend "git gc --prune=now" instead of "git prune"
Message-ID: <20200608101720.GA33389@generichostname>
References: <pull.652.git.1591581739031.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.652.git.1591581739031.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John,

Thanks for working on this topic.

On Mon, Jun 08, 2020 at 02:02:18AM +0000, John Lin via GitGitGadget wrote:
> Subject: [PATCH] Recommend "git gc --prune=now" instead of "git prune"

The format for subjects is generally "<area>: <description>" so perhaps
something like "git gc: recommend use of `git gc --prune=now`"?

> From: John Lin <johnlinp@gmail.com>
> 
> Signed-off-by: John Lin <johnlinp@gmail.com>

This commit is missing some justification. In the commit message, we
should mention that `git prune` is a plumbing command and in the
documentation for it, it mentions that the porcelain `git gc` command
should be used instead.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722D0C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 19:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbiKGTDX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 14:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiKGTDR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 14:03:17 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E36F1D307
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 11:03:17 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id l6so6348633ilq.3
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 11:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TJXutMK83QWOoN9ZvZucNHbiSrvoNtFlOjdujDqVvw0=;
        b=kwSVNEJACfevTcUyYPsqA6xa14juaWv/17GHaK89sldTKZ9I1KqOJTZu5heMewBoDy
         OX12grmf5Kin50EpApuTL05JsYgmQNpbQE0opwOEHYI+lyc1MSN1xv34YxG1jaOGHMnV
         L9UjW5JXF3nCn2+hu8YRsF4oqsop81szWVjYs/+nlo4Dghwg4uIXcx1B0YYpvtT4tB75
         aQ2IWv76/rpQ8ndu/Faxi4VqEJzms8XcDrUhVzbE8576vKPRVE5F+/CroD7VWjOl1gae
         /HJUU1MLL4Bx5Kjv+BJtgEG7rNRf8EzsIVdjvtrQOQFD9mHcWYThqrC6mn/t+5qm19/A
         qEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJXutMK83QWOoN9ZvZucNHbiSrvoNtFlOjdujDqVvw0=;
        b=0hEz2kn0brmxXoSwOomOwd30Yrz30vu0aoaRsji02Kqqiqawowkx7qurmv3WAZFkMG
         dsvsmRlFYR3sE028ppdNFn3crZ0xfY/HidvdadRf10CatZe8lF0J7NjjbqGRoz6DRL4i
         8btymjuuyMhcm3+O9K+/c/9uIk+ehjfiuJnP/sjJnyAlVn0suYwtIZcstcxCSdE5uyEd
         Kusm1KTbpLuS+oWDbeI6Ph2C0OrnR+GuI6zg8sF0+0H7EKzVfMKCRAPTHYkoYbRwTOta
         qBuO7IaI9YY3BIxdkxzKQiV9j1qv7V5N92F8sBYBknvPbtMRsuqel2y5/bX9hraKH7qu
         JONQ==
X-Gm-Message-State: ACrzQf3todHpIS4jRRB6b7zHnEOJFTAwrXcOoiEe8+I+guJoHWxtGqlU
        hxQezvG/2lpzuCAV0RqT+knxAGtwG9GEcjKO
X-Google-Smtp-Source: AMsMyM42XSAzd4I5F5h2jv1s88DOYBqOyD/4cHp+SS11nuvwtYtg9M4yXnEPh+DXecuyfA5CWMq2QQ==
X-Received: by 2002:a92:c142:0:b0:300:e232:e0d4 with SMTP id b2-20020a92c142000000b00300e232e0d4mr11831143ilh.73.1667847796587;
        Mon, 07 Nov 2022 11:03:16 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x14-20020a92060e000000b00300d3c0e33dsm3077514ilg.4.2022.11.07.11.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 11:03:16 -0800 (PST)
Date:   Mon, 7 Nov 2022 14:03:15 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] scalar reconfigure -a: remove stale `scalar.repo` entries
Message-ID: <Y2lWc2gmPaTfi4k5@nand.local>
References: <pull.1407.git.1667845501422.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1407.git.1667845501422.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2022 at 06:25:01PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Every once in a while, a Git for Windows installation fails because the
> attempt to reconfigure a Scalar enlistment failed because it was deleted
> manually without removing the corresponding entries in the global Git
> config.
>
> In f5f0842d0b5 (scalar: let 'unregister' handle a deleted enlistment
> directory gracefully, 2021-12-03), we already taught `scalar delete` to
> handle the case of a manually deleted enlistment gracefully. This patch
> adds the same graceful handling to `scalar reconfigure --all`.

Makes sense, thanks.

> @@ -166,6 +166,17 @@ test_expect_success 'scalar reconfigure' '
>  	test true = "$(git -C one/src config core.preloadIndex)"
>  '
>
> +test_expect_success '`reconfigure -a` removes stale config entries' '
> +	git init stale/src &&
> +	scalar register stale &&
> +	scalar list >scalar.repos &&
> +	grep stale scalar.repos &&
> +	rm -rf stale &&
> +	scalar reconfigure -a &&
> +	scalar list >scalar.repos &&
> +	! grep stale scalar.repos

Arguably this test would be slightly improved if we checked not only for
'!grep stale scalar.repos', but that the correct set of repositories
*does* appear in the list.

But presumably we have plenty of other tests which do so already, so
we're not lacking any coverage here by omitting it.

This patch looks good to me, will queue.

Thanks,
Taylor

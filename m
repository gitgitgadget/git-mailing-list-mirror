Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA247C001DE
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 21:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjHGVYz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 17:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjHGVYy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 17:24:54 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7958E76
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 14:24:41 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d299ed34bacso8603849276.1
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 14:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691443481; x=1692048281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mvFlt8Zri7PjKoElgHrx01MCkFEFjrz/8Tq0NEZKdh0=;
        b=bL7EAcfMTkQOQLPnRH+mkecsSa8BZTRgh1maL85scf6QuNvWnUuSi2g9WiYR30VNQO
         BA8eGqdTTsInBpAUIVPJwihTbgrdHYv+RHD/q35HLDlsiLCwoFSmgplYB/7/5hLEBneB
         5TerNx1Z4psvWoK+IwV+j+d9+tn+tpnQ5neFDfHvrRVLmruT4o7y2epcLu5DA46BpYCD
         SWS56E89f2XuIa1G/P9NORrE0EFJIjqT+XAzrtuOgep7vXvnlwjZ33INmLHpJ9WGCGh3
         Z6himuTnwQESmQzvMUOfE+wmrhzEjbnUiNkwLPpRgIv99yMUAQIop2W+B0aaBTNWhXDt
         nLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691443481; x=1692048281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvFlt8Zri7PjKoElgHrx01MCkFEFjrz/8Tq0NEZKdh0=;
        b=AWh9KK9ocvM5gggpE/S5Ptb+EQV74jpEEpd1kV5ejYKM/WBJkCNbQ1YrWs/mF7H2uu
         eG/7wgHJ/Cud+dt1QWIEi0GYL/Aal8YoZkNb/QYrhUDno8KicCdIfvl52jIngmN7gYPU
         Yx4NeOoliNkMqjpWx2eyUnV0DRQb5KjxjCmlaWWV9wpGojKsKiMZTAtb8GGP8Wt5DD2V
         Bz9LO95hQ7e9CErTkhIrMZmmN/MaYD+02RL4kCVYWrsCECi5L3oQ79ge104MzuC61XEd
         Fs6kYlJ3Yz1sdHT3sXGEPqAQ3CQ+6Yj5nZuyrc2YnO3gm2VPD8fQ+2jKFHRj0eQuB+Bx
         KYZQ==
X-Gm-Message-State: AOJu0YwzS88UusufVxt8iGETKCId64pqii5DLDWDj5w+6zn8QrOmZksF
        FYGFqW4sYA8LCxfZOY7k3P4wQ19MjvYkX9b9Bzh4DA==
X-Google-Smtp-Source: AGHT+IEv4lmZnJ0zNZiCvTzbuxjeGOqYtfMXtvaef/r65T4Vbf7YvCI1mFxKDDtHurlJ3rhDgE5M3w==
X-Received: by 2002:a25:d348:0:b0:d08:7d6a:2221 with SMTP id e69-20020a25d348000000b00d087d6a2221mr9870145ybf.18.1691443481166;
        Mon, 07 Aug 2023 14:24:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x6-20020a5b0806000000b00d1b86efc0ffsm2430951ybp.6.2023.08.07.14.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 14:24:40 -0700 (PDT)
Date:   Mon, 7 Aug 2023 17:24:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, lenaic@lhuard.fr,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 5/6] maintenance: swap method locations
Message-ID: <ZNFhGIXaQr5YQfLq@nand.local>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
 <37f96b6b619d2d3eecd9c2b35483b2d61083603b.1691434300.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37f96b6b619d2d3eecd9c2b35483b2d61083603b.1691434300.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 07, 2023 at 06:51:39PM +0000, Derrick Stolee via GitGitGadget wrote:
> The diff is computed smaller by showing systemd_timer_enable_unit() move
> instead of systemd_timer_write_unit_templates().
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  builtin/gc.c | 128 +++++++++++++++++++++++++--------------------------
>  1 file changed, 64 insertions(+), 64 deletions(-)

This looks like a straightforward code movement, and diffing with
`--color-moved` verifies it as such. LGTM.

Thanks,
Taylor

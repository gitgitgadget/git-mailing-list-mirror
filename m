Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341E9C41513
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 20:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbjHHUoZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbjHHUn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 16:43:59 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80755198A
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 13:19:27 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-57026f4bccaso65937997b3.2
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 13:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691525966; x=1692130766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=naWscuukDHvDjUAs3NnWNaDxPJHmmgfCJ8xW9YmkE98=;
        b=DpTNeBnH2bJRe6HOCWFlvc/FdEGZR0f77KbGrlQIRhpj4dpHN96g0rDLLhgPk2M2j8
         McLZPduFKtF0mvx5MeLwuzu1T8APvpBKdDHS+RL1Ypi+S1deoArqdfA56eRx74ZvWJvS
         GKjpwQI1X5Zk8D4vediSnLG9n+/Fe6rUO3ozGnwmLFDq4hJGNxF/EBzkN8wiPfYmzfia
         SiyzMMRaD8oVVuapVzNJhPLJILLxUXHsb/OlW5ouE4yos2xDmpBIetJyiD7K13kxlQmU
         T3fbMYz6jb6VIu08NSTTNK/jPurojfA+F+2d+1hHUHSA7mEQK1QHOETVk0AeXbPwyIij
         wdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691525966; x=1692130766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naWscuukDHvDjUAs3NnWNaDxPJHmmgfCJ8xW9YmkE98=;
        b=Vtwgwz93HnuTQNVMrObVmyYiiqDwDhZjuxzux2wmECjQUkIgFb/fbKRk7PRAlbGUuL
         Q3LKm5W9o6HaUf8TfeDmWjTXgichB+RPwIUjaeMSJxUM5DfhJF08aqqLvqk+XTQybQcc
         LM1TDekOKqclOMuU1fgB9YhrvNtL9nESynnRF62Lwjk9FUFiy1AVHh9gkLjAy/g1fFss
         hKMLn59e85jfhSHOIqW6FrFuJb/2Icb0jJ/01TOTvetJA0CH0MBdfFMPT+3VGe6WctNM
         6zGMRKjz5B1+l+PDTnqs3RGOJ2wjYjkfXAYa3leyQS9vZpXlKloNSNjuTZV9v+znSbPG
         pmxA==
X-Gm-Message-State: AOJu0YxPSRjewEDngSSToYiJveVH78fZ85Hzwwb/Ujg/N9cms0WqmSZ6
        OLRmgo3Yz9Fzpr5OXxILj1llgA==
X-Google-Smtp-Source: AGHT+IFzFcTlPphRAU74B2ZJzMlkl8j/VFw9MDpVgm0DQKpZotf0KzVodEpd1PuKiwD0cwpAcGayFw==
X-Received: by 2002:a81:8310:0:b0:577:bc0:2d55 with SMTP id t16-20020a818310000000b005770bc02d55mr811814ywf.33.1691525966732;
        Tue, 08 Aug 2023 13:19:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z206-20020a0dd7d7000000b005840861b15fsm3582490ywd.13.2023.08.08.13.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 13:19:26 -0700 (PDT)
Date:   Tue, 8 Aug 2023 16:19:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t0040: declare non-tab indentation to be okay in this
 script
Message-ID: <ZNKjTfhOUpnxrw/L@nand.local>
References: <pull.1568.git.1691491054706.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1568.git.1691491054706.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2023 at 10:37:34AM +0000, Johannes Schindelin via GitGitGadget wrote:
> ---
>     t0040: declare non-tab indentation to be okay in this script
>
>     When preparing Git for Windows v2.42.0-rc0, I ran into this issue: the
>     Pull Request's check-whitespace run failed. Let's prevent having future
>     contributors from also running into this type of issue when modifying
>     t0040.

Thanks for hardening these up. This looks obviously correct to me!

Thanks,
Taylor

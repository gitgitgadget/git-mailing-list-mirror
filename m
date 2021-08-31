Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E50C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 00:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99D2960FF2
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 00:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238492AbhHaAel (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 20:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbhHaAel (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 20:34:41 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB6DC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 17:33:47 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id a15so22542685iot.2
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 17:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6VvZuEDHswXp9sTdxqbnCYAQVZc+h+GHn3gOOLMvT5I=;
        b=OORfHOukiiJFtrXIpHF/db6/zz+diFJVagP7hWwJPS1zIBOMSFBZ6M8nEFcTYauRZn
         ku5lj5tNzpM7BwPQUO1UGjnPwg06TDB6sbfuaRNlpnOByuThjIB/xNxV2icU5xdI00Ih
         mG7OODMWEdatAcOJ7Di2aCuRlISOz6bWZLoAR2LCtR/FZsfX/ZMnq65I2TVTSJKtk6xI
         WkQ3j6HYMv43y/GDoBFc+UQtlUKKi4uKlyUQxb22hLLGEhsgPX25olkLuQeYKHA2XQ1B
         hjFcJPEUeQZouG0Jnuwmp6qoyaOqgIMbX8IWDZFBySO8MPYcX3tjetTlSjM+dwAeUJL5
         GKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6VvZuEDHswXp9sTdxqbnCYAQVZc+h+GHn3gOOLMvT5I=;
        b=m2IJTjolmcaVz1l2teOkxKE/TikUTWfgcIHJBBZsAjRvLu/gSAR9k4XT7C0+4qbP6e
         cuYRXU+PV4RssvOO/HwIG7aDJTlVAGL4DY77yvT0FJEX5uvIDtDZrYX7kcr9uusubwKM
         YcGfR1qsqoKmAi1tx9dPoSfxNST5ZJ2pvhF2oeMyVdpd9Bx68E7nUyLZaTcn/rqJ9hrU
         zLTaRpw+L7YfAc+F7cttVWao3y6Gudqog0IsHmSTVlP06K6Z4zgE9ErFkOPZb/Htj618
         3+A3blVcMscmbmCsvw44DZA0j817BReHDIU+LMKvNV6N3EyFPcP9UJnp290dU6y7ivpH
         LQgA==
X-Gm-Message-State: AOAM533NQmvrUVrciF6fTPtyD1RtiU/tfzNHShiFPCoY5zkYJQ6ellVH
        XXqQAAbtTxDne07tZaDFtNojKg==
X-Google-Smtp-Source: ABdhPJzHWdgLypuWZjtY5wrmR8iVUhIIOw4v3vvLAQ73MU6QvyOiyaanC8F/MELSakGKp4ZWeSd2bg==
X-Received: by 2002:a02:9542:: with SMTP id y60mr254636jah.87.1630370026494;
        Mon, 30 Aug 2021 17:33:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x5sm8876235ioa.35.2021.08.30.17.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 17:33:46 -0700 (PDT)
Date:   Mon, 30 Aug 2021 20:33:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 1/2] builtin/add: remove obsoleted support for legacy
 stash -p
Message-ID: <YS146dlPrxwF0dl6@nand.local>
References: <20210817064435.97625-1-carenas@gmail.com>
 <20210817064435.97625-2-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210817064435.97625-2-carenas@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 16, 2021 at 11:44:34PM -0700, Carlo Marcelo Arenas Belón wrote:
> 90a6bb98d1 (legacy stash -p: respect the add.interactive.usebuiltin
> setting, 2019-12-21) adds a hidden option and its supporting code
> to support the legacy stash script, but that was left behind when
> it was retired.
>
> mostly revert commit.

(Sorry for a much-delayed response, I'm trying to do a little bit of
inbox-cleaning ;)).

If you're re-rolling based on Dscho's suggestions later on in the
series, I'd suggest two changes to make the patch message clearer:

  - Clarify the antecedent of "it" in "it was retired". I find that
    "...but that [option] was forgotten about even when [the legacy
    stash implementation] was retired".

  - Link to the commit where we dropped support for that implementation
    (which was in 8a2cd3f512 (stash: remove the stash.useBuiltin
    setting, 2020-03-03)) to make it clear that that happened after
    90a6bb98d1.

  - Finally "mostly revert commit." should add more detail without being
    verbose. I'd write:

        Since 8a2cd3f512 removed the legacy implementation, the changes
        from 90a6bb98d1 are no longer necessary, so revert them.

> @@ -483,6 +480,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  			  builtin_add_usage, PARSE_OPT_KEEP_ARGV0);
>  	if (patch_interactive)
>  		add_interactive = 1;
> +

Stray whitespace change, but the rest of the patch looks good to me.

Thanks,
Taylor

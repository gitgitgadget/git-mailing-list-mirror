Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458E1C433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 02:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbiATCii (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 21:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiATCih (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 21:38:37 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9593C061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 18:38:35 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id x37so96092pfh.8
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 18:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2pamAdwSnlRLW5ISMcT7KBthufaL8SxjshJAlHrpvc0=;
        b=iCJ8nHx2wIUS0NSV8tmvxGZOCqz2lmUCD8ginWgVXFdOgNM0WqCxlZbAkpDtoh/xUI
         q96/nWJnv2lN5uWM7zqU7UP1xaLCxmpoYz5GiPEXjp/Mt5S16zcB/J8OebiPDlFm/3jj
         A2PwB5VRm6FG04uQxFXVEsUw9gyOcfThXfNYZ0ZBPHbexawRwcUERffbrOT8ayibNVKM
         XSURkNG1SPIAFJyGFYD6lHHMFMdI5d6buRCnPJehAbv6LBu2Ux3oP6rjhmmcX6eqy81l
         B6vZTTFfr6xbHXopWrx0X0/2jqK0YE7B80HUflV4xOd3xbC/hnnUSP913twSR0236Tph
         MjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2pamAdwSnlRLW5ISMcT7KBthufaL8SxjshJAlHrpvc0=;
        b=YUQgxUgrICr0747AMPlb7mA5V+/9sVodTl+643LBTEPiCyjurdle8iY49T/V5LFgr3
         b6SfhH3KhdSojB3KKMhIXoLElmQG5QPHodM+f5S/aa47a36TMCDLPEXP9bXgxmwSxY6W
         +XKNt3h+btfyJd6EygPYDtiW0SYt1uCJbVm+o17uWbSEivf0fMgRx4V/R1NOTGO00PXT
         kpot7dtMxdWn8fP9wu8pLlceVAYNE42D+gRLvirBuSA+DaKj+X59xTTNqFQZTkO5WDpX
         SO8jtACm/Kvrx8KwvFtOSxu3IQy1XbmBr1u6CjiwBaPI0i69Ucz5pcoY5Cg0l67nWGj/
         9HdQ==
X-Gm-Message-State: AOAM531/U2mNBh0sIduYnhcpV3GtTmwKZzXjcHzswi6RNx1lqajdEPYa
        k0672NGTMRdBxyYqQXOiiaM=
X-Google-Smtp-Source: ABdhPJw01MEZrQb2TW0ZsEH89m9u219N8DEb/3M0sn+KokNPfUEw1ZA33wEEIL5vTuj4CT9uiqQ42g==
X-Received: by 2002:a05:6a00:1342:b0:4c2:a000:bf8 with SMTP id k2-20020a056a00134200b004c2a0000bf8mr26056928pfu.41.1642646315009;
        Wed, 19 Jan 2022 18:38:35 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y128sm980343pfb.75.2022.01.19.18.38.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jan 2022 18:38:34 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Glen Choo <chooglen@google.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: RE: [PATCH v6 3/3] fetch --negotiate-only: do not update submodules
Date:   Thu, 20 Jan 2022 10:38:21 +0800
Message-Id: <20220120023821.12320-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220119000056.58503-4-chooglen@google.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 18 Jan 2022 at 16:00:56, Glen Choo wrote:

> @@ -2014,6 +2015,27 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  
>  	argc = parse_options(argc, argv, prefix,
>  			     builtin_fetch_options, builtin_fetch_usage, 0);
> +
> +	if (recurse_submodules_cli != RECURSE_SUBMODULES_DEFAULT)
> +		recurse_submodules = recurse_submodules_cli;
> +
> +	if (negotiate_only) {
> +		switch (recurse_submodules_cli) {
> +		case RECURSE_SUBMODULES_OFF:
> +		case RECURSE_SUBMODULES_DEFAULT:
> +			/*
> +			 * --negotiate-only should never recurse into
> +			 * submodules. Skip it by setting recurse_submodules to
> +			 * RECURSE_SUBMODULES_OFF.
> +			 */
> +			recurse_submodules = RECURSE_SUBMODULES_OFF;
> +			break;
> +
> +		default:
> +			die(_("--negotiate-only and --recurse-submodules cannot be used together"));

Found this new l10n message in "po/git.pot" in the next branch[1]. To be
l10n-friendly, it's better to follow the standard Jean-Noël provided in
commit 246cac8505 (i18n: turn even more messages into "cannot be used
together" ones, 2022-01-05). And rewrite the l10n messageas as:

-			die(_("--negotiate-only and --recurse-submodules cannot be used together"));
+			die(_("options '%s' and '%s' cannot be used together"),
+			    "--negotiate-only", "--recurse-submodules");

[1]: https://github.com/git-l10n/git-po/blob/pot/next/2022-01-19.diff#L23

--
Jiang Xin


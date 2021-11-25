Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2C1C433FE
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 11:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354707AbhKYLDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 06:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354697AbhKYLBH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 06:01:07 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288BDC06174A
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 02:57:16 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r11so23781091edd.9
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 02:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Yl31elET+FICkS1h+lTL/8OcCNqAeJZ34FdkjuS2uH0=;
        b=q6SBlsW3iSdQX+0qEYkISGj4wNMkF2ekwtqaIhfEbX2nk/Nm7E3GQngrGkekGDsHdX
         /3ZzNVdfi5WMdaql0uFPspUWWPD9D7fB9HwhCM28N3repTo9nHdNnCU7NcASGuNElKlF
         8eZNiM69FUw8wqAaja1RpCwq8T/00BY1dsroEIa86s/qRONXKZKV2wPbVk4KBg/x694k
         JsH7dk1y0Wv+018NM2whDanbuY5Yf/fdDK9tw+Yy29eUttlBBoYg+/9/7cQQmnF+uluz
         aTQY0N/ndveA+PZQBHsItPIUdtNbrdx3qHjTRQxjzLlmoeDhG/3JLME1c7MRT6UhCkyu
         9ZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Yl31elET+FICkS1h+lTL/8OcCNqAeJZ34FdkjuS2uH0=;
        b=Q+35pxzO2pdQ+vRQ3UWSSAZlYNL73AX71RJiathxRyi7Y51YZTDRIr9UvF4nHoccMF
         BlLjyl6eYXCmYOIEtwKRrrA/I6BVrq7062xVvP7b97Wu/Ou5KRJq8ARzGCh4aHV0gTVs
         nyUO+SNEt/7DX7sDkrwSvAFIs5BhjGFzkR09w8ipENo1hF21NSVfTixn/tvC1PYeKzqj
         0OrQiry8oxAdZ7a9pqSoNje0NpG3x5e9amod4PiSc4vIkOSHCFmPmMUdX8neAJuyngKe
         NZ+g9vNz9SCClEobGT8XoDlV1MYmNAXKc23Jg8R9OpZOpI4I/sSBHRXOhJQlOSurwqf9
         T/qw==
X-Gm-Message-State: AOAM533Q499plR3HUBAC7v9VSg9wj3HzY+yxNFXykCMc1sSQ2XLkoshx
        9PXFCAFFdi+r7lWZkiFm5TO5xSOhrt8=
X-Google-Smtp-Source: ABdhPJxi/t8KEYYL+kWun+B5WjZ7EZB4cj3ITwr3bXScUuMCsVkxLVtONiDKJJKbSpluv9WVY11lRQ==
X-Received: by 2002:a50:d710:: with SMTP id t16mr37184415edi.50.1637837834456;
        Thu, 25 Nov 2021 02:57:14 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x7sm1926006edd.28.2021.11.25.02.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 02:57:14 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mqCRF-0004hg-9g;
        Thu, 25 Nov 2021 11:57:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 3/9] unpack-trees: refuse to remove
 startup_info->original_cwd
Date:   Thu, 25 Nov 2021 11:56:18 +0100
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
 <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
 <e74975e83cc7a11b8f0378d59a8c2c4a97d3aa50.1637829556.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <e74975e83cc7a11b8f0378d59a8c2c4a97d3aa50.1637829556.git.gitgitgadget@gmail.com>
Message-ID: <211125.867dcwjyeu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 25 2021, Elijah Newren via GitGitGadget wrote:

> +	/* ERROR_CWD_IN_THE_WAY */
> +	"Refusing to remove '%s' since it is the current working directory.",
> +
>  	/* ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN */
>  	"Untracked working tree file '%s' would be overwritten by merge.",
>  
> @@ -131,6 +134,9 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
>  	msgs[ERROR_NOT_UPTODATE_DIR] =
>  		_("Updating the following directories would lose untracked files in them:\n%s");
>  
> +	msgs[ERROR_CWD_IN_THE_WAY] =
> +		_("Refusing to remove the current working directory:\n%s");
> +

We end up capitalizing the first letter here, which isn't our usual
style, but I see we do it for all of unpack_plumbing_errors already, and
some related things like the error setup.c would emit.

Still, perhaps it's better to not follow that convention for new
messages?

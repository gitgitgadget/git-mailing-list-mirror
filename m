Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22757C4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 23:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiKIXC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 18:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbiKIXCL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 18:02:11 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF34931379
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 15:01:22 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id p184so13353iof.11
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 15:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7b6jtwkThwyS6Z7w6IwYfaAmJgVXdHYRMmiqXYGSDfg=;
        b=8T96FOmNbE0pk83O4Vqh6z+dB1NxewZqlU5o8v9C62bcF2qzPPbzzQVM4gRqswpSyq
         5iGJBfvZih5zOwEjvj2jcx2SNsDsByJOPjvQ16kBss2XVz2aNbmgsduuHZmCABZxsEej
         yPiZxDfGlc/Zk1pVWMr/oiz8ClIPYF2ok1hTmaAZpQnhNxjoyfr1Qw2s7Oc3IvPXVhqC
         hgvj8VMBQdipBZWiPcmQeQqVoC86L8Tw9vzLTSty9ykkzYrjl1TNGfVtIZYW60b6OH34
         hLqIza4p5km3aGVDaPbVTyEHpGmfba8C0oLvpHWXu5d9BO6kEBDuBrE39dmMOW7YClDO
         JZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7b6jtwkThwyS6Z7w6IwYfaAmJgVXdHYRMmiqXYGSDfg=;
        b=Fgo9rlPtudyRsXJHHH+V3c8EUOU+GIBZlOn44l/FKyfrJUv4lj1HEgSnD/Nz45jFU+
         ZAAdCtvpFhziiQDIY+M5AwQxpnlFo56PtN62mqkpiZtYv13hyVmenkOn4PwRpH5SBsUd
         lbIVziJGO0ZjEbKqLnlE24TN+11/Op3YN2Dl55mL65E/K1aKJRJlJgoarl9/HVP76XHB
         TbFjaiPRnHfIERajeccL9dPLzU5zOTVC/ys8QKIncqBrEjXmy/2AvUEqRjFQhWN7TQuF
         fUvwPMxcMnfgb+aXe95rPySmzkUcvF2ihFDYS9Mz8flwuVlMhuqwBLGzFvZKtwoXWqMy
         0zgQ==
X-Gm-Message-State: ANoB5pkdPaQdYLypMHZQsyfXHt2TBa2fMXJtTxz0RbVacTLlsIjBec1M
        wAZ7qSAw3FHVgnfrrEwnGmVIruu6owsZmg==
X-Google-Smtp-Source: AA0mqf5Uxi7hV7jbsLlUHJJCYmdDGb4NFP0sgyual0WN3ujNoapobG0BOt1T1MmR/7yrdIzgCUVoRQ==
X-Received: by 2002:a02:cf89:0:b0:375:da4e:ae77 with SMTP id w9-20020a02cf89000000b00375da4eae77mr1723072jar.303.1668034882364;
        Wed, 09 Nov 2022 15:01:22 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bo8-20020a056638438800b00371a4b02effsm5264617jab.69.2022.11.09.15.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 15:01:22 -0800 (PST)
Date:   Wed, 9 Nov 2022 18:01:21 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, phillip.wood123@gmail.com,
        derrickstolee@github.com, jonathantanmy@google.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 0/5] Skip 'cache_tree_update()' when 'prime_cache_tree()'
 is called immediate after
Message-ID: <Y2wxQdOUmuUHNec1@nand.local>
References: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2022 at 10:44:20PM +0000, Victoria Dye via GitGitGadget wrote:
> Victoria Dye (5):
>   cache-tree: add perf test comparing update and prime
>   unpack-trees: add 'skip_cache_tree_update' option
>   reset: use 'skip_cache_tree_update' option
>   read-tree: use 'skip_cache_tree_update' option
>   rebase: use 'skip_cache_tree_update' option

Very cleanly done and demonstrated. I'll keep an eye out for the reroll
that you and Stolee discussed below.


Thanks,
Taylor

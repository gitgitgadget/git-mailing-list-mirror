Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32DDC38A02
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 18:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJ3Stk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 14:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJ3Sth (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 14:49:37 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B62A1B1
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 11:49:33 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id n191so8312102iod.13
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 11:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=49GsekmZkQK8zTz0vUddYqmPYZ0kMxddBYp5Lu3m64A=;
        b=cNzdAvwe4cBds1BWhGktlKB5R20H58iHbl8ldCujCG/GzpAiivNs3m57arDfuxdJm7
         mJucNFgtX3jqvP39AX3Fr9WyVc/EJZZjq/2vmNFKhYcPJXZZWBBoBVRRWy6jmL0cIPPF
         BG/OHWPXn+ocRgjr6BdRrEqp8JhpCBBk+FjeHzKtrXA+Zi9rSavDyMytn7ghMax4sjjW
         NfOt331mAafCcZS1FctLSUD/9gdx/vB6wF83wf7pzQNi+URvCJYjMPO6uIckzxDjagce
         MzI3TkWhTmLEwRYnBSAZVsHqlBV1bgo70lqbMI2jTom9zy2AdLGT7kpr4xiYO7f6CxBm
         Elew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49GsekmZkQK8zTz0vUddYqmPYZ0kMxddBYp5Lu3m64A=;
        b=YJ0ULtuZG+MdFkmNmeuYXRFlUZsZNMUM4M02kKV5plLbba29Le54OG1IVE3z8eBlpc
         gSqvU+HVPfOridsqiNJkuaGHdy28VMxOOCAwa8+HbE8wWH/3LZxdc+XE+CuL+Lz6xzlr
         9KKuV/Jw7Biuz7dHg0Db7Mc+1tcOZUCeWersrbYnBjJw568c6VFLbeiCNlNwPm3hMFjq
         6HFlKedq1NRCDgWOW1wiRjOS6OLCUM93n12R732osaBkSBZci425ITfpgN595ouzLF0T
         88mE4xB07oUGAFbQCOGN71qS1L9ENNzJbKUgNK/LaxtJ4T8K7whNzcMntOxZPq6TR4X+
         G3tA==
X-Gm-Message-State: ACrzQf0YO29YRqd87SUcKhbFQ88c6cAOX2J6rmJP0Ajh20OvXTFDK/J3
        EVmkmoww1/X0hJslQV6b505Oo7McOYKyMVO1
X-Google-Smtp-Source: AMsMyM4ZEza43waeE+EWwRU9R8BOFeFJkqOkJHqxqUW7rjdY0jCoy/nzSiZZ6aEpS/+BSPfc2+mrRQ==
X-Received: by 2002:a05:6602:2ac4:b0:6bc:e67d:b429 with SMTP id m4-20020a0566022ac400b006bce67db429mr4808409iov.121.1667155772998;
        Sun, 30 Oct 2022 11:49:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s3-20020a92ae03000000b002f16e7021f6sm1751384ilh.22.2022.10.30.11.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 11:49:32 -0700 (PDT)
Date:   Sun, 30 Oct 2022 14:49:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] connected: allow supplying different view of
 reachable objects
Message-ID: <Y17HO9c9fJweCrPt@nand.local>
References: <cover.1666967670.git.ps@pks.im>
 <a32e3d6146dd41af36f525a744d6cc099b42d6fb.1666967670.git.ps@pks.im>
 <xmqqr0yrizqm.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr0yrizqm.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2022 at 11:12:33AM -0700, Junio C Hamano wrote:
> In the original code without the reachable_oids_fn, we refrain from
> excluding when the is_deepening_fetch bit is set, but here we do not
> pay attention to the bit at all.  Is that sensible, and if so why?

I was wondering the same thing. Thanks for asking.

Thanks,
Taylor

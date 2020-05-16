Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41569C433DF
	for <git@archiver.kernel.org>; Sat, 16 May 2020 10:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B73A20727
	for <git@archiver.kernel.org>; Sat, 16 May 2020 10:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQu/IGIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgEPKze (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 06:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726044AbgEPKzd (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 06:55:33 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC18C061A0C
        for <git@vger.kernel.org>; Sat, 16 May 2020 03:55:33 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id z5so2400550qvw.4
        for <git@vger.kernel.org>; Sat, 16 May 2020 03:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GtiOQxhfkZIT75035APsZyd3HvTUM/l0soKeu/tcfoU=;
        b=fQu/IGIlMu+2A/6DXg50BKH/KD8WGaGpFhzzb9kCD/ZjNeOOUQvVN8CSWGpJDLP1YO
         QAzvL7UeXDVBzNXKYYzMRAk8cwSHYjWJSnW0fI+Jl4SHzySd48wEq8xKF6qMn1gn1DPj
         KzWIyfLXONO5CfFLAE9ndU7fxqN7A7aBIofCg4MyRVKHDM2G/TFYghJhxb7ChnQzyPlV
         Wbw+KHuFOFdtPpU5f6eJ18wdYYyE7Y5t/vKEZnL03ptURSs3oE2TbSHO1UeeXvNTJxg/
         i+rBB/0plXBRj4Op72YeqexmYNrFq/iSdWwvCgpHJIjkh8abFWpVyeS0SGIVmadOabKV
         DOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GtiOQxhfkZIT75035APsZyd3HvTUM/l0soKeu/tcfoU=;
        b=N3rEUy+X8/zZtm/F98GuiXS6tAlQqM5fDHWHZT2RKc+KsET6C5HpDnhfGCnAV+jKOD
         7LbGpDYW0KaZK0NpSZU/U93crk+ndlDsuzH6+8LOPOAlRK167z4huEIDtA5BX+V6Rds8
         9rdR6foDF5lK37lqTWb3wR7mpE9o4qzdo0B0lc+7ViKHoCHiAxgzidYm4EojTnVdaM+7
         OAFK74zB9TwvudEPzC7iUDhS69SWMiG/ycsAx8dhVFYZ8KaR6OH+K1bcX+JhuVG9GFRg
         0deiBM3WekbAbjOqJLnPRaL804zIYoOejYBo68oCAljSrG5CI5i6tPiIdmlyNpQSA1Am
         md2g==
X-Gm-Message-State: AOAM532LYwdpjBUMCT5U450huj77Z2yqkL3eZucCZtD3SLDOHUXn3szE
        lGphugi6h4eqUU6RB33ajFQ=
X-Google-Smtp-Source: ABdhPJzz3Ev8Cj+w5Eqks7h7iDvJK3rfviU6pxsQW3fCNnY2u3dgVnPcAHa7KU+pkx0c15wrO6AJhw==
X-Received: by 2002:a0c:fb4b:: with SMTP id b11mr1339315qvq.96.1589626532566;
        Sat, 16 May 2020 03:55:32 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id b198sm3670395qkg.37.2020.05.16.03.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 03:55:31 -0700 (PDT)
Date:   Sat, 16 May 2020 06:55:28 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, gitster@pobox.com
Subject: Re: [PATCH 1/2] submodule: port subcommand 'set-branch' from shell
 to C
Message-ID: <20200516105528.GA22601@generichostname>
References: <20200513201737.55778-1-shouryashukla.oo@gmail.com>
 <20200514101013.GA28018@generichostname>
 <20200516103744.GA25211@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516103744.GA25211@konoha>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 16, 2020 at 04:07:44PM +0530, Shourya Shukla wrote:
> On 14/05 06:10, Denton Liu wrote:
> > Error messages in Git are generally written without capitalising the
> > first letter of the sentence.
> 
> Corrected. BTW, many other subcommands have this problem (the error
> messages as well as the options start with a caps and end with a
> fullstop). Should they be corrected or let them be as is?

If it's already written, it's probably fine to leave it as is. Although
if you're working in an area with some messages that could be fixed, it
might be good to clean them up as a preparatory patch.

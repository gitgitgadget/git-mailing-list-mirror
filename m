Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEF4C11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 06:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 774BE61CCA
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 06:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhF3GKO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 02:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhF3GKO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 02:10:14 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91524C061766
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 23:07:44 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id b2so2196263ejg.8
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 23:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=WXMPEYFyuvlarASOVGo3n8hSoqUfSG9E7yDsXLCG3Ds=;
        b=GJbwZUjUIDR1+muhn80aSlS/pFL/UFD2+53tWhQDn7it0LlPgL83I8RB8qryZVXlo5
         xw2eMmrj0XaBoqr2/JY+thJisCQobrE8x0Ju5Y006owIbiNFao/hdVflcyE7X/KZQgrX
         fY4Z7p1ZlcA6glNWmdmKRCR7PMfzsVMR/KfNmWzO09ZX1WpbVHP+GvZQWDIbeHbMxmmH
         Vu+uikYohLFxiHcoWf/ko2JRB+O6EAZv3Rs6IM7dpS8O+a7mJMR3kW1Fq6oUP01j7u4V
         jt/bst1YoHpOtaSbc1Ncj7aNTXBCsydf3WX2Yws9eEZP0Ddlac4fqLbWZSFcbj9IxM/X
         QhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=WXMPEYFyuvlarASOVGo3n8hSoqUfSG9E7yDsXLCG3Ds=;
        b=PSWRt5rLnUWbSdgaY0aAIHYxAGcdV0QWD2buC+k0Pnr2RuzRBVcS/NY0lRqGRzPt8h
         cHrlN6RN5m8B5mkuSknNFvmAgGYT3q3jn87CM8KoatuoTZxKRI5I9ZMG6xBb83nqKGZ+
         VB7Ouok+QLif6tZkm5B3XZrMxVCxTGRTDIiCN7cjRjIa81Jx//gScx1Bc5dnl0rlPdej
         ylB4yw9sJwOjHq5lJcmMUbZlXrWdrOLwCgG4YcQ0Hryz7lBllqvvQtdUWVphKyU8tKIg
         dmrTdK4T7b+3wDoMwhudfvKt0HweSIQwXg/GV+zT64HCEc0G+Kt2aK8qYDhDyMGQuLcn
         2z3Q==
X-Gm-Message-State: AOAM533W3LXBFlZ2Nejv97E5vMEBBFGubUIqVbs6mm2K1eYu+/hzAqyc
        gED03D9bwVoOxzhaBBqgBQ+rNpaw5H04Rg==
X-Google-Smtp-Source: ABdhPJxa1WxxwgiPYIMEgttaR/zJAtqTSu7GEjZ0fBlwfi7gPvDe1cYRmb/3uuvlOKl5wCvMZ0zPCw==
X-Received: by 2002:a17:906:a203:: with SMTP id r3mr33957000ejy.361.1625033262590;
        Tue, 29 Jun 2021 23:07:42 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p18sm11132106edu.8.2021.06.29.23.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 23:07:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] map_loose_object_1: attempt to handle ENOMEM from mmap
Date:   Wed, 30 Jun 2021 08:06:21 +0200
References: <20210629081108.28657-1-e@80x24.org>
 <20210629081108.28657-3-e@80x24.org>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210629081108.28657-3-e@80x24.org>
Message-ID: <87czs3ga1f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 29 2021, Eric Wong wrote:

> This benefits unprivileged users who lack permissions to raise
> the `sys.vm.max_map_count' sysctl and/or RLIMIT_DATA resource
> limit.
>
> Multi-threaded callers to map_loose_object_1 (e.g. "git grep")
> appear to guard against thread-safety problems.  Other
> multi-core aware pieces of code (e.g. parallel-checkout) uses
> child processes

s/uses/use/ & missing full-stop.

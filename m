Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EA8C47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 07:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1FDC20721
	for <git@archiver.kernel.org>; Tue,  5 May 2020 07:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKZB+DZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgEEHSi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 03:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgEEHSh (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 03:18:37 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7D5C061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 00:18:37 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d184so463092pfd.4
        for <git@vger.kernel.org>; Tue, 05 May 2020 00:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PQuJUXu3EwhXZIQM/P3Ob2Rp/7hi3zHd8bTBppgXPYM=;
        b=UKZB+DZ7D1nUNzsVDp949sJVEGHlpU+91PSPstSj+T46MOwanfEID5/xD8v+oFSDhD
         xbsLN67KvpWDIDRrXqPJI67Soo0F8ToBronyAawZd7c5YsJTaHwOZY3IGJIMTEcUAVcm
         J5zKYyMENEppoEWhxrs5W6VGn1UVHSHBB13WYIIFZP0iNTSlDxjzlBWAlOGPzUff7lhZ
         fr68GbQDjg+6fKxjZ9iG0dk+vNXRUdDkRzInk3sUp/82pMiQNbpkJBVkDJkrh1apgpMF
         R68OYl7Ja5hxq9YgFwp62iYcajwSJXhvAJu1m1FRwh4p/A6Z1gKypFKKqjzFjtX2QHzL
         jDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PQuJUXu3EwhXZIQM/P3Ob2Rp/7hi3zHd8bTBppgXPYM=;
        b=U90O/nts++b8I/mteIiaVffYCJdhBWW++ZPT8+Mzdwwj+/rw23RrLOV9FqTciJQT0x
         APKWl2w4ZEntGszKkSwPTkE27+aVHSnzLO7v7fH1jUvVEQwJrOBKpEjS6yDs1OlKqhGW
         AvV10ujknQ5FsjkeNb+ajeheWq7Tp1sODbQhgRBbBi96WUibD0ySkawmVytTOqlIwy6C
         /QxDqpO0/7B7gaRcLC0FCw43BFrW13PP54ULibX2JRZ21IoMPmmnyuudeHNvHSjBXYGb
         ARxh3kfGhZFKWjzIip/rfQdnzCs/XqWKpKuFLW36pHbFVZDdZFXGU2NFNvMKBDEmwT+t
         3euQ==
X-Gm-Message-State: AGi0PubQDIMW66rN3e2FRlj7gLpHzIotLRQoI7XSOwsCqBkz0+2eOmgw
        iPx+5QfDKjw+XD8EMVffEzBy8jPY
X-Google-Smtp-Source: APiQypI4Y+g1AmImxuDlzYtx2og5TgV98Zkdaqfc9zpxjI55fJ8Ta1EAf2Qg8waQjlUYkuPmQukcBg==
X-Received: by 2002:a63:794d:: with SMTP id u74mr1856236pgc.15.1588663116579;
        Tue, 05 May 2020 00:18:36 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id 128sm1127080pfy.5.2020.05.05.00.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 00:18:36 -0700 (PDT)
Date:   Tue, 5 May 2020 00:18:34 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net
Subject: Re: [PATCH] builtin/receive-pack: avoid generic function name hmac
Message-ID: <20200505071834.GB1218@Carlos-MBP>
References: <20200505054630.5821-1-carenas@gmail.com>
 <xmqqsggec2g1.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqsggec2g1.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 11:37:18PM -0700, Junio C Hamano wrote:
> Carlo Marcelo Arenas Belón  <carenas@gmail.com> writes:
> > While the conflict, posses the question of why are we even implementing our
> > own RFC 2104 complaint HMAC while alternatives are readily available, the
> > simplest solution is to make sure the name is not as generic so it would
> > conflict with an equivalent one from the system (or linked libraries); so
> > rename it again to hmac_hash to reflect it will use the git's defined hash
> > function.
> 
> I do not mind renaming ours, as it is harder to get the <stdlib.h>
> fixed on the NetBSD, but I would phrase s/equivalent/unrelated/ (or
> even "irrelevant"), as it is clearly not an "alternative" that is
> readily available outside NetBSD.  Otherwise we would have found
> this a lot sooner (it used to be called hmac_sha1() and renamed to
> hmac() in August last year).

fair enough, would probably better drop this paragraph; but I wasn't
referring to hmac() in NetBSD, but the fact that we are linking against
OpenSSL (or their equivalent in macOS and Windows) that provide HMAC,
and even using it (but with MD5) already for git-imap-send.

the SHA256 feature will even bring (alternatively) libgcrypt to the mix
so it seemed strange that we didn't abstract this hmac function as part
of that interface instead since we seemed to have plenty of alternatives
to chose from and would had make IMHO more sense as a fallback inside
there.

Carlo

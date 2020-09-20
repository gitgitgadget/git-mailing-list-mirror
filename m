Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56482C43466
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 11:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 159B2216C4
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 11:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHyj2uN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgITLBw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 07:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgITLBw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 07:01:52 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74881C061755
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 04:01:52 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d6so6508564pfn.9
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 04:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nRmDuEhrbezGIQh8KmtfiWMRJZUnj3R2AhC26VaReT8=;
        b=jHyj2uN95AdlFt5M16tQvp39TjqxDmRJ1XDn8WaiQEuOdP9KWbf7xqpDriM/wsKK4J
         bIvaCjOeinJTXzgkv1BcddK/VX4D5p7oigZ5KAZABvFTeU+s/xxQJ1szADO4cVpqtzCa
         PgFJ63VIieHxt9+aGaF9TzFI/HlKILnF5pyDHnprDxAky2B5jsNVSOlF9OO/MsN4csYB
         5CiCdQ762vCr5VWxYb/wOQDsJNPdT99WG3TZ7qlMkoHlw6bkzHrf4Sx+ZZCwIHCaYNbP
         zQd5cr5o0JRlKG6rzotDwvLMv2n0w+rqCPJfR+JL4jmfAXb3fVXzzXKcBLF6VEAPOqhr
         ASfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nRmDuEhrbezGIQh8KmtfiWMRJZUnj3R2AhC26VaReT8=;
        b=nPqXzybR21LRf0wAam1M2WnzrFU2B0PKRuBpbVF4rwynXIRMpSEhsT3DA6ET2/GghQ
         xf/9FCmYf+6dKWf++majeqYVLPAOLjHnES5wZ9JwP114uAC2FJFYc0U++jokUADGOQhE
         WuCcWnBK7Q/B53P99ve9eymtxGull1kUiIu9JEy4SLGJkx2A+o+K1luDSuKslieeUNAh
         qrtqbk/+ZOhXFP8LxqBPfh8qA51ZyDYR+9j6TcjvoniHIrnSznI37ZBytAHGuKtMR7qW
         FlWRXivuCsQIjxubQZMNu16BIjqRyy7grk/aar5Hx+sTxwPYR4qu725tgBWhlwmZclKP
         EPaA==
X-Gm-Message-State: AOAM530yMi7zjuV0gT0lcUwy5QsNI0a2B+nvlLa6FBesW6fq7nFEeBWX
        TovAo6XaF2onKXQw9b/TKZkFhUSdQHQ=
X-Google-Smtp-Source: ABdhPJy1U6n8mlcGnB1HXaQdI4fvg++dMIQX0cgSCfeUSsJSV5gLQFTNEbV+uK3tHOGb9pmhYfxMWw==
X-Received: by 2002:a65:6685:: with SMTP id b5mr11960948pgw.385.1600599711861;
        Sun, 20 Sep 2020 04:01:51 -0700 (PDT)
Received: from generichostname ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id f18sm9872912pfe.153.2020.09.20.04.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 04:01:50 -0700 (PDT)
Date:   Sun, 20 Sep 2020 04:01:48 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 09/10] builtin/diff-tree: learn --merge-base
Message-ID: <20200920110148.GA227771@generichostname>
References: <cover.1599723087.git.liu.denton@gmail.com>
 <cover.1600328335.git.liu.denton@gmail.com>
 <c0d27b125e969e13c52b0fa806a8e3caa8c20ac6.1600328336.git.liu.denton@gmail.com>
 <xmqq363gs1mt.fsf@gitster.c.googlers.com>
 <20200918104833.GB1874074@generichostname>
 <xmqqy2l7m3hk.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy2l7m3hk.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, Sep 18, 2020 at 09:52:39AM -0700, Junio C Hamano wrote:
> I wonder if turning the builtin/diff-tree.c to match that structure
> make the result easier to understand (and I'll be perfectly happy if
> the answer to this question turns out to be "no, the result of the
> posted patch is the easiest to follow").

git diff-tree does not even recognise ranges so as a result, the else
case does not even need to exist there, unlike in git diff.

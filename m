Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E529BC433DB
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5BD664FC6
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbhCJTjR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbhCJTjK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:39:10 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB31C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:39:10 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id c16so9015730ply.0
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PAPmTi+C6RokibWNDFDkszel3ecZt28NddBTMaXlq94=;
        b=tlhQcTMln68+MzKJLDAH+L9DbPKEJIZ7yYx0SPfYCUvNgepWNAxuVUK6URCZNwGpO/
         cwgSn5DGVKHt4i5kZRe+fz7q5crXmB8PWxLQCscn7eAq3E6y1rBxYbcuNxcY9kk8LkNE
         1qfSjMEMoSZm7KWpTvzC7CCS6U3m+9i8CPJ+i13i+Uud1j+NPyFsnZiiCT2sYqLwM/iR
         +A4XdARx21dJDllQLFcXfPKO8Qh7hNRONbrLDdPePMCqkzedPJdVwNuj/RB0yHVuDPPi
         3tRzyF1SH52iy6tSA3Myo8MKfOCgmYMj/1Sy1dDu1HvufP1fAGNF4W9sDNzBu6m1Y0cA
         n3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PAPmTi+C6RokibWNDFDkszel3ecZt28NddBTMaXlq94=;
        b=Zv0EcYuj9ZAsbje1a68QKBu2MZwRsPk7rhLQRsfQZq3I+4UwIk7uOHpmJBB0ooHlNW
         3ajZgCMpZEEPEpeGNcRHqygFpfGMAKasJLSNtPxmvOvur6/TNKYtCH63OK9066KArIgG
         MmahHnpyv5lJBJljRTnYgH7Sv/AeakpudvNTzQhJkfG96Xaryilr0HM74izDQaUaKlNp
         s0ulCzbHEBNDm7MRLm576jwaS77varfyfJY7qwHVMdtV9SZoHcq23nMgzNXHRunxOM50
         w8WGu4eC0FbcF/Nbayekub4U5DprtujpvboH/WUBBJoxjv+7VF8N4h6QS4dDjGjEoxPY
         x/Vw==
X-Gm-Message-State: AOAM531Xm6WEYJvAvxLs/hBKvDBB1/v/miOn+AouLLl9+Hqly6siZDHx
        GyCQGkgxQ6bdT8m6tWk8Vfic5aYhTY7WcA==
X-Google-Smtp-Source: ABdhPJxLdkfSCHVyIDrjuxHNR/eUPBE9m+SYjZbknxuvQ73w2lSWuxf5TXtUJ+bMJuqrXyhMWh/q5Q==
X-Received: by 2002:a17:902:b210:b029:e6:33b4:cd9e with SMTP id t16-20020a170902b210b02900e633b4cd9emr4192168plr.67.1615405149553;
        Wed, 10 Mar 2021 11:39:09 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
        by smtp.gmail.com with ESMTPSA id b3sm290216pgd.48.2021.03.10.11.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:39:08 -0800 (PST)
Date:   Wed, 10 Mar 2021 11:39:04 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 01/17] commit: use config-based hooks
Message-ID: <YEkgWDthF7sObtAt@google.com>
References: <20201222000435.1529768-1-emilyshaffer@google.com>
 <20201222000435.1529768-2-emilyshaffer@google.com>
 <xmqqwnvrie8k.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwnvrie8k.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 01, 2021 at 03:02:03PM -0800, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > @@ -175,6 +183,8 @@ invoked after a commit is made.
> >  This hook is meant primarily for notification, and cannot affect
> >  the outcome of `git commit`.
> >  
> > +Hooks executed during 'post-commit' will run in parallel by default.
> 
> The "by default" makes it sound as if there is a way to force
> 'post-commit' alone serially, but other than hook.jobs that can be
> used to uniformly make everything run serially, I didn't find a way
> to do so.

Yeah, hook.jobs is the way to make it run serially, and as you say, it
can't be applied everywhere. I'll try to change the language.

> 
> The comment applies to all the "by default" in this latter half of
> the series.
> 
> Thanks.

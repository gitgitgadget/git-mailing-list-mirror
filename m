Return-Path: <SRS0=WTnS=CW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED462C433E2
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 10:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9E012158C
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 10:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVAuhpYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgIMKrJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Sep 2020 06:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgIMKrH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Sep 2020 06:47:07 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A77C061573
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 03:47:07 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id o16so3979038pjr.2
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 03:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0Y8ojwmiXK+Qr/qTSLTmod46QKw0om9dPdwr4Jn4tKI=;
        b=KVAuhpYNf5OtOre8gT5TYuwU0mhxZh+0J9JKf3J8HeBuKooPgdOy56rs/9cVhd5Gja
         gGVNSQLh1QKjJvZzU+fFun2u7ZRnIt5b6Gr/5Us/ghOXQuDqYJIgrMcI5X/7vVguNJ6h
         E9i5vF94xa2hRU6EuXmFhzFf1yPyxnNpXL7fhqtiCJlKPhV4uuvFhaSV23IujrYxBPOY
         wZpsIWgzaswiCB3e0GcLdPDvVujCNWuG6oCssEfp6KXbPpeulonCCpF3llyDOnvzh9Fe
         M1I7rniR1wk9atgk1yZJet3VH29rGfAFjYqtLyxLfy1gaVPF4ey4g63QJonWqFve5eY5
         i44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Y8ojwmiXK+Qr/qTSLTmod46QKw0om9dPdwr4Jn4tKI=;
        b=IvqiZNgxTUDDuskQSUm6zRSQF67GLO5/AqCkTj44crRMjNk6oeKLaxa8OP8snV+oLo
         j+Q5raQPD9EjvNIaQSMuHIGegYj7sCDcCzyqoXrW8pGGgrKEkP437ks7JziZ+4iW0pvv
         IRt1Dz6N3woM5bUecsPzEiD4PpmKD+JvVWTYg/YhNP4E5N7GjQdLsII3YYy1kXWPzXLD
         +3w8NMZW4K8dc3YFszNf8g0744s+gfeF7foIgQ86lK7xywwJqSP5y2RanM4N2QepfoWC
         Uml5hJBBEvlsybnAw5g3I0PVZGvFMy6KQMbVSGKqsaJ1g7ESMBzILQ60oazbz7fd4NnG
         wsSA==
X-Gm-Message-State: AOAM533DaInM8U1/2a7QzRpytJmZcprbbr4mdTV2xRuS1dGP4gtxnR1E
        bMh1i5FUr6dmj/1OcLRfUvs=
X-Google-Smtp-Source: ABdhPJz/ZVTaXHSr6oipYI64pOYmS++/aJ3sWz9WeAB07dmqCX3q1NGjs3b7naU3YIiTOd5Th5LbHQ==
X-Received: by 2002:a17:90a:f682:: with SMTP id cl2mr9892516pjb.158.1599994025963;
        Sun, 13 Sep 2020 03:47:05 -0700 (PDT)
Received: from localhost ([2402:800:63a8:edfa:1ca8:8e9c:e6de:6bb2])
        by smtp.gmail.com with ESMTPSA id e123sm7335105pfh.167.2020.09.13.03.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 03:47:05 -0700 (PDT)
Date:   Sun, 13 Sep 2020 17:47:03 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] ls-files: respect 'submodule.recurse' config
Message-ID: <20200913104703.GA2034@danh.dev>
References: <pull.732.git.1599707259907.gitgitgadget@gmail.com>
 <xmqqv9gms1fp.fsf@gitster.c.googlers.com>
 <45EB4E9E-1819-41D6-839E-A3812456478C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45EB4E9E-1819-41D6-839E-A3812456478C@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-09-11 09:05:42-0400, Philippe Blain <levraiphilippeblain@gmail.com> wrote:
> I understand, but I would argue that such a user could easily adapt their
> script to add '--no-recurse-submodules' to their ls-files invocation if that 
> is the case, no ?

There're people still live in the past, for example those poor souls
still live in Ubuntu 16.04 LTS, they don't have the luxury of using
Git with ls-files that understand --recurse-submodules and
--no-recurse-submodules.

> > So, no.  I am not enthused to see this change.
> 
> OK, if I'm not able to change your mind, what would you think of a separate
> config variable then, say `ls-files.recurseSubmodules` ? This would be more granular,
> so less chance of breaking existing scripts, but still provide for a way to configure 
> Git to always recurse in submodules, including for 'ls-files'...

If you're really buy into configuration and using ls-files
interactively, I think it's better to make a Git-alias instead.

	alias.ls = ls-files --recurse-submodules

-- 
Danh

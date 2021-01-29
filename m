Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0408C433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 20:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B57964E00
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 20:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbhA2UDT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 15:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbhA2UCk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 15:02:40 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49549C061574
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 12:02:00 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id l27so9944712qki.9
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 12:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kTFxBvQ3+I+lJCEyxhewErp5d+YcCqg8t7cN2E8R/J0=;
        b=idSuowBUlO7ID4A/i8GxTjeNsRsDFpN4LJw2qXf6nqVel/v38ECBd+P8c/AuVfwsHf
         FlT7cFNdAUn0zWzorIZthp3jhorXMcxvnB1Op5JQK67IECQmE51PjTarqkJ9whFKERPe
         eUgUVlP8gkzyqunyPeGO96A+bzrTMc05nebCeotHsIwmKJKkyXSeWFRTjaXsZ4RYHmHh
         ekbx+LqWWscvaCKZQbLUXpWTTlGaiLrQOXLo7oHfHspkV1qeNY1oT9As0dZk0O87h2jY
         gDutELHEICTsWqY8TtVYKOqjdLcQFTJ+ff+BOzzJKKDIqzeL34lQikJ4OT3FWyEsy+nx
         st0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kTFxBvQ3+I+lJCEyxhewErp5d+YcCqg8t7cN2E8R/J0=;
        b=sWoYiquoXSOhKllq65nWt6vaYukx0ScoOHOb8T9WfaLIVCQIcjqDawEQqyggKgtVFt
         Sj0jfaI2W4WuxsMMFAGCNLPgF7clqvjFWzc6IkiftOfr/Z7Z09v9qVYfM+60EVvJZ/NR
         Z3Hy7ug8DtThnOOVGg/sNitqTb2iSTCEQFtycOzkesKXraoWFKAYr6YA9mQxPdSuCkuc
         +mlfQZTgpT2YpKTMiSELtNu1DoLp1vMcgKVDqiHyZGcDBMl4eXg7xOPzh2UDwWlyGAvW
         ytlIhDtNDqCg0Z7ZNqy5SUhxlZi7539XREsDaG4WxJtBW+ffgCWDcah+tpih3T0gP4wY
         TjVA==
X-Gm-Message-State: AOAM5304leEwxsHQGKokud1g+0ZwVGLAo7IpVu+yZBQ25TMGXd61yn0C
        Bxa5vLVu7+mFITx9FlM4IXTasg==
X-Google-Smtp-Source: ABdhPJxiL+R6cvwNXPB1RcDQiAQnGwndMJ5r4RinMnvcQ/8Mc/RDWhMY1+lNPC8q49/rsH4nB8MZ2Q==
X-Received: by 2002:a37:9ac5:: with SMTP id c188mr5577228qke.422.1611950519546;
        Fri, 29 Jan 2021 12:01:59 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f05a:e493:9aaa:4c8c])
        by smtp.gmail.com with ESMTPSA id k187sm6951938qkc.74.2021.01.29.12.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 12:01:58 -0800 (PST)
Date:   Fri, 29 Jan 2021 15:01:48 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH 03/10] builtin/pack-objects.c: learn
 '--assume-kept-packs-closed'
Message-ID: <YBRprCmIX4IrHAi0@nand.local>
References: <cover.1611098616.git.me@ttaylorr.com>
 <2da42e9ca26c9ef914b8b044047d505f00a27e20.1611098616.git.me@ttaylorr.com>
 <xmqqk0rwtom2.fsf@gitster.c.googlers.com>
 <YBRfvZh86Z8wAnxZ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBRfvZh86Z8wAnxZ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 29, 2021 at 02:19:25PM -0500, Jeff King wrote:
> The overall goal here is being able to roll up loose objects and smaller
> packs without having to pay the cost of a full reachability traversal
> (which can take several minutes on large repositories). Another
> very-different direction there is to just enumerate those objects
> without respect to reachability, stick them in a pack, and then delete
> the originals. That does imply something like "repack -k", though, and
> interacts weirdly with letting unreachable objects age out via their
> mtimes (we'd constantly suck them back into fresh packs).

As I mentioned in an earlier response to Junio, this was the original
approach that I took when implementing this, but ultimately decided
against it because it means that we'll never let unreachable objects age
out (as you note).

I wonder if we need our assumption that the union of kept packs is
closed under reachability to be specified as an option. If the option is
passed, then we stop the traversal as soon as we hit an object in the
frozen packs. If not passed, then we do a full traversal but pass
--honor-pack-keep to drop out objects in the frozen packs after the
fact.

Thoughts?

> I think it would want to be "the set of all .keep packs is closed". In a
> "roll all into one" scenario like above, there is only one .keep pack.
> But in a geometric progression, that single pack which constitutes your
> base set could be multiple packs (the last whole "git repack -ad", but
> then a sequence of roll-ups that came on top of it).

I don't think having a roll-up strategy of "all-except-one" simplifies
things. Or, if it does, then I don't understand it. Isn't this the exact
same thing as a geometric repack which decides to keep only one pack?

ISTM that you would be susceptible to the same problems in this case,
too.


Thanks,
Taylor

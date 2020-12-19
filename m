Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00620C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 00:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B99BB23BA7
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 00:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgLSAyh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 19:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgLSAyh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 19:54:37 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53206C0617B0
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 16:53:57 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id f132so4796651oib.12
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 16:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=XkCFfVY1OJq1NIWn1DIbgy1jo+V8ZrdY4C2KA4ZGACc=;
        b=So6iWdi2A1ZEDsObtvNngPlGb106YyhXfl0IaZiptKiB87PHDut6GWu1TqY5eSXs1n
         tjDnTrJz2/TJSMOENprrBlkWnuDQLu8XZoH+akluZX6i4cPvFnefB2szzPk2XOfltStB
         7G7ri2mmhus0JoqEnzuTVBT/u3La3YgCdqQ3eFTHtDgQQPx3PJR2F0oT+98fsUKzbj7G
         m9fsdRoCBWeOWAEJUTMS1D95EjaM0e2UmvmlAGssWKQ/JfQD8On9FcEOBFHb2zfGbMwx
         U+d1l+RdrjTzDQhI8FA+1Jk3grRyTIZE0mMagSkR9QxL2IW9whGNMnQ7+z9818cVH2Yy
         gAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=XkCFfVY1OJq1NIWn1DIbgy1jo+V8ZrdY4C2KA4ZGACc=;
        b=kqcJicMxdURuwSwpsiIrE1oV2zRdfz1HvWRRWILvfEC+BqAMgOtZeS94FRGjaPsee5
         SIt+ujPD9NJA2yr2U3w7UuEynY+oebTj6+Ah5lhdrMlKLYnt82anGmlNxYyoCu8uGIen
         eLUTGu/FDXJMOLxuzZSU5WR8ubvfxOBW1PV14LHlDAkLPQmfOi+3xqqAUIGgmkSSVh8C
         scM3TDpykNQ2rGkmC63b5MEii5LsJ41rVgh5LJ9YxiZqyjeyTj6kVNImP39ClieMfPhf
         gHRWDJr5iOFqeYY5q4j9NrKm9F3q6KuGCUawT6CNe6dNpDoGHoLJwSoL5hGQMsJWeH6I
         GufA==
X-Gm-Message-State: AOAM533V192HoGL1C6soqLvYaU/9ImmmWTwSToK95plOzu6jcr76pGZi
        LEhmGVhbiYLNCFNh0TvVEiQ=
X-Google-Smtp-Source: ABdhPJyK1IOoh0R9Yd63NJI6MhD/LiMN+njh8Zn1LCmB13B2q4nINVH2BkdWbZ0RRp4RyEhG+tD4tg==
X-Received: by 2002:aca:4c1:: with SMTP id 184mr4697980oie.157.1608339236651;
        Fri, 18 Dec 2020 16:53:56 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id p81sm2077375oif.30.2020.12.18.16.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 16:53:55 -0800 (PST)
Date:   Fri, 18 Dec 2020 18:53:54 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Seth House <seth@eseth.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, David Aguilar <davvid@gmail.com>
Message-ID: <5fdd4f22c473b_1d952220844@natae.notmuch>
In-Reply-To: <20201219001358.GA153461@ellen>
References: <5fdaef83a40ba_d0e26208f6@natae.notmuch>
 <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
 <20201217094424.GA75257@ellen>
 <5fdb3471c6bb7_d6d032087@natae.notmuch>
 <20201217175037.GA80608@ellen>
 <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
 <20201218023534.GA117762@ellen>
 <5fdc18a91c402_f2faf20837@natae.notmuch>
 <20201218054947.GA123376@ellen>
 <5fdc7a7d3a933_f4673208d0@natae.notmuch>
 <20201219001358.GA153461@ellen>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House wrote:
> On Fri, Dec 18, 2020 at 03:46:37AM -0600, Felipe Contreras wrote:
> > Yes, but the author of diffconflicts is not infallible.
> > 
> > Explain why the *users* of the diffconclits tool would be affected
> > negatively
> 
> You've got that right -- I'm definitely not infallible. My point isn't
> that I'm right; my point is that is my *preference*. Other mergetool
> authors may have different preferences.
> 
> I think where we're not seeing eye-to-eye is that you're focusing on
> potential "negative" consequences whereas I'm talking about having more
> information about the merge rather than less.

Yes, but it's not due to some unreasonable hankering; it comes from a
deep philosophical reason, which is Karl Popper's falsifiability principle
[1] that solves both the problems of induction and demarcation.

To put it plainly; if we want to know if all swans are white, where you claim
the negative, and I the positive; it's much easier for you to prove the
negative. All you need is *one* black swan.

Analogously in our case; all you need is *one* negative consequence to
prove your point, while me providing one hundred success cases does not
prove my point.

> There is very likely no negative consequences for most, if not all,
> mergetools.

Again: do you have *one* negative consequence that is present in tool a,
but not in tool b?

You say there is "very likely no negative consequences", but do you have
evidence of *any* negative consequence?

> I wrote the initial version of diffconflicts ten years ago and I've
> been using it nearly every day since. I'm fairly confident in the end
> result. What is a fact is there is undisputedly less information about
> the merge if we overwrite LOCAL and REMOTE;

But it's objectively not useful information.

Edit your make-conflicts.sh script, and remove the first paragraph from
poem.txt.

What happens when you run "git merge"?

Does it not complete the merge without *any* user interaction?

Doesn't that mean that git considers the changes in the second paragraph
to be non-conflicts?

> This is where I will part this particular debate.

All right.

I'm still waiting for anyone to provide *one* example of a negative
consequence.

Cheers.

[1] https://en.wikipedia.org/wiki/Falsifiability

-- 
Felipe Contreras

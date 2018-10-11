Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	URIBL_ABUSE_SURBL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEFA21F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 06:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbeJKNcO (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 09:32:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43227 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbeJKNcN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 09:32:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id n1-v6so8178824wrt.10
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 23:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=L9BrhCtHjmMp4r610p6stKp3BXB7Zb4LFtkxukLo4i4=;
        b=D1V6w5HbWUunmkbZiLHK86syw7ga1oO/b6RARYJVPEw/RYyrpWgAVUgdboYsQCFUxN
         /rusJI3mm0P23aB5fF779FDWkBZHTOXGutXMr0AjLVBTieVi9bOuw8mAUaE89bEFsYZZ
         r13wBb2kAbNfCGHuFogMmSFR/tWevvRe3b+L6IzS5dg30a+LV5//R6canDA7b6LVlEXx
         AblYwR2WR/hcd2CbtP0q7aYWDJU6gQ8EzYerWA8jSOpKsITooHwRf799pYPoMuKWjqWb
         W+RrdJSG5vuRzZzdVtv9aCb6BUIuRRhUYpKoIf/obp+MbOJpZku0VmOiprTHZlph7dsN
         r93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=L9BrhCtHjmMp4r610p6stKp3BXB7Zb4LFtkxukLo4i4=;
        b=Vibkq6MLq9bSx5Orp2Sd7y4NCI2rWjXoDyqNv2S3pgF+r24NoppqozFHRBjrBFdu1x
         d8wM+66IbgaqxJbOuL/24leToK0RM2Clb2jnaMcqYw1I12XNF64Xhu6Iw+4zUHeiZq4m
         YJwOmRzbmHX1a0FORUI+gzUFW74Yi/VrqmOR7ZzX8cYymzyRFMBgUe0ODZbIF6OXccBH
         Rx6aNX8/lPQAXZAEdSNPNeq3ylOx2Yy/3Umf7cHPzHAI31E1kSaTPE7EB9yfjPCo6DfB
         mQqQOBkbrZOXXUJBivNrAomTtsa8V5qFuCTtrCzCSy0iIMMZaICYomaNhd6H/1ec/4AQ
         QTVg==
X-Gm-Message-State: ABuFfohe/V7zUpw7eZO+gVH11J17dUjS703LoGpmFzHqkA4S7alZtcMe
        haI00OewPT7wA4VpCUqqh+GQIuo+msw=
X-Google-Smtp-Source: ACcGV60vHvv87NepOrZKo7g8pheXi0zPtnbIunBKsy4RuSLl68vr04QdTjClXhTjZZpxGNsLd42fjA==
X-Received: by 2002:a5d:69c2:: with SMTP id s2-v6mr196748wrw.232.1539237989012;
        Wed, 10 Oct 2018 23:06:29 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l67-v6sm47143792wma.20.2018.10.10.23.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 23:06:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/3] send-email: only consider lines containing @ or <> for automatic Cc'ing
References: <20181010111351.5045-1-rv@rasmusvillemoes.dk>
        <20181010111351.5045-3-rv@rasmusvillemoes.dk>
        <871s8yez74.fsf@evledraar.gmail.com>
        <7b03da07-4301-1b42-b8a2-a29e4e1f80d0@rasmusvillemoes.dk>
Date:   Thu, 11 Oct 2018 15:06:25 +0900
In-Reply-To: <7b03da07-4301-1b42-b8a2-a29e4e1f80d0@rasmusvillemoes.dk> (Rasmus
        Villemoes's message of "Wed, 10 Oct 2018 15:29:56 +0200")
Message-ID: <xmqqk1mpggpq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rasmus Villemoes <rv@rasmusvillemoes.dk> writes:

> I considered that (and also had a version where I simply insisted on a @
> being present), but that means the user no longer would get prompted
> about the cases where the address was just slightly obfuscated, e.g. the
>
> Cc: John Doe <john at doe.com>
>
> cases, which would be a regression, I guess. So I do want to pass such
> cases through, and have them be dealt with when process_address_list
> gets called.

We are only tightening with this patch, and we were passing any
random things through with the original code anyway, so without
[PATCH 3/3], this step must be making it only better, but I have to
wonder one thing.

You keep saying "get prompted" but are we sure we always stop and
ask (and preferrably---fail and abort when the end user is not
available at the terminal to interact) when we have such a
questionable address?


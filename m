Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5611DC43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 13:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbiFPNGe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 09:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiFPNGb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 09:06:31 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759E82DE7
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 06:06:30 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x5so2126230edi.2
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 06:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=9RjNSor/rOwWlDqriyudSAQXXHFfZL/7XBvhvK23gvs=;
        b=FEfFSzGMpCt8SjvFNaR0uCaprX/FYh8fgk96MgtadvE6Dsdnkds3GyzK8I5UeDiewn
         jsuXyKOls9j16w33pK44zZ9+JcaQriIXFI2tL9CLaK+QgZIRdcTV7LApn6DrEUz6Kk1d
         uXHCqsO3A002vTXHc4OQDRvXMvaDoigIIOIVDyjQ4q701gXkKKLzYKe0b772W3DB1wu0
         xx4dOjO6P+Ar2UgDhwEtVzu0wH6we7IulUe/92DIh+osM8EGdz9TXTDAE53zFA9Gbbwg
         i8Ut978+lklpgFB/Sl9cGtNfPm6DmCT2Uoqi8XAw3dLf7j2pTL7BrarSSkwBmMtwNFq6
         hbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=9RjNSor/rOwWlDqriyudSAQXXHFfZL/7XBvhvK23gvs=;
        b=0k1rpr5PU0Ba1A+Vug9rXddT6WwKLxJbIcNmsQDNGn4ToOlZrKFIfWbNlaJZUmj4Dy
         HISFpHDyniTJIxLddADlwpG7PFgOVB/60jMUcFdomfdssxuA1TyDCKMCgIHVkR5RDlCk
         F6DLGOFgn8hbADNwxjyWbGuvW0LO6COwYBxTmbsXcOING8vArplNpsqssBM+dlijKK9G
         +Y5j9Cp6YBWO4tWWxrwiQZmvRuQr1iqNmBO+kQkyKCDW2jwccF/X6ZeQvr3mMw7BuQHO
         ZRT+141gVZJYFKcJP92pZmIR5U+qib0RtTmRF8TDd5jrQGYoZ+b1TNqBeomBXiEMDQce
         KdGA==
X-Gm-Message-State: AJIora+9GweDjKZTA06BtTNGn3vqs93svXKg/XW8vteKs1mJjDSYm+Fe
        MPL0b1kJt/FGMeelKSAKcGQ=
X-Google-Smtp-Source: AGRyM1ueFYBjW8jXRaqKo6T4V0vp6OH8C1U4BCCIQ1BYm1Hg4ojS58X6HIxpAmcHaSF1adoreJiodA==
X-Received: by 2002:a05:6402:2999:b0:434:edcc:f12c with SMTP id eq25-20020a056402299900b00434edccf12cmr6293113edb.96.1655384788897;
        Thu, 16 Jun 2022 06:06:28 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id c10-20020a170906924a00b006ff045d7c9bsm761546ejx.173.2022.06.16.06.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 06:06:28 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o1pCd-0013iw-Bs;
        Thu, 16 Jun 2022 15:06:27 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 11/11] bug_fl(): add missing `va_end()` call
Date:   Thu, 16 Jun 2022 15:02:03 +0200
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
 <d674aefa78bdb6d255e40af2f308abf8a87a593a.1655336146.git.gitgitgadget@gmail.com>
 <Yqq3O5hykBecoVKQ@coredump.intra.peff.net> <xmqq8rpxw6ch.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq8rpxw6ch.fsf@gitster.g>
Message-ID: <220616.86o7yswyek.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 15 2022, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> On Wed, Jun 15, 2022 at 11:35:45PM +0000, Johannes Schindelin via GitGitGadget wrote:
>>
>>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>> 
>>> According to the manual:
>>> 
>>> 	Each invocation of va_copy() must be matched by a corresponding
>>> 	invocation of va_end() in the  same function.
>>> 
>>> Note: There is another instance of `va_copy()` in `usage.c` that is
>>> missing a `va_end()` call, in `BUG_vfl()`. It does not matter there,
>>> though, because that function either `exit()`s or `abort()`s, anyway.
>>> 
>>> Reported by Coverity.
>>
>> This was introduced by the recent 0cc05b044f (usage.c: add a non-fatal
>> bug() function to go with BUG(), 2022-06-02). But there's a much worse
>> bug in the same function. The code introduced by that patch does:
>>
>>   va_list ap, cp;
>>   [...]
>>   va_copy(cp, ap);
>>   va_start(ap, fmt);
>>
>> So "cp" is copied from "ap" before we have actually initialized "ap".
>> It's surprising that this works at all. The two lines should be flipped.
>
> Yes, it is surprising.  Perhaps it is not working at all.
>
> Thanks for an extra set of eyeballs.

It's "working" now in the sense that we run this code, and even test
that trace2 output specifically, see the tests in 0cc05b044fd (usage.c:
add a non-fatal bug() function to go with BUG(), 2022-06-02).

But obviously that's a bad use of the varargs API, I just don't know how
we've been getting away with it in practice, sorry about that.

The fix Peff's got here LGTM. I can (re)submit it with
format-patch+send-email after giving it a commit message describing the
issue if you'd like, but the change would be the same.

I'm also happy for you to pick up the upthread directly, but I don't see
that you did that already in one of the integration branches (but
perhaps I missed one).

Just let me know, but I didn't want to re-submit this without asking, in
case I'd step on any toes (or submit something in duplicate).

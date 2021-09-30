Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38439C433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 18:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10642619F6
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 18:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352960AbhI3SCB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 14:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352965AbhI3SB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 14:01:58 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1CAC06176C
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 11:00:16 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id n9-20020a63f809000000b0026930ed1b24so4696228pgh.23
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 11:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ug1GY+Y/BVb4dT8cVqyw+Al6ajrFbpiA/D5640U+bHk=;
        b=CDGXEnG9nzNvcDGjoRx/OE18e7dsh5hRx5kK2Gltdx5wPH8yFHqG/ETYL4Qey/EanG
         Iu9T9zT2I90EoTtOQANGoSDK6TtaXzhm3h1syeTffljlcuA9I6sdrvccQ4gj/oS+Gm+U
         lbdftlQCytUR6gZwdUtCHpYB5THmj2q4lc0IqTrbX1AshFPggadoCN2TXU3t9K+SIIjt
         iXxct5XS8h3doI7tTCz199RFrsPnJWkQlU9gjpYfo9yRh7q20G9u8QKSPZwICqHwg9nh
         uH/GO4sYDXHHKEj5LDMPBR5xa3+Q+R9wYG67RY5xpoYgRr3fWJpm3HtBKGeXdpBPt8n3
         MEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ug1GY+Y/BVb4dT8cVqyw+Al6ajrFbpiA/D5640U+bHk=;
        b=ZmkLGz5y7nogYI6R3I1poYQY6RlMJvyl0TwvOvPwGBwyK6Js9DFZWWdpVePW22eXm1
         gBgeY/WrZ9LmXbApMuAvBS96taW9MjWwk98eQzcH8dg5OWzugc9OEpy8pIAWL1o5SJnj
         FJ6PeBTuOOEyDb8xKjzflvJnyu9bvtjxDTMHTSJ4C2BZ+NCgvivrQMU2AOW4OFWa4x0i
         7QOOR7HmVDkxdD3UEgJqgdhwTdoCxrXbqlRo9ueBfwti7uxyrSWVTW3/9RE+VjQWWDAs
         lqaUctNeVp4fZ85dKnPySBDKBU34FvWiLaXnOrVLAQIkq+cUItKW9USIFrp5BRx/dukb
         rs2w==
X-Gm-Message-State: AOAM5319ogiMZ75RAiqGRwuCj6ZZlMikRfVTwFeQ7IKtrKS/q8okclEI
        V3GdotxTqUcz8yDJjd1HEWejtDYyYup6Hw==
X-Google-Smtp-Source: ABdhPJy4cMEbKa5e2Id2QfmqOMxvi6x5nfNWl3sagw8IpZNSERxEXKd2fJrgPdSQI3rKaCFqOwIOFWmZPnIZnA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:8347:b0:13d:e81d:3e76 with SMTP
 id z7-20020a170902834700b0013de81d3e76mr5460771pln.37.1633024815515; Thu, 30
 Sep 2021 11:00:15 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:00:13 -0700
In-Reply-To: <e1447d0e-091d-c659-b702-c5b33fffdb59@sunshineco.com>
Message-Id: <kl6lmtnu7xle.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20210913181221.42635-1-chooglen@google.com> <20210917225459.68086-1-chooglen@google.com>
 <20210917225459.68086-2-chooglen@google.com> <e1447d0e-091d-c659-b702-c5b33fffdb59@sunshineco.com>
Subject: Re: [PATCH v2 1/3] fsck: verify commit graph when implicitly enabled
From:   Glen Choo <chooglen@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Because I took the time to scan backward through this test script, I 
> understand that `core.commitGraph` is already `true` by the time this 
> test is reached, thus the new test title is accurate (for now). However, 
> it would be a bit easier to reason about this and make it more robust by 
> having the test itself guarantee that it is set to `true` by invoking 
> `git config core.commitGraph true`.

Reading this and..

> I find it somewhat confusing to reason about the behavior of 
> test_when_finished() when it is invoked like this before the `cd`. It's 
> true that the end-of-test `git config core.commitGraph true` will be 
> invoked within `full` as desired (except in the very unusual case of the 
> `cd` failing), so it's probably correct, but it requires extra thought 
> to come to that conclusion. Switching the order of these two lines might 
> lower the cognitive load a bit.

I'll make both of these changes. Test readability is important and
people shouldn't be wasting time thinking about test correctness.

> test_config() unsets the config variable when the test completes, so I'm 
> wondering if its use is in fact desirable here. I ask because, from a 
> quick scan through the file, it appears that many tests in this script 
> assume that `core.commitGraph` is `true`, so it's not clear that 
> unsetting it at the end of this test is a good idea in general.

This is a good point. I made the original change in response to Taylor's
comment, but I think we both didn't consider that this script assumes
`core.commitGraph` is `true`. The rest of the tests pass, but only
because the default value is true and I'd rather not have tests rely on
a happy accident.

> Taking Taylor's comment[1] on v1 patch [2/3] into account, I wonder if 
> it would be simpler for these all to be combined into a single test. 

Interesting thought. The marginal benefit here is much lower than in
patch [2/3]. The difference is that corrupt_midx_and_verify() uses an
additional $COMMAND to perform verification, but
corrupt_graph_and_verify() does not. The result is that
corrupt_midx_and_verify() is subtle and confusing when used in separate
tests, but corrupt_graph_and_verify() is not so bad.

> A downside of combining the tests like this is that it makes it a bit 
> more cumbersome to diagnose a failure (because there is more code and 
> more cases to wade through).

Yes, and we also lose the test labels that would guide the reader. It
might not be that obvious why the tests for a boolean value has 3
cases {true,false,unset}.

Taking churn into account, I'm inclined to keep the tests separate.

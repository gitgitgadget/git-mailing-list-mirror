Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38667EB64D7
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 13:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjFWNhB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 09:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjFWNg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 09:36:59 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528532695
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 06:36:55 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b72329b63eso529674a34.0
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 06:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1687527414; x=1690119414;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qdRWphy8Rbiz2/EkDnNyogw2NVIcOW+akI4PNOeXvU8=;
        b=F0qneIjKs3cl+l7JBSvYjMYQFdhCmB0CU3s4dKHfdVkf4miVvxjJ064DP6ETLvqd27
         OvyXLmqDwQPMvlSPgTYRjcg7BnAoBp+elidOsLaa23VCmTVpSFhCaEbA06Z9hMu2n0j6
         TXObylS4ERKw7yMS0iBXyPI6lIe2Niv0u7o9FzkU/Zc3Fe3Hgf1TD0rAaVbUFv5o1tFC
         R56Di+vLHoxnIJwyh8Gk86Q5BQRvz7Iplsv+jYvWiw0GM4Ubrr0hn8tGrrNiYc27tqhp
         aKO3lFqEsLsjTEMAJgQEOuhGzMz3m4CJaTCOQGTW5RneunyxUFHQbNqMUBJCASgejbYP
         hOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687527414; x=1690119414;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdRWphy8Rbiz2/EkDnNyogw2NVIcOW+akI4PNOeXvU8=;
        b=IabfXE8Nh+Fgb2pP2NyHBJB3umgdmWFNBDynEKOQRr3ikpTBSLZHx+KvVhgvOkN9w4
         nd/CrCfM/fmoISBFwHajcr6thKiyThuyhTnq4+J44ylUqyclq6tm1Cpcni64rmfe1y4S
         XWGoR9ldKG7Mjz0giwW177ynC6Sf3qy/XSH3/hsPAEh7xsfPxERo3KrDjvKmj5GeqHNb
         vMg/DOvA19O6FPUJkdc8+0CB7yaIGCWlbMusQJstPisgQwiC1J4ad1hvLauelacgwUDp
         OO5jMpJbMmM+ws+1l+juMYM1rXjbj7kbjl64p5HQs4EilupE4HUTUJOwY36rLhKO6yi5
         nEUA==
X-Gm-Message-State: AC+VfDzg9e3mCeRdtkSxYgW4SaQ8t7Ug07YrbjGR6SDglBOG/ZkKoR/X
        5QlpNHW450XDUczl7W/5rcQDyWHeA1ZO8tI6zg==
X-Google-Smtp-Source: ACHHUZ4r1TomGp5lKeI+lkpJCqXNyScwjAMaqEq9XANWQddtZIqRykXDPrbHWYCB9TLVvt3jaZaGHw==
X-Received: by 2002:a05:6359:a03:b0:132:d7c7:65d1 with SMTP id el3-20020a0563590a0300b00132d7c765d1mr3962061rwb.18.1687527414562;
        Fri, 23 Jun 2023 06:36:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:ed06:4a41:daac:5b11? ([2600:1700:e72:80a0:ed06:4a41:daac:5b11])
        by smtp.gmail.com with ESMTPSA id y6-20020a253206000000b00be674b1b740sm1246840yby.5.2023.06.23.06.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 06:36:54 -0700 (PDT)
Message-ID: <6961779f-9fd8-28cb-6046-cc24b6869cbc@github.com>
Date:   Fri, 23 Jun 2023 09:36:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: BUG: config.c:129: kvi should not be set while parsing a config
 source
Content-Language: en-US
To:     jkasky@slack-corp.com, git@vger.kernel.org,
        Glen Choo <chooglen@google.com>
References: <CAJSLrw6qhHj8Kxrqhp7xN=imTHgg79QB9Fxa9XpdZYFnBKhkvA@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAJSLrw6qhHj8Kxrqhp7xN=imTHgg79QB9Fxa9XpdZYFnBKhkvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/21/2023 7:45 PM, Jesse Kasky wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> git clone --no-checkout --sparse --filter=blob:none --depth=1 <repo> <dir>

I'll note the oddity of using a blobless clone filter alongside a
shallow clone. This is something we are not super-likely to do
very often, so I could see how it is skipped by our test suite.

> cd <dir>
> git sparse-checkout add <dir1> <dir2>
> git fetch --depth=1 origin <commit>

Especially this fetch after the clone. Shallow clones are better to
only clone, then throw away. Don't fetch from them again. That said,
we shouldn't be hitting a BUG statement.

> Received the following error:
> 
> BUG: config.c:129: kvi should not be set while parsing a config source
> [1]    5842 abort      /opt/homebrew/bin/git fetch --depth=1 origin

I've come across this error while playing around with things in
the config space, and the case I figured out was due to nested
iterations over config.

In my case, I was adding dynamic config loading when certain
global variables were used, and some were used during config
parsing causing this nesting.

That's where I would start investigating, but don't have time to
dig in more than to contribute my experience with this BUG
statement.

> Two items I came across while trying to troubleshoot:
> https://github.com/git/git/commit/9828453ff00b330c57daa3a8b672cbb5f0cdce34

I have CC'd Glen, the author of that commit, and an experienced
contributor in this space.

Thanks,
-Stolee

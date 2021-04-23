Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58ECC433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 20:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC4DD61458
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 20:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243879AbhDWUQq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 16:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbhDWUQo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 16:16:44 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7503C061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 13:16:07 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id k25so50340408oic.4
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 13:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sj7adCVy9YX/daqknRjyTddDADZnK5VL+unsUonMCoM=;
        b=Sc5Dx+pPabR5XkxcaLEjBbvqvhk2oiT/voe9GM6dwT+znyNxKb713fgcuKzOGoDlxt
         H3JQsemSXC2wK6GTd7z5PmfmLqbOMYh8KFqNnZoZ8F9EqT7aZMfIGwA9yCMWQI/CXTu4
         Fc3kEH2tA7WixOttppadMy6WslKHe6LDU+JV211E0v8koSa1Ct5IzKC0Ll5bmxsPd25k
         gW32a1boAGvprh1mfIPIAGRbauwU0fI+jPbGlRKqHBBfb5BhexzekutXAvpI+UDaaF9B
         gAM+MLaG9pt7LpPmBxZoP8loQVagDGoNrrmzVOrNysPByniMM+Ryd31odrArxI2V+CTH
         ppYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sj7adCVy9YX/daqknRjyTddDADZnK5VL+unsUonMCoM=;
        b=MNtVEbWLJbIeOfEJaQXgT2oovFxXxKyOVEKuHhIDPNa3VqfNwJGEy6i5LoDovSxeYT
         /WLGEhtM0TjLALS6zOR7gZsTvp04QVocOETHC4W0NWhnPWGLWhfVeKWM0zqjLgzTPiRg
         uGoeZ2BuyPBZAFHHWORJqoBFhOPXcKneT7lywUmWoeDG9qqQprF1E0sEcALD9WkOXPcZ
         L9tqn08XhOavHmNa8AmixNERoHfOwcfyJZvqU9EhW2LEoyPl2CHXXjcJT5xLhprlahFB
         pz+TmDZzHKvYCYyeZ8ItSmpjFZi6WUt0N1X1HcFAVYpMY6yPYprgoqRarhZ5nlh1sE5d
         Ifdw==
X-Gm-Message-State: AOAM533sc8+EZwTPjA8rDvFV4Cm/KZGcnw1dELP+se4QJWkRT0ydI3TL
        9PF55Az4uqDFgaqjZGIMRE0=
X-Google-Smtp-Source: ABdhPJyRW4ZD62Z+yflUf9WqPlfuwWaxLyI5JiRcpx1AS7aFhwc/ZCwibd4TGQpieRDWh1WAgJ8+xw==
X-Received: by 2002:a05:6808:c7:: with SMTP id t7mr5304079oic.43.1619208966914;
        Fri, 23 Apr 2021 13:16:06 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3de1:cfe2:170e:4cb9? ([2600:1700:e72:80a0:3de1:cfe2:170e:4cb9])
        by smtp.gmail.com with ESMTPSA id w3sm1561260otg.78.2021.04.23.13.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 13:16:06 -0700 (PDT)
Subject: Re: [PATCH 02/10] unpack-trees: make sparse aware
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
 <0a3892d2ec9e4acd4cba1c1d0390acc60dc6e50f.1618322497.git.gitgitgadget@gmail.com>
 <CABPp-BHcdhO_kEdqR23sDdGAgoSu2R-HBWv-RmzQvJ0ysWtzxg@mail.gmail.com>
 <34972851-7d3b-c759-ba87-7022702f74c0@gmail.com>
 <CABPp-BF0ZhbSs42R3Bw_r-hbhQ71qtbXSBqXdq0djyaan=8p=A@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <74f21db2-d8ba-3aae-99f6-2712d581f2cb@gmail.com>
Date:   Fri, 23 Apr 2021 16:16:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BF0ZhbSs42R3Bw_r-hbhQ71qtbXSBqXdq0djyaan=8p=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/21/2021 2:56 PM, Elijah Newren wrote:
> On Wed, Apr 21, 2021 at 10:27 AM Derrick Stolee <stolee@gmail.com> wrote:
>> Alternatively, we can decide to change the behavior here and send an
>> error() and return failure if they try to add something that would
>> live within a sparse-directory entry. I will think more on this and
>> have a good answer before v2 is ready.
> 
> See my comments on 01/10; users are already getting surprised by "git
> add" today and has been going on for months (though not super
> frequently).  When they try to "git add" an untracked path that would
> not match any path specifications in $GIT_DIR/info/sparse-checkout,
> the fact that "git add" doesn't error out (or at the very least give a
> warning) causes _subsequent_ commands to surprise the user with their
> behavior; the fact that it is some later command that does weird stuff
> (removing the file from the working tree) makes it harder for them to
> try to understand and make sense of.  So, I'd say we do want to change
> the behavior here...and not just for sparse-indexes but
> sparse-checkouts in general.
> 
> As for how this affects the code, I think I'm behind both you and
> Matheus on understanding here, but I'm starting to think it was a good
> idea for me to spout my offhand comment on what looked like a funny
> code smell that I thought was unrelated to your patch.  Sounds like it
> is causing some good digging...I'll try to read up more on the results
> when you send v2.  :-)

I think there are enough strange thing happening with 'git add' that I
want to take some time to figure out the right approach here. In v2, I
will delete the changes to builtin/add.c and instead focus on making
'git status' faster with a sparse-index. The 'git add' improvements
will follow in another series after I take enough time to understand
all of these special modes.

I think this split is especially important if we decide that changing
the behavior is the best thing to do here.

Thanks,
-Stolee

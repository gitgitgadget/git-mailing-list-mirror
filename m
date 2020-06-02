Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599F9C433DF
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 19:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F014206A2
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 19:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBZUoT7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgFBTkb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBTkb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 15:40:31 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC42C08C5C0
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 12:40:30 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id u23so11865851otq.10
        for <git@vger.kernel.org>; Tue, 02 Jun 2020 12:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4Aq+yxlidvuHSUFMTbOQb3I8uUMs2NanHso2tL1qnrg=;
        b=mBZUoT7ud9XCO55Vc4f8baK4QB9rnS/DH0mz3bp742YSTw8IBJRZ1fUeR/J0bdtfBJ
         xd82O5klvsSO7gtIqhmRx0ymr9/115LCxtmHzTH9SAdaS0g02UNDLcWwTvA/IWbwWT84
         H2AEwqO8XNbBA4V6QMf/40pmU/aWQme9DazbeNGN+QEO0QBExtmtgZLVNC30c/d/AcJ/
         kch+EgNsgPzZhFZMk7HmyKPnwr5JTydvzrg8k/3EeqBrOcBZVhKByJspdAIZ8A36p6gq
         o6t3z4/qMSEevrTTUuzlL5DmgehjwBQOzVF/qordlOjkO5FDMoM31OFK0RQGai+PiMHQ
         og3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Aq+yxlidvuHSUFMTbOQb3I8uUMs2NanHso2tL1qnrg=;
        b=J4HB6h1qkeB6hScKadJGUAjYfXRPHYD4ZLf9r+XtuP29N5d2FCNY4HHkYPIs5DcB3O
         r2Myib5ko9bNidUULoVaj93EEnMSpWsMQcN1rcUnJcdXZ1P++rrIj+m9yt9FqP+71Mow
         HNRZ4XWBadNEOAywafxa1UTNlo5lvgSDYj8dpxveNyAP7o7gPLVV33r785rssWt5KYS/
         PPcdn8RzfHE2c2woJME/u3GkFJk21xcrBR9yVnAL+6ithNIM4nVV1jR7CIRo05V9Dw7X
         /mUZa6FQN1yLQiRc1pUKq+YgZdMIAyWjRuN0/vVfiLyVQWhwvJQJlinqqNwxFa03hgR3
         MKdw==
X-Gm-Message-State: AOAM5322xQIBk2gd2JgUtY58EE+nCiqLIf2+RTUqzTfijAmpVuXqY9lj
        I/o/XjoZhqqN3DCYm9WQmak=
X-Google-Smtp-Source: ABdhPJwIZvNzHvzG/Mmuy4NdYEviqWrB4IQZY/lu59ZARGPm9fiMt6FQnxeHQOx2n3TS+ynIBuzXKw==
X-Received: by 2002:a05:6830:1af4:: with SMTP id c20mr628770otd.191.1591126830041;
        Tue, 02 Jun 2020 12:40:30 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id a2sm855613otb.13.2020.06.02.12.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 12:40:29 -0700 (PDT)
Subject: Re: Huge push upload despite only having a tiny change
To:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Jonathan Nieder <jrnieder@gmail.com>
References: <CABPp-BEswHLhymQ1_07g3qqu=7kFR3eQyAHR0qMgSvi6THy=zQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <29e6c05e-2d79-d2ac-a033-dab6342ebcaa@gmail.com>
Date:   Tue, 2 Jun 2020 15:40:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BEswHLhymQ1_07g3qqu=7kFR3eQyAHR0qMgSvi6THy=zQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/2/2020 3:21 PM, Elijah Newren wrote:
> * The user was two commits behind the closely-related branch at the
> time of the first push, and 10 commits behind at the time of the
> second push.  Running format-patch on these 10 commits that were on
> the server at the time shows their size is at most about ~55 k.

This is most-likely the difference, since the pack-objects algorithm
only looks at the _boundary_ between the server's commits and the
commits-to-push. This also could have dramatically changed the delta-base
matches.

Do you have exact object counts? It would help to know if somehow the
object discovery algorithm is at fault or the delta-base algorithm
is to blame.

For instance, `pack.useSparse` was enabled by default this release,
and has some opportunity to push extra objects. See [1] for more
details on both the "boundary" description (the "commit frontier")
but also how that option changes the algorithm.

The only case I know of that could lead to sending extra objects
(that was not the case before) is described in t5322-pack-objects-sparse.sh
and 4f6d26b1 (list-objects: consume sparse tree walk, 2019-01-16).
It involves doing a full _copy_ of a tree from one position to
another, without "disturbing" the parent of the original tree.

(I mean: copy directory A/B to C/D and make sure nothing is
different in directory A.)

However, if these two pushes were with the same config setting,
I'm not sure what could have changed between the pushes to hit
this very narrow case.

Thanks,
-Stolee


[1] https://devblogs.microsoft.com/devops/exploring-new-frontiers-for-git-push-performance/

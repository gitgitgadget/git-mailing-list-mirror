Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D36C433E0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 10:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2006222D0A
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 10:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbhAXKWC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 05:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbhAXKWB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 05:22:01 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D59C061574
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 02:21:20 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c6so11734072ede.0
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 02:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=u0q3BDFG8S2M7W67SYxHYJ/uwCr2j8aA5qvKo7sy5rU=;
        b=KC/MrGl7hl0Etc7T24tkYyFHig399m5UcNz3jb5ECW7ePSuhHO9Qo2j7i7cIW99+D0
         9taO06tcyRUX0oN4Zp2EmNCai7C2LZPwYG3c+zCSPM9S3SPGTsB2Tggq622MCDskgxih
         B35vhOLBbsexHJDinU6Dmx36PkjSYOKGBK1wzj5aVPJbQpn32nCpA83Oe3JmEr6Cxy6q
         BpUMJTjfq/ml2L1HJiAfFrVmSBUZqL14BhplRptSCsXkpRB55707o8zQWgZEvkwZyMRS
         NPEXUC88Yi9ZNRV8GJNr2FpbItYlyuTMrEkMUX7fcmq0dVd0JvEllmuKupRRr6dK0/vO
         j5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=u0q3BDFG8S2M7W67SYxHYJ/uwCr2j8aA5qvKo7sy5rU=;
        b=KXqJw33vo71SNRWqxz9nJUIoQKIyo+NfIU6FBHFV0LFzYuDc/q04ca5FTO2i4EA19y
         C4G82haA2ZLCXJmlJTG0XmLi5p5g5d//zejK92ywOIFDrEINKCaS8UtJdin+6nQuRtxh
         Lwe+fzuAnfIzAFRIyO3tCoWWXmuiTpUL/QfuYl3VlGy/oSxVmeuVLO6ymW6vnGW9Vx0Q
         lkB/PolEU7Gvz4XCM7pETNIOPEBf9yFMVb6fZO33L5EEK3CycSZKCjNpkXfLCl6CQpaz
         D+837GrsBuOcR96hGr+MQ1Mk7a8DA9CVeH5XBhCN25Znp/nz3LOmueVU4wVeGQ5f4VC3
         m0Vw==
X-Gm-Message-State: AOAM532i10GdXYH/EzNbEnP2+ogdFMcUGaCdBND9P+pNokt+KEys5Pq8
        TixYz+vTaCtchJRpyr7ivkR6mVXUANuNsA==
X-Google-Smtp-Source: ABdhPJwyYnWJAU1cHzmdbOxxkHCa00waQ/pvRoOyfNAcPBjjBH3gJbwLMJW38W/k/7bz3jp3jfAXZg==
X-Received: by 2002:a50:fd19:: with SMTP id i25mr513636eds.386.1611483679075;
        Sun, 24 Jan 2021 02:21:19 -0800 (PST)
Received: from cpm12071.local ([79.140.115.149])
        by smtp.gmail.com with ESMTPSA id zg24sm6881372ejb.120.2021.01.24.02.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 02:21:18 -0800 (PST)
References: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
 <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
 <20210119212739.77882-8-rafaeloliveira.cs@gmail.com>
 <CAPig+cQnp1iV4u9Z6cArSEq-oMrQW6yQVG6VTTjnOZ3MNO9nEQ@mail.gmail.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 7/7] worktree: teach `list` verbose mode
In-reply-to: <CAPig+cQnp1iV4u9Z6cArSEq-oMrQW6yQVG6VTTjnOZ3MNO9nEQ@mail.gmail.com>
Message-ID: <gohp6keeiaoctf.fsf@gmail.com>
Date:   Sun, 24 Jan 2021 11:21:17 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Eric Sunshine writes:

> On Tue, Jan 19, 2021 at 4:28 PM Rafael Silva
> <rafaeloliveira.cs@gmail.com> wrote:
>> [...]
>> Let's teach "git worktree list" a --verbose mode that outputs the reason
>> why the worktrees are being annotated. The reason is a text that can take
>> virtually any size and appending the text on the default columned format
>> will make it difficult to extend the command with other annotations and
>> not fit nicely on the screen. In order to address this shortcoming the
>> annotation is then moved to the next line indented followed by the reason
>> If the reason is not available the annotation stays on the same line as
>> the worktree itself.
>> [...]
>> Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
>> ---
>> diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
>> @@ -134,6 +134,36 @@ test_expect_success '"list" all worktrees with prunable consistent with "prune"'
>> +test_expect_success '"list" all worktrees --verbose with locked' '
>> +       test_when_finished "rm -rf locked1 locked2 out actual expect && git worktree prune" &&
>> +       git worktree add locked1 --detach &&
>> +       git worktree add locked2 --detach &&
>> +       git worktree lock locked1 &&
>> +       git worktree lock locked2 --reason "with reason" &&
>> +       test_when_finished "git worktree unlock locked1 && git worktree unlock locked2" &&
>
> Same minor problem here as mentioned in my review of [5/7]: If locking
> of the second worktree fails then test_when_finished() won't get
> invoked, so the first worktree won't get unlocked, thus won't be
> pruned. To fix:
>
>     git worktree lock locked1 &&
>     test_when_finished "git worktree unlock locked1" &&
>     git worktree lock locked2 --reason "with reason" &&
>     test_when_finished "git worktree unlock locked2" &&
>

Make sense. Thank you.

-- 
Thanks
Rafael

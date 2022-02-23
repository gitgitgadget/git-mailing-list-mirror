Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F10C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 19:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244520AbiBWTum (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 14:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238759AbiBWTul (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 14:50:41 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824E04B87A
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 11:50:13 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id e22so10269164qvf.9
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 11:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=7hYaHNbo52ZMPGs1X3P4qCvukE3JJaq8VhT0mWwW/U4=;
        b=bE5fRtWKk8/+VAZFhoeZ3dI6fWrH6fInsfYKaJyZT74XM8XkNbF1qVkqG9xlcKyuyX
         1CsWZ7Q411d8W4Lvh/erMmUFc9mvWi0mAZe9sfvCjyNWWs6v1mbe7sxZ32kV+xwfTl3h
         fj47H8cNi8i7FT8ZGrno6OYyoZdTZY1y8ixdwcvWJ5MiZ/MOBADRQVn2r+S39I5MrKWP
         Dqb9vEMO4nid8V+LsiWsuBkH0AIUC98hpT6guvDYoWIpUeXAT3sJN1s3irltSnysxsHo
         dKUMbkm9Xju0v828nTVzL+nwM4FploJC4L9m67agWUmzPqE6XuAPSuzX3HWzHdrxaHOq
         nK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=7hYaHNbo52ZMPGs1X3P4qCvukE3JJaq8VhT0mWwW/U4=;
        b=W+TXUWg695eHsRz6kOaxrpy5J5zQlgO9cUcXwcAkXIFc2ttw9d11MQgEnjWZk9m57D
         tYN6nKDN3a0OmCn8GWb7H3iw/EceqEZ0VJ8wdZqNEH5l5cPsZv1rslSggW8Qxz4TrqKu
         8DxKaUE5JnNlh9eXjhdT7MwkJYy5K1fal42XN1q5ZrZhfqaMT4ugsldbYWlKEkk8zlFv
         IjULVM7hYcz7BOyyJ8KgGtJND796p9kK8LoZXQd0KaE5E/iBwtvDPG3eCbBiR43hyIST
         w3YWej9qgptyJ547jHxAbSBEZd7LgTj+lmWgq78s2G2TRmKfSxkLxufFpDA3YP+BN8I7
         lDbw==
X-Gm-Message-State: AOAM530SN2B/qsumHyj0HWT4Y5tye/dsn9WRKzZC9cblt9UJVhqwZ1JU
        NSTRNcM79LiVUofOpzKnYU8Rw09JMto=
X-Google-Smtp-Source: ABdhPJzT6YIAg//U5euki5xmxwRji9MHNzE8+uJoi9LoAzQ+lSVldOuUkKIgjBjAOa6fPAQ33KjwBA==
X-Received: by 2002:ac8:5c05:0:b0:2de:70c9:f9e6 with SMTP id i5-20020ac85c05000000b002de70c9f9e6mr1330339qti.568.1645645812628;
        Wed, 23 Feb 2022 11:50:12 -0800 (PST)
Received: from [10.37.129.2] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id e64sm235091qkd.122.2022.02.23.11.50.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Feb 2022 11:50:12 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] reflog: libify delete reflog function and helpers
Date:   Wed, 23 Feb 2022 14:50:11 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <F889CE8D-BFFD-4E3D-8CD1-0F2A1948805F@gmail.com>
In-Reply-To: <YhLv9P9VFQ6Iwv41@nand.local>
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
 <9e17ece8d8956c7fd41b7be2f5c0475b1f9af6ec.1645209647.git.gitgitgadget@gmail.com>
 <Yg/09XYTruPJQVV/@nand.local>
 <F49696AE-3A00-4870-A355-A9510468F35D@gmail.com>
 <YhLv9P9VFQ6Iwv41@nand.local>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On 20 Feb 2022, at 20:50, Taylor Blau wrote:

> On Sun, Feb 20, 2022 at 08:43:14PM -0500, John Cai wrote:
>>> One question that I had which I don't see answered already is what the
>>> plan is for existing reflog-related functions that live in refs.h.
>>> Should or will those functions be moved to the new reflog-specific
>>> header, too?
>>
>> Thanks for bringing ths up! Maybe this cleanup can be included in a separate
>> patch series since this one is mainly about getting rid of the shell-out in
>> stash.c. What do you think?
>
> Yeah; I think that's fine. We don't need to get all reflog-related
> functions moved into reflog.h in the first series, so I think it's fine
> to move things as you discover them.
>
> I was just wondering whether it was something you planned to do at some
> point (as part of this series, or a future one).

Yes I will open a new series for this. I've been looking through refs.h, and as you
alluded to there are a number of reflog related functions. But, they also relate to refs.
I'm not sure which ones should go into reflog.h versus staying in refs.h. What are your
thoughts?

>
> Thanks,
> Taylor

Thanks!
John

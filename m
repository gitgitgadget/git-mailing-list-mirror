Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCB0C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 11:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6900B23A51
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 11:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgLRLmg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 06:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgLRLmg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 06:42:36 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14148C0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 03:41:56 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id b24so1663564otj.0
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 03:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=S7dj032G/CzcBB8bn3loR8GYh/apnX4WUQW1qVPC9hE=;
        b=IDsSajxWMt2XnOAkkhmFUszeh4mLAz0fsNlHX23YQZEMIsoCK6RIc486aJ83lWW7Yf
         jeavn6XKpDmvtlkjxK4nR3i8CjWdJCmJwVPYOsPj21EIIiO3KSfmfQSp+V9JYx8xailh
         K14o2Bc+D4DmUT7nlX9RssoBhjqxZz2Gz2geL/cxh7pUhgpe8qPZHMknVCerDCxrNsC1
         OmY3U+HInRIqToR/LMJkfhfqOYRKFp6ePHpqFDdliLagnRnHI2u1dV6JNrq6U+xhGgm+
         L+f5IWZd/POuKAvm7uQCX2lvQjxlLqMmuLNPehIfTs54406cN3z1XJ29GvjG1IcJJHx7
         q9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=S7dj032G/CzcBB8bn3loR8GYh/apnX4WUQW1qVPC9hE=;
        b=mH7vhd7aplYhRWiARm5sqe76BzB+qHXeUICkfYZkQ+iInKOSIEwqq7ldEIKT4OZCAg
         SD1FZGOuOVWy8KLhVsSJRYCammYgJDMK7VT88O/5Az/WOgz/ZB7kkrmAUgXhRhFkM6Nm
         L9wwmmyTtgdGk3SdZxc6bKJdP/Blo4uE1XhdDrHUS2GaKw6SuhSTJVcXM6/+24azo+Nm
         yDt/59R873/93lJGloOqJRvyJJdTNXwQu7wgQW3/vxY3ALeRu5HnEohEiAzgX9nt09By
         bCuZXBPyCVzgGDMX28tVQOw4QZA8uaIwVaVQbuiiHajc2waDLl5g0p5rnNL0YUfS/X63
         6g0Q==
X-Gm-Message-State: AOAM530Uh3iFAl4hxrdEvCoz8D+gwywodVEyLJ9s6kmU+L641BwVa0PF
        kCf3l3CilSLVUuJBdFRmWXA=
X-Google-Smtp-Source: ABdhPJzev9Q7ygC4Uv7WbeP7X6h5xnogwymBJZO/XWZ9ZzTZoVFFZsTF+mzHTn4KlAJ5DVJ1xCp9IA==
X-Received: by 2002:a9d:620d:: with SMTP id g13mr2445978otj.56.1608291715442;
        Fri, 18 Dec 2020 03:41:55 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id l134sm1683505oig.25.2020.12.18.03.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 03:41:54 -0800 (PST)
Date:   Fri, 18 Dec 2020 05:41:53 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sangeeta <sangunb09@gmail.com>, Git List <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <5fdc958199da4_104e15208fe@natae.notmuch>
In-Reply-To: <CAHjREB7UonP7TPCd9dvXLX2ho+rJP07JM8nk33AYj9K=Mi7EYw@mail.gmail.com>
References: <CAHjREB6+=ZT9B-XASAk7Hqt7qD5YhgROjDLCKoJR7cNyJDpDMw@mail.gmail.com>
 <CAP8UFD2AOaPC+7+qcJHQ4+Q5=dhY7ReNbRfJQ=HCS6=4bTPuVA@mail.gmail.com>
 <CAHjREB6ynLFW46C9s8D_nvUpavkugo7syegGuvCMdnfVNiZ+0Q@mail.gmail.com>
 <3bd5cef1-cda7-5118-07ac-a2f91cc80371@gmail.com>
 <CAHjREB7UonP7TPCd9dvXLX2ho+rJP07JM8nk33AYj9K=Mi7EYw@mail.gmail.com>
Subject: Re: [Outreachy] Blog Post Submission
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Sangeeta,

Sangeeta wrote:
> Here's my second blog post on "everybody struggles".
> https://sangu09.github.io/everybody-struggles/
> 
> Do give it a read let me know if you have any suggestions.

Just a few obsevations.

 1. Don't feel bad about the lack of code. In my professional experience
    I've seen situations where a developer spent one month working on a
    problem, and the solution is *one line* of code. It's not the amount
    of code that matters; it's the amount of effort that was put into
    it, and in fact; once you have a solution that works, putting more
    work can make it cleaner (less code), which is appreciated.

 2. There is a concept called "the curse of knowledge" [1] that everybody
    who is an expert in an area suffers. Certainly many old-timers in
    Git development do.

    That's why newcomers are always appreciated; fresh eyes usually spot
    issues many of us don't. You have a unique vantage point, so it's
    good that you document your struggles; they may give us an insight
    that otherwise we would be blind of.

 3. Once you have some code you would like to bounce off on Git
    developers, you might want to try git-related [2] (that's my tool
    but there are others). For example, I just did this:

    git related master..mergetool

    To find people to CC regarding the branch I'm currently working on
    (they have worked on the lines of code I'm changing).

That's it, I hope you find that useful.

Cheers.

[1] https://en.wikipedia.org/wiki/Curse_of_knowledge
[2] https://github.com/felipec/git-related

-- 
Felipe Contreras

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37DAC5479D
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 17:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239839AbjAKR3W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 12:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbjAKR2L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 12:28:11 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2090E32EB9
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 09:24:03 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id b10-20020a4a9fca000000b004e6f734c6b4so4207511oom.9
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 09:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pVTYXLJ5W95+45OAhgbyKH2TYT0N6zaoqoNs2l0MCLM=;
        b=Ip22jztkZ1nIDJP/OEfv4HOkeKDOqNma3Mdkdys7yXTJgWkIOjj+fAVDTuSufVyEgS
         6BIIswTPkxsLNrF55JQZZJ+2Nm/4HNBh9yZSMWqZFaV/IV19nMm2296kDvavmUnCbPUo
         fOMTlyDzs7gKtDqUpeFSYUN2PdoidktoedanS6sMcGlI36KR3Y+r/3WdSJwChN57RDIU
         EL2bY6ju5tVOtrxW9Yew6Ht7Y45Q8bjjTRPkUCT0Ax2nCoK7+hNBNxTEMbAiRMx7sc3x
         YSY7tgPERESeudunxdm/OgH8ecaPDMUn7+JQ1jhlkJ0QMJjpEsM0gLC2B/r62b4+fHHC
         +9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVTYXLJ5W95+45OAhgbyKH2TYT0N6zaoqoNs2l0MCLM=;
        b=nqFMf1Av+fXJHzyV+lGxRIuw4XBsqtP1TydoJGauiAxGts/ott3qwYYC31rMJjyVKL
         9K1jZzQwBmluyv8nh0UWSuSnhh/z1lvrOy8WrtYFwNUsKkjsIJv+1Vge6wTvkTWLvLsR
         kF5WzgeDJ2dKwjQ+qU4EKHg0iCTkqwoR+DI+tAJ6iRUtmmLfKo9YTGeOSZvPrvM+uFFG
         WQcGSmEuc7bsMljST2YVCoU41DEeUeRWm3P9icxrM5WSItoywU4tfRQsj+NnPBsbL23j
         vkwIktkqPEN2uJ/UvYHJ+MqD+yJWEUeJ6EoUDucexjXGOnInZtae091vEYeMy9Qk7nUX
         dZTA==
X-Gm-Message-State: AFqh2kowcC2g/JzzdJCGb3Uu8m9OMa7wFcCppES0yfoS6it9W0wyiQNa
        q5nIGzGzMTz4Q4gXUDzfLDJEi1nO7FS3xB6aUAIBbU8Pp1A=
X-Google-Smtp-Source: AMrXdXvvLWZRlKAxbWXkFfy6n+0jGIaAvDxpCZxvgqPvqyVK3s2Cf5nAle2sELIl0w4brjv5DlKB5dFG7XXtlYP56Q0=
X-Received: by 2002:a4a:d086:0:b0:45d:e01f:8d7d with SMTP id
 i6-20020a4ad086000000b0045de01f8d7dmr3573219oor.2.1673457841888; Wed, 11 Jan
 2023 09:24:01 -0800 (PST)
MIME-Version: 1.0
References: <7hfRSnKTRnT4uJh5Pok8U8gfLm_NXzCS6w_7_Rc9OH3a9Lv8hpjySZqxDglBFC-fTOdZHi-ODCihiEHlQD9nIhUmld5jYvRx_JvB0z2IAL0=@164.ooo>
 <064601d91f0e$b5521940$1ff64bc0$@abilitybusinesscomputerservices.com>
 <d84712ed-1504-4d54-a664-63713db570b6@iee.email> <20230103150814.neevxs7trmzfbi67@carbon>
In-Reply-To: <20230103150814.neevxs7trmzfbi67@carbon>
From:   Rudy Rigot <rudy.rigot@gmail.com>
Date:   Wed, 11 Jan 2023 11:23:50 -0600
Message-ID: <CANaDLWKuS4X5fyK7U0PTQTVrC2mAXf5b+TPyeBAsDPxNVJ3GDQ@mail.gmail.com>
Subject: Re: Request to remove Junio C Hamano as the Git Maintainer
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Because apparently, most users seem to have a problem with it.

I apologize for reopening a conversation that probably has already
gone on too long already (I won't particularly comment on the
misguided attempt this thread was initially started for), but I
actually have some limited data points about perception of Git that
could interest people.

I'm on the project at Salesforce to move our thousand+ of developers
on our 1-million-file monolith, from ~20 years of using Perforce, to
using Git. Obviously it's a legitimately painful move for some, so
when the project got funded as a top priority, there was a decent
amount of concerns expressed by people about Git's reputation of being
complicated to use. We noted it as an adoption risk of the project,
and we were sufficiently funded to drill into understanding that risk
for our user base, so we did.

For additional context, our user base is made of very diverse
technical comfort levels. We have interns whose knowledge of Git is
one chapter of one class they had last year; we have people who have
been working with Git at Salesforce on smaller projects for years; we
have people who joined recently and have been working with Git outside
of Salesforce for years; and we have people who have been working on
the monolith at Salesforce for 20 years and never had to get into Git.

Here are some interesting data points:
- Our beta went live in November, and we now have 600+ users who
onboarded. The perforce route is still being supported for now, and
there is no incentive to switch, so it's all organic adoption.
- We do most of our support on an internal StackOverflow instance, and
move the conversation to Slack when the conversation needs to be more
synchronous. We braced for having to support people through struggling
with Git situations, but that never really happened. We currently have
200+ StackOverflow questions from people using our product; but only
~5 of them are about struggles with Git itself. All others are about
the infrastructure and tooling we built around it to mitigate our
scale, or issues using our app's build tools, that people mistakenly
thought were related to Git because they happened to have recently
switched, but were not. The wave of supporting people out of Git
struggles hasn't meaningfully happened so far.
- We sat down with the customers with the loudest concerns to build
understanding, and so far my read is:
  a- A lot of concerns we've heard that can be legitimately attributed
to something that has usability downsides with Git related to
Perforce, also offer compelling upsides that seem to make them worth
the downside so far. For instance, Perforce versions per file so
people could "get latest version" on any file separately without
impacting their other files and their "status"; but when we explain
people the upsides of Git versioning the entire codebase at once,
particularly how the top root cause of local build errors have been
due to the perforce sync having silently failed on some files, which
can't happen with Git's approach, this kind of usability downside gets
really easy to justify.
  b- Most users we've heard strong concerns from are people with a lot
of seniority on core at Salesforce. A lot of their concern seems to
boil down to the legitimate loss of value of the perforce expertise
they've built over the years. It is a very legitimate concern, but
it's a concern we have chosen to disregard because we feel it ties too
strongly with reasons companies sometimes don't adapt, and the dangers
that come with it. In fact, the fact that the concerns are limited to
this kind of user profile tracks well with our initial feeling that
this move to Git would allow us to better include newcomers and
leverage industry-wide skills.

Obviously this is somewhat anecdotal, our user base is basing
comparative judgement on one alternative only (perforce), they have
other common needs related to the app itself being managed, and we
haven't yet issued a mandate for people to switch so a lot of
concerned people are probably hiding a bit until then. So, I'm not
sure how representative of the broader Git user base ours is. But if
one would consider that it is reasonably representative, then it would
fairly strongly disprove the notion that people have legitimate
systemic problems with Git itself.

Still, I hope those data points are interesting to some. They
definitely have been fascinating and surprising to me!

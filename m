Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E53C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEA266113E
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241194AbhHTPuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 11:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241313AbhHTPuj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 11:50:39 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59671C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:50:01 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so14761634oti.0
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dHezg9JRejdAGbm/50uguLenxsUc/rr7b+O8OpWhQBY=;
        b=oQcNIptshbRptY3HuUtNJHAdZ9EZc5fLHX6H9uP5qZu1zDqMQ7MhbLVDQxmQPHYZ0O
         /Q9M4BwieGLv7dT0Q/G/5w4OiDq4eulfz/ykH2ApYuyrsN1E5Oo5Jfqy6Rt+tW5BuU+u
         wcg6R6jHTlw8007cEjznWSLI2qWI8d76XsmwSPk1THErNA7dqe4pR2Qho56hO1XQ7YFO
         VbS1RXjl+8l8KMbvkayvhzSOlKjIGsN/xJMeryz4YOHd/mzh6vcl1jG/IDKdQaO2K0C+
         su+mb+pD5Ty9yf08NUtQ/pwG3YyKzReCAVSdbI6C/saPKxgF1XOgSj0SqkRCDouFFXf8
         1OUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dHezg9JRejdAGbm/50uguLenxsUc/rr7b+O8OpWhQBY=;
        b=eahVdTBSeoxq0BZJ/gxPi8rDesitwNm9L0bR5BkJId5RvnHw+o1OAnR1KHsu2G1G0J
         c6YDTInh4yze7DyWN1atYtkUxVy/8sRePu+v5azVl8y1re1QX/cahSKBjNcfkVCUg8DW
         +PG2PlqrBqT4m9Wp0rDVf8c2WcNEY2GXSZLPZUGaex29E/Gd2e7rdGZbJLztSGos9h/q
         V5Zk8xs1qsS1wBR9+SzP4MLR3z/9dfcHXFe1wLmegor2HRuICV4wEOqpBmnICgtYtKpW
         mvY3RP4OWYsay7hqRyKsF3Zc+lNjKF190hm3trUtpsO2PknuZRrWNaZFTAXswJWCVkHF
         oC3w==
X-Gm-Message-State: AOAM533zfGJSfx5rJpzV9MddDRMijl4EjiCN8fuTdUnQdD1J8sne8xci
        SNMLB8S0CLoqGUng1RzNb0U=
X-Google-Smtp-Source: ABdhPJyzwKrZrv8djtsvwLdaXbRgZQGgADovpMr8b1I9wz2L3WE7ShBmC5HfZtshPLj29g/f8HJrNw==
X-Received: by 2002:a05:6830:929:: with SMTP id v41mr16844900ott.16.1629474600611;
        Fri, 20 Aug 2021 08:50:00 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:f436:fc6f:2dd3:d49? ([2600:1700:e72:80a0:f436:fc6f:2dd3:d49])
        by smtp.gmail.com with ESMTPSA id u15sm1579927oiu.43.2021.08.20.08.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 08:50:00 -0700 (PDT)
Subject: Re: [PATCH v3 8/8] sparse-checkout: clear tracked sparse dirs
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        matheus.bernardino@usp.br,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
 <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
 <febef675f051eb08896751bb5661b6deb5579ead.1629206603.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2108191015260.55@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <643d67a9-054f-bc22-cf30-763fc082e9d3@gmail.com>
Date:   Fri, 20 Aug 2021 11:49:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2108191015260.55@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/19/2021 4:48 AM, Johannes Schindelin wrote:
> On Tue, 17 Aug 2021, Derrick Stolee via GitGitGadget wrote:
> This description makes sense, and is easy to explain.
> 
> It does not cover the case where untracked files are found and the
> directory is _not_ removed as a consequence, though. I would like to ask
> to add this to the commit message, because it is kind of important.

Right. I should have modified the message from my earlier version when
the issues with untracked files came up.
 
> The implementation of this behavior looks fine to me.
> 
> About this behavior itself: in my experience, the more tricky a feature is
> to explain, the more likely the design should have been adjusted in the
> first place. And I find myself struggling a little bit to explain what
> files `git switch` touches in cone mode in addition to tracked files.

Keep in mind that 'git switch' does not change the sparse-checkout cone,
and the activity being described is something that would happen within
'git sparse-checkout set' or 'git sparse-checkout reapply'.

> So I wonder whether an easier-to-explain behavior would be the following:
> ignored files in directories that fell out of the sparse-checkout cone are
> deleted. (Even if there are untracked, unignored files in the same
> directory tree.)
> 
> This is different than what this patch implements: we would now have to
> delete the ignored and out-of-cone files _also_ when there are untracked
> files in the same directory, i.e. we could no longer use the sweet
> `remove_dir_recursively()` call. Therefore, the implementation of what I
> suggested would be much more complicated: you would have to enumerate the
> ignored files and remove them individually.

Outside of "it's harder to write that feature", perhaps I could convince
you that it is better to do nothing in the presence of untracked files.

If a user has an untracked file within a directory that is leaving the
sparse cone, then that means they were doing something in that space and
perhaps has unfinished work. By leaving the files on-disk, they have an
opportunity to revert the change to the sparse-checkout cone and continue
their work interrupted. This includes keeping things like build artifacts
(that are ignored) so they can incrementally build from that position.

The general thought I have here is: having untracked, not-ignored files
in a directory that is leaving the sparse-checkout cone is an unexpected
behavior, so we should do as little as possible in that scenario.

It also makes it more clear to the user what happened: "You had untracked
files here, so we left them alone" is easier to understand than "You had
untracked files here, so we deleted the ones that were ignored and kept
the rest."

> Having said that, even after mulling over this behavior and sleeping over
> it, I am unsure what the best way forward would be. Just because it is
> easy to explain does not make it right.

Of course, you already have a retort to my claim that "simpler is better",
but I'll just focus on the point that "simpler for the user to understand"
is a different point than "simpler to implement".

> Which leaves me to wonder whether we need at least a flag to turn this
> behavior on and off? Something like
> `core.ignoredFilesInSparseConesArePrecious = true` (obviously with a
> better, shorter name).

You are right that there are a lot of users out there, and they have
very different habits. Those habits are shaped by the way Git has worked
for a long time, so adding a way to go back to the previous behavior
would be good to have.

Thanks,
-Stolee

Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8892C10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 12:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F9A20578
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 12:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ejlf5Doh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgCOMU3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 08:20:29 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43053 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgCOMU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 08:20:28 -0400
Received: by mail-qk1-f193.google.com with SMTP id x18so1074952qki.10
        for <git@vger.kernel.org>; Sun, 15 Mar 2020 05:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8CKGpcahL3yvKsKmtI5RVrswri3mlS/deSFu/h7cgRM=;
        b=Ejlf5DohdjmDOER3b9NRKX9lkX7hfoXdkGE0yr6Eyjxb/1QNjvwiglqbzetd9ysBEQ
         Zrro4xqKj6v49Ou6EjncxU9n4Yydwy2r3x8Kz8IAbiy/INBWF0avQdiyDN6nL5TJ8AmL
         EHl9ARVf/lW0HvlEAHVANnDCU55czvarOYRZOf6mN4LNrpHr8Hn0SOx0VPUsTIGI8VxE
         /q8IKCGbsH08fqJC6v6hAPjHFFrcW0rdoztjjC1cjIg08uxv/Pn5Gzp/9hHP2de1HsDH
         xNW0a6MtK3PeZXzXBBGt1h+Bw/jnUVUmCoj7oW4hLzg9lxwGPZV20xjXbNSTnAWG8+SR
         HbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8CKGpcahL3yvKsKmtI5RVrswri3mlS/deSFu/h7cgRM=;
        b=QFpKK5EyyGFJzN094c30s6g90hoZDLlXbRt2D3xAoWXubifFW7ihokHSFw1dasjTcr
         aqlVU0cA7DOIQsfSVCeZiTZgAv8IF71tMwI63jNx76sE+nzsstb9L/LY7Qw3Wl+kaJKo
         7ggqefYkbOf5pbL8gRsQDGkqkKOd+9iZ1gJRgutFuIr2jmhaJXRh02niMyul+bNTMHdj
         CHE/RtWJ6EwmhHkzKdiCS9gKLLhBKeacuiqPESjw7graT+2sbtg/rWSVZUAbllQjqF0k
         +2n+rZ5CBE0kND0g4CiUFjkJhAxxIdpZJPxsNMvB9tx9mR/LGrETn6Qy3epjfYOTppy9
         YO5w==
X-Gm-Message-State: ANhLgQ2ZlBm6bv5daNoNtiUq002479UtIgjSGRLld8fwbXO89DJ3bFq2
        RMFafE7VB8lbupUiS5OXFyM=
X-Google-Smtp-Source: ADFU+vtj0Z6WouxmVcbEfcCi2AehedQe72WQz/RzbLE4h3tdFUeF0pcAUD3BykbrXswu6ezqmaQSkw==
X-Received: by 2002:a37:67c1:: with SMTP id b184mr9231120qkc.307.1584274827050;
        Sun, 15 Mar 2020 05:20:27 -0700 (PDT)
Received: from [192.168.1.76] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f16sm6791176qtk.61.2020.03.15.05.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2020 05:20:26 -0700 (PDT)
Subject: Re: [PATCH] clone: use --quiet when stderr is not a terminal
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
References: <pull.581.git.1584133742475.gitgitgadget@gmail.com>
 <xmqqh7yqc16w.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a044478f-ca04-3475-90de-0332e80f552d@gmail.com>
Date:   Sun, 15 Mar 2020 08:20:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:74.0) Gecko/20100101
 Thunderbird/74.0
MIME-Version: 1.0
In-Reply-To: <xmqqh7yqc16w.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/14/2020 1:10 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> "git clone" is used by many build systems to download Git code before
>> running a build. The output of these systems is usually color-coded to
>> separate stdout and stderr output, which highlights anything over stderr
>> as an error or warning. Most build systems use "--quiet" when cloning to
>> avoid adding progress noise to these outputs, but occasionally users
>> create their own scripts that call "git clone" and forget the --quiet
>> option.
>>
>> Just such a user voiced a complaint that "git clone" was showing "error
>> messages" in bright red. The messages were progress indicators for
>> "Updating files".
>>
>> To save users from this confusion, let's default to --quiet when stderr
>> is not a terminal window.
> 
> This is the kind of behaviour change that makes me (and probably
> others who have been with the project long enough) to say "it is
> certain that some other users and tools are relying on the current
> behaviour and their expectation, when explained, would look just as
> sensible, if not more, than 'any output to the standard error stream
> is an error', which is the justfication given for this change."
>
> I would not be surprised if a GUI program is counting the bytes
> coming to the progress output to show the equivalent with bits on
> the screen, for example.  They would say "Git has always given
> progress output to the standard error stream.  We, as any other
> sensible folks, know that they are not errors and won't give a
> misleading and alarming messages in red.  We could change our
> program to pass --progress but why should we be the one who are
> forced to do such a change", and I do not have *any* excuse I find
> sensible enough to give them.

You are absolutely right. Tools should do the right thing, and users
creating their own scripts should understand the output of the
commands they are calling.

And I was coming back to this thread shortly after waking up since
I realized why the test fallout was bigger than I anticipated: this
change shouldn't enable "--quiet" but instead "--no-progress". The
loss of messages like "Cloning from ..." is actually a problematic
behavior change.

I'll send a v2 using "--no-progress" instead.

> I do not mind queuing this (or any similar backward compatibility
> breaking changes) and merging it down to 'next', but if we were plan
> to have it in a tagged release, I'd prefer to keep it in 'next' for
> at least a few releases before doing so, and under three conditions:
> major organizations and those who build tools around Git promise me
> that they adopt 'next' for their developers and users early, and
> that they actively measure and report potential damages before it is
> advanced to 'master', and that they won't let their users complain
> after it hits a tagged release.

I understand that this is low-priority. This idea of adapting "next"
early is interesting to me. It is likely difficult to deploy that
branch to CI/CD systems, but I have been thinking of ways to
automate our integration process in microsoft/git (and Scalar and
VFS for Git) so we find the behavior changes and pain points a lot
sooner. I'll see what I can do on this front in the coming weeks.

> If the world and userbase were like today back when "clone" learned
> the --quiet option and showing the progress meter 15 years ago, I
> suspect that we may have chosen this way from the beginning, though.

I appreciate your perspective here. I will not be upset if this
change is rejected due to backward compatibility concerns. It's
tricky to update the user experience around these well-established
features like "clone".

Thanks,
-Stolee

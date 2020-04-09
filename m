Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49514C2BA19
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 17:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE3020768
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 17:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2gjDOih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgDIRVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 13:21:00 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37656 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgDIRVA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 13:21:00 -0400
Received: by mail-ot1-f67.google.com with SMTP id g23so11281322otq.4
        for <git@vger.kernel.org>; Thu, 09 Apr 2020 10:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8gLg25FH5hDyLa81K7UPCkFChkFT7d291VSfnVc7nT0=;
        b=d2gjDOihG3aB6DFuL/I5Oblfo9BReD2k7Z2E0EzkyfcIq+IMXzfIukmZ/2Iiu80am0
         PWQ7eG24os5tfRXzbiypnQXfRx0Lf3Ka27nrpgu/fzojO8ARKCuM0bNboRos0z0Gpzwf
         5YI3UfuUPWF9U2AUZ4a3HrzONeCjHUoNc0W5WBzTNUFEPeJozNpMlnGD9qhC8yHQVJBd
         9ng8Iia13piMdBqRwzjQy6UTmRJnRYsgPoVMV5EG5JHaBzWJwdYi1jVXRDj/gFOTD5cW
         0cgFf+undwve5jq/+lqAzFEWJorpJzoxxCdcWIQdp37N9fCvYMN+v7wGJHz3U7oAXc2m
         qqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8gLg25FH5hDyLa81K7UPCkFChkFT7d291VSfnVc7nT0=;
        b=Xl2pqaZPKYLeSX+l8anCsb1nqp67u6c3Z+RtCmBH8gr+xOhlJ9yBEUHLlWzyxv/Lmm
         nAWneVR3+MrYyWdjL7ho7cEMdK5HvlFavAv5/xxzdTC8uvo7EfW60uoM31C2HoOlVRUj
         FgHnvJQaMRTT7qGhY+W4YU8nMPAt8YKMe/yF1B7GO6Of8Fts+BhLayvGn+u9/o3AeEBP
         T06n7meSG4EYwswEE2xY2/e2Gbyo9zWs0PNY9CU+rp6BPDyrJ7fO1Id3ZHhH1W9yhs/l
         saskIxzxqtvpt/VE0cnrEME1VQplMJazSBzpbBUS3wLlWYSq4UiuS6nTq54Xo420V3N3
         HQSg==
X-Gm-Message-State: AGi0PuYhLY3F827kTgVQGTMePUjWrVRb321CYzV5V4UA5GSuDyWKweax
        xReeiGlJqRAoKF0zrFLgi8U=
X-Google-Smtp-Source: APiQypJ6GY/lMjjbessC95pKZ7v8ZrkBrFkWXjLu2nXeZIXrepOdTm3EskS3+lR9kx0WDgOk7wHaBg==
X-Received: by 2002:a05:6830:1c38:: with SMTP id f24mr816181ote.328.1586452859742;
        Thu, 09 Apr 2020 10:20:59 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 89sm7088613otj.66.2020.04.09.10.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 10:20:59 -0700 (PDT)
Subject: Re: [PATCH] revision: --include-diversions adds helpful merges
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.599.git.1586308923544.gitgitgadget@gmail.com>
 <xmqqv9mapxw9.fsf@gitster.c.googlers.com>
 <5f1c6868-303c-ccc1-553e-e54d0fa8e24f@gmail.com>
 <74562b04-b1ce-cad4-da18-4af030a3dc29@gmail.com>
 <xmqqzhbloj4u.fsf@gitster.c.googlers.com>
 <20200408200526.GA2270445@coredump.intra.peff.net>
 <9eab6c60-3c99-d6ac-9206-02ce37f7a479@gmail.com>
 <xmqqv9m9oe2p.fsf@gitster.c.googlers.com>
 <91fafa17-c58f-dcd0-320d-48c4512561f6@gmail.com>
 <xmqqimi9o705.fsf@gitster.c.googlers.com>
 <7d84fc45-786f-7a2e-5889-ef26916627ef@iee.email>
 <xmqqeeswodol.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <63667043-dbca-0092-209d-865c2f60efc8@gmail.com>
Date:   Thu, 9 Apr 2020 13:20:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <xmqqeeswodol.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/9/2020 11:56 AM, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
> 
>>> Yes, but "redirect", "switch", "detour", or "divert" do not quite
>>> mean "merging in a real change", at least to me.
>>>
>>>> I'll just submit my v2 as-is, which includes a significant change to
>>>> the documentation that should make things more clear.
>>> Thanks.
>> Can I suggest "--side-merges" as a possible descriptor for these
>> non-mainline diversions?
>>
>> My thesaurus had suggested detour and sidetracked, which led to the
>> side-merge view.
> 
> Ahh, sorry Derrick for being slow and thanks Philip for repeating
> "diversion", as the word did not click for me at all when I saw the
> patch and wrote my response.
> 
> But I think it started slowly to dawn on me.  
> 
> Does it come from the worldview where we want to follow the "trunk"
> but because when we notice at a merge that we got everything that
> matters to us from a side branch, we switch the track out of the
> mainline and from then on follow that side branch?  Switching the
> track and following the side branch happens silently with the
> default "history simplification", but the new feature shows where
> that side-tracking happens more prominently---is that where the
> words "divert" etc. come from?
> 
> Then I can understand how these candidate words may have place in
> describing the situation we want to use the feature; I am not yet
> convinced any of the concrete option names floated on the thread (or
> what I can come up with right now) would be clear to our target
> audiences, but at least I am not as confused as I was before.

After thinking about all the great responses here, and having a
chat with Dscho about this, then taking a break, I had an "Aha!"
moment. We should call this option:

	--show-pulls

The direction here is important. Let's look at a potential
"git log --graph --oneline" output to explore this idea:

	* (master) A
	|\
	| * (feature) B
	| |\
	| | *   (topic) C
	| | |\
	| | | |
	| | * | D
	| | | |
	| * | | E
	| | | |
	* | | | F
	| |_|/
	|/| |
	* | |   G
	|/ /
	* /     H
	|/
	*       I

I use (master), (feature), and (topic) to decorate branches
that are updated only by "git commit" or "git pull". The
file 'foo' was created by commit I.

In this graph, the single-parent commits G and D change 'foo'.
The commit G enters master using "git commit".

The commit G enters topic using "git pull" starting from D. The
developer on that branch resolves conflicts by taking the version
of 'foo' from D. Thus C is TREESAME to D but not G.

The commit B is created by running "git pull topic" from the
feature branch.

The commit A is created by running "git pull feature" from the
master branch.

Thus, A and B "pulled" the change into their branches. The
commit C "pulled" G into the branch, but did not keep the change
to 'foo'.

Thus 'git log --graph --oneline master -- foo' would output:


	* D
	* I

'git log --graph --oneline --show-pulls master -- foo' shows:

	* A
	* B
	* D
	* I

'git log --graph --oneline --full-history -- foo' shows:

	* (master) A
	|\
	| * (feature) B
	| |\
	| | *   (topic) C
	| | |\
	| | | |
	| | * | D
	| |_|/
	|/| |
	* | |   G
	|/ /
	| /
	|/
	*       I

'git log --graph --oneline --full-history --simplify-merges -- foo'
would show:

	*   C
	|\
	* | D
	| |
	| * G
	|/
	*   I

'git log --graph --oneline --full-history --simplify-merges --show-pulls -- foo'
would show:

	* A
	* B
	*   C
	|\
	* | D
	| |
	| * G
	|/
	*   I

In conclusion, I think "--show-pulls" provides the right context for these
extra merges to show in the history view. It also roots these merges in a
Git-native name (that also happens to evoke the "pull request" concept that
is _not_ native to Git).

What do you think?

Thanks,
-Stolee

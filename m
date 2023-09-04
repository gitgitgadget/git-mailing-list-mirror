Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E2ECA0FE3
	for <git@archiver.kernel.org>; Mon,  4 Sep 2023 10:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238199AbjIDKFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Sep 2023 06:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237326AbjIDKFb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Sep 2023 06:05:31 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2F819B
        for <git@vger.kernel.org>; Mon,  4 Sep 2023 03:05:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so1069815f8f.3
        for <git@vger.kernel.org>; Mon, 04 Sep 2023 03:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693821924; x=1694426724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tdkz9Q5MDP9+vJ1ko6uPWRWbT+wRHtGGCcVfwlKPhhI=;
        b=rOJHkHNZz1+jqZScqC99rzGC/5UcdzwQ7QdH44yWd9vz7ZYvhAV3svzj9x71t3JbsN
         X3+/ZQrtTEmldH3HWDyCUcsvXDUh27vjRv5i+cyi6HWJty/5WUt1asRvPzKFh766wnlc
         S+SfaieChRC3JFHZ3DRWfNjltRvgTNHFJ9XR99M3bkh6YvpE8RgVYdXIda5HXXEmZNez
         huxS7PDp0o0rJRWnc7qhnyS/DoTQBer62dkpShDY1k0YmBJlxu+toGc1/r72mahqY/RM
         ob28Ar89bFJRKY4iFJFi5kKekP6N7671afsmdOOTor68+eUP76uNNSjprpOFxK0Fuh3Q
         KApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693821924; x=1694426724;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tdkz9Q5MDP9+vJ1ko6uPWRWbT+wRHtGGCcVfwlKPhhI=;
        b=US87N6sOjQzJ+wI3PAEgxJ317Oz6t4VXKho9/3xo/p5+puj9m9AJibYqMbuVloW5y3
         DUFAocwxLjzWybTPQxhHssUsxSC065tH8ahDBC2flUjPZIYw7ngLM76hGhGtkM3YcBOr
         2nCgJYNJXwm46zOF/QxdVxYSEi3TVpjoBM5nQ3HZV2/xsIYXuUTE3IPFZ5n+qeTXZlQO
         0Bza7mvJ2nVQSCPZ4CJLMQ5rTEsj+MkMR8PZs5I4x90rHUS9BwiSIP3eT4ImIa7Z0rZi
         ceV3J1rtIE7oEMM6iXBRAZGB0CnFlB+biq3600tyyYA46LS35Zna17ADgHURGiV32dZO
         xmSw==
X-Gm-Message-State: AOJu0Yz5FjbcH7oqfgfCQhuviG3UO5GucntxPjAe+mwl04yhUvfxQZUO
        9oXpBT+h0Tux9zMuFRry7LM=
X-Google-Smtp-Source: AGHT+IFpI/4TYCpRUWzdbdxMIARsXYwzaemHMQuvyoTB2e0CJG6yLPpZIfVZKM/wN/X3sB7cc/l7Jw==
X-Received: by 2002:a5d:560a:0:b0:317:e5ec:8767 with SMTP id l10-20020a5d560a000000b00317e5ec8767mr6792235wrv.21.1693821923391;
        Mon, 04 Sep 2023 03:05:23 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id x16-20020adfffd0000000b0031c8a43712asm14083307wrs.69.2023.09.04.03.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 03:05:23 -0700 (PDT)
Message-ID: <4e0628ab-c39c-410d-864b-b7c74f9e04b1@gmail.com>
Date:   Mon, 4 Sep 2023 11:05:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: update abort safety file more sparingly
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20230903151132.739166-1-oswald.buddenhagen@gmx.de>
 <29fb7a38-1e92-457a-93ff-0e64ac09b907@gmail.com> <ZPTdmnHfDcTBqaSl@ugly>
 <fdf80c36-0e28-44f3-9cef-85d38d2d48f1@gmail.com> <ZPTqEIvW3zJ4eafT@ugly>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ZPTqEIvW3zJ4eafT@ugly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/09/2023 21:18, Oswald Buddenhagen wrote:
> On Sun, Sep 03, 2023 at 08:48:14PM +0100, Phillip Wood wrote:
>> On 03/09/2023 20:25, Oswald Buddenhagen wrote:
>>> On Sun, Sep 03, 2023 at 07:40:00PM +0100, Phillip Wood wrote:
>>>> it only matters for "cherry-pick --skip"
>>>>
>>> that doesn't seem right. a --skip is just a --continue with a prior 
>>> reset, more or less.
>>
>> sequencer_skip() calls rollback_is_safe() which checks the abort 
>> safety file.
>>
> that's weird. can you think of a good reason for doing that?

I think it is clear from the code - so it does not reset changes after 
the user has committed the conflict resolution.

>>> i'll try to find a better "choke point".
>>
>> I think that is probably tricky,
>>
> yeah
> 
>> I'm not really clear what the aim/purpose of this refactoring is.
>>
> to make my head not explode.
> more specifically, to get it out of the way of the rebase path, which is 
> what i'm actually concerned with.

rebase and cherry-pick share the same code path most of the time. In 
particular "cherry-pick --continue" and "rebase --continue" both use 
sequencer_continue() as their entry point so I think the best you can do 
is guard the calls to update_abort_safety_file() with "if 
(!is_rebase_i(opts))" or add "if (is_rebase_i(opts)) return" to the 
start of update_abort_safety_file().

> generally, i think this whole ad-hoc state management is a nightmare, 
> and i'd be surprised if there weren't some more loose ends.
> i think i'd aim for an object-oriented-ish design with an encapsulated 
> state, lazy loading getters, lazy setters, and a commit entry point (or 
> maybe several partial ones). no idea how that would play out.

I've been working on something similar to only write the state to disc 
when the sequencer stops for user interaction. I'm hoping to have the 
first set of patches ready to submit in the next development cycle. You 
can see the branch at [1]. It is very much a work in progress at the 
moment, the code is mostly OK (I'm running it in my git build) but some 
commits are empty, others need splitting and the commit messages need a 
lot of work. The basic idea is to add a private struct that holds the 
state and write that to disc when pick_commits() returns.

Best Wishes

Phillip

[1] https://github.com/phillipwood/git/commits/wip/sequencer-context

>>> if you did a fresh commit before or after the single pick, you'd lose 
>>> it.
>>
>> Oh, I can see that you'd lose a commit made before a single pick but I 
>> don't see how you'd lose a commit made after it.
>>
> right. thinko. it's a bit late here. ^^
> 
> regards


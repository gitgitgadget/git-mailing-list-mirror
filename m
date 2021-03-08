Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5B1C433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8700E65285
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhCHUdi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 15:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhCHUdV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 15:33:21 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEF8C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 12:33:20 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id i9so296419wml.0
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 12:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VL4zd6HeJ1u4890NOgg7S0uKN6KiY/7Rk0JwBSu/YVQ=;
        b=uGzhgtjENQ2e8Od7P6rOMhLkWEjze9sUZP0lfdakBGtNHPRgund5S9FaRZM4sPSvoO
         K1I0Edd3cXvZoRY9bp5VVd4nZBJGrInW/UM17zfrdX5m1iZ7/4zc06UzeBll4A50PF8c
         KTsGSb1clIqxOrbnnzb6shA+Kf5cyrVn5oskzmf6TwE4v83mlucrBJ+agNx4aYuARhOT
         R38Rrvfn9iqu6J1lc8jrJ6/Dh+scflbUTy77JzxKVNog8MKIY+uWKF9lKQeznBiAArsc
         7NY0cRP8Yv6qTn0z6Qf5B1wpAsUkn+mrcWDZVxb5t2tY41/N5Ow8vLVvz/YGOX/oDHsI
         fH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VL4zd6HeJ1u4890NOgg7S0uKN6KiY/7Rk0JwBSu/YVQ=;
        b=D+Ay7saSezZqTn9pM+IY8TTBQWpZM4hoXBbn7YELCxO/DVmNj4QT87uG5z6J9wGVh/
         Vm5B2gdvZP7BOBDQc6o9JYNi9bOZ6g5OdPVUnZiDMa60j38N95u4qyjyALy769dbEYjr
         2A29M4H9kjiaYhNGFRgsx8WN9jX8UsmhTSz2xsZq05DiIWcPGocQyA+JmtZGNM5clv/+
         xBuC83tg7r4qeXmEZfVTHhSo9LQqiU+H/oId7iJlZgavTJWi/y074FmJNwW1QLFs+Mo9
         42ks+4i/ripJAZcBfUHnGsk/KIk5k5Bf4xnkNCI04cIs6vUibRXxVWfT0N4OxOFtBpnX
         moWg==
X-Gm-Message-State: AOAM530B/CckTWWQM6d616Ut7hR58pe8LIUVMFq5FK8/K7UfDzlxEqQM
        CN5jaVpH1Xts76nxEWOSTKs=
X-Google-Smtp-Source: ABdhPJxEDRXv76FXKKmy2ZikTH+GxdY/38PbVx3ymW+E46114a9JJz+jRPboAWOT3s9K5psaNRe2Gg==
X-Received: by 2002:a1c:e041:: with SMTP id x62mr498574wmg.95.1615235599558;
        Mon, 08 Mar 2021 12:33:19 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-654-1-330-85.w86-199.abo.wanadoo.fr. [86.199.217.85])
        by smtp.gmail.com with ESMTPSA id 9sm607240wmf.13.2021.03.08.12.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 12:33:19 -0800 (PST)
Subject: Re: [PATCH v6 06/13] merge-index: don't fork if the requested program
 is `git-merge-one-file'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
References: <20201116102158.8365-1-alban.gruin@gmail.com>
 <20201124115315.13311-1-alban.gruin@gmail.com>
 <20201124115315.13311-7-alban.gruin@gmail.com>
 <44c9189d-9d2f-c437-d0d6-9529708d2c99@gmail.com>
 <411b68ad-dee5-5a19-ae94-c2b6a249161a@gmail.com>
 <xmqqv9cax1le.fsf@gitster.c.googlers.com>
 <f7d7cc3b-b53d-ed48-8aa4-2b26a0ce7da3@gmail.com>
 <xmqqzh1g8qhd.fsf@gitster.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Message-ID: <0371a283-61a4-b4d4-0909-5ce4b3cb2485@gmail.com>
Date:   Mon, 8 Mar 2021 21:32:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqzh1g8qhd.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 10/01/2021 à 21:51, Junio C Hamano a écrit :
> Alban Gruin <alban.gruin@gmail.com> writes:
> 
>>> These days, there exists an optional installation option exists that
>>> won't even install built-in commands in $GIT_EXEC_PATH, which
>>> invalidates the assessment made in 2019 in the article you cited
>>> above, so the code might still be OK, but the old justification no
>>> longer would apply.
>>>
>>> In any case, if two people who reviewed a patch found the same thing
>>> in it fishy, it is an indication that the reason why the apparently
>>> fishy code is OK needs to be better explained so that future readers
>>> of the code do not have to be puzzled about the same thing.
>>
>> Perhaps we could try to check if the provided command exists (with
>> locate_in_PATH()), if it does, run it through merge_one_file_spawn(),
>> else, use merge_one_file_func()?
> 
> So you think your current implementation will be broken if the "no
> dashed git binary on disk" installation option is used?
> 
> I do not think "first check if an on-disk command exists and use it,
> otherwise check its name" alone would work well in practice.  Both
> the 'cat' example that appears in the manual page, and the typical
> invocation of git-merge-one-file from merge-resolve:
> 
> 	git merge-index cat MM
> 	git merge-index git-merge-one-file -a
> 
> would work just as well as before, but does not give you a way to
> bypass fork() for the latter.  And changing the order of checks
> would mean the users won't have a way to override a buggy builtin
> implementation of merge_one_file function.  Besides, using the name
> of the binary feels like a bad hack.  
> 
> As the invocation from merge-resolve is purely an internal matter,
> it may make more sense to introduce a new option and explicitly tell
> merge-index that the command line is not asking for an external
> program to be spawned, e.g.
> 
> 	git merge-index --use=merge-one-file -a
> 
> You'd prepare a table of internally implemented "take info on a
> single path that is being merged and give an automated resolution"
> functions, which begins with a single entry that maps the string
> "merge-one-file" to your merge_one_file_func function.  Any value to
> the "--use" option that names a function not in the table would
> cause an error.
> 
> Note that in the above the "table of functions" is merely
> conceptual.  It is perfectly OK to implement the single entry table
> by codeflow (i.e. "if (!strcmp()) ... else error();").  But thinking
> in terms of "a table of functions the user can choose from" helps to
> form the right mental picture.
> 
> Hmm?
> 

Yes, this should work.

To achieve this, I think I have to reorder this series a bit.
Currently, this is what it looks like:

 1. convert git-merge-one-file;
 2. libify git-merge-index, add the ability to call merge-one-file directly;
 3. convert the resolve strategy;
 4. convert the octopus strategy.

After the reorder, the series would look like this:

 1. libify git-merge-index, add `--use=merge-one-file', change
git-merge-resolve.sh, -octopus.sh, and t6060 to use this new parameter;
 2. convert git-merge-one-file, add the ability for merge-index to call
it directly;
 3. convert the resolve strategy;
 4. convert the octopus strategy.

Alban


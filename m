Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966B6C6FD1D
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 16:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjDGQiN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 12:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjDGQiM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 12:38:12 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2147E7E
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 09:38:10 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id kx12so1527439plb.12
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 09:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680885490; x=1683477490;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XdyHdXgFCbu/XWqF0lTxD7qNwq9pSsmulmVllxiUKo0=;
        b=C0qM0hEDdRS7ih7vx9zf0Zrb+6gqfxWpCH3sY4pf0ArpPMcHhklKsP6FZt2t35eHHZ
         4ycuMRnmg9axLD99OFRl0kW70NG62S1NgE6AzqbySTsS+FlMNSL2iFmneNqaqgId6B5u
         5iPAffULnSXQDQAV23qR5vp2OIWbT4wa5XkrqL0y/j1xc6x0HDc+6gVKtOuNQqljAI2e
         VwY10beTkf38bHGTRstj/W7wgjUMYgQryzdeStWZPfU85R3oTx7qtjjzqPPMnZxnpxxT
         +xHPTSli33pok+WeldrgyfIkVHcBYbwdAwlpsadPWTUWarV9MwU/I41c2aGEcwNuLCe2
         LYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680885490; x=1683477490;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XdyHdXgFCbu/XWqF0lTxD7qNwq9pSsmulmVllxiUKo0=;
        b=Fg8pbt8585vUeBiPaTbzyOaaWzf6SxtfNGmpGQFDhkf+Ax3uPpNqL3NCT3WGI5KsBc
         yTWC/2Hb+J8EnE7Fe+RliIR6pAPc2H1XKTGUTmvSxYbvOkq59aYGK2ZVKob8hnNuud2a
         Yy9yhW6B68Qd4G7rFIEryXN8IDGuXQq9H/33Fg4mqdA92h0Bils4ydk4yhmR/FbETplK
         d5XQb4+NB0ryW0z3ZMEfnyz93RI0kNKexpmEcji66KJ6Wzyv7OPkgo1788Xdx8DipsX8
         u7J77NI5Dwdqj+Tz45gSK/3dOT7eNxov4u/i/mrgul9XNFi4BVtR3+mXosuNUF75hlV4
         z58A==
X-Gm-Message-State: AAQBX9eTEfX3320Y6lnzJa/ZjALuMvU5TDW3f61hiHfDLzxlq7lgNWT+
        orXagkuCAHXxaHnYkMXxzhE=
X-Google-Smtp-Source: AKy350Z6KMV5YI0/tFtVC3ctOxb/9C3rU+SN4MBTDFfNGS2CHW1UdqRJMERzyp1kOuUJczIk8saw5Q==
X-Received: by 2002:a05:6a20:6594:b0:db:520c:430a with SMTP id p20-20020a056a20659400b000db520c430amr3005238pzh.38.1680885490154;
        Fri, 07 Apr 2023 09:38:10 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id y7-20020aa78047000000b00628c0988d94sm3264855pfm.55.2023.04.07.09.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 09:38:09 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        William Sprent <williams@unity3d.com>
Subject: Re: [PATCH v2 1/2] builtin/sparse-checkout: remove NEED_WORK_TREE flag
References: <pull.1488.git.1678283349.gitgitgadget@gmail.com>
        <pull.1488.v2.git.1679903703.gitgitgadget@gmail.com>
        <4b231e9beb43e4fac6457b9bf86e4c1db39c4238.1679903703.git.gitgitgadget@gmail.com>
        <xmqqr0taaxrr.fsf@gitster.g> <20230407161655.GB3117@szeder.dev>
Date:   Fri, 07 Apr 2023 09:38:08 -0700
In-Reply-To: <20230407161655.GB3117@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Fri, 7 Apr 2023 18:16:55 +0200")
Message-ID: <xmqqttxrk5qn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>>                 struct option builtin_sparse_checkout_options[] = {
>>                         OPT_SUBCOMMAND("list", &fn, sparse_checkout_list),
>>                         OPT_SUBCOMMAND("init", &fn, sparse_checkout_init),
>>                         OPT_SUBCOMMAND("set", &fn, sparse_checkout_set),
>>                         OPT_SUBCOMMAND("add", &fn, sparse_checkout_add),
>>                         OPT_SUBCOMMAND("reapply", &fn, sparse_checkout_reapply),
>>                         OPT_SUBCOMMAND("disable", &fn, sparse_checkout_disable),
>>                         OPT_END(),
>>                 };
>> 
>> yet we have to sprinkle setup_work_tree() to all of these functions'
>> implementation.  If we were able to describe which selected ones do
>> not need the setup call, we could let the parse-options API to look
>> up the function and then before calling "fn" we could make the setup
>> call.  That would allow us to maintain the subcommands much nicely.
>
> It's easy enough to do in this particular case: there is an
> OPT_SUBCOMMAND_F() variant which takes an additional flags parameter,
> so we could add a PARSE_OPT_SETUP_WORK_TREE flag, check it in e.g.
> parse_subcommand(), and act accordingly if it's set.
>
> However, this wouldn't work when the command has a default operation
> mode and is invoked without any subcommands.  And I'm not sure about
> doing this in parse-options, because it's about, well, parsing
> options, not about doing fancy setup stuff.

Yes, exactly.  What I was imagining was more along the lines of

	parse_opt_subcommand_fn *fn = NULL;
	parse_opt_subcommand_fn *fn_with_setup = NULL;
	options[] = {
		OPT_SUBCOMMAND("list", &fn_with_setup, sparse_checkout_list),
		...
		OPT_SUBCOMMAND("check-rules", &fn, sparse_check_rules),
	};

	parse_options(...);

        if (fn_with_setup) {
		setup_worktree();
		fn = fn_with_setup;
	}
	fn(...);

But of course as a "safety" measure, one options[] array can all
point at the same "fn" variable or parse_options() becomes unhappy,
so the above does not work out of the box.

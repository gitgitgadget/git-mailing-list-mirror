Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72DDC433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 14:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6E5E610CD
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 14:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbhDJORv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 10:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbhDJORu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 10:17:50 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE38C06138B
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 07:17:35 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id 12so8368688wrz.7
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 07:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cgPM8kQ+45FVxtUjYoUXEHeCUfH+qteknYwLMGAdQis=;
        b=P3tRPBZNcooi1lffKM+fMXiv52P/6gLR4ILqVNeMxEfeBGLMcd7vLfVLEdZvKwWxo+
         rJWgKu9DfdCf/uyrIiuFc3UUCD0uw4EeWhX9ObNZyEBJOcGYtayJSwc+eeoadWU6eLrp
         7N22wZF7dIOTIQnuotHLRlyW0lMS3Rxmyp2CIamW9KHFvI/4ql0XyX2t2VQ3Py6p/K02
         Wf2+SMp7pot4K9GNDgG0HEonDFXvynBxEDnyWUr7wVEPZVnykdp88SGJQbEqGA98JNqn
         RGvgcIshn+9X+5uIImo3ARGu8ICshBjfWDAowCCv+mMwGvpQ4OkJwCobEYILEjFzjIlO
         E19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cgPM8kQ+45FVxtUjYoUXEHeCUfH+qteknYwLMGAdQis=;
        b=sc4nT6d2K/xbinXNMuriqWAXlm9/MGIFfiVtI3n9kfs9Bvn/fgDdl9D4TL3z3dbSKw
         ColFuBHUwoX7VgZqswQPyAo1SvPYAZeJe1oS/gsIm7Id0iNVgGpJtC5BsyVT3v/OOiN3
         nFAHaTthJIxmHHCASN/oSqX0rzVwO/eQ3tA/go5e5Ruoh8/sCOXsMmwRw2d/mwSi+v9l
         ujt453IqIyolGxaLl+2BHnfX1/AblAX57FJFy7z4Spu0/BVehjn99EsbU4AUsvXuSXuN
         745UiGDddeLQiKVYRDqn8rdAw/PWoORtx1tD9cMowhcL8jYCJoqOZI7rpfKz0lGlE0SD
         Mdig==
X-Gm-Message-State: AOAM530iMUY4IhvJnq88KcweKDd8gPHR0Nr58Uu41ksFltxCB8le8+87
        16r+BqpmgSOQ+uu5aV+ESIk=
X-Google-Smtp-Source: ABdhPJwe9ypus0w7zudYS24SO2xZX/BibHpa0w0hBG53bxL/hTfDdwAj66Lt3kxKrsSWpv9RRk6T7w==
X-Received: by 2002:adf:f504:: with SMTP id q4mr6794224wro.304.1618064254021;
        Sat, 10 Apr 2021 07:17:34 -0700 (PDT)
Received: from [192.168.0.104] (abayonne-651-1-48-7.w92-156.abo.wanadoo.fr. [92.156.201.7])
        by smtp.gmail.com with ESMTPSA id f24sm7826936wmb.32.2021.04.10.07.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Apr 2021 07:17:33 -0700 (PDT)
Subject: Re: [PATCH v7 09/15] merge-resolve: rewrite in C
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
References: <20201124115315.13311-1-alban.gruin@gmail.com>
 <20210317204939.17890-1-alban.gruin@gmail.com>
 <20210317204939.17890-10-alban.gruin@gmail.com>
 <nycvar.QRO.7.76.6.2103232257590.50@tvgsbejvaqbjf.bet>
From:   Alban Gruin <alban.gruin@gmail.com>
Message-ID: <025aad24-68e3-295b-1e3b-2a7250807276@gmail.com>
Date:   Sat, 10 Apr 2021 16:17:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2103232257590.50@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Le 23/03/2021 à 23:21, Johannes Schindelin a écrit :
> Hi Alban,
> 
> On Wed, 17 Mar 2021, Alban Gruin wrote:
> 
>> diff --git a/merge-strategies.c b/merge-strategies.c
>> index 2717af51fd..a51700dae5 100644
>> --- a/merge-strategies.c
>> +++ b/merge-strategies.c
>> @@ -272,3 +275,95 @@ int merge_all_index(struct index_state *istate, int oneshot, int quiet,
>>
>>  	return err;
>>  }
>> +
>> +static int fast_forward(struct repository *r, struct tree_desc *t,
>> +			int nr, int aggressive)
>> +{
>> +	struct unpack_trees_options opts;
>> +	struct lock_file lock = LOCK_INIT;
>> +
>> +	refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
>> +	repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
> 
> Shouldn't we lock the index first, and _then_ refresh it? I guess not,
> seeing as we don't do that either in `cmd_status()`: there, we also
> refresh the index and _then_ lock it.
> 

Yeah, I don't think I saw a lock/refresh sequence, but I may be wrong.

>> +
>> +	memset(&opts, 0, sizeof(opts));
>> +	opts.head_idx = 1;
>> +	opts.src_index = r->index;
>> +	opts.dst_index = r->index;
>> +	opts.merge = 1;
>> +	opts.update = 1;
>> +	opts.aggressive = aggressive;
>> +
>> +	if (nr == 1)
>> +		opts.fn = oneway_merge;
>> +	else if (nr == 2) {
>> +		opts.fn = twoway_merge;
>> +		opts.initial_checkout = is_index_unborn(r->index);
>> +	} else if (nr >= 3) {
>> +		opts.fn = threeway_merge;
>> +		opts.head_idx = nr - 1;
>> +	}
> 
> Given the function's name `fast_forward()`, I have to admit that I
> somewhat stumbled over these merges.
>> +
>> +	if (unpack_trees(nr, t, &opts))
>> +		return -1;
>> +

I just noticed that the lock is not released if there is an error here.

>> +	if (write_locked_index(r->index, &lock, COMMIT_LOCK))
>> +		return error(_("unable to write new index file"));
>> +
>> +	return 0;
>> +}
>> +
>> +static int add_tree(struct tree *tree, struct tree_desc *t)
>> +{
>> +	if (parse_tree(tree))
>> +		return -1;
>> +
>> +	init_tree_desc(t, tree->buffer, tree->size);
>> +	return 0;
>> +}
> 
> This is a really trivial helper, but it is used a couple times below, so
> it makes sense to have it encapsulated in a separate function.
> 
>> +
>> +int merge_strategies_resolve(struct repository *r,
>> +			     struct commit_list *bases, const char *head_arg,
>> +			     struct commit_list *remote)
> 
> Since it is a list, and since the original variable in the shell script
> had been named in the plural form, let's do the same here: `remotes`.
> 

This one is supposed to contain only one commit, so I'm not really
conviced that this parameter should be in the plural form.

>> +{
>> +	struct tree_desc t[MAX_UNPACK_TREES];
>> +	struct object_id head, oid;
>> +	struct commit_list *i;
>> +	int nr = 0;
>> +
>> +	if (head_arg)
>> +		get_oid(head_arg, &head);
>> +
>> +	puts(_("Trying simple merge."));
> 
> Good. Usually I would recommend to print this to `stderr`, but the
> original script prints it to `stdout`, so we should do that here, too.
> 
>> +
>> +	for (i = bases; i && i->item; i = i->next) {
>> +		if (add_tree(repo_get_commit_tree(r, i->item), t + (nr++)))
>> +			return 2;
> 
> Since we're talking about a library function, not a `cmd_*()` function,
> the return value on error should probably be negative.
> 
> Even better would be to let the function return an `enum` that contains
> labels with more intuitive meaning than "2".
> 
> It _is_ the expected exit code when calling `git merge-resolve`, of course
> (because of the `|| exit 2` after that `read-tree` call), but I wonder
> whether a better layer for that `2` would be the `cmd_merge_resolve()`
> function, letting `merge_strategies_resolve()` report failures in a more
> fine-grained fashion.
> 

Right -- I'll see what I can do here.

>> +	}
>> +
>> +	if (head_arg) {
> 
> It would probably be easier to read if the `if (head_arg)` clause above
> was merged into this here clause.
> 
>> +		struct tree *tree = parse_tree_indirect(&head);
>> +		if (add_tree(tree, t + (nr++)))
>> +			return 2;
>> +	}
>> +
>> +	if (remote && add_tree(repo_get_commit_tree(r, remote->item), t + (nr++)))
>> +		return 2;
> 
> You get away with assuming that `remotes` only contains at most a single
> entry because `cmd_merge_resolve()` verified it.
> 
> However, as the intention is to use this as a library function, I think
> the input validation needs to be moved here instead of relying on all
> callers to verify that they send at most one "remote" ref.
> 
> Other than that, this patch looks good to me.
> 
Well, this condition checks that there is one commit, and if so, uses it
to call add_tree().  I don't see the mistake here.

Cheers,
Alban

> Thanks,
> Dscho
> 



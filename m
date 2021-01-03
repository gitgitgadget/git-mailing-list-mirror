Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C7DC433E0
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 22:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0351620776
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 22:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbhACWmE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 17:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbhACWmD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 17:42:03 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BE1C061573
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 14:41:22 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q18so29906150wrn.1
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 14:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9tEQQo/UF0NYSZu5GJYkpusSk2jtnhF94nzShSAwzSM=;
        b=ptQ0kdEpgPam++5CVvgAFWE2l6Z+n4D3vDrqrzEPlHp/BWYlOgNcOFuMWnd566gYk2
         xqhkzYwetTE9yJbKkAYbnc1pjDp/vjDEeFUDWJ/N0+DBesgxTVMhyCT/0p6cqUXTUtwn
         Gaa/quVj/tzfGca98t2Qa5COPfhR2vJwQ/hwIQujsQDV6z18Shu+8J3aJzyT9pkaIZ7T
         0C7Y04zVLwrk0jc+xFcCWrz2S2xaYBg41bDD/wgePYIsdaA41G69Gq6dJELTBETYKlGH
         sZm95VXdp4/JCCL5yTSHvp7sSFJG5n+Glm+omVfnTH3YJIIO+oBOcmsbxGspUZjUrPvj
         NV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9tEQQo/UF0NYSZu5GJYkpusSk2jtnhF94nzShSAwzSM=;
        b=fBwMuTOdtedhGRDHCxLFaTixMYjHpyff3peivvqBNfwhunssOmchKnU63xYZZ0x7Nb
         gjpx1c/49r98deAcNVVyTfRkFfIKUZsz2lmewfjez0hXNO3QMKmYpfkWCNtkajGV7w/q
         TDVKzhVuyOAVex3OMAtkVrh/BMuTzSXQ0Uzp5s39bN0hhRXzOcXYEmEXuP9Le3GwWD2u
         J2dMgwNkcfQ6yBZExzgYAw83SRH3uu6+LO2miSPkHZ1qYnmD504442Cgu3mvzLCNtg6b
         rJ/k4Uo7y7MXHoHRKEmFyhTHijvHtvAVyHavW/TdJdEP0F+cnaFJN5MkE9EWuik8j7Jd
         bHYg==
X-Gm-Message-State: AOAM531EQGffS5pl7iSmQf57Ra8Dh1nF+oj8Wy2eyKiT4kN7kQCjwRr1
        X3aWZs6V/36o7KUdu+rJxmY=
X-Google-Smtp-Source: ABdhPJzuG9pGfgnXr4Y0G4c9eH3tv4kA8Mo5y2+TZLCuUWRVggqeKNWKw1/vhx4XcpiGmO1dQk9LJA==
X-Received: by 2002:adf:b194:: with SMTP id q20mr78138032wra.199.1609713679665;
        Sun, 03 Jan 2021 14:41:19 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-654-1-424-100.w2-6.abo.wanadoo.fr. [2.6.87.100])
        by smtp.gmail.com with ESMTPSA id g192sm31662009wme.48.2021.01.03.14.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jan 2021 14:41:18 -0800 (PST)
Subject: Re: [PATCH v6 04/13] merge-one-file: rewrite in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
References: <20201116102158.8365-1-alban.gruin@gmail.com>
 <20201124115315.13311-1-alban.gruin@gmail.com>
 <20201124115315.13311-5-alban.gruin@gmail.com>
 <xmqq5z4th6ak.fsf@gitster.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Message-ID: <30de2a29-a3fe-57f7-76b4-5d2bd3688635@gmail.com>
Date:   Sun, 3 Jan 2021 23:41:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq5z4th6ak.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Thank you for your comments.

Le 22/12/2020 à 22:36, Junio C Hamano a écrit :
> Alban Gruin <alban.gruin@gmail.com> writes:
> 
>> +int merge_three_way(struct repository *r,
>> +		    const struct object_id *orig_blob,
>> +		    const struct object_id *our_blob,
>> +		    const struct object_id *their_blob, const char *path,
>> +		    unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode)
>> +{
>> +	if (orig_blob &&
>> +	    ((!their_blob && our_blob && oideq(orig_blob, our_blob)) ||
>> +	     (!our_blob && their_blob && oideq(orig_blob, their_blob)))) {
>> +		/* Deleted in both or deleted in one and unchanged in the other. */
>> +		return merge_one_file_deleted(r->index, our_blob, their_blob, path,
>> +					      orig_mode, our_mode, their_mode);
> 
> When both ours and theirs deleted, by definition orig_blob cannot be
> NULL, so "orig_blob &&" part would be true, but the other side that
> requires either (!their && our) or (!our && their) is true cannot be
> satisfied.  So it seems that the comment does not match the behaviour.
> 
> You'd need "(!their_blob && !our_blob) ||" in the second part?
> 

Yes, you're correct.

> This shows lack of test coverage, I think A manual test seems to
> trigger the "unhandled case" error you added:
> 
> $ make
> $ ./git-merge-one-file $(git rev-parse :COPYING) "" "" \
> 	COPYING \
> 	100644 "" ""
> error: COPYING: Not handling case 536e55524db72bd2acf175208aef4f3dfc148d42 ->  ->
> 

Okay, I will add a test case for this.

>> +	} else if (!orig_blob && our_blob && !their_blob) {
>> +		/*
>> +		 * Added in one.  The other side did not add and we
>> +		 * added so there is nothing to be done, except making
>> +		 * the path merged.
>> +		 */
> 
> This is not the sole "Added in one" case.  The next elseif arm also
> is added in one.
> 
> What is notable in this elseif arm is that this is "added in ours",
> which allows us (and forces us) not to touch the working tree with
> extra "checkout".  So either remove "Added in one" from here for
> symmetry with the next elseif arm, or better yet say "Added in
> ours".
> 
>> +		return add_to_index_cacheinfo(r->index, our_mode, our_blob,
>> +					      path, 0, 1, 1, NULL);
> 
> All callers to add_to_index_cacheinfo() uses 0, 1, 1 for stage,
> allow_add and allow_replace, except for the original.  The new
> callers you added should not have to keep repeating 0, 1, 1 like
> this caller does (see below).
> 
>> +	} else if (!orig_blob && !our_blob && their_blob) {
>> +		struct cache_entry *ce;
>> +		printf(_("Adding %s\n"), path);
>> +
>> +		if (file_exists(path))
>> +			return error(_("untracked %s is overwritten by the merge."), path);
>> +
>> +		if (add_to_index_cacheinfo(r->index, their_mode, their_blob,
>> +					   path, 0, 1, 1, &ce))
>> +			return -1;
>> +		return checkout_from_index(r->index, path, ce);
> 
> "git grep -A4 -e add_to_index_cacheinfo" after applying all patches
> in the series shows us that the &ce parameter was added only to call
> checkout_from_index() using it.
> 
> I doubt add_to_index_cacheinfo() is the right interface for this
> series.  This caller (and all other callers in the series that calls
> add_to_index_cacheinfo(), followed by checkout_from_index()) rather
> wants to have a function (defined in <cache.h>):
> 
> 	extern int add_merge_result_to_index(struct index_state, *
> 			unsigned int mode,
>                         const struct object_id *oid,
> 			const char *path,
> 			int checkout);
> 
> with which the last 4 lines of the above hunk can just become
> 
> 		return add_merge_result_to_index(r->index,
> 			their_mode, their_blob, path, 1);
> 
> I would think.  The earlier caller to add_to_index_cacheinfo() for
> "ours is the result" can pass 0 to the checkout parameter so the
> helper won't make a call to checkout_from_index().
> 
> And the step to add that helper would be in this patch (it could be
> after the previous step and before this step, but it is probably
> easier to understand if the new helper is introduced with its
> callers).
> 
> If we were to do that, then I do not mind the repetition of 0, 1, 1
> too much.
> 

Okay.  Are we sure we want add_merge_result_to_index() inside
read-cache.c/cache.h?

Cheers,
Alban


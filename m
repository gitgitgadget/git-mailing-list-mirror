Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82288C433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 08:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F8B564F89
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 08:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhCQIXn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 04:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhCQIXT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 04:23:19 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D35C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 01:23:19 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 205so7364182pgh.9
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 01:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xwzImuyNcdfCUr6K1cJLszXiQokaDbMx9b2Syz8et4M=;
        b=WplntkjZj0xk7lkLKHGtEUzYJ6GYRWLK/IlHzFgX+nlmXaM7NjIT8hvVvXGJ956Xoc
         7aQ9DPFs1xyzWnzen1r1pCQK+cMnmo07jyWwRy1O6Skjb9uzHvw5cvGdShCeRbudWT16
         tgxGptxVgbpoSSEZyHHef0ti+RTvXab8U7jVLXBr95oDHhJVGj2wJkmIueOTNbNqMFqX
         xGI61Pcd3x7+z8kfxTAYO5cEwEP0TACGWcSMzTbVPo5GTPmT2AKTt1k6vojDZwXMg6ZF
         KXoDgCe+OG+JBwkPz0emKxOZxXP7sm9e0L1aLN507gQxSAf6PxYANYASaqcg2CAVBgpC
         mT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xwzImuyNcdfCUr6K1cJLszXiQokaDbMx9b2Syz8et4M=;
        b=lhj1kJWRfxxB5PcoyKfIRwuze9XRGq11lQq2d4amHClu0tV3vRlta8xjYbUyMgDStZ
         A+P5RHmh4ZYXEn30d1d2hHErgYUoaYj8bzot7jQGqEohQNRbMSA+Vfaiqqm+CUS6sXkc
         PzSApc7jYXJfK1wF4ebfajAVkP5Rai5w0njHMoeSTuSDTuGCmWaU06B9ybOLcyeI70uB
         GCTb4Wc5n17S2RvAcbTa6DtXF16LcC62SGmgkoqTW/YJfPxh7lDYMAxeuKYwgak7BSpm
         jKvExFCxIEaot/PIbkxdQ5Xh5wbibj8s3y3zfTOp0C3+bBJL78mJBEaGoF6SFbUrx+Qf
         S5LA==
X-Gm-Message-State: AOAM5331mPCZhIk8XC71zrvjizFy7autSDnBRSvWLHxEerFvcJ/RAmg3
        EcealLQkkuJT2peztz/lemX+Y0mt/M31nAuT
X-Google-Smtp-Source: ABdhPJyiNMOAvXIuiOvG5BhpowQlkWXEu0JLbAokkghlqscMAfUsqJU+3Rb/Cx5Ogiq5yFVL4L4cgg==
X-Received: by 2002:a65:5bc6:: with SMTP id o6mr1643119pgr.127.1615969397726;
        Wed, 17 Mar 2021 01:23:17 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-36.three.co.id. [116.206.12.36])
        by smtp.gmail.com with ESMTPSA id z11sm19322966pgj.22.2021.03.17.01.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 01:23:17 -0700 (PDT)
Subject: Re: [PATCH] bisect: peel annotated tags to commits
To:     Jeff King <peff@peff.net>, Andreas Schwab <schwab@linux-m68k.org>
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <878s6nz1sg.fsf@igel.home>
 <YFDGX4EsrvHqZgPF@coredump.intra.peff.net>
 <YFDLq9mLbJtLqKea@coredump.intra.peff.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <5c41383f-55b5-a68e-4e35-8b8dc4694375@gmail.com>
Date:   Wed, 17 Mar 2021 15:23:13 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFDLq9mLbJtLqKea@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I can reproduce this issue with v2.31.0 (as you mentioned).

Applying the patch, bisecting between annotated tags now worked
just before git bisect is rewritten in C.

Thanks.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

On 16/03/21 22.15, Jeff King wrote:
> On Tue, Mar 16, 2021 at 10:53:19AM -0400, Jeff King wrote:
> 
>> On Tue, Mar 16, 2021 at 02:05:51PM +0100, Andreas Schwab wrote:
>>
>>> $ git --version
>>> git version 2.31.0
>>> $ git bisect start
>>> $ git bisect good v2.30.0
>>> $ git bisect bad v2.31.0
>>> 3e90d4b58f3819cfd58ac61cb8668e83d3ea0563 was both good and bad
>>
>> Looks like it bisects to 27257bc466 (bisect--helper: reimplement
>> `bisect_state` & `bisect_head` shell functions in C, 2020-10-15), which
>> isn't too surprising. So it broke in v2.30, but nobody seems to have
>> noticed during the last cycle.
>>
>> I'd guess it's just missing a call to peel the input oid.
> 
> Yep. Here's a fix. Again, not new in v2.31, so we don't have to worry
> about a brown-bag fix for yesterday's release. But I do think it's worth
> trying to get onto a maint release. I prepared this patch on top of
> mr/bisect-in-c-3.
> 
> -- >8 --
> Subject: [PATCH] bisect: peel annotated tags to commits
> 
> This patch fixes a bug where git-bisect doesn't handle receiving
> annotated tags as "git bisect good <tag>", etc. It's a regression in
> 27257bc466 (bisect--helper: reimplement `bisect_state` & `bisect_head`
> shell functions in C, 2020-10-15).
> 
> The original shell code called:
> 
>    sha=$(git rev-parse --verify "$rev^{commit}") ||
>            die "$(eval_gettext "Bad rev input: \$rev")"
> 
> which will peel the input to a commit (or complain if that's not
> possible). But the C code just calls get_oid(), which will yield the oid
> of the tag.
> 
> The fix is to peel to a commit. The error message here is a little
> non-idiomatic for Git (since it starts with a capital). I've mostly left
> it, as it matches the other converted messages (like the "Bad rev input"
> we print when get_oid() fails), though I did add an indication that it
> was the peeling that was the problem. It might be worth taking a pass
> through this converted code to modernize some of the error messages.
> 
> Note also that the test does a bare "grep" (not i18ngrep) on the
> expected "X is the first bad commit" output message. This matches the
> rest of the test script.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   builtin/bisect--helper.c    |  9 ++++++++-
>   t/t6030-bisect-porcelain.sh | 12 ++++++++++++
>   2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index fc6ca257a4..f0eeb4a2f0 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -876,12 +876,19 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, const char **a
>   	 */
>   
>   	for (; argc; argc--, argv++) {
> +		struct commit *commit;
> +
>   		if (get_oid(*argv, &oid)){
>   			error(_("Bad rev input: %s"), *argv);
>   			oid_array_clear(&revs);
>   			return BISECT_FAILED;
>   		}
> -		oid_array_append(&revs, &oid);
> +
> +		commit = lookup_commit_reference(the_repository, &oid);
> +		if (!commit)
> +			die(_("Bad rev input (not a commit): %s"), *argv);
> +
> +		oid_array_append(&revs, &commit->object.oid);
>   	}
>   
>   	if (strbuf_read_file(&buf, git_path_bisect_expected_rev(), 0) < the_hash_algo->hexsz ||
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index b886529e59..9c389553a7 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -929,4 +929,16 @@ test_expect_success 'git bisect reset cleans bisection state properly' '
>   	test_path_is_missing "$GIT_DIR/BISECT_START"
>   '
>   
> +test_expect_success 'bisect handles annotated tags' '
> +	test_commit commit-one &&
> +	git tag -m foo tag-one &&
> +	test_commit commit-two &&
> +	git tag -m foo tag-two &&
> +	git bisect start &&
> +	git bisect good tag-one &&
> +	git bisect bad tag-two >output &&
> +	bad=$(git rev-parse --verify tag-two^{commit}) &&
> +	grep "$bad is the first bad commit" output
> +'
> +
>   test_done
> 

-- 
An old man doll... just what I always wanted! - Clara

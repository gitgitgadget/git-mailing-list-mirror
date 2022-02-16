Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B586AC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 13:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbiBPNtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 08:49:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiBPNts (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 08:49:48 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB6A1662D1
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 05:49:34 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h6so3581755wrb.9
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 05:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vw/slbVcLcSVteYPuPXtybq+1veG1Tm65XZd2LKe9+A=;
        b=mCPv8Mk4db+OSzB475xlPACnBfGTe/KpoVD2zTW8f7esp4Yi17fUS3vIErYLHvsLgJ
         1jhWnCzMuMlKxt+0Z7dLprx1VGH/po+pjGYNzDe7gUgMEuXm7T9Ioss4JvoyENB98CxN
         B/Vm3NujOCBS5lPflFCx/uxF+cpNjrcXe2r8L/2ofBWK+ogO+iZjV5CxlAXIcey3LLY4
         yYHh0G7w3wAay6io8kYYPs1Un4Qr8i+W542oKt0Zlieip4wn4N9wROpdNSCyP2i9Ac0I
         /CvXErZ4XYDg0b/nJxxfIShcueUtR+DBnw6eJdKf37BW4yJPwNGWlQjYwqTRRa5Eyamg
         t95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vw/slbVcLcSVteYPuPXtybq+1veG1Tm65XZd2LKe9+A=;
        b=Kky77j8gPnhq6sky65PmF0Zx39xTm69phrEmR9yEccXfm/Ifqt/Q7Kczt6Lr0QLE2a
         1q3ZjXyvS/vzBs42MZPYVgjCA6h6YWEMdxAdD2c0XG1Z3ifHGRFVVmlCJIHdKAtFIHia
         Ew8OPFXUxmAHcwX9ZFOfMnegx0wfMp3APuhu04uyDrgL2Qe3T4igIC10t8lPmPxCH4cB
         QQlq46q4/8RjURfepDIjaXKy9DjXIiLTa/5xoY9g+8xRWXHsplK0YPiI1GKIBJt7Atwc
         MQTy6gRyiUXVT65gxWNVdasgXRTECdCALnuuGggRHuyocBZ9kUBTU1wOVQ3EoYx/jRK4
         WkUQ==
X-Gm-Message-State: AOAM53140S7veUrw3OtdtvMsMbbPLkPcefuiK9LBkIA+/U2btO/Bu34K
        CZC+M26+8csGSv2EhK3dfsY=
X-Google-Smtp-Source: ABdhPJzesqMC2ahjTTz8y2qekKHC21XpKQLTYJnMQ9e6hDcgzJZtx5C19XZU+yFJRhVNsmeW7JAuBw==
X-Received: by 2002:adf:9783:0:b0:1e0:8842:af03 with SMTP id s3-20020adf9783000000b001e08842af03mr2425906wrb.506.1645019372991;
        Wed, 16 Feb 2022 05:49:32 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id q23sm16589417wmj.44.2022.02.16.05.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 05:49:32 -0800 (PST)
Message-ID: <10c8dfa8-ab98-4a46-8baa-97857bb914b0@gmail.com>
Date:   Wed, 16 Feb 2022 13:49:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/4] xdiff: fix a memory leak
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1140.git.1644404356.gitgitgadget@gmail.com>
 <pull.1140.v2.git.1645006510.gitgitgadget@gmail.com>
 <3fcb6c8036794a16c4aa9285e3ef70da02e2bc80.1645006510.git.gitgitgadget@gmail.com>
 <220216.86tuczt7js.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220216.86tuczt7js.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

Thanks for taking a look at this patch

On 16/02/2022 10:28, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Feb 16 2022, Phillip Wood via GitGitGadget wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Although the patience and histogram algorithms initialize the
>> environment they do not free it if there is an error. In contrast for
>> the Myers algorithm the environment is initalized in xdl_do_diff() and
>> it is freed if there is an error. Fix this by always initializing the
>> environment in xdl_do_diff() and freeing it there if there is an
>> error. Remove the comment in do_patience_diff() about the environment
>> being freed by xdl_diff() as it is not accurate because (a) xdl_diff()
>> does not do that if there is an error and (b) xdl_diff() is not the
>> only caller.
>>
>> Reported-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   xdiff/xdiffi.c     | 33 +++++++++++++++++----------------
>>   xdiff/xhistogram.c |  3 ---
>>   xdiff/xpatience.c  |  4 ----
>>   3 files changed, 17 insertions(+), 23 deletions(-)
>>
>> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
>> index 69689fab247..758410c11ac 100644
>> --- a/xdiff/xdiffi.c
>> +++ b/xdiff/xdiffi.c
>> @@ -315,16 +315,19 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>>   	long *kvd, *kvdf, *kvdb;
>>   	xdalgoenv_t xenv;
>>   	diffdata_t dd1, dd2;
>> +	int res;
>>   
>> -	if (XDF_DIFF_ALG(xpp->flags) == XDF_PATIENCE_DIFF)
>> -		return xdl_do_patience_diff(mf1, mf2, xpp, xe);
>> -
>> -	if (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF)
>> -		return xdl_do_histogram_diff(mf1, mf2, xpp, xe);
>> +	if (xdl_prepare_env(mf1, mf2, xpp, xe) < 0)
>> +		return -1;
>>   
>> -	if (xdl_prepare_env(mf1, mf2, xpp, xe) < 0) {
>> +	if (XDF_DIFF_ALG(xpp->flags) == XDF_PATIENCE_DIFF) {
>> +		res = xdl_do_patience_diff(mf1, mf2, xpp, xe);
>> +		goto out;
>> +	}
>>   
>> -		return -1;
>> +	if (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF) {
>> +		res = xdl_do_histogram_diff(mf1, mf2, xpp, xe);
>> +		goto out;
>>   	}
>>   
>>   	/*
>> @@ -359,17 +362,15 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>>   	dd2.rchg = xe->xdf2.rchg;
>>   	dd2.rindex = xe->xdf2.rindex;
>>   
>> -	if (xdl_recs_cmp(&dd1, 0, dd1.nrec, &dd2, 0, dd2.nrec,
>> -			 kvdf, kvdb, (xpp->flags & XDF_NEED_MINIMAL) != 0, &xenv) < 0) {
>> -
>> -		xdl_free(kvd);
>> -		xdl_free_env(xe);
>> -		return -1;
>> -	}
>> -
>> +	res = xdl_recs_cmp(&dd1, 0, dd1.nrec, &dd2, 0, dd2.nrec,
>> +			   kvdf, kvdb, (xpp->flags & XDF_NEED_MINIMAL) != 0,
>> +			   &xenv);
>>   	xdl_free(kvd);
>> + out:
>> +	if (res < 0)
>> +		xdl_free_env(xe);
>>   
>> -	return 0;
>> +	return res;
>>   }
> 
> I wanted to test if this made some diff test pass under SANITIZE=leak
> that didn't before, and my usual quick way to discover that is to run
> the tests with something like this for testing:
> 	
> 	diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> 	index 758410c11ac..7811ce2a1d3 100644
> 	--- a/xdiff/xdiffi.c
> 	+++ b/xdiff/xdiffi.c
> 	@@ -368,7 +368,7 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
> 	 	xdl_free(kvd);
> 	  out:
> 	 	if (res < 0)
> 	-		xdl_free_env(xe);
> 	+		BUG("needed freeing");
> 	
> 	 	return res;
> 	 }
> 
> But doing so has all tests passing, so either this code is unreachable
> or not reachable by any of our tests.

Yeah, it is fixing a leak in the error path. The only possible error is 
an allocation failure and we die rather than returning in that case so 
the test suite is not going to tell us anything about this patch.

> More generally I think this patch is taking the wrong approach, why are
> we trying to the members of a stack variable in xdl_do_diff(), when that
> variable isn't ours, but is created by our caller? Why aren't they
> dealing with it?

They are not dealing with it because they do not initialize it - it is 
an "out" parameter that is used to return data to the caller. This patch 
changes the logic to "whoever initializes it is responsible for freeing 
it if there is an error". By doing that we localize the error handling 
to xdl_do_diff() and can leave the callers unchanged.

> The main issue the memory handling is such a pain here is because of
> that mixed ownership.
> 
> The below POC (and seems to pass tests) shows a way to do that, which I
> think in general is *much* simpler. I.e. sure we'll call free()
> redundantly some of the time, but that'll be safe as long as we
> zero-initialize the relevant struct.
> 
> The xdiff code is much harder to read & maintain than it needs to be
> because it's trying to micro-optimize these sort of patterns.
> 
> E.g. with the diff below we'll now redundantly call the free on a xe2
> when we only used a xe1, but "who cares?" is my considered opinion on
> that topic :)

Then you should reread the cover letter and commit message and code 
comment in patch 3 that all mention avoiding a double free in that case. 
If you have any ideas how to make those clearer please let me know.

If xdl_do_diff(orig, mf2, xpp, &xe2) fails it frees any members of xe2 
that it allocated but it does not NULL them. If we then call 
xdl_free_env(&xe2) we will have a double free error.

Best Wishes

Phillip

> By not trying to micro-optimize it like that the memory management and
> ownership becomes so much easier to deal with.
> 
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index 758410c11ac..6ad30a98b62 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -1054,19 +1054,19 @@ static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdfenv_t *xe,
>   int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>   	     xdemitconf_t const *xecfg, xdemitcb_t *ecb) {
>   	xdchange_t *xscr;
> -	xdfenv_t xe;
> +	xdfenv_t xe = { 0 };
>   	emit_func_t ef = xecfg->hunk_func ? xdl_call_hunk_func : xdl_emit_diff;
> +	int status = 0;
>   
>   	if (xdl_do_diff(mf1, mf2, xpp, &xe) < 0) {
> -
> -		return -1;
> +		status = -1;
> +		goto cleanup;
>   	}
>   	if (xdl_change_compact(&xe.xdf1, &xe.xdf2, xpp->flags) < 0 ||
>   	    xdl_change_compact(&xe.xdf2, &xe.xdf1, xpp->flags) < 0 ||
>   	    xdl_build_script(&xe, &xscr) < 0) {
> -
> -		xdl_free_env(&xe);
> -		return -1;
> +		status = -1;
> +		goto cleanup;
>   	}
>   	if (xscr) {
>   		if (xpp->flags & XDF_IGNORE_BLANK_LINES)
> @@ -1078,12 +1078,14 @@ int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>   		if (ef(&xe, xscr, ecb, xecfg) < 0) {
>   
>   			xdl_free_script(xscr);
> -			xdl_free_env(&xe);
> -			return -1;
> +			status = -1;
> +			goto cleanup;
>   		}
>   		xdl_free_script(xscr);
>   	}
> +
> +cleanup:
>   	xdl_free_env(&xe);
>   
> -	return 0;
> +	return status;
>   }
> diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
> index fff0b594f9a..4751eab9c12 100644
> --- a/xdiff/xmerge.c
> +++ b/xdiff/xmerge.c
> @@ -685,7 +685,8 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
>   		xmparam_t const *xmp, mmbuffer_t *result)
>   {
>   	xdchange_t *xscr1, *xscr2;
> -	xdfenv_t xe1, xe2;
> +	xdfenv_t xe1 = { 0 };
> +	xdfenv_t xe2 = { 0 };
>   	int status;
>   	xpparam_t const *xpp = &xmp->xpp;
>   
> @@ -693,25 +694,25 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
>   	result->size = 0;
>   
>   	if (xdl_do_diff(orig, mf1, xpp, &xe1) < 0) {
> -		return -1;
> +		status = -1;
> +		goto cleanup;
>   	}
>   	if (xdl_do_diff(orig, mf2, xpp, &xe2) < 0) {
> -		xdl_free_env(&xe1);
> -		return -1;
> +		status = -1;
> +		goto cleanup;
>   	}
>   	if (xdl_change_compact(&xe1.xdf1, &xe1.xdf2, xpp->flags) < 0 ||
>   	    xdl_change_compact(&xe1.xdf2, &xe1.xdf1, xpp->flags) < 0 ||
>   	    xdl_build_script(&xe1, &xscr1) < 0) {
> -		xdl_free_env(&xe1);
> -		return -1;
> +		status = -1;
> +		goto cleanup;
>   	}
>   	if (xdl_change_compact(&xe2.xdf1, &xe2.xdf2, xpp->flags) < 0 ||
>   	    xdl_change_compact(&xe2.xdf2, &xe2.xdf1, xpp->flags) < 0 ||
>   	    xdl_build_script(&xe2, &xscr2) < 0) {
>   		xdl_free_script(xscr1);
> -		xdl_free_env(&xe1);
> -		xdl_free_env(&xe2);
> -		return -1;
> +		status = -1;
> +		goto cleanup;
>   	}
>   	status = 0;
>   	if (!xscr1) {
> @@ -730,6 +731,7 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
>   	xdl_free_script(xscr1);
>   	xdl_free_script(xscr2);
>   
> +cleanup:
>   	xdl_free_env(&xe1);
>   	xdl_free_env(&xe2);
>   
> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> index cfa6e2220ff..63fb2eee975 100644
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -414,7 +414,8 @@ int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
>   	 * ranges of lines instead of the whole files.
>   	 */
>   	mmfile_t subfile1, subfile2;
> -	xdfenv_t env;
> +	xdfenv_t env = { 0 };
> +	int status = 0;
>   
>   	subfile1.ptr = (char *)diff_env->xdf1.recs[line1 - 1]->ptr;
>   	subfile1.size = diff_env->xdf1.recs[line1 + count1 - 2]->ptr +
> @@ -422,13 +423,16 @@ int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
>   	subfile2.ptr = (char *)diff_env->xdf2.recs[line2 - 1]->ptr;
>   	subfile2.size = diff_env->xdf2.recs[line2 + count2 - 2]->ptr +
>   		diff_env->xdf2.recs[line2 + count2 - 2]->size - subfile2.ptr;
> -	if (xdl_do_diff(&subfile1, &subfile2, xpp, &env) < 0)
> -		return -1;
> +	if (xdl_do_diff(&subfile1, &subfile2, xpp, &env) < 0) {
> +		status = -1;
> +		goto cleanup;
> +	}
>   
>   	memcpy(diff_env->xdf1.rchg + line1 - 1, env.xdf1.rchg, count1);
>   	memcpy(diff_env->xdf2.rchg + line2 - 1, env.xdf2.rchg, count2);
>   
> +cleanup:
>   	xdl_free_env(&env);
>   
> -	return 0;
> +	return status;
>   }


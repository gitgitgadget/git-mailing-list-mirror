Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D3CC433E0
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 16:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C11A22C9D
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 16:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbhAEQMB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 11:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbhAEQMB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 11:12:01 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE947C061793
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 08:11:20 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id z11so26930348qkj.7
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 08:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CbfQ2zm3bPmR3CrgSNvQXq901kKdeBPt3pI1p+Wmfmc=;
        b=MEnaB66dg7N1BPtJ+XPuJfWgukgSvAV7cY5no4FsQRWlgSnZyjlUTZeJ0a6xZkhF5p
         SglEUVsHhL2mo9OMQTz/hknJkEEbakjeasdRZgH5YPo9draqtPOnebGdMKWL4O/IpOer
         ScNoEof1QyqR7GIwybqcn7GJKgvWLC7ia2kpeyqdnGfupuanPYbBd4eeskmEtKgt6NFC
         o6jtn2wFWQVyM2Fy02hAmpjg5O+T+khhr/ikJoyu6TFg/h141ZuexY8CkRiyCHI6FP7/
         0dWebbyJ0S8EyqeLcIv/3Zbwa1PwASCzTK/rQzECE8WwpdM0l96qGgWhAAgUhTsO3Ck8
         Na/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CbfQ2zm3bPmR3CrgSNvQXq901kKdeBPt3pI1p+Wmfmc=;
        b=F71kkQGTXlBkBZRvyN7Wvu6PryiiR2OdF78zZw+zvmdDvf5/oeXF8jIhk3IyV9acI0
         ecmrppUMJ++1T/ICu1gLId4nZKwC6bydSE/HVBD128juo+LkGUvhCjkiaQID67OXUNet
         In79mh1VtkJ/y03m4pyohCMThwAkjGjTBHMtkmGNoA8OcMiH7Dyfdl/WFqW7iGtJdrns
         XpGib/4VVIoVhImeDJr36glmED4rcY5x+UXCca+5pL/c4xgUTunZIhHXSeL/1COFK+Kh
         89jBDx8lXSpUPdYm4ZwdMlQWtNmvPrd4C7hzMyqsaaUxFU4qOtro9jOjV0Iq34D5Na55
         lODQ==
X-Gm-Message-State: AOAM531cpF0zlv05rHOTu8d+zTGYWlnAnT0xhvRqLjK0IlqSStBkXZSl
        NCr+jmNwEhG3ulh3HSNr8Y0=
X-Google-Smtp-Source: ABdhPJxKSHNS75eysymVh7zL4lIWMePgtkPvo6I9UWK3IGwwWKAjeWY+7+iiFjBHLrRcmV1/XHk7VA==
X-Received: by 2002:a05:620a:122d:: with SMTP id v13mr245730qkj.186.1609863080143;
        Tue, 05 Jan 2021 08:11:20 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id g26sm212646qka.76.2021.01.05.08.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 08:11:19 -0800 (PST)
Subject: Re: [PATCH v6 06/13] merge-index: don't fork if the requested program
 is `git-merge-one-file'
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <20201116102158.8365-1-alban.gruin@gmail.com>
 <20201124115315.13311-1-alban.gruin@gmail.com>
 <20201124115315.13311-7-alban.gruin@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <44c9189d-9d2f-c437-d0d6-9529708d2c99@gmail.com>
Date:   Tue, 5 Jan 2021 11:11:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <20201124115315.13311-7-alban.gruin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/24/2020 6:53 AM, Alban Gruin wrote:
> +
>  	pgm = argv[i++];
> +	setup_work_tree();
> +
> +	if (!strcmp(pgm, "git-merge-one-file")) {

This stood out to me as possibly fragile. What if we call the
non-dashed form "git merge-one-file"? Shouldn't we be doing so?

Or, is this something that is handled higher in the builtin
machinery to take the non-dashed version and change it to the
dashed version for historical reasons?

> +		merge_action = merge_one_file_func;
> +		hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
> +	} else {
> +		merge_action = merge_one_file_spawn;
> +		data = (void *)pgm;
> +	}
> +

...

> +	if (merge_action == merge_one_file_func) {

nit: This made me think it would be better to check the 'lock'
itself to see if it was initialized or not. Perhaps

	if (lock.tempfile) {

would be the appropriate way to check this?

For now, this is equivalent behavior, but it might be helpful if
we add more cases that take the lock in the future.

> +		if (err) {
> +			rollback_lock_file(&lock);
> +			return err;
> +		}
> +
> +		return write_locked_index(&the_index, &lock, COMMIT_LOCK);
>  	}
>  	return err;

nit: this could be simplified. In total, I recommend:

	if (lock.tempfile) {
		if (err)
			rollback_lock_file(&lock);
		else
			return write_locked_index(&the_index, &lock, COMMIT_LOCK);
	}
	return err;


>  }
> diff --git a/merge-strategies.c b/merge-strategies.c
> index 6f27e66dfe..542cefcf3d 100644
> --- a/merge-strategies.c
> +++ b/merge-strategies.c
> @@ -178,6 +178,18 @@ int merge_three_way(struct repository *r,
>  	return 0;
>  }
>  
> +int merge_one_file_func(struct repository *r,
> +			const struct object_id *orig_blob,
> +			const struct object_id *our_blob,
> +			const struct object_id *their_blob, const char *path,
> +			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
> +			void *data)
> +{
> +	return merge_three_way(r,
> +			       orig_blob, our_blob, their_blob, path,
> +			       orig_mode, our_mode, their_mode);
> +}
> +

Again, I don't recommend making this callback in the library. Instead, keep
it in the builtin and then use merge_three_way() which is in the library.

>  int merge_one_file_spawn(struct repository *r,
>  			 const struct object_id *orig_blob,
>  			 const struct object_id *our_blob,
> @@ -261,17 +273,22 @@ int merge_all_index(struct repository *r, int oneshot, int quiet,
>  		    merge_fn fn, void *data)
>  {
>  	int err = 0, ret;
> -	unsigned int i;
> +	unsigned int i, prev_nr;
>  
>  	for (i = 0; i < r->index->cache_nr; i++) {
>  		const struct cache_entry *ce = r->index->cache[i];
>  		if (!ce_stage(ce))
>  			continue;
>  
> +		prev_nr = r->index->cache_nr;
>  		ret = merge_entry(r, quiet || oneshot, i, ce->name, &err, fn, data);
> -		if (ret > 0)
> -			i += ret - 1;
> -		else if (ret == -1)
> +		if (ret > 0) {
> +			/* Don't bother handling an index that has
> +			   grown, since merge_one_file_func() can't grow
> +			   it, and merge_one_file_spawn() can't change
> +			   it. */

multi-line comment style is as follows:

	/*
	 * Don't bother handling an index that has
	 * grown, since merge_one_file_func() can't grow
	 * it, and merge_one_file_spawn() can't change it.
	 */

Thanks,
-Stolee

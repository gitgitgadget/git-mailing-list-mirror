Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70B1C433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 07:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbiBKHQQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 02:16:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiBKHQP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 02:16:15 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F6810A4
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 23:16:14 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id 62-20020a17090a09c400b001b80b0742b0so5261209pjo.8
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 23:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kF5+mknEtQ58orouC+7FmHh6i69QYIV5Sunjl6x3a5o=;
        b=DHzy8ov4enILx0Iw1kXF3oHQXSe6cxFHHpqLo3W/7ASKmPx3mMDl7T371jj03ZjQQn
         noXVn4eqRjBZ46OcDGtou441qowegnmTt9qmtwDuHHm3PofXlgnL/mFG20hH1EXqrK+n
         RGgOvpbFh58gqmSFh7+jkdnRnzPnd/FjBuSNZ8TPPdF8Bel6j3PP0BfmZlya/dD0A98r
         0nT28NI7rh1BlFpy52S0mNNrNRytaXhDlfmSemqI+rfLVkeBRaZeoj643ocXwgj5E4j9
         q5uFjD9tlFgC9VcRrmA6y3G57QYqnz6obFtAo/q/mDiO4R2AM5gNvomunFwVJtR6NEK0
         kNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kF5+mknEtQ58orouC+7FmHh6i69QYIV5Sunjl6x3a5o=;
        b=l3lj6NSM4yKkBM55jqU7ZAA0mlNTVCjqiaCh6AaYopfe8V8bj4TP0/3iX8A7XXUbgh
         M4iON4uswtwr4lOjip7mYezUFSlP1ygXAncPLMBxF7AqC9VRCwmyfkx4AhfA2hnF9X7D
         5OF+aq053GT/TE8H5KVAUm8aiqxUaP9YLQd058EKO6GFPR8x7dQUeB3ASKGmgTSEuC+u
         TCm8QYtTViZqlg1FISxCwaRmjFOWQTz5rnvzEwzhwSCxLKBSe2WOlCC2nJURHGcB1Pcy
         xIEpqdrazqO8v60l4Zgb38mF+DVOUl/VI4LjpmsKgN8yNfmDWXqXSF7rBp6LCR+lQnPQ
         omag==
X-Gm-Message-State: AOAM531qCMesVzgD8SWQ/mtMSuxJx2kc+FcH72VLfZ9slRjrPHv8vWiw
        5ltE5fwvVVsULh+KB0rCeaKxU3us5CY2Bw==
X-Google-Smtp-Source: ABdhPJys7CdPCmVKpbxp+wQOEi9ErbQQbe/zNJZ8leqGgWUesasreV6RwWlpWnyY149fnuBORI158FHb6rcBsA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:bd01:: with SMTP id
 p1mr401524pls.29.1644563773713; Thu, 10 Feb 2022 23:16:13 -0800 (PST)
Date:   Fri, 11 Feb 2022 15:15:58 +0800
In-Reply-To: <xmqqtud6e3r8.fsf@gitster.g>
Message-Id: <kl6lbkzdyitt.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220210044152.78352-1-chooglen@google.com> <20220210044152.78352-8-chooglen@google.com>
 <xmqqtud6e3r8.fsf@gitster.g>
Subject: Re: [PATCH 7/8] fetch: fetch unpopulated, changed submodules
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +static struct fetch_task *
>> +get_fetch_task_from_changed(struct submodule_parallel_fetch *spf,
>> +			    const char **default_argv, struct strbuf *err)
>> +{
>
>> @@ -1553,7 +1628,10 @@ static int get_next_submodule(struct child_process *cp, struct strbuf *err,
>>  {
>>  	struct submodule_parallel_fetch *spf = data;
>>  	const char *default_argv = NULL;
>> -	struct fetch_task *task = get_fetch_task(spf, &default_argv, err);
>> +	struct fetch_task *task =
>> +		get_fetch_task_from_index(spf, &default_argv, err);
>> +	if (!task)
>> +		task = get_fetch_task_from_changed(spf, &default_argv, err);
>
> Hmph, intersting.  So if "from index" grabbed some submodules
> already, then the "from the changes in the superproject, we know
> these submodules need refreshing" is not happen at all?  I am afraid
> that I am still not following this...

Hm, perhaps the following will help:

- get_next_submodule() is an iterator, specifically, it is a
  get_next_task_fn passed to run_processes_parallel_tr2(). It gets
  called until it is exhausted.
- Since get_next_submodule() is an iterator, I've implemented
  get_fetch_task_from_index() and get_fetch_task_from_changed() as
  iterators (they return NULL when they are exhausted).

So in practice:

- We repeatedly call get_next_submodule(), which tries to get a fetch
  task by calling the get_fetch_task_* functions.
- If get_fetch_task_from_index() returns non-NULL, get_next_submodule()
  uses that fetch task.
- Eventually, we will have considered every submodule in the index. At
  that point, get_fetch_task_from_index() is exhausted and always
  returns NULL.
- Since get_fetch_task_from_index() returns NULL, get_next_submodule()
  now gets its fetch tasks from get_fetch_task_from_changed().
- Eventually, we will also have considered every changed submodule, and
  get_fetch_task_from_changed() is exhausted.
- get_next_submodule() has now been exhausted and we are done.

As for the other questions, I'll dig a bit deeper before getting back to
you with answers.

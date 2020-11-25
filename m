Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1F8C2D0E4
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 01:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34CA220BED
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 01:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eNBMxjMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgKYBON (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 20:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgKYBOM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 20:14:12 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AEFC0613D4
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 17:14:12 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id b139so338091pfb.2
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 17:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=eeY1/VKlTY1/L6+WHNWah+KNFQSdQvKhpftlrGW5m1U=;
        b=eNBMxjMsVa4IZY1vUoMWTZAJ5z0ukpX5Kv+d6coq+telXx5NRTZATZAO22yiHlJGdu
         DtI+tt3AXeOAQ4IJeqI6GzpK7GyNkdXOKZ5BW9ymlq1HAQ5hOeSs8KAZFsygekmQ3koh
         V2VHWHlyR0qOB+/WV/AqPsD5IN+GByuvQm+1FfpgyN5CeHKx5124us5UOYHAi/7gAE/m
         BKH/86fVeS6v/gvvQzWibdMIcnIf1gipIfI0TX/NhY+Agt3EA9QuEc2IbkzM8/pnthU2
         XSzIltXJgYKFk5KxbFrHHMoooUgF7oyhhsbYBDRWyj5sZZogOD8tzSBykrEqWDpbMj4V
         5zFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eeY1/VKlTY1/L6+WHNWah+KNFQSdQvKhpftlrGW5m1U=;
        b=mDjgKHIQ3IJAYu8W8CvISUeUUc8mOPpeojs16Hyp01Q2KAMjI3KXbjOpIDDPPJ/6Qu
         J/6TYrLMlInAJPtgZlJXyDPtLj0Gaa6HXFSfJw+HWseSdayk8KGrKMpZHnsymLviRqQE
         rQmdi/nhi5+VD5e31o5YMhkIqjeoLu8j6WZJdh7+opneV7udhTjtfvPaN2N/8ZW4CgV3
         apDOFpCWQgos4S7SvU0Bm2VAhEAJkvcqOFdtt7q69KxSazeQ7t/ICQwNO9CTn4vvh03b
         CR4+CFPSrJ+kOm7xsic5dgPGIVBvGOwHwYqipx6QcFoX77sjEjgy07ZGnDmzpmeuXvmg
         jOZQ==
X-Gm-Message-State: AOAM533EWPuoBavg46IRtFDjBGxE5Ld7gl5TCgQ5d2ExMqSR7jZPH/ng
        3OqLOgZtgaSGjXBESH+crsQYEW2JoevCiSsH1hbT
X-Google-Smtp-Source: ABdhPJzf6LT4igWrexTmc73QCmMjVY2ZLjwr1ORlbR2rTpASbi/zBz/2Luzauff0LdekzR+fhbNnCV61DaJtpKWGaJT1
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:86d8:0:b029:18b:585b:3b16 with
 SMTP id h24-20020aa786d80000b029018b585b3b16mr961967pfo.72.1606266852148;
 Tue, 24 Nov 2020 17:14:12 -0800 (PST)
Date:   Tue, 24 Nov 2020 17:14:09 -0800
In-Reply-To: <8e5607929d66a3c808dbe3a06c312d0cda1ef568.1605649533.git.me@ttaylorr.com>
Message-Id: <20201125011409.941639-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <8e5607929d66a3c808dbe3a06c312d0cda1ef568.1605649533.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: Re: [PATCH v2 12/24] pack-bitmap-write: fill bitmap with commit history
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net, martin.agren@gmail.com, szeder.dev@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The fill_bitmap_commit() method assumes that every parent of the given
> commit is already part of the current bitmap. Instead of making that
> assumption, let's walk parents until we reach commits already part of
> the bitmap. Set the value for that parent immediately after querying to
> save time doing double calls to find_object_pos() and to avoid inserting
> the parent into the queue multiple times.

I see from the later patches that this has no effect until the part
where we can skip commits, but as Junio says [1], it's worth mentioning
it here. Maybe something like:

  The fill_bitmap_commit() method assumes that every parent of the given
  commit is already part of the current bitmap. This is currently
  correct, but a subsequent patch will change the nature of the edges of
  the graph from parent-child to ancestor-descendant. In preparation for
  that, let's walk parents...

>  static void fill_bitmap_commit(struct bb_commit *ent,
> -			       struct commit *commit)
> +			       struct commit *commit,
> +			       struct prio_queue *queue)

As far as I can see, this function expects an empty queue and always
ends with the queue empty, and the only reason why we don't instantiate
a new queue every time is so that we can save on the internal array
allocation/deallocation. Maybe add a comment to that effect.

>  {
>  	if (!ent->bitmap)
>  		ent->bitmap = bitmap_new();
>  
> -	/*
> -	 * mark ourselves, but do not bother with parents; their values
> -	 * will already have been propagated to us
> -	 */
>  	bitmap_set(ent->bitmap, find_object_pos(&commit->object.oid));
> -	fill_bitmap_tree(ent->bitmap, get_commit_tree(commit));
> +	prio_queue_put(queue, commit);
> +
> +	while (queue->nr) {
> +		struct commit_list *p;
> +		struct commit *c = prio_queue_get(queue);
> +
> +		bitmap_set(ent->bitmap, find_object_pos(&c->object.oid));
> +		fill_bitmap_tree(ent->bitmap, get_commit_tree(c));
> +
> +		for (p = c->parents; p; p = p->next) {
> +			int pos = find_object_pos(&p->item->object.oid);
> +			if (!bitmap_get(ent->bitmap, pos)) {
> +				bitmap_set(ent->bitmap, pos);
> +				prio_queue_put(queue, p->item);
> +			}
> +		}
> +	}
>  }

[snip rest of code]

Everything else makes sense.

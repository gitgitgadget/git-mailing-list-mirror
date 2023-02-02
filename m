Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8ACC61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 23:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjBBXGx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 18:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbjBBXGv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 18:06:51 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D203A7EFF2
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 15:06:47 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so7166462pjq.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 15:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eCACNoyb00ebyvY1SmsA/vfol1V6jjnOXWhCq6BilTQ=;
        b=m7Zqeyl7/lTx0ZzZiAVThTg+ehcGVSYl1EsrbnjGHE+W+Z2AjZzxAprTJBeI9DnbaU
         C/r+TxAWGbGuMNVw8jUD4NN/pkgusvltgAv8UMRt8XW9/kFgow8IZpV7IvdGlrxS6q7o
         gXP+4zxK+ipVjIFlg4A2rZVsSV3PVmo05DHMXLh2tsi1D0uaraVtJ/skrxcfrYPg/DTN
         qvuCZDlb8n4Wb/0BPt20QpMSHn0aoWymdIS+kQKh7FsXlABtvBV2AJiBkVe3dCa3HXio
         x4YDkoiPfDMcACoFoFO94Zs5FVeATeAGcj8cOQHHp8zwbFYr7kEsS4aye7P+H58qXyGx
         /Czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eCACNoyb00ebyvY1SmsA/vfol1V6jjnOXWhCq6BilTQ=;
        b=Lttl/bJFnG0M9XHgA9cmERoaK8fMgBIjGeJMy+bNGqF+rSZkGk4IhnFqjkBczuQTBa
         jtO+L5Mf/aTTn7+M7yx1PP6HxnLuGF/sA/+p57o8A+hj8LtdccTZV9B9Wi/6EuIDHCm0
         Ty/UzrLg85EN0BHz8VrybZXbySmp4j0QjLZWAQdh2yhHqXKnxVtLAnuzgSD97mqjWThO
         FTigrBSGuwKv9Rkr5tHBfGIJac77Zszi59IVu7+FC5XH+ExXVt9DDta9YNvFJ8Rh6UAQ
         44vWVzzZ6JN5P/OMQnLGEFbENtqTPUkqFttjBt6XdMy69RdMFdWqw8kq4pdoucptuo/K
         yFKw==
X-Gm-Message-State: AO0yUKUuC5/1H5Mln3enqT+HmRJ9/LpcgVWywe2eulYEKiaz5G7UTNNr
        AO3gXGWALqn/FHpZjQrvpXA=
X-Google-Smtp-Source: AK7set+KxV3RVCG00Dj1bEc90tm1z0i/BLMZLOXQtgdSkvp2tuKPHfkOiJ7YXYRys2+r+MPLPeCx2Q==
X-Received: by 2002:a17:902:e809:b0:196:40ff:97b5 with SMTP id u9-20020a170902e80900b0019640ff97b5mr8775623plg.40.1675379207139;
        Thu, 02 Feb 2023 15:06:47 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id jj14-20020a170903048e00b0019607aeda8bsm204401plb.73.2023.02.02.15.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 15:06:46 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH] merge: use reverse_commit_list() for list reversal
References: <20230202165137.118741-1-five231003@gmail.com>
Date:   Thu, 02 Feb 2023 15:06:46 -0800
In-Reply-To: <20230202165137.118741-1-five231003@gmail.com> (Kousik
        Sanagavarapu's message of "Thu, 2 Feb 2023 22:21:41 +0530")
Message-ID: <xmqq1qn7sm49.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kousik Sanagavarapu <five231003@gmail.com> writes:

> Instead of manually doing an in-place list reversal, use the helper
> function reverse_commit_list(), hence improving code readability.

But isn't reverse_commit_list() destructive in that it reuses the
elements on the original list to create the reversed list?  The
original code creates a new and separate list, so even when
try_merge_strategy() is called many times, its "common" parameter
given by the caller stays the same.

What happens in the second and subsequent call to
try_merge_strategy() in your updated version?  The element pointed
at by the "common" variable, which is the first element of the list
in the first call, gets its .next member NULLed by calling
reverse_commit_list().  The rest of the try_merge_strategy()
function in its first call might work the same way as before (as
long as it does not use "common" and only uses "reversed"; I did not
check), but because the "common" the caller passed is now a single
element list that consists of itself, and all the other elements are
lost.  The caller uses that same "common" to call try_merge_strategy()
again, with a different strategy.  This second call is getting a common
ancestor list that was already broken by the first call, no?

> Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
> ---
>
> This patch addresses the issue #1156(Use reverse_commit_list() in more
> places) on gitgitgadget. I also would like to submit this patch as the microproject for
> GSoC 2023.
>
>  builtin/merge.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 5900b81729..4503dbfeb3 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -736,7 +736,6 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
>  		struct commit *result;
>  		struct commit_list *reversed = NULL;
>  		struct merge_options o;
> -		struct commit_list *j;
>  
>  		if (remoteheads->next) {
>  			error(_("Not handling anything other than two heads merge."));
> @@ -757,8 +756,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
>  		o.branch1 = head_arg;
>  		o.branch2 = merge_remote_util(remoteheads->item)->name;
>  
> -		for (j = common; j; j = j->next)
> -			commit_list_insert(j->item, &reversed);
> +		reversed = reverse_commit_list(common);
>  
>  		hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
>  		if (!strcmp(strategy, "ort"))

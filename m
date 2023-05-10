Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31A5C7EE22
	for <git@archiver.kernel.org>; Wed, 10 May 2023 23:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbjEJXZy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 19:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbjEJXZx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 19:25:53 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E512E45
        for <git@vger.kernel.org>; Wed, 10 May 2023 16:25:52 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64115e652eeso53977142b3a.0
        for <git@vger.kernel.org>; Wed, 10 May 2023 16:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683761151; x=1686353151;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVCLCtQNSoIfNdGEDrNGUk8tYCME+HBxMbqzXYlQynU=;
        b=UusjPMbuwlzvKNberMZJL4ARhfv8+ggUXSUrnbZQH4NrW6d4tXJnc41ppUUmfiXkAG
         MFm3IwS9IcEa5u64vN9ue9JDWodULyg8OEetYouGLN7NoSbsWAgxwUk20NJ08Ook42Oj
         lhm1SMJSES/v1IZjil7lwD/IU588D+BTB9nAYiosqW8XzbXVBmsDfmQ1BV5vkFWzirKf
         QR0ICRRzPOtF3TXAv1V6FLwMWnm11i42Cdyk9eN83mps22Cl6PT4U3VXLPvEXLsTHdkG
         se5J1l6VtCXUNSlXS63CFFxlwdsEcTULi5b9/Hf48VNdi10fwiGEzu/VmnZyQdALB103
         cvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683761151; x=1686353151;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DVCLCtQNSoIfNdGEDrNGUk8tYCME+HBxMbqzXYlQynU=;
        b=G/xxBnkPCxuokmYB1k9kb0zJpi4BaDanI72RnEey+rBtB6iWy2X5j+1sdtd7wGPLEQ
         F5w8Im/v7Wg1FWoFPek5PsBeVqpXuI4j6TaYrUtupUDl5JEvdpDjqAeRFGwB51nU6W+0
         yVgMHvOIJmg/zkUOGuT2ht6dT+/Euj611LTZFHOzMrGlYm4saOvislbiZgnjzduvl6iF
         tm8Fm+I+xmDcW8LO47rWvsWKQz9zylBYm0F6pce+lmMW0OlnGbxXniYoXs8BdjwW5u/V
         52DlYGUpvDI1f/k+NjYGoIw86Qhw0r9ER4fqwkceQDYU25SbKP1ZO0wHZYwpSGdLGKpj
         yLeA==
X-Gm-Message-State: AC+VfDzOtuD/aMKopK7hWPMiYKZEpLxBIuV13K8O+QoBwArktUM4b9Iq
        UFtYc3oft/gqIVar/ztphr4=
X-Google-Smtp-Source: ACHHUZ6nuCVdudKHjgUcZ31Y9zTS/p412Fci/DPQ9aC5lbjYqt+6HzfO4Jx+GLoWpmo1SWSXZRjP1w==
X-Received: by 2002:a05:6a20:918d:b0:ee:cc76:5023 with SMTP id v13-20020a056a20918d00b000eecc765023mr25172524pzd.22.1683761151366;
        Wed, 10 May 2023 16:25:51 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id k5-20020aa792c5000000b0063b89300347sm4180790pfa.142.2023.05.10.16.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 16:25:50 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] rebase --update-refs: fix loops
References: <pull.1531.git.1683759338.gitgitgadget@gmail.com>
        <2ac7c7a7c615db75a46076b58a51d363bc2daf2e.1683759338.git.gitgitgadget@gmail.com>
Date:   Wed, 10 May 2023 16:25:50 -0700
In-Reply-To: <2ac7c7a7c615db75a46076b58a51d363bc2daf2e.1683759338.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 10 May 2023
        22:55:37 +0000")
Message-ID: <xmqqcz3722gx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `total_nr` field in the `todo_list` structure merely serves display
> purposes, and should only be used when generating the progress message.

This is a good distinction to keep in mind.

I notice that sequencer.h does not do a very good job at giving
guidance on how these members are to be used.

        struct todo_list {
                struct strbuf buf;
                struct todo_item *items;
                int nr, alloc, current;
                int done_nr, total_nr;
        };

The <nr,alloc> tuple lets readers to guess they are tied to the
items[] array, so perhaps it is sufficient to give a comment to
total_nr member and probably done_nr while we are at it.

> In these two instances, however, we want to loop over all of the
> commands in the parsed rebase script. The loop limit therefore needs to
> be `nr`, which refers to the count of commands in the current
> `todo_list`.

Yes.

> This is important because the two numbers, `nr` and `total_nr` can
> differ wildly, e.g. due to `total_nr` _not_ counting comments or empty
> lines, while `nr` skips any commands that already moved from the
> `git-rebase-todo` file to the `done` file.

OK.  The items[] array has not just executable insn but also holds
comments and NOOP, and <nr,alloc> tuple is used to control its
sizing in the usual ALLOC_GROW() way.  Because total_nr is used only
for progress, it naturally excludes the no-ops.  Elements of items[]
array are consumed in core by incrementing the current pointer and
nr will not update while that is happening, but when the sequencer
gives control the user and then takes the control back upon resuming,
items[] would contain only the insns that have not been moved to the
done list, meaning that 'nr' would shrink.  total_nr is compensated
by reading the done list and adds its size to 'nr'.

OK, that all makes sense.  The whole arrangement sounds like a bit
more error prone than necessary (an obvious alternative is to just
always keep the whole todo list with "done up to here" pointner) but
changing that is not in the scope of these fixes, because such an
arrangement wouldn't have prevented this particular bug from
happening, as total_nr and nr could still be different due to
no-ops.

> diff --git a/sequencer.c b/sequencer.c
> index 5f22b7cd377..f5d89abdc5e 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4202,7 +4202,7 @@ void todo_list_filter_update_refs(struct repository *r,
>  		if (!is_null_oid(&rec->after))
>  			continue;
>  
> -		for (j = 0; !found && j < todo_list->total_nr; j++) {
> +		for (j = 0; !found && j < todo_list->nr; j++) {
>  			struct todo_item *item = &todo_list->items[j];

The .total_nr member could be smaller (because it does not count
noops) or larger (because it counts already done steps that are not
in the items[]) than the .nr member, and the old code could have
made out-of-bounds access into the items[] array.  It is now
corrected.  Excellent.

>  			const char *arg = todo_list->buf.buf + item->arg_offset;
>  
> @@ -4232,7 +4232,7 @@ void todo_list_filter_update_refs(struct repository *r,
>  	 * For each todo_item, check if its ref is in the update_refs list.
>  	 * If not, then add it as an un-updated ref.
>  	 */
> -	for (i = 0; i < todo_list->total_nr; i++) {
> +	for (i = 0; i < todo_list->nr; i++) {
>  		struct todo_item *item = &todo_list->items[i];
>  		const char *arg = todo_list->buf.buf + item->arg_offset;
>  		int j, found = 0;

Ditto.  Will queue.

Thanks.

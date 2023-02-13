Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51232C636CC
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 17:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBMR3O (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 12:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBMR3M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 12:29:12 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB7EA276
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 09:29:06 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id e17so5361902plg.12
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 09:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BllCsXO60dqJh366sulHVqaMcz8fzrwKAqBphqy5UXU=;
        b=FwduCJNyX1V4bJhnb4y4GUgMI5fHK5N7MLz9Owtg8rq+Nar6ACbHEtLXJpsefeal/f
         B9bRa44dMg213IcaUnBkOU0Y/gXqOlZ8gfaWeksAn9kkyO/MI1wGkiCSg2moZx03ScXP
         Quy9Zdh4KGyIJjUgb6OO7Kt/MMELijytTAW+LqQznMrS0vp/rSWY4DMzG7aX0xPofqE9
         /2zv8X+bfo4F6AN5PZbJo6WTI4SAGkNLwOdYLzFSPqTZpL/TP/am4x+DVSfiAxRhpmQN
         JIrZLcPD5XKQxolbA62ZjmrlEA6xfSi+b5/3LhBdVfQXiLI8qUyR8Gjq6ub3EhTxb0nc
         PYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BllCsXO60dqJh366sulHVqaMcz8fzrwKAqBphqy5UXU=;
        b=Zk0f/dsjN8JdCaODP/PZUYfa+ocLvVuOUhky7Jhkjap+iRS9aKigKAtCuDP8KzjDmK
         BcPoGFC2KQfAPB4/UP5m1U+oK5jFoPn8pT07mha7NMxjPgHLz0PL4AWOCgnwoVug3cl/
         Jeh+mrFKMCo+WjISfzEIj3D5N/5U9lP/vytcUoYPls9C1xd0GXECYNY65sXPIsWUtYrM
         rycs3D8xtQ5PC5uPgf3Xc62icuduAVb1XC7X/oJG2a42oCPFRGbV705QjqKywWDGLAN8
         kC1iQn1FgBxfX5iWwN9AfrBjNRibCi7uVGM62GwusJye8ye6KJAJWzetgYVMy121/nks
         +/0w==
X-Gm-Message-State: AO0yUKX9zRHmfZhujjXk845+ZJI9D8zOed+mrGvzcfZGP6144kvLdMp8
        mBGj6csX2qQa9onu0/p1zi8=
X-Google-Smtp-Source: AK7set9RJziE61Z23KlwaG0IqxBKOkYpe/BL6DS/XKDLjQ57qah2hSKmwp9gnyvLvLRqTJqD8Gv0DA==
X-Received: by 2002:a17:902:ec8a:b0:19a:a279:fd5b with SMTP id x10-20020a170902ec8a00b0019aa279fd5bmr4484594plg.17.1676309346131;
        Mon, 13 Feb 2023 09:29:06 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id o7-20020a1709026b0700b00196519d8647sm8510887plk.4.2023.02.13.09.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 09:29:05 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: Re: [PATCH] commit-reach: avoid NULL dereference
References: <20230211111526.2028178-1-e@80x24.org>
        <xmqqcz6fesca.fsf@gitster.g>
        <876cf920-113a-90cf-f49e-6e1b7b146acf@github.com>
Date:   Mon, 13 Feb 2023 09:29:05 -0800
In-Reply-To: <876cf920-113a-90cf-f49e-6e1b7b146acf@github.com> (Derrick
        Stolee's message of "Mon, 13 Feb 2023 08:58:46 -0500")
Message-ID: <xmqqmt5hcw4e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> The above seems to indicate that the expectation by callers is a bit
>> uneven.  Shouldn't the first onetrust the callee to clear the flag?
>
> Yes, that makes sense. (But there's more!)
> ...
> Thanks for digging into the details here. I agree that this extra
> assignment of the flag to these non-commit objects is unnecessary
> since we intend to clear them by the end of the method and don't
> do anything with the flags otherwise.
>
> What you seem to be suggesting is this diff:
>
> diff --git a/commit-reach.c b/commit-reach.c
> index 2e33c599a82..8c387911228 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -740,10 +740,8 @@ int can_all_from_reach_with_flag(struct object_array *from,
>  			/*
>  			 * no way to tell if this is reachable by
>  			 * looking at the ancestry chain alone, so
> -			 * leave a note to ourselves not to worry about
> -			 * this object anymore.
> +			 * skip it.
>  			 */
> -			from->objects[i].item->flags |= assign_flag;
>  			continue;
>  		}

Agreed with this part.

> @@ -856,17 +854,6 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
>  
>  	result = can_all_from_reach_with_flag(&from_objs, PARENT2, PARENT1,
>  					      min_commit_date, min_generation);
> -
> -	while (from) {
> -		clear_commit_marks(from->item, PARENT1);
> -		from = from->next;
> -	}

This too.

> -	while (to) {
> -		clear_commit_marks(to->item, PARENT2);
> -		to = to->next;
> -	}

But I didn't think this is redundant.  PARENT2 is used to mark "to"
commits by this function, not the callee, before making the call.
The callee may clear PARENT1 used to mark the ones visited by the
traversal starting from the "from" commits, but does not do anything
to "with_flag", does it?

>  	object_array_clear(&from_objs);
>  	return result;
>  }
>
> And instead of the current patch, this should allow the
> following diff hunk instead:
>
> @@ -807,9 +805,6 @@ int can_all_from_reach_with_flag(struct object_array *from,
>  	clear_commit_marks_many(nr_commits, list, RESULT | assign_flag);
>  	free(list);
>  
> -	for (i = 0; i < from->nr; i++)
> -		from->objects[i].item->flags &= ~assign_flag;
> -
>  	return result;
>  }
>
> This avoids the need for the NULL check, since we are skipping the
> entire loop. The clear_commit_marks_many() is sufficient. 

Yeah, that was my reading based on very limited and sufrace level of
understanding of what this function was doing, although I think my
understanding of it is still very skimpy (if I understand it well
enough, I would give it a bit more understandable name but I cannot
come up with one yet).

Thanks.


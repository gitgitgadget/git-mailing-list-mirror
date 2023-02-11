Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C41C636CC
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 22:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjBKWnV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Feb 2023 17:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBKWnU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2023 17:43:20 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BD218B11
        for <git@vger.kernel.org>; Sat, 11 Feb 2023 14:43:19 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id nn4-20020a17090b38c400b00233a6f118d0so6603256pjb.2
        for <git@vger.kernel.org>; Sat, 11 Feb 2023 14:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EtqTpR2pEYrHmCtkXLL2yTv4Cpq/cfonyNLrlQ1EonU=;
        b=askzOwYqOdlJnf/JQSsk2k0W1/lupN2sb1F4Kd/OdhUf2YypT45nv/Pn0gz+tMX7TI
         LkAPTvHJm9laeTJ8g1j4lEVh7QqA+KYkBpk6dMKDGlC/rzGnvE42HRlokb0c64co6myq
         BP/gN9ucJyPO/+W8NSO8y6WnFlOZWZWYS55ZO6Y4JwZZn4SoMMLN7ibmi4YEJnprs0ji
         legcqLk3XzSaKR6a3+PFKhVG/llkob9l2JXEj5CDtghUYQzHdfU4+B/32ZyneY53ywqT
         1KHyq+zVHW352o/zbgnYMe1fLhBUkw7TdyrQyTl84ObrUDa8I3J48nVSFx36AC0qYAEc
         sfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EtqTpR2pEYrHmCtkXLL2yTv4Cpq/cfonyNLrlQ1EonU=;
        b=s8558qn6MFFaGe5lLcOCWUgE3OxW3kYeVTqmn417N1ZMnoEWLpYH8FnRA7rSRWLcFX
         MrAiizH1qmfE1afFhxhiCZIMPuchrxEvHtlt/vfXb8ULBQ1nSsX58H9ljjhnnrXXRmt9
         zmrnZ2X//A88+1A9i0q57fe2lNj/IVTe0DRlOmttg9kZnLr0Tb8b+/LVXzqQ5fmKifGT
         88A4F7yOLkdpV5csm0/oRSqzTte1FErOord/FtBiAhYLgF7EjNX13gYQU3m61NFDYuxZ
         UX0Yx8o/O7Zlrq+n2sqlwoWoMqUDyng3z6R7jrhK9d1bfezI4hqm3is/EppT9QPdvQx7
         sa/A==
X-Gm-Message-State: AO0yUKVv5vRqZP8/9SdtnKa1P5QrA/BiVFGAjxIjogLwtXcEDCkDv9Ix
        cgJe+kszZ5bfvUeZhfG9GgY=
X-Google-Smtp-Source: AK7set9h2ugk0ZfhdA+vsSyae2a+POgdK41Tp6Yuw+yUl3K44Zs8u3xdH2cKoBX3zLfjq1PNOIXB8g==
X-Received: by 2002:a17:90a:760c:b0:233:bd59:5719 with SMTP id s12-20020a17090a760c00b00233bd595719mr3577358pjk.0.1676155398644;
        Sat, 11 Feb 2023 14:43:18 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id q94-20020a17090a1b6700b00233567a978csm3868788pjq.42.2023.02.11.14.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 14:43:18 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] commit-reach: avoid NULL dereference
References: <20230211111526.2028178-1-e@80x24.org>
Date:   Sat, 11 Feb 2023 14:43:17 -0800
In-Reply-To: <20230211111526.2028178-1-e@80x24.org> (Eric Wong's message of
        "Sat, 11 Feb 2023 11:15:26 +0000")
Message-ID: <xmqqcz6fesca.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

>  Not sure if somebody who understands the code better can come
>  up with a good standalone test case.  I figure using the top
>  loop as reference is sufficient evidence that this fix is needed.

Good comment.

>  commit-reach.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/commit-reach.c b/commit-reach.c
> index 2e33c599a82..1d7056338b7 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -807,8 +807,12 @@ int can_all_from_reach_with_flag(struct object_array *from,
>  	clear_commit_marks_many(nr_commits, list, RESULT | assign_flag);
>  	free(list);
>  
> -	for (i = 0; i < from->nr; i++)
> -		from->objects[i].item->flags &= ~assign_flag;
> +	for (i = 0; i < from->nr; i++) {
> +		struct object *from_one = from->objects[i].item;
> +
> +		if (from_one)
> +			from_one->flags &= ~assign_flag;
> +	}

The flag clearing rule of this function smells somewhat iffy.  There
are three primary callers of the function:

 * commit-reach.c::can_all_from_reach() calls the function, but it
   has its own loop to clear the flag it asked the function to add.
   If the function uses the flag as a temporary mark and is designed
   to clear it from all the objects, as 4067a646 (commit-reach: fix
   memory and flag leaks, 2018-09-21) states, why should the caller
   have a separate loop to clear them?

 * fetch-pack.c::negotiate_using_fetch() calls this function in a
   loop, so it does depend on it to clear the flag upon returning.

 * upload-pack.c::ok_to_give_up() is a thin wrapper around this
   function and none callers of it have any logic to clear flag, so
   it clearly depends on the function to clear the flag.

The above seems to indicate that the expectation by callers is a bit
uneven.  Shouldn't the first onetrust the callee to clear the flag?

Even before 4067a646 (commit-reach: fix memory and flag leaks,
2018-09-21), the function had a call to clear_commit_marks() to
clear two bits it used temporarily.  The reason why 4067a646 needed
to add this additional flag clearing, whose NULL-dereference bug is
being fixed with the patch in this thread, is because it marks any
incoming object that peels to a non-commit (e.g. a blob, a tree, or
a tag that points at a non-commit) with the flag bit, but such a
non-commit object is not added to the list[] of commits to be
processed, before the main processing of this function.

		from_one = deref_tag(the_repository, from_one,
				     "a from object", 0);
		if (!from_one || from_one->type != OBJ_COMMIT) {
			/*
			 * no way to tell if this is reachable by
			 * looking at the ancestry chain alone, so
			 * leave a note to ourselves not to worry about
			 * this object anymore.
			 */
			from->objects[i].item->flags |= assign_flag;
			continue;
		}

		list[nr_commits] = (struct commit *)from_one;

But I am not sure if it is even necessary to smudge the flag for the
object that was a non-commit (or the tag that peeled down to a
non-commit).  The main process of this function is a history
traversal that stops when the "assign_flag" bit is already set on
the found object, but the object that was part of the incoming
objects (i.e. in from->objects[] array) that turned out not to be a
non-commit would not be discovered during this history walk, would
it?  In other words, if we walk from list[] that is an array or
commits to the parents (but not its trees and blobs), we won't
encounter anything but commit.  What does it help to smudge an
object that peeled down to a non-commit in the incoming set of
objects, if it would not appear in the walk from list[]?  It would
not stop the traversal by having the flag.

So I wonder if we can just stop smudging the assign_flag bit for
these objects in from->objects[] that do not make it into list[]
as a simpler fix?  Wouldn't that make the follow-up cleaning loop
added by 4067a646 (commit-reach: fix memory and flag leaks,
2018-09-21) unneeded?






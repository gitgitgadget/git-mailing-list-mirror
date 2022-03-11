Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71B1C433FE
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 14:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244508AbiCKOPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 09:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242666AbiCKOPp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 09:15:45 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DDE1C6ED0
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 06:14:42 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id c7so7016706qka.7
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 06:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=ak9YtecTzZv3ISYxh8p2DaFTVkShExUcJIS/UaFavbY=;
        b=XQdssn0PLlCBra6BVTKcbsOBR5BVDXFB5BzLitAGIjkzluy73DbCjXAN1dmZcBcLsj
         CFTiYNP3Ed2gYVdelTJkd8r3ZWg1d2SR23alaNzQg/1HGf1O1FkxI+Tt9AnpJduxU/dK
         FVATnB9fbHs6lC4iYaZacdgC2nyKOrZ3RU511qnnF3EYMdfeCC1GeZKB0jAiHnTOP6yo
         hxjP4z2fAt/Tla+wjUDWDJRhXn0ug5rgVCTrMClcXEKLi6KTIGXvmbeYT/q9p8fKrIsz
         5YZoU6CIriBAWtnu5UUlgwgbLyR2rkSEvTU/j7zXyj2CT50LvSZkejl/HA7pIzAqVacA
         7/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=ak9YtecTzZv3ISYxh8p2DaFTVkShExUcJIS/UaFavbY=;
        b=dXUKvf6Xx0ofpJPYZ3oXZBEcTGN6x3NNo3QCaBxWaycaY5gk8b6dTFI9miTcsEwwjp
         dV/Pj3VFmWScEzLisuqIazDd1VgmeXnLU+gPWz+QqkRwXoxuMhA7Peo93uoN5rMbWsBN
         aSHYyfl100wgfZCvq+OIWpM840df4OT+yp9UkrwD8VmfNhI4SxpYagTZgMX14UPKrJEG
         T2zWRfl8ijhutUtSruWYQ2vsmunGqK3GIffCYjQxUmfbzsHwN7rZ4eIeYWthuxnH7rSw
         Ht3msf3lczEMu8NLRJqAbucUFqKbyFsVjI9WiItTlS2sDJ7+WwHAXqzsCyDTliw4uYJE
         ELkA==
X-Gm-Message-State: AOAM533hVf88dLmvURgOovIt3i6mZEQH7VqJEa4OibV7ke+BczxlXoaf
        bTFAe+W9jKzQc5hDdK3U+9Y=
X-Google-Smtp-Source: ABdhPJwerTgWxXU5aMbCH30eP9Oq5ibSCdVzBg0vv5sAMNWT0GM+7DhavrNQVlR+TyXeTGYmTy1+lQ==
X-Received: by 2002:a37:ad0e:0:b0:67d:3c0c:6aea with SMTP id f14-20020a37ad0e000000b0067d3c0c6aeamr6553745qkm.65.1647008081097;
        Fri, 11 Mar 2022 06:14:41 -0800 (PST)
Received: from [10.37.129.2] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id q26-20020ae9e41a000000b0067d1a20872fsm3921529qkc.94.2022.03.11.06.14.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Mar 2022 06:14:40 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] rebase: set REF_HEAD_DETACH in checkout_up_to_date()
Date:   Fri, 11 Mar 2022 09:14:39 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <B1A94338-404E-43F2-AF3C-889097FD938B@gmail.com>
In-Reply-To: <xmqq5yolav8l.fsf@gitster.g>
References: <pull.1226.git.git.1646975144178.gitgitgadget@gmail.com>
 <xmqq5yolav8l.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 11 Mar 2022, at 0:55, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> This is happening because on a fast foward with an oid as a <branch>,
>> update_refs() will only call update_ref() with REF_NO_DEREF if
>> RESET_HEAD_DETACH is set. This change was made in 176f5d96 (built-in rebase
>> --autostash: leave the current branch alone if possible,
>> 2018-11-07). In rebase, we are not setting the RESET_HEAD_DETACH flag,
>> which means that the update_ref() call ends up dereferencing
>> HEAD and updating it to the oid used as <branch>.
>>
>> The correct behavior is that git rebase should update HEAD to $(git
>> rev-parse topic) without dereferencing it.
>
> It is unintuitive that unconditionally setting the RESET_HEAD_DETACH
> bit is the right solution.
>
> If the command weren't "rebase master side^0" but "rebase master
> side", i.e. "please rebase the side branch itself, not an unnamed
> branch created out of the side branch, on master", according to
> <reset.h>, we ought to end up being on a detached HEAD, as
> reset_head() with the bit
>
>     /* Request a detached checkout */
>     #define RESET_HEAD_DETACH (1<<0)
>
> requests a detached checkout.  But that apparently is not what would
> happen with your patch applied.
>
> Puzzled.  The solution to the puzzle probably deserves to be in the
> proposed log message.

Good point. Thinking aloud, here is the callstack.

checkout_up_to_date() -> reset_head() -> update_refs() -> update_ref()

if <branch> is not a valid ref, rebase_options head_name is set to NULL. This
eventually leads update_refs() to decide that it doesn't need to switch to a
branch via its switch_to_branch variable.

reset.c:

if (!switch_to_branch)
	ret = update_ref(reflog_head, "HEAD", oid, head,
			 detach_head ? REF_NO_DEREF : 0,
			 UPDATE_REFS_MSG_ON_ERR);
 else {
	ret = update_ref(reflog_branch ? reflog_branch : reflog_head,
			 switch_to_branch, oid, NULL, 0,
			 UPDATE_REFS_MSG_ON_ERR);
	if (!ret)
		ret = create_symref("HEAD", switch_to_branch,
				    reflog_head);
}

since the flags do not include RESET_HEAD_DETACH, detach_head is set to false and we get a
deferenced HEAD update.

The solution I came up with works because when <branch> __is__ a valid branch,
udpate_refs() takes a different code path that calls create_symref() with a
branch, which is why we don't end up with a detached HEAD.

I see why this is confusing though. From checkout_up_to_date's perspective it looks like we
are unconditionally detaching HEAD. So what we could do is only set the flag in
checkout_up_to_date() when, from checkout_up_to_date's perspective, we will end
up with a detached head. something like this:

diff --git a/builtin/rebase.c b/builtin/rebase.c
index b29ad2b65e72..f0403fb12421 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -827,8 +827,10 @@ static int checkout_up_to_date(struct rebase_options *options)
                    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
                    options->switch_to);
        ropts.oid = &options->orig_head;
-       ropts.branch = options->head_name;
        ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
+       ropts.branch = options->head_name;
+       if (!ropts.branch)
+               ropts.flags |=  RESET_HEAD_DETACH;
        ropts.head_msg = buf.buf;
        if (reset_head(the_repository, &ropts) < 0)
                ret = error(_("could not switch to %s"), options->switch_to);

Otherwise, checkout_up_to_date() has to implicitly know the downstream logic in
update_refs(). I believe that's the main source of the confusion--is that right?

>
> Thanks.

Thanks
John

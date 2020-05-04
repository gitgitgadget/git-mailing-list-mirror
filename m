Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A65C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 20:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 681A720721
	for <git@archiver.kernel.org>; Mon,  4 May 2020 20:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="THD33hy3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgEDUkE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 16:40:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63179 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgEDUkE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 16:40:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A8ADDBCACB;
        Mon,  4 May 2020 16:40:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=38Az5GVeHv3R7b9dDkjGdHJRnzk=; b=THD33h
        y3bQXjBuiCSHs6yJHFHJGtpW8n4FUcHv26bS1yWnOeQBsR7l+f9TEjOPFm6g0Grs
        PsuzMMVKkQjAQMgsBC0apCQ6uMOH003ayfhPJbDiha3Q7C/dfS3Q5dy+zCAB3h6a
        9EBusPJnueHuBcTEi0raIc29bjH6I22cszax4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DQjAnOk3b63NAFbXmqH5e/IL8LOZG5OX
        ETZc7Fm5rz19pmzad2zQp/IxOGb/2LH1MGp5MxrklhpwYLrK7LrPeKABcdu/7y/O
        uU4FYuuUSWesZnFbX7kYb9SqlIWbWC8yg7QwSHkCSMRK9FFYrEBpwtIqOl6NKRYb
        NWv4She9WBc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8001BBCACA;
        Mon,  4 May 2020 16:40:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B4446BCAC9;
        Mon,  4 May 2020 16:39:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vadim Zeitlin <vz-git@zeitlins.org>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fetch: allow running as different users in shared repositories
References: <E1jHGdD-00079b-06@smtp.tt-solutions.com>
        <nycvar.QRO.7.76.6.2003261538170.46@tvgsbejvaqbjf.bet>
        <E1jUeoi-000205-RT@smtp.tt-solutions.com>
        <xmqqr1vzhd8z.fsf@gitster.c.googlers.com>
        <E1jVeWV-0006Sj-JC@smtp.tt-solutions.com>
Date:   Mon, 04 May 2020 13:39:55 -0700
In-Reply-To: <E1jVeWV-0006Sj-JC@smtp.tt-solutions.com> (Vadim Zeitlin's
        message of "Mon, 4 May 2020 19:04:55 +0200")
Message-ID: <xmqqlfm7fn8k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B05328C-8E47-11EA-893F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vadim Zeitlin <vz-git@zeitlins.org> writes:

> From: Vadim Zeitlin <vz-git@zeitlins.org>
> Subject: [PATCH] fetch: allow running as different users in shared repositories

This pretends the change to affect ONLY "git fetch", but ...

> The function fopen_for_writing(), which was added in 79d7582e32 (commit:
> allow editing the commit message even in shared repos, 2016-01-06) and
> used for overwriting FETCH_HEAD since ea56518dfe (Handle more file
> writes correctly in shared repos, 2016-01-11), didn't do it correctly in
> shared repositories under Linux.

... fopen_for_writing() is not only about FETCH_HEAD.  In fact, the
author of this patch knows "git fetch" was not the primary target.

So, we need to make sure that (1) this change is beneficial to those
other codepaths that use the helper function, and (2) describe the
(good) effect of the patch on these other users in the log message.
We also need to retitle the commit.

Hits from "git grep fopen_for_writing" are

builtin/commit.c:812:	s->fp = fopen_for_writing(git_path_commit_editmsg());

That's .git/COMMIT_EDITMSG file.

builtin/fast-export.c:1049:	f = fopen_for_writing(file);

This is inside export_marks() to create the marks file.

builtin/fetch.c:1191:	FILE *fp = fopen_for_writing(filename);

This is the .git/FETCH_HEAD.

> This happened because in this situation the file FETCH_HEAD has mode 644
> and attempting to overwrite it when running git-fetch under an account
> different from the one that was had originally created it, failed with
> EACCES, and not EPERM.

Isn't that because FETCH_HEAD and others are not concluded with
adjust_shared_perm()?  The fopen_for_writing() that removes and
recreates the target file sounds like a band-aid to me.  The right
fix we should have done when we did 79d7582e (commit: allow editing
the commit message even in shared repos, 2016-01-06) would have been
to open(2) with 0666 (and let the umask(2) adjust it), and then use
adjust_shared_perm() to give it the desired protection bits.  With
the existing band-aid, we won't be able to fix incorrectly created
append-only files, for example, as the band-aid depends on the
contents in the existing file being expendable.

Having said all that, I agree that EACCES is the right errno to
detect for this band-aid, at least for FETCH_HEAD.

I think COMMIT_EDITMSG is also left after "git commit" finishes,
so it will share the same issue with FETCH_HEAD and the same fix
should apply (this is just a hint for you to write an updated
proposed log message for the patch).

I haven't looked at or analysed how fast-export will get affected.
I think it is used to create and leave a "marks" file, to be later
read by another instance of the fast-export process, which may (or
may not) further write new contents to the (same?) "marks" file, but
I do not know the ramifications of unlinking and recreating.  In any
case, even if that is broken, it is not a new breakage this patch is
introducing.  You may want to look at it further to make sure you
are not breaking things, though.

So, here are the things I would like to see in this area:

 - The same patch text, but with updated commit log message, to tell
   readers that we have looked at all the callers that are affected,
   and retitle it (e.g. "fopen_for_writing: detect the reason why fopen()
   failed correctly" or something like that, perhaps?).
   
 - Audit other codepaths that create .git/ALL_CAPS_FILE (e.g.  I see
   that "git branch --edit-description" creates a temporary file to
   edit without fopen_for_writing() band-aid and it does not use
   adjust_shared_perm(), but I think it should) and fix them.

 - The existing repositories have these files created and left whose
   permission bits were set according to the then-current umask
   without taking "core.sharedrepository" into account, so we have
   to keep the "if unable to open for writing, unlink and recreate"
   trick to salvage them.  But it does not mean we need to keep
   creating the files with wrong mode.  Update fopen_for_writing()
   and its users to leave the file created in the right mode by
   calling adjust_shared_perm().  I think fopen_for_writing() should
   switch from calling fopen(3) to calling open(2) and then fdopen(3)
   on the result as the first step.

The first one is better done by you to tie the loose ends for this
discussion.  

Other two items do not have to be done by you.  Anybody interested
can do them as a clean-up (only if people agree that it is a good
idea to do so---so I won't mark this as a left-over-bits yet).

Thanks.

> diff --git a/wrapper.c b/wrapper.c
> index e1eaef2e16..f5607241da 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -373,11 +373,12 @@ FILE *fopen_for_writing(const char *path)
>  {
>  	FILE *ret = fopen(path, "w");
>  
> -	if (!ret && errno == EPERM) {
> +	if (!ret && (errno == EACCES || errno == EPERM)) {
> +		int open_error = errno;
>  		if (!unlink(path))
>  			ret = fopen(path, "w");
>  		else
> -			errno = EPERM;
> +			errno = open_error;
>  	}
>  	return ret;
>  }

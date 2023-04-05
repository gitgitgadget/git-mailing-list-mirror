Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F77C7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 16:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjDEQsd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 12:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjDEQsc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 12:48:32 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2074C17
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 09:48:25 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id v135-20020a63618d000000b005139242a138so6639163pgb.7
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 09:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680713304;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fMtGSb1AC4KvIUVLMrg0WXZSDWUmL0Q48C8MU8g17NU=;
        b=PXIsE/Slwnp4tD74fMYwkNgkta40sXMr35PACZjqTTtpuK4YWghbIa/Zzz975MiVPS
         Id2zCQqan+56YHMUrxCo6iZUimQu59lwaKyqPf3lcvqV91x2XszKbN1ctFiJk3sySNeJ
         I0iy9+06AQ4rZcAsou8PTK4LJ2yQaivU5Zd9CzxeemEwpPv99wWHuOl5HaiaC13rwh2N
         rKi2UlzoSx4HckrGmiqBuDymRwkKYdrumGdDMF2W+U6Ka6YOsFMANM91YAId2lnevBIf
         xJ55YCF0U7ousgKjYXfqHIHofJbYnSRT27pmAo/WW1MOyeq835E9fuqPIN3ADDjydjcz
         igHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680713304;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fMtGSb1AC4KvIUVLMrg0WXZSDWUmL0Q48C8MU8g17NU=;
        b=fgU5b9SxtjO2IDSWOa1LR1dKZXOr/XFwDG803zrQN4/BHeBWsrJLRxBnHPkBMpbBoE
         mIhwVmtrisfS0vn6tw4e1xV9CkvJhVOS1xKbcjlkv+xX97ULG/2mjIbyKawYlcIhybvc
         UJA+rhe0CkJeQhKWWWtU6sVvre5De+3XqVr2H/p9Y9IzVo5PQafOdIoYqC5QoXrQBRbi
         058cKSXiuA9KB3CDsoik6n/86NspPLniiDJKfj6z5+76cJYcg9hqqqEV0niun9/LyHfa
         P7YWghaqehtRm5Xr/o99/15L1KKVD6hO0VTSS10S+31SWczMKtPGIzprL2HnxqcA8exO
         2OEw==
X-Gm-Message-State: AAQBX9dwig4SHKpGBaIhChytFHHU/UTLy3rXuq1AoF2ClXGCA5WShSBN
        jSbUUKcljG8iNo+6aCVpUfhmJKpbRDTaVw==
X-Google-Smtp-Source: AKy350Zy3Ezvb5QzgYNJ/kd8msJBPDI+oagTbFDTF+uHYDRK+4sfVRPtCNQhBB4oxJJzN9Q8t6PvELDTg+t2NQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:902:bb95:b0:1a2:a843:d363 with SMTP
 id m21-20020a170902bb9500b001a2a843d363mr2874380pls.10.1680713304610; Wed, 05
 Apr 2023 09:48:24 -0700 (PDT)
Date:   Wed, 05 Apr 2023 09:48:22 -0700
In-Reply-To: <xmqq7curxk22.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1488.git.git.1680652122547.gitgitgadget@gmail.com> <xmqq7curxk22.fsf@gitster.g>
Message-ID: <kl6ly1n65l7t.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH] clone: error specifically with --local and symlinked objects
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> If you want to do lstat(2) yourself, the canonical way to check its
> success is to see the returned value is 0, not "not negative", but
> let's first see how dir_iterator_begin() can fail.

Ah, thanks.

>                                Unfortunately, if lstat(2) failed
>    with ENOTDIR (e.g. dir_iterator_begin() gets called with a path
>    whose leading component is not a directory), the caller will also
>    see ENOTDIR, but the distinction may not matter in practice.  I
>    haven't thought things through.
>
> ...
>
> 	if (!iter) {
> 		if (errno == ENOTDIR)
> 			die(_("'%s' is not a directory, refusing to clone with --local"),
> 			    src->buf);
> 		else
> 			die_errno(_("failed to stat '%s'"), src->buf);
> 	}
>
> may be sufficient.  But because this is an error codepath, it is not
> worth optimizing what happens there, and an extra lstat(2) is not
> too bad, if the code gains extra clarity.

Yeah, the considerations here make sense to me.

Since this is an error code path, I think the extra lstat() is probably
worth it since it lets us be really specific about the error. Maybe:

	if (!iter) {
		struct stat st;

    if (errno == ENOTDIR && lstat(src->buf, &st) == 0 && S_ISLNK(st.st_mode))
			die(_("'%s' is a symlink, refusing to clone with --local"),
			    src->buf);

    die_errno(_("failed to start iterator over '%s'"), src->buf);
	}

Doing the extra lstat() only makes sense if we saw ENOTDIR orignally
anyway.

Alternatively, since we do care about the distinction between ENOTDIR
from lstat vs ENOTDIR because dir_iterator_begin() saw a symlink, maybe
it's better to refactor dir_iterator_begin() so that we stop
piggybacking on "errno = ENOTDIR" in these two cases. I didn't want to
do this because I wasn't sure who might be relying on this behavior, but
this check was pretty recently introduced anyway (bffc762f87
(dir-iterator: prevent top-level symlinks without FOLLOW_SYMLINKS,
2023-01-24), so maybe nobody needs it.

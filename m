Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D26EC433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 23:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 165D86103C
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 23:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbhJYXCk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 19:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbhJYXCg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 19:02:36 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3432C061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 16:00:13 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id kx11-20020a17090b228b00b001a23c39abfaso449263pjb.0
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 16:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=d4Ah5uvx8cK547CZek5SjiaWLSZttnAOtPToOJLV3/g=;
        b=X0qNBKPcyHj6IQm2kc/15NyIRrNZ8R74FQGudmGqG50v8xMvSi3C3Uj6KPUM3Ry435
         cH+n09650JuZUGk/KAmsuNLTdI3gLdL5FGTP/Ax454jGritUKz1INx+6tSyb6iT8ikz1
         88RF7yf8WnzUdl9qAjCSX1cpgBeiHPQxCXJI7jlTVGNnpwsJ2R14NfuimD/pVfOQp4zt
         s6ep1XmKWdtT8rhcCuQ9ntccgXdMU6ztGmLAxyf0DX/Lzs57osqiuX2BuTD8pbd0/AmE
         YFBQVYEP9RIJqCgGoStL+qVEilZvq2CwtKJhh86hMJI9kZLYpQhKmVT+PE3Em6FtgHUO
         roKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=d4Ah5uvx8cK547CZek5SjiaWLSZttnAOtPToOJLV3/g=;
        b=Th7eeGGGObbAqT5eqErRfOsRfEEHo9A9cmE1fgbqpkcW6i7e1Ffyi39P9qZ4cDwZdX
         /0b0y7I9l/MpzKc+gIUAMV76Rdb8j/GpdpBy9sde3sU3OeTrNb7VQlbawuVj0BBFOH++
         oUOjU8ht6EUVdz+wttavlKjh8ObBfmr3uraztixMl3OwypaoCUim1Mhn+aUqzm/zJbm2
         zWynaBFGe9KqTFaV9hI9mKw1oICwI/UAOwfW6sXh82ZCIRuSLBJEfrhvxvu2KgY73wD6
         5HMkwxrojHrnhIsXfm47NFFoKpwLCtXuMAOjrauhuGbq4YFf8kCHRPoR7dDSax9y3N9L
         I5/A==
X-Gm-Message-State: AOAM531tqmARgy79Xviz+i8gzDbY3K4MqrYgheOKu62vyUYWCiyIiyln
        xVFo8d1cJK7rp/Fy48xkbGc/k/j6cnz9Lw==
X-Google-Smtp-Source: ABdhPJxXm0D243MqdMGfxX+OzTrOSyx9wJjpYa6KxyBq6Tif5UT8MNtwE30zRlP6TmKoES66Z3q5iJoucfrryA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:5285:: with SMTP id
 w5mr200392pjh.1.1635202813010; Mon, 25 Oct 2021 16:00:13 -0700 (PDT)
Date:   Mon, 25 Oct 2021 16:00:05 -0700
In-Reply-To: <xmqqzgqwzvwx.fsf@gitster.g>
Message-Id: <kl6lbl3c7lsa.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Subject: Re: [PATCH v3 2/4] remote: use remote_state parameter internally
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I just checked.  The repository the push is run in is bare and its
> HEAD is detached, pointing at a commit directly.

Thanks, I was able to reproduce the segfault using your config.

>> "current_branch" is allowed to be NULL when HEAD does not point to a
>> branch.
>
> Good point.  It is a good justification to make the remote_state
> available to the function, as branch==NULL that signals "there is no
> current branch in the repository" cannot be dereferenced to get to
> either the repository or the remote_state, yet the function needs
> access to remote_state even when branch==NULL.

Yes, I wish we had noticed this sooner in our discussion and the fault
is mine. It seems that pushremote_for_branch() is a prime example of
"get the settings from the branch if possible, but default to the
correct repository settings otherwise.", which is difficult to express
if remote_state is not available to the function.

> What "branch" is pushremote_for_branch() meant to take?  Is there a
> caller that asks a hypothetical "I know this is not a branch that is
> the current branch in the repository, but to which remote would we
> push if this branch _were_ the current one?" (and passes NULL to
> mean "there is a checked out branch, but what happens if our HEAD
> were detached?") question?  Even if there isn't currently, do we
> want to add such callers in the future?
>
> If the answer is yes, then the function need to take both branch and
> remote_state as two separate parameters.  If the answer is no (i.e.
> we never ask hypothetical questions, we just ask what we should do
> in the current, real, state), then the function can just take the
> remote_state and remote_state->branch being NULL would be used as a
> signal that the HEAD is detached.  I suspect it is the former, as
> this information is used in string-name-to-object translation for
> "topic@{push}" in object-name.c::interpret_branch_mark() function.

I agree that the need for hypothetical "what happens if HEAD were
detached?" questions may arise, though I'm not sure if there are any
right now. When we call branch_get(NULL), the expected return value is
the "current_branch". If there is no "current_branch" i.e. the return
value of branch_get() is the NULL branch. A NULL branch is not usable -
branch_get_push() and branch_get_upstream() return error messages
indicating "HEAD does not point to a branch". (these are the functions
used by object-name.c::interpret_branch_mark()).

Given the convention of "NULL branch == detached HEAD", how do we
proceed? Some options:

a) Represent detached HEAD with a non-NULL "struct branch". This will
   let us continue using the remote_state backpointer, which makes many
   interfaces clean, but is somewhat invasive, error-prone and it uses
   "struct branch" for something that is not a branch, which is itself
   an error-prone interface.

b) Keep the backpointer, but add remote_state as a parameter to
   pushremote_for_branch(). The least possible effort to fix the problem
   and might be 'easy' but is inconsistent with the other functions and
   is prone to misuse because the backpointer and parameter can be
   different.

c) Replace the backpointer with a remote_state parameter. Expressive and
   fits the paradigm of "defaulting to the repo when needed", but
   interfaces are repetitive and shifts the responsibility of
   correctness to the caller (see v2).

d) Default to the_repository in pushremote_for_branch(). Easy, but
   incorrect in general.

e) Some kind of reimagining of the remotes interfaces that doesn't
   have this problem. One possible approach is to remove branches from
   the remotes system altogether, since remotes are primarily concerned
   with _branch tracking information_ and not really _branches_ per se;
   perhaps we are being led astray by our terminology. If possible, this
   is probably the most elegant long term solution, but it's
   time-consuming and it's not clear how we will get there.

Currently, my preference is to go with (c). We can create a clear
expectation to callers that branch tracking information is not complete
without a repository, thus a repository is always supplied, explicitly
or not. If so, the remote_state parameter looks less like an
implementation detail, especially since a NULL branch is allowed.

I know we have already considered and abandoned (c) after v2, but has
your opinion changed after considering the new information?

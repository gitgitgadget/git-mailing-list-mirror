Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCAEC2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 20:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 120B32068D
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 20:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WjFHjYS0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgKIUz3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 15:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKIUz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 15:55:29 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDF9C0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 12:55:28 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id x20so4860023qts.19
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 12:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=H2HjwHXaWJtbFYVqOq2IvLIKW8wV4Q7sVptP6dPoXHs=;
        b=WjFHjYS0AiV32BwNnJ3pjEnjKFiwWbK3v4hRHWrz9DmoKec2k6KgCQPu9Ieu+HS26j
         +zCXtCUU28DwkEvao1XjFym2KWPYZNOTmTjOZI3IL5xVPL6JBgMeFygXQpZNJNN0Z2ac
         Dn+34UONlyrMeSytgsEYjyna2ZpkUE83S5dvpjakaAwbn0JK6EGC5K5oqhNqxsSQuT7s
         x4N/qQL8X0USJLkv6cKL3j5AQbpQ2JtnvuKRDtRyaeACRe9HeN9M8QHAVb2r5rcwktqX
         qhiYD6bzoDFRlx2j38mt7IcP5nppztaquTvgeM6FQko7TAYLhZp0Tpvej0bNUhq6UUgd
         PHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H2HjwHXaWJtbFYVqOq2IvLIKW8wV4Q7sVptP6dPoXHs=;
        b=JIzR33gruFp1vsE4Gxp5T6PeuMKhWU22tisFP5IohLq6AuxQ+CAkRD/uuYhvzYCl7K
         BshtQn1KyuBaHYsb/dPz6s1ngHOPSd21ofA8ikZ1TlES/z0QtBBrDKHwx9GN/0Q1aSK/
         ALyN+2wvqZNaRN03GCIrcmkhd6jSIHoPaL8O5tBRe6EjuwSPGm5Ln85mcoWrE2bPlST7
         1+t8iUzE13u3QeREuj7jMYQ7sj7ifJqxADSSYZP+lZtYiokhhBifz/inT3rK2sPyug+D
         NcPHM9zJe4Ek0eErjcvQ9TQHqv8i6JYHR6kTpcq2HEaAe/G/Iw2WV8hcFbgM58xekmuf
         s/xw==
X-Gm-Message-State: AOAM533wdGWuCqZa4ZATpHW8vFJ/C1p8f2pnq7PtznLJ1+IZiAerWHpK
        6g7I7t8+bc6t5e1HpPfxOlEjrA+w1CVhjAuXa3Al
X-Google-Smtp-Source: ABdhPJy2w+hg2T8mdXEPE8Sr6HzR/eeDXhjMIIkwZSjXvojlxKwrouZMUX6wJXe+tlDC8iP9IXzo6gF/nOAXwBkVuipd
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:e585:: with SMTP id
 t5mr15968669qvm.6.1604955327984; Mon, 09 Nov 2020 12:55:27 -0800 (PST)
Date:   Mon,  9 Nov 2020 12:55:25 -0800
In-Reply-To: <CABPp-BHx4w1_JAen0fupCzosu0NfoTsT9d8dEve7n5VJZ0EvBQ@mail.gmail.com>
Message-Id: <20201109205525.2521806-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BHx4w1_JAen0fupCzosu0NfoTsT9d8dEve7n5VJZ0EvBQ@mail.gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: Re: [PATCH v2 01/20] merge-ort: setup basic internal data structures
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > There seems to be 2 ways of referring to something that we couldn't
> > merge - "conflicted" (or "having a conflict") and "unmerged". Should we
> > stick to one of them?
> 
> Uhm...perhaps, but it feels like I'm going to miss some while looking
> over it.  Also, there are some semantic differences at play.  Since
> the whole algorithm is divided around multiple stages --
> collect_merge_info(), detect_and_process_renames(), process_entries(),
> as of a given early stage we might just know that we couldn't merge it
> *yet*.  For example, both sides modified the entry, or one side
> modified and the other side is missing ("did they delete it or rename
> it?").  After rename detection and three-way content merge, something
> that had not been automatically mergeable as of an earlier step might
> end up being so.  But we need names for stuff in the interim state.
> But it's also possible for us to know at an early state that thing are
> definitely going to be a conflict regardless of what later stages do
> (e.g. both sides rename a path, but rename it differently).

In that case, maybe "possibly conflicted" and "unconflicted"? Or maybe
someone else will come up with a better name.

> > Also, looking ahead, I see that current_dir_name is used as a temporary
> > variable in the recursive calls to collect_merge_info_callback(). I
> > would prefer if current_dir_name went in the cbdata to that function
> > instead, but if that's not possible, maybe document here that
> > current_dir_name is only used in collect_merge_info_callback(), and
> > temporarily at that.
> 
> Yeah, not possible.  collect_merge_info_callback() has to be of
> traverse_callback_t type (from tree-walk.h), which provides no extra
> parameters for extra callback data.  I can add a documentation
> comment.

But traverse_callback_t provides a data field, which you use to store a
struct merge_options in patch 6 - in theory, you could instead create
another struct that contains a pointer to struct merge_options and store
that in data instead. That does sound like it will make the code more
complicated, though, so maybe current_dir_name here is the way.

> > I wonder if this needs to be documented that the least significant bit
> > corresponds to stages[0], and so forth.
> 
> Maybe I should just put a comment to look at tree-walk.h?  The struct
> traverse_info has a "fn" member with a big comment above it describing
> mask & dirmask; filemask is just mask & ~dirmask.

That makes sense. I understood a lot more once I saw that it was
iterating over a variable number of trees - hence the arrays.

Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9972C352A4
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 22:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9192082F
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 22:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HAlvct5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgBLWNl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 17:13:41 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:36270 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbgBLWNl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 17:13:41 -0500
Received: by mail-qv1-f67.google.com with SMTP id db9so1707217qvb.3
        for <git@vger.kernel.org>; Wed, 12 Feb 2020 14:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mAzU2geDuLVagJ9IhS2Z49g1pIeYgci4zP6GpHOUA6g=;
        b=HAlvct5owelcxDRlhFbeiECgP572btfnj0X3WSrJC2M8mY7jjJXkn2YkHsDM5lHBu7
         2QrYNnS7Qzrqu0KTGDRZDNP439tPsSKUBmy3LDurXcp66YcXbMvRQ3CYcyx/15BlY5Iv
         W0X+mG3weAsmlGFEOyLVmCLKq6fAx1HCGMkeX5R+Pfc6MR3EGv2Tsq8ZajDpa8z5u8Od
         TzI72i1b6M07wcrChgmDT8oQl4o7Xi2p/sViX7P4vrPe0Cvyt+An/nraWR7NEb7ShQTq
         Qqe8IPT6bVOXXM5RtEMIqcwmRa/L8wiDCyriaRq3f0zJo79ftKLNswQidCnNPSepjHda
         IlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mAzU2geDuLVagJ9IhS2Z49g1pIeYgci4zP6GpHOUA6g=;
        b=qVfmxxcwMvvfDeN3aame2u2pOtU7IIe35CsuO1WUE85bsFuWn+hX15X9d0U/hyCiNz
         RBEjr0iaoHsHYF3qNR16/3UQ4DXF0atGXoF/2DJeYgWx6bO8cnNkU/s7VYYxeDtVjUr0
         nhdzrcuvR5oaAJVZdM2mA4MVQmEJUK8QcchkODjE94ANIvx5x1/WIFABSsCmfk0Rl4tY
         Ck895n3+Fg+M1bZrLf4gbut+08jVBhjimitRFac7RPYPruFWEx04wooJVisQKsBhrgtY
         v+lv26u2fVqXe5i7LmKwrrX6Iw4/Gu6cXDXt58X7YC0PBSL6bTBqBhBdJxvqUgl63TPs
         wRBQ==
X-Gm-Message-State: APjAAAU9d+s8P/0323WalKDv9iAztUfaQNft6Y58cC2sc2qOWc98hFf8
        OAjM5qUInevYECxOAQFLDAZ1Nm6ENDJg9Yu6oCgxIC71B9A=
X-Google-Smtp-Source: APXvYqxiCdqEXnmvcfqf04yXUFRQj8Hu0lHp+/g9w0HGZ1e/lEGi1ylUbLIlwrrYv8krY14cZAduco7GCn0NXNHZYo8=
X-Received: by 2002:ad4:4511:: with SMTP id k17mr8743820qvu.135.1581545619973;
 Wed, 12 Feb 2020 14:13:39 -0800 (PST)
MIME-Version: 1.0
References: <20200131221800.240352-1-masayasuzuki@google.com>
 <20200207204225.123764-1-masayasuzuki@google.com> <CAJB1erXMR_aCqVPsH6WQZdC7yybOBCUbwkJDv3LtU2f0ymNmbQ@mail.gmail.com>
 <xmqqlfpe2jx3.fsf@gitster-ct.c.googlers.com> <CAJB1erVZ5E6FxtD8gJXXpzJjquvksLxpz+h1TzG52Yr9DFmDRQ@mail.gmail.com>
 <xmqqa75t3l1h.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa75t3l1h.fsf@gitster-ct.c.googlers.com>
From:   Masaya Suzuki <masayasuzuki@google.com>
Date:   Wed, 12 Feb 2020 14:13:29 -0800
Message-ID: <CAJB1erWuCTYtGdjiwBT3hhbH5Jrdr+cE8duwtoH=P7Fe6BmUpg@mail.gmail.com>
Subject: Re: [PATCH v3] doc: describe Git bundle format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 7, 2020 at 5:49 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Masaya Suzuki <masayasuzuki@google.com> writes:
>
> > Yes. The reason that I've been trying to check the semantics of the
> > prerequisites is that I DO recognize that this is possible
> > format-wise. I'm not sure if this Git implementation can create such
> > bundles, but format-wise such bundles can be created.
>
> Yeah, now I get it.
>
> The problem is *not* that v2 format "cannot represent a shallow
> clone repository", but is that there is nothing that prevents a
> bundle in v2 format from depending on objects behind (not just at)
> the shallow boundary, making it impossible for a reader to guarantee
> that a bundle with prereqs can be used to create an equivalent
> shallow repository with shallow boundary at the same place as
> prereqs.  IOW, bundle with prereqs in the v2 format allows more
> objects to be omitted than an equivalent shallow repository omits,
> because prereqs and shallow cutoff points mean different things.

Yes. So, I think it's better to say prereqs and shallow boundaries are
different.

> While we are at it, I suspect that with reachability bitmap, a "git
> fetch" that updates a history up to commit A to a new history up to
> commit B can omit more objects than what is directly reachable from
> the commit A.  That is, if A's direct child (call it C) is a commit
> that reverts A, a blob in A's tree won't be in the bundle (because A
> is a prereq), but the blob at the same path in C is the same blob as
> the blob at the same path in A's parent (that is what it means for
> that A's direct child to be a revert of A).  In the normal
> enumeration based on object-walk to decide which objects to send,
> such a blob in C will be included in the pack,

That's interesting. I have never looked CGit's implementation, but I
think JGit would omit those objects. (At least that was my
understanding. Not confirmed with the code.)

Anyway. Is it OK with adding this small note on "prereq is not a
shallow boundary"? In practice, there are not many Git implementations
that handle Git bundles, so it's not that big deal as long those few
implementers recognize this, but this document is meant for those
implementers.

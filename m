Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F306C10F29
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 19:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0372D20777
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 19:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FLyj21cp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgCRT20 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:28:26 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:46374 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgCRT2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 15:28:25 -0400
Received: by mail-pl1-f202.google.com with SMTP id x6so6200959plo.13
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 12:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=H/+fSBWfvTp5XKd8/lYP1N3HcuoQwc+tRQZYYxjO9Rg=;
        b=FLyj21cp6vSmcY+a8sYMhMm0rna6Zn47wEhkTBTXrhygXnNUKYbNgWLiawxJY/FUKd
         oB6ANyetmlYImz4eNRgtDXLpPnM0kUqWVDPim1rqd/Bnccw8BBE0z5YfONDYzeQKmNXD
         IjF7ICWbEC2fROTWNdiy5102fU+Qx2afgSVhfUs3KvZxeojxDStJ4ueiC69P9naSSzuu
         HOJwxYea+23wdSvCSJwhhh0HEgywiZHi8Dskvc2CE7aEpmdeoGmoX5hiMs7uvPnVkOos
         kobSFQDI2X7NfKX9IMORQlOsW5/1eY9PojNcVLq1Up9PnuZx/mFp43hHiX2J8hABvhl3
         36HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H/+fSBWfvTp5XKd8/lYP1N3HcuoQwc+tRQZYYxjO9Rg=;
        b=ODSvTU5o2wh1ZdUJT0NrJ/N3ZqD4C8xyFFCeR6kuGKHzW2jpcgE7XsgQKdYy3RSwYC
         H/BeqnBk2C0IIIOLtpkcfTL9W3sdh1oW7rNm1FVpG6jnFqy4isbdHNTpRo2a8rxxPplT
         y6C2PbAWAw/0M57wJDQ3gos7hshWqf1EXCechQfFF81+HGVC+j6TZHCwykVajgDjYlbh
         tcZ7VDuKesKZxxkfNbtga4oAV4cj8qLKAtjV8nbLUiyRqDG91HcgVtXK1hq3VLGDQw9o
         WLzF05MY2YBfmjXTS7df1ipn+xovTqn4vFx2qMQVfpJY4Dd2Q1FIrn8EW3J9F9Qg+Hlx
         qSpQ==
X-Gm-Message-State: ANhLgQ2onc2Ite+DSFkpapzUgURrhXlpTOZh6pkOUGlee7vbSov2rw2z
        5godG6qpdIH38UuRYkUTom1TEHEAJsw5uUXKA6KZ
X-Google-Smtp-Source: ADFU+vvwmpeemCf528KVes8WKdMDQADv9k1WC7bDl6aQz5qLGa5yOikDocbrUEi9oFay0yUFDNBIqHYSJ1ivcXQg0CtY
X-Received: by 2002:a17:90a:8586:: with SMTP id m6mr5999474pjn.121.1584559704688;
 Wed, 18 Mar 2020 12:28:24 -0700 (PDT)
Date:   Wed, 18 Mar 2020 12:28:21 -0700
In-Reply-To: <xmqqpnd9fql0.fsf@gitster.c.googlers.com>
Message-Id: <20200318192821.43808-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqpnd9fql0.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: Re: [PATCH v2] rebase --merge: optionally skip upstreamed commits
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, me@ttaylorr.com,
        Johannes.Schindelin@gmx.de, newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > When rebasing against an upstream that has had many commits since the
> > original branch was created:
> >
> >  O -- O -- ... -- O -- O (upstream)
> >   \
> >    -- O (my-dev-branch)
> >
> > it must read the contents of every novel upstream commit, in addition to
> > the tip of the upstream and the merge base, because "git rebase"
> > attempts to exclude commits that are duplicates of upstream ones. This
> > can be a significant performance hit, especially in a partial clone,
> > wherein a read of an object may end up being a fetch.
> 
> OK.  I presume that we do this by comparing patch IDs?

Yes.

> Total disabling would of course is OK as a feature, especially for
> the first cut, but I wonder if it would be a reasonable idea to use
> some heuristic to keep the current "filter the same change" feature
> as much as possible but optimize it by filtering the novel upstream
> commits without hitting their trees and blobs (I am assuming that
> you at least are aware of and have the commit objects on the
> upstream side).
> 
> The most false-negative-prone approach is just to compare the
> <author ident, author timestamp> of a candidate upstream commit with
> what you have---if that author does not appear on my-dev-branch, it
> is very unlikely that your change has been accepted upstream.  Of
> course, two people who independently discover the same solution is
> not all that rare, so it does risk false-negative to take too little
> clue from the commits to compare, but at least it is not worse than
> what you are proposing here ;-)  And if one of your commits on
> my-dev-branch _might_ be identical to one of the novel upstream ones,
> at that point, we could dig deeper to actually compute the patch ID
> by fetching the upstream's tree.

As far as I know, the existing patch ID behavior is only based on the
patch contents, so if there was any author name or time rewriting (or if
two people independently discovered the same solution, as you wrote),
then the behavior would be different. Apart from that, this does sound
like a cheap thing to compare before comparing the diff.

Elijah Newren suggested and I investigated another approach of using a
filename-only diff as a first approximation. The relevant quotations and
explanations are in my email here [1].

[1] https://lore.kernel.org/git/20200312180427.192096-1-jonathantanmy@google.com/

> That's all totally outside the scope of this patch.  It is just a
> random thought to see if anybody wants to pursue to make the topic
> even better, possible after it lands.

OK.

> > New in V2: changed parameter name, used Taylor's commit message
> > suggestions, and used Elijah's documentation suggestions.
> 
> Hmph, what was it called earlier?  My gut reaction without much
> thinking finds --no-skip-* a bit confusing double-negation and
> suspect "--[no-]detect-cherry-pick" (which defaults to true for
> backward compatibility) may feel more natural, but I suspect (I do
> not recall details of the discussion on v1) it has been already
> discussed and people found --no-skip-* is OK (in which case I won't
> object)?

It was earlier called "--{,no-}skip-already-present" (with the opposite
meaning, and thus, --skip-already-present is the default), so the double
negative has always existed. "--detect-cherry-pick" might be a better
idea...I'll wait to see if anybody else has an opinion.

> I also wonder if --detect-cherry-pick=(yes|no|auto) may give a
> better end-user experience, with "auto" meaning "do run patch-ID
> based filtering, but if we know it will be expensive (e.g. the
> repository is sparsely cloned), please skip it".  That way, there
> may appear other reasons that makes patch-ID computation expensive
> now or in the fiture, and the users are automatically covered.

It might be better to have predictability, and for "auto", I don't know
if we can have a simple and explainable set of rules as to when to use
patch-ID-based filtering - for example, in a partial clone with no
blobs, I would normally want no patch-ID-based filtering, but in a
partial clone with only a blob size limit, I probably will still want
patch-ID-based filtering.

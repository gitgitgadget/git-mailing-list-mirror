Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07662C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 21:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbiGRVYL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 17:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbiGRVYK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 17:24:10 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E5027142
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 14:24:09 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id y10-20020a056a00180a00b0052b10093100so3741890pfa.4
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 14:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=Mmg61fQ53z3qZ78ADvFbpXqyYdUJU/WanI18LVXm6FU=;
        b=GyjGPgCP/dCxBSYSCd6gDRzehsB2IH5OPnAJME4mbVHNx3u7w34wCFsGkmXnT5Y50y
         QgOOGLI12IdIFqPRb95Za0OH2ZlHmJ0T/JdZn0aEQUEY/cYHbiyGE6kNY22axH36neB/
         5Q3O6x1XHo+1QVw/Ht0y9/HXLVpPEhAmK94ikwgiFvCcnxEjt8mAiSyJvWygyAGCNSGo
         FhXdxCqr93kvBlsIlGN9Y/c/oebJQ/uWZThNO2gKlE4/9/YjGBe87scRCDGF6UkYLgjR
         2nhCULOMdI98IvrugKu7bqs5Is16MYkL4Q1GB1rFd5qdHWOSxbnbNqTTlmRZ40rD1ECz
         OzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=Mmg61fQ53z3qZ78ADvFbpXqyYdUJU/WanI18LVXm6FU=;
        b=T6T61+DirLBQpPcG32S5Qpi/de3CaNRM8GOcVgj+QwRvSZQYr+c12REgZBh85S50qG
         DtYRBQxG6qUeTQaN9WhFp5CMkNfGPcowajIuc4JPsEGhbEU4HcgF0oMjKYg5azXIUXy5
         YFSpZu+SoIGBXiPF8HU63rzgRZ6GGlVhuL3Q7DWX87TuiVZpJFaQa0fMqlIzZj6HGRAs
         7hFNGJJob1WuHK4Fe+cSzIt6qwxsGGFQC6IvHd1NDEjJEV9SYDt7e1UqLHMnNFUnAoWl
         SUFfrr4QnjxQjq/2pNnAkH9HgGwN/JpmGPFQbuBQv79QRavNvKx4SlMC+hcVpnGplIjY
         WrTw==
X-Gm-Message-State: AJIora9w70P56jWorH5a+7mNR/MPx7A9JQx2jVtXo/+v9Dhau1cnrux/
        zrR1BKJ8rZBUdi+Lgy5BfYZYdePfyjKQNg==
X-Google-Smtp-Source: AGRyM1u8+MQ4oV2p1sI471Xu7ZtvL1WVY69xrDyNxsKp1S/6sG9I4Deb/DUhZYp4Q9jrZpmP0JqomvBtOXddUg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:10e:b0:1f1:f3b0:9304 with SMTP id
 p14-20020a17090b010e00b001f1f3b09304mr41700pjz.1.1658179449107; Mon, 18 Jul
 2022 14:24:09 -0700 (PDT)
Date:   Mon, 18 Jul 2022 14:24:07 -0700
In-Reply-To: <20220718173511.rje43peodwdprsid@meerkat.local>
Message-Id: <kl6lo7xmt8qw.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru> <20220718173511.rje43peodwdprsid@meerkat.local>
Subject: Re: Feature request: provide a persistent IDs on a commit
From:   Glen Choo <chooglen@google.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Stephen Finucane <stephen@that.guru>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> On Mon, Jul 18, 2022 at 06:18:11PM +0100, Stephen Finucane wrote:
>> ...to track evolution of a patch through time.
>>=20
>> tl;dr: How hard would it be to retrofit an 'ChangeID' concept =C3=A0 la =
the 'Change-
>> ID' trailer used by Gerrit into git core?
>
> I just started working on this for b4, with the notable difference that t=
he
> change-id trailer is used in the cover letter instead of in individual
> commits, which moves the concept of "change" from a single commit to a se=
ries
> of commits. IMO, it's much more useful in that scope, because as series a=
re
> reviewed and iterated, individual patches can get squashed, split up or
> otherwise transformed.

My 2 cents, since I used to use Gerrit a lot :)

I find persistent per-commit ids really useful, even when patches get
moved around. E.g. Gerrit can show and diff previous versions of the
patch, which makes it really easy to tell how the patch has evolved
over time.

That's not to say that we don't need per-topic ids though ;) E.g. Gerrit
is pretty bad at handling whole topics - it does naive mapping on a
per-commit level, so it has no concept of "these (n - 1) patches should
replace these n patches".

I, for one, would love to see some kind of "rewrite tracking" in Git.
One use case that comes up often is downstream patches, where patches
are continuously rebased onto a new upstream; in those cases, it's
pretty hard to keep track of how the patch has changed over time

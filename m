Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCF9C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 22:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3832070E
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 22:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bNa/o4If"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfKVWGy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 17:06:54 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37453 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKVWGy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 17:06:54 -0500
Received: by mail-pj1-f66.google.com with SMTP id bb19so64554pjb.4
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 14:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SIFm2RM1yV+ZiFZnbGAPBxXq58hgiv0857X3Ux0BbHw=;
        b=bNa/o4IfqrIDzZIaW3f4hsTn1iu9G40cScgq3WQNw1BCCjKIi77SFAYe2yvnvRgBIC
         ZHSCyaT+YuEIKaduL+wk3/4jvv8ZckpCetMC35b+NBfbszI/LuGr94VowXUElN9/qs8Z
         47FIe//dsvxPH3iHXTfiN+NLqn7OuJswtm78RzjVfGjfT6qnC/xkZcWfa6esN/BtH20N
         2Txl8he8BMzgEhjsA5Ly88VLb2O9bbwndrIXHnQJEIZXO7NQPtxm3UyfXBZA4zbcOY62
         wni4AKxfQx0pwaxIMGAQAaP+z63iGwOZZKSbB2pljf2Aj6j6LkztmUZVT7VRHGygWxhL
         HhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SIFm2RM1yV+ZiFZnbGAPBxXq58hgiv0857X3Ux0BbHw=;
        b=oiRvSJCNhRvKDryddUlQjAsnCM3P9LEKmIIyMaxJWmfhJ9QeKz4ZQuSmBXyR/XBE2V
         nGssU6Qu8bRQKJ9OxNNRw3d6FtlRBi/WArJWDDdta8qvBTQ9Xq+7VBvQewZn86XswYWB
         oO/UYjzQgxbG1JlnhGrtTgus/vNxMGubRsiHL5AP04OieLspesbcZwpxfcSEfSMyw3my
         DtCGcAwBJxXOzJBHx7fceQb77FS78fUPEXOU9rkM51NpOdamvfEK897/r3SJg1+3Q050
         WD25OikueHF3er/bYbQVH+/fVxhT1/HJ7+Wi4TREEEW+D7WjDY/AggOZu6Pr/LWD4HJ4
         G3VA==
X-Gm-Message-State: APjAAAUh0FjoriU31Qbk+0fXUYLoir/wqkcCnVlq7rGQ7sRxQsgU6SHW
        bYWQMF7DFNAgzvPjUHGZrTTtAw==
X-Google-Smtp-Source: APXvYqzmQ27f4f2genvEw9u6i8rShZ45RTq7VirCxaf5U5RAcCrVF1yj4mYC6cUJJTEaM4r0kZLLpw==
X-Received: by 2002:a17:902:6ac2:: with SMTP id i2mr6243811plt.133.1574460413264;
        Fri, 22 Nov 2019 14:06:53 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id v17sm9108419pfc.41.2019.11.22.14.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 14:06:52 -0800 (PST)
Date:   Fri, 22 Nov 2019 14:06:48 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] grep: provide pathspecs/patterns via file or stdin
Message-ID: <20191122220648.GA101478@google.com>
References: <20191122011646.218346-1-emilyshaffer@google.com>
 <20191122021419.GA52557@generichostname>
 <xmqqwobs7i6u.fsf@gitster-ct.c.googlers.com>
 <20191122220241.GA56020@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122220241.GA56020@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 22, 2019 at 02:02:41PM -0800, Emily Shaffer wrote:
> On Fri, Nov 22, 2019 at 11:34:17AM +0900, Junio C Hamano wrote:
> > Denton Liu <liu.denton@gmail.com> writes:
> > 
> > > The reason I ask is because (correct me if I'm wrong) a lot of other git
> > > commands (like add, reset and checkout) don't seem to accept pathspecs
> > > via stdin and could suffer the same problem. xargs seems like a more
> > > general way of solving the problem of long command lines.
> > 
> > You contributors who are potentially throwing your own topics into
> > the cauldron, please be paying a bit more attention to other topics
> > already cooking in the pot.  I think am/pathspec-from-file wants to
> > go in the general direction.
> 
> Thanks for pointing it out. It is certainly easy to miss the big picture
> when you spend your time looking at a bug queue instead of a review
> queue; we who stand in different places see different things more
> clearly. I appreciate the reminder to look around a little more.
> 
> am/pathspec-from-file does solve this issue in the way that we discussed
> internally, so I'm excited to base a solution for this issue on that
> branch instead.

In fact, as I think further, it could be that the solution is "don't
change anything, just use --pathspec-from-file". But I think my next
question will still be useful to learn the response to anyway. :)

> In this situation - where it is not a related fixup for a branch in
> next, but the topic does rely on that branch - should I send a series
> which is based on 'next'? How do I make the dependency clear to you via
> emailed patch?
> 
>  - Emily

Return-Path: <SRS0=qItC=6C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19D4C352BE
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 20:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F3F0221F7
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 20:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTI7pVu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgDRUSu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727927AbgDRUSu (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Apr 2020 16:18:50 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8CAC061A0C
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 13:18:49 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g10so4244346lfj.13
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 13:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Amw4txvyBTWw1h2KNQYOsBTYbnNJNuwhjC496m7b6zk=;
        b=GTI7pVu7ku+TSxk0T5VeSo2BHpYqeQrzHsiZZFtf1DHMb5Of3pTSBD5DrZm0L2es0f
         xp9llmpweW5qj702puwYJVBHLbGD2s4GhUULilaVMBSwU1pFA6PtPOLRr6EYf8Y7zKGF
         uO3oFzIayJSMY15kS+O9libYbDRl7w5w8zDGxwxhIkc7V4He1+3nHWVleS8yZgz9Gqp3
         bN2MY5Mt81zv1ceVjcXTnPonZ3sfDHw2Z+hy+tpJQ4Trxj3LvoXq+MJ34pQDbQ8WNHIh
         PKdC6HdjjI83HwkpxtcGJtfopV2bkfG+UievKpyLsKXR8E6zZV5TUGNnczWFxVfRxniE
         LZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Amw4txvyBTWw1h2KNQYOsBTYbnNJNuwhjC496m7b6zk=;
        b=MM2LeUR47gTYWlxXHzRGzHafoi5Mpt9XsLy1pJTwbYzF7NLwspSVqQevSViuTDFo8T
         l/MtmwlW3VhbZ2yw9gmRS6wbrRtYtQHL2mAzdj8Fqznm6L3aHgLOel1trahPlsVhVP3x
         Y92nfBssqo8Sl6TL4PT8Y/jrmNNjydW+r78f0MJ46dTR3Ic/soGp48flBqMHoTubvIzN
         ZMCtz2xva2pIYhPDgZdBOP10tvzHSAy26mmd57YGAaI1Hndy3lrZ0qMFnBnTyFcF5LPu
         IKN/Q01kNMASj9f60PAQ1DnJdMo9820A3lwDxS5SKVGLwOVDTumEqZcmZaSs1M9FcRH9
         SwPw==
X-Gm-Message-State: AGi0Pua2jKZgvzqXe+GdbjAW8r3VRZFEw/KP0jH9qppOs7+BTEW9MDq5
        bKuf3GKNJ6tlZUF7K9wJzRv9012M
X-Google-Smtp-Source: APiQypKJdz2Y5ZHcWPokNeK1lbwf+s5miqd3GEiArFtBAXptZxiPHKgzyEjbNcGo2UM4UYb/iBAtug==
X-Received: by 2002:a19:dcc:: with SMTP id 195mr5715927lfn.193.1587241127929;
        Sat, 18 Apr 2020 13:18:47 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id 73sm218713ljj.72.2020.04.18.13.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:18:47 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 0/6] strbuf: simplify `strbuf_attach()` usage
Date:   Sat, 18 Apr 2020 22:18:23 +0200
Message-Id: <cover.1587240635.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <CAN0heSppn6BBX4V1T1qgKc4XP+8i6qbcEqd1_3NqWQtZJLaJww@mail.gmail.com>
References: <CAN0heSppn6BBX4V1T1qgKc4XP+8i6qbcEqd1_3NqWQtZJLaJww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 18 Apr 2020 at 21:56, Martin Ågren <martin.agren@gmail.com> wrote:
> > -       strbuf_attach(line, out, strlen(out), strlen(out));
> > +       strbuf_attach(line, out, out_len, out_len);
>
> This conversion is ok as such. I wondered why we pass in the same
> value twice (before and after this patch). Turns out this usage is wrong
> (as per the documentation in strbuf.h) but safe (as per my understanding
> of the implementation in strbuf.c). I'll follow up with a series that
> fell out of that investigation.

Here's that series. It could go in parallel to Danh's, or one could go
on top of the other. Any of those would be ok with me.

I think `strbuf_attach()` is sufficiently hard to use that we might as
well simplify it for the majority of the users that don't care about the
distinction between the string's length and the size of the allocated
memory, and avoid it for the few remaining users that are just as well
off using `strbuf_add()`.

The summary is that this function takes `len` and `alloc`, where the
latter must be greater than the former, yet several callers use the same
value for both. I first thought this could cause quite hairy problems
such as writing outside of allocated memory, but it doesn't look that
way. See the patches for more information.

An alternative to the approach taken here would be to introduce
`strbuf_attachstr()` and convert most existing users, then convert the
few remaining ones to use the new function or to move in another
direction. But the new name is a downer -- what else would you attach to
a strbuf if not a string?

Another alternative would be to first convert certain users away from
the function, then simplify it for the remainder. I preferred to first
spend a few patches converting a few existing callers to make it clear
that those are ok.

Martin

Martin Ågren (6):
  am: use `strbuf_attach()` correctly
  strbuf_attach: correctly pass in `strlen() + 1` for `alloc`
  strbuf: use `strbuf_attach()` correctly
  fast-import: avoid awkward use of `strbuf_attach()`
  rerere: avoid awkward use of `strbuf_attach()`
  strbuf: simplify `strbuf_attach()` usage

 strbuf.h             | 16 ++++++++--------
 apply.c              |  2 +-
 archive.c            |  2 +-
 blame.c              |  2 +-
 builtin/am.c         |  2 +-
 convert.c            |  4 ++--
 fast-import.c        |  7 ++++---
 imap-send.c          |  2 +-
 mailinfo.c           |  2 +-
 merge-recursive.c    |  2 +-
 path.c               |  3 +--
 pretty.c             |  4 ++--
 refs/files-backend.c |  2 +-
 rerere.c             |  3 ++-
 strbuf.c             | 11 +++++++----
 trailer.c            |  2 +-
 16 files changed, 35 insertions(+), 31 deletions(-)

-- 
2.26.1


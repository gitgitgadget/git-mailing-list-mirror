Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AF7C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 18:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48237206F2
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 18:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1rzFzhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgC0Soi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:44:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37954 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgC0Soi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 14:44:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id s1so12673631wrv.5
        for <git@vger.kernel.org>; Fri, 27 Mar 2020 11:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+EK/EYdX0R2iGZ/c9X7LUH+Psmpc3OfBkr1rwXNPORM=;
        b=r1rzFzhVm0hW2NgsvMzRxinpNIjJV348iK8yHJCsZvM1dn9eCgxIqWJSw/gOJNE/+G
         iIb6XXm8txOrzoQSwEt5Uu8No+6j7VSI7CrlLK2j4d8HxccipEnCqMnLJdplIoYy3JjO
         VRXrQqKP2MaNana1B76gol7mxIyTZ4aAzhPT/hPr3TruoHojvVOk5wll+4N3eSiWqoyi
         +AXy8Cg75mAEfoBwlpsRmfupBMXE1kW5RyM3+p77xhMBZWZ9+YJRHzT7yvHs5Uwc3Efb
         TSQEAj+MsJtOQ/qJOMdwkE3pG3cP4xuEdT1pPqBLv3lqokS+oZ5G5mLcqzwnSR0gIL+Q
         odDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+EK/EYdX0R2iGZ/c9X7LUH+Psmpc3OfBkr1rwXNPORM=;
        b=TH3+m6nYn+99aPSytV/rGxMLqwJU0YkMJ6x6gpBZLV+OaK9NNwvBJMd9uLEBHZfaQ2
         kLStdnl4Knf1nqDs4F4+JM4Hd91PrH7aYdbpwMl3fJi39qTrzxCMRNHYrP4sUvJbNBwh
         nQOUVwQE42/C9TT+nATfJ0CsWjJSRJHrkdNquQKoQo7BTKFJL7eCCB8qrMJSeI+5oyK+
         Us47lJbA201tF2Im6f0E3GO0fqwGfBZeElgYDfesNg9XWePbu8wGtGoIOMNtXtsinepg
         t7e8X1mXNPtSd5SO2wR+TyYh0H80mvNW4oqCEtdMYLZd9XQSD4Dt8l3St8UJgKegOEV/
         ItTw==
X-Gm-Message-State: ANhLgQ23k3nPh0gbUV3fhdmYgWHckCYU3+5Hac5a7Jpy+GC6C9Z5Oaxe
        VH1iCmY6J7QXKZ1OJsz3VF0=
X-Google-Smtp-Source: ADFU+vvTFlPcJWm3/Nna8zAuqH7ihpynst7cLcRPS3pJ7HEM0o9LM9wKrpc/qsv7B0ws11ajq3+P2w==
X-Received: by 2002:adf:ce0d:: with SMTP id p13mr852759wrn.8.1585334676066;
        Fri, 27 Mar 2020 11:44:36 -0700 (PDT)
Received: from ocellus (p200300EAE7168C007DE5706AB5458F3F.dip0.t-ipconnect.de. [2003:ea:e716:8c00:7de5:706a:b545:8f3f])
        by smtp.gmail.com with ESMTPSA id c18sm9601256wrx.5.2020.03.27.11.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 11:44:35 -0700 (PDT)
Message-ID: <58dbecff48068644daa24b5e39c03dc8ddfb0053.camel@gmail.com>
Subject: Re: git rebase fast-forward fails with abbreviateCommands
From:   "Jan Alexander Steffens (heftig)" <jan.steffens@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Alban Gruin <alban.gruin@gmail.com>
Date:   Fri, 27 Mar 2020 19:44:34 +0100
In-Reply-To: <CABPp-BEV0NxMLuM3U8fqECkEB_XHTvLMav1q_TiYveBWrpsr_w@mail.gmail.com>
References: <9b4bc756764d87c9f34c11e6ec2fc6482f531805.camel@gmail.com>
         <a3cc46ca-824d-8cab-e333-83f51a7824ca@gmail.com>
         <CABPp-BEV0NxMLuM3U8fqECkEB_XHTvLMav1q_TiYveBWrpsr_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2020-03-27 at 11:39 -0700, Elijah Newren wrote:
> Hi Alban,
> 
> On Fri, Mar 27, 2020 at 8:46 AM Alban Gruin <alban.gruin@gmail.com>
> wrote:
> > Hi Jan,
> > 
> > +cc Johannes, Elijah, and Phillip.
> > 
> > Le 27/03/2020 à 12:44, Jan Alexander Steffens (heftig) a écrit :
> > > Hi,
> > > 
> > > Since 2.26.0 a simple "git rebase" fails to fast-forward a
> > > branch, reporting "error: nothing to do."
> > > 
> > > It started to work again after removing my gitconfig. I've
> > > reduced it to the following:
> > > 
> > >     git init foo; cd foo
> > >     git commit --allow-empty -m foo
> > >     git commit --allow-empty -m bar
> > >     git checkout -tb foo
> > >     git reset HEAD~
> > >     git -c rebase.abbreviateCommands=true rebase
> > > 
> > 
> > Thank you for reporting this bug.
> > 
> > Since git 2.26, the default rebase backend switched from "am" to
> > "merge".  So, by default, a todo list is created, even if you can't
> > see it.
> > 
> > In this case, the todo list contains only a `noop', but this
> > command has
> > no short form, and is abbreviated with a comment mark.  As there is
> > no
> > more commands in the list, the backend will fail with the error
> > "nothing
> > to do".
> > 
> > Three approach to fix this:
> > 
> >  1) add an abbreviation to `noop';  this is the simplest fix, and
> > "n" is
> > not taken.
> >  2) if a command has no short form, do not abbreviate it;  this is
> > trivial to do, and should not break anything.
> 
> Both sound reasonable to me.
> 
> > A third approach would be to change the meaning of an empty buffer,
> > but
> > this would break some tests (at least t3404.3) and cause more
> > confusion
> > for users than necessary.
> 
> Well, "error: nothing to do" probably makes sense if the user
> specifies a list of empty commands or sees a list of empty commands
> and agrees to pass these to the backend.  But I'm not sure that
> message makes sense for implicitly interactive runs as opposed to
> explicitly interactive ones.  Perhaps we could change the message to
> just be "Already up to date" if the buffer is empty and the run is
> not
> explicitly interactive?

Changing just the message and return code wouldn't be enough, as the
empty todo results in the rebase being aborted without fast-forwarding
the branch.


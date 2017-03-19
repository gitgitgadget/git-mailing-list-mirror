Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A4AF20323
	for <e@80x24.org>; Sun, 19 Mar 2017 20:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752496AbdCSUYH (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 16:24:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35798 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752131AbdCSUYG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2017 16:24:06 -0400
Received: by mail-wm0-f67.google.com with SMTP id z133so11349431wmb.2
        for <git@vger.kernel.org>; Sun, 19 Mar 2017 13:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UgYwyHAd8pRioUzQZTWUpd9OSXuDHun9AO7z7lQejHI=;
        b=igNWszjAtH9aO49LbrybRocHcicl/9hhMKroqSyPu+0hKpR0jrPfe3Dz8zANMnHOLt
         TBpCZv9CdN5nEXVUU/WDFvxCX7NKe0L0b467k2noueAJIsFqxh58RDDMSYj98snkvVft
         z6it+fK45MFTO/ztrDHHV/e1sUNAHPH0hk+M1WO1diClAICcXzzCVEjFE7yHUSQSmPdr
         02X72uRnu8ftMdSwFFhJ2Vq0hrnOavaKhhJom3JU4fUlpVlcVixQxx3rFld1zM2OoQcd
         8Z9UW4wTJMnWvXze0lsdTOx1KZJOR1CMGs+zzNrqbwcqGVuIjlYVhHsHGPjPCW2A/9vh
         aqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UgYwyHAd8pRioUzQZTWUpd9OSXuDHun9AO7z7lQejHI=;
        b=LPq530Qi659e+kdjeooAz7i3zlbzNgxE1oiOFb/4bKm7E5jtXN+qwKs997tJok5HN/
         lpEKLbFYVx2lhkQnL+GzxV5NvCTewink+K5PIk8j4tUMFWAhwT02JocfHOT5zwsvI6bX
         kBc6BV+AJlqlMLRvfIHcdX0dFN2ih7iVFh13yk6Y9pYxXeQ45sY1o+zKXLf/7NAMVFRC
         GFGHTp3NjOgnWAejTDek8Mz7nszaKujk7J0gW+CQcom5HdrTlCnDk4PTzuHAJwa49xOY
         Lilf0H1QjlSYJaFncxqp/IXzOYZUQxqGP9U2blF6hN0I7XjsbnJt+mDipaErCj3oXqaD
         93Mw==
X-Gm-Message-State: AFeK/H1OriySb2tkXKc71Ba3pV6KtdACKty/1T9s94WjC6HPL0uy5Ysdew2JQ7JjRcfMtQ==
X-Received: by 10.28.87.6 with SMTP id l6mr6981845wmb.109.1489955018306;
        Sun, 19 Mar 2017 13:23:38 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id g23sm10892542wme.8.2017.03.19.13.23.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Mar 2017 13:23:37 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [BUG] "git stash -- path" reports wrong unstaged changes
Date:   Sun, 19 Mar 2017 20:23:48 +0000
Message-Id: <20170319202351.8825-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.12.0.483.gad4152297
In-Reply-To: <20170318183658.GC27158@hank>
References: <20170318183658.GC27158@hank>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series implements my proposal for fixing bug in git stash --
<pathspec>, plus the two other things I noticed while looking at the
code.

> I think one option would be to to just keep quiet about the exact
> changes that git stash push makes, similar to what we do in the
> --include-untracked and in the -p case.  The other option would be to
> find the files that are affected and print them, but that would
> probably be a bit too noisy especially in cases such as
> git stash push -- docs/*.

1/3 implements just this.  This may deserve some more discussion on
what should actually be done.

> Also from reading the code in the -p case, when --keep-index is given,
> the git reset there doesn't respect $GIT_QUIET at all, and also
> doesn't respect the pathspec argument, which seems like another bug.
> I can submit a patch series for those, but I won't get to it before
> tomorrow :)

2/3 and 3/3 have the fixes for the above.  No tests yet, as I'm not
100% sure 3/3 is doing the right thing, though I think it makes the
overall experience better.

Thomas Gummerer (3):
  stash: show less information for stash push -- <pathspec>
  stash: make push -p -q --no-keep-index quiet
  stash: pass the pathspec argument to git reset

 git-stash.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.12.0.483.gad4152297


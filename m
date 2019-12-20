Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B794C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7764C206D3
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfLTSe5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:34:57 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:42821 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfLTSe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:34:57 -0500
Received: by mail-il1-f193.google.com with SMTP id a6so8745616ili.9
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 10:34:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DjbuB2YH7uF9W7tmYDTV7DkydGNVQEDWdm+ELJgqRKU=;
        b=LkwBW6wxEcDI56Kp0qglyhZxx4GaGu5MymBiNM9Z1tJeD23JRycZzDDXgZxQb0QMvl
         hCHnmPeQ+JfYxmfVRrWrWkdws+Z0Ur21Sfqnu5WCzArhvwg8gqj0/UtFViO09KQTYS9c
         9Wrpex3ktc195tDrveJOEo8BeOChhRgdKE0aYNR1jwPM4dXeXejumBewa8oy94E5WCFS
         YF8DrXizlxtx4WvfB72s2qQH/ZqZ4o18HsDSys15evjbGmWf8uWp+tRU0OQSfx7Gc+2Z
         4/+JlgFbSGjGfKFxiQCijXLen+BdW39BKQN02TKHjtG8Av88ZuJ4iYIDpeBqDpf+Qfd/
         tIBw==
X-Gm-Message-State: APjAAAXWFxbuUJ7/+VGCN8uBhSy2OIIjqSKKapCWJjBUutk4LvLtPRLi
        Yp7owtWnojmwV8VdgXJlIpJfqu6FRKjTj2nAc7w=
X-Google-Smtp-Source: APXvYqwmumnJPap0iDbZwBpvgjJX/9uS2pljX8g68bbXg1sQWJhgc559WVqlwD6IfcgnweHbtzzwkD1kuo9RZlopQFs=
X-Received: by 2002:a92:cbd2:: with SMTP id s18mr13099134ilq.98.1576866896805;
 Fri, 20 Dec 2019 10:34:56 -0800 (PST)
MIME-Version: 1.0
References: <20191219015833.49314-1-emaste@FreeBSD.org> <20191220153814.54899-1-emaste@FreeBSD.org>
 <CAPig+cS6XPc9KZo3ytEHLFjMxEFqCk5OJMUjZyFBP0cA95u9Lw@mail.gmail.com> <xmqqftheamea.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftheamea.fsf@gitster-ct.c.googlers.com>
From:   Ed Maste <emaste@freebsd.org>
Date:   Fri, 20 Dec 2019 13:34:43 -0500
Message-ID: <CAPyFy2AF+zcriUfZnpbXy+9r7hRpNBUe0agMuan-cE1ryqTipw@mail.gmail.com>
Subject: Re: [PATCH v3] sparse-checkout: improve OS ls compatibility
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        git mailing list <git@vger.kernel.org>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 20 Dec 2019 at 13:21, Junio C Hamano <gitster@pobox.com> wrote:
>
> "This is similar to ls" is not all that important, especially if we
> then need to say how different from "ls" ours is.  The log message
> that describes why we needed to move away from "ls" is a good place
> to say what aspect of "ls" was unsuitable.

Ok, I'm also happy if it goes in with no comment; the reason I added
it is I could foresee someone coming along in a few years, thinking
this is just a strange local implementation of ls, and changing it.
But, perhaps we can assume that any such person would check the
history before doing so and the comment is not needed.

> If we _were_ to add an in-code comment, we may want to say something
> like
>
>         # Do not replace this with "cd "$1" && ls", as FreeBSD "ls"
>         # enables "-A" when run by root without being told, and ends
>         # up including ".git" etc. in its output.
>
> to warn future developers against improving and/or cleaning up.

Indeed, that is more direct, although it's not just FreeBSD ls; this
came from 4.2BSD and is probably common to most/all non-GNU ls
implementations. In particular, macOS behaves the same way. (Also, the
replacement would be even simpler, just "ls $1".)

Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C34C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 17:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F22921741
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 17:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgBERQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 12:16:59 -0500
Received: from locusts.copyleft.no ([193.58.250.85]:50030 "EHLO
        mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgBERQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 12:16:59 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181])
        by mail.mailgateway.no with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72 (FreeBSD))
        (envelope-from <johan@herland.net>)
        id 1izOIK-00091Z-Ow
        for git@vger.kernel.org; Wed, 05 Feb 2020 18:16:56 +0100
Received: by mail-lj1-f181.google.com with SMTP id w1so3097681ljh.5
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 09:16:56 -0800 (PST)
X-Gm-Message-State: APjAAAW3q9UwbI+dM7HA0DKKrco2AZZcslkMP5ue7iV/IDpONKT/bKg5
        fuTD0c65VdfAux8p0BnumI2e5BbqZm63K3Iq7ZQ=
X-Google-Smtp-Source: APXvYqxbQzHO00+sEJIZTExNvCh4V8ZEEZnybW0t/pTH3f/1bCjXLQxXECgcYpSFPmAuKr1SEaHzRu/w/g0p7JDAOLU=
X-Received: by 2002:a05:651c:38c:: with SMTP id e12mr19954196ljp.142.1580923011392;
 Wed, 05 Feb 2020 09:16:51 -0800 (PST)
MIME-Version: 1.0
References: <20200203210445.2854-1-johan@herland.net> <20200203210445.2854-2-johan@herland.net>
 <20200204010523.GR4113372@camp.crustytoothpaste.net>
In-Reply-To: <20200204010523.GR4113372@camp.crustytoothpaste.net>
From:   Johan Herland <johan@herland.net>
Date:   Wed, 5 Feb 2020 18:16:40 +0100
X-Gmail-Original-Message-ID: <CALKQrgcbo-giO=5c=+=KtVxFth0WOB5j+M3Lw26PpLFd+Pqpng@mail.gmail.com>
Message-ID: <CALKQrgcbo-giO=5c=+=KtVxFth0WOB5j+M3Lw26PpLFd+Pqpng@mail.gmail.com>
Subject: Re: [PATCH 2/2] notes.c: fix off-by-one error when decreasing notes fanout
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johan Herland <johan@herland.net>,
        Git mailing list <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 4, 2020 at 2:05 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On 2020-02-03 at 21:04:45, Johan Herland wrote:
> > always follow the ->next pointer from the last non-note we wrote.
> > (This part is was caught by an existing test in t3304.)
>
> I think you have "is was" here.  You probably want one or the other.

Will fix.

> > Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Cc: Brian M. Carlson <sandals@crustytoothpaste.net>
>
> I generally write my name in lower case, but I think typically we prefer
> to omit Cc lines in patches (unlike LKML), so it may just be better to
> remove these lines.

Ack. Will remove.

> > Signed-off-by: Johan Herland <johan@herland.net>
>
> Patch 1 looked good to me.  Your explanation here makes sense, but I
> must admit that I still don't understand this code, so I can't give an
> outright approval.  I do appreciate that it comes with a test, though.

Thanks for having a look. I must admit it's hard to get back into this
code even though I originally wrote it. I've been trying to prepare a
patch #3 which decreases the fanout more aggressively on notes removal
(having a fanout of 1 in a tree of 17 notes is  bit ridiculous, IMHO),
but I'm not yet able to figure something out that behaves in a stable
manner. (I find scenarios where removing a note will switch fanout
from 1 to 0, but removing another note will then switch fanout from 0
back to 1, and so on, and the current notes code does not have these
problems, AFAICS.)

> I haven't tested, but I expect this series will make Dscho's patch
> unnecessary, so I'll drop it in my reroll unless one of you tells me to
> keep it.

Yes, my patch includes Dscho's change. I don't particularly care
whichever lands first, and I can easily rebase on top of yours.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

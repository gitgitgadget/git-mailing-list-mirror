Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBC6220960
	for <e@80x24.org>; Fri, 14 Apr 2017 00:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753420AbdDNAeT (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 20:34:19 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35758 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753288AbdDNAeS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 20:34:18 -0400
Received: by mail-lf0-f65.google.com with SMTP id i3so8682720lfh.2
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 17:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nPczuyU+5VXKrh+y/NV8+lYCYD0/wie6sgGS7BjEK74=;
        b=AyqRFd/ZIKNFmAJgcCKJXWmomY0011Bo0VvOoZBdwT0Yj4WLCN7HWw+ORv8uCSuP9q
         nUF8zXAbLFfTNhNcBjcdVZLQl1mWU7tqnsF77U0U+BE1NxqrHrRMR2cex+67ouuDogYv
         4DoT3v+SYc+s6JTVfuYXccM8wjEUte2rEe3e3jsoRkUREabXnEXRwbBMW3bmNFW3Mzqp
         25SWSyUyogZ5e1V18e7i7qQam8kiG5sp6gO1L7DAMXlwrivEingbIXOyVWKW0pl8W2aa
         NuivcykGoCohG7uamsU4ISUJnrZe5Fh4bwXMwSDYscNNO8nfdOEsyJD9Pl2n50oFFpCK
         ns+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nPczuyU+5VXKrh+y/NV8+lYCYD0/wie6sgGS7BjEK74=;
        b=cw5FkyZJzqwuB36SphMJMqYYceOF1cYMOUJM67h0LkGquyKyZqJPtut5Mq4PDOetJq
         xH3VO/GQfcWsP9drfeZWtqAmd1WuM9M7HvxnK8icazYJCnCVZO/Y7snAQGbWDDpc0k95
         AZfmusQy/WnV0usQNP/Jn9KIm90aEHycA9YPwjYZWla0nYQH1hxDypFUgvOfnr9BF1Es
         dCTOHUYK7BiE5qAfDmXwWQk2csDqCnhElhKy80QaEIeShDbTbyIclbM34lRH3zbyRUAs
         Y/0OFpln6vO1m2wzkFzRlkFdFSUW3ERFk6g2jvXhqLJXYy9pCZJ/KDJ1Q9KkwEHCcA81
         Fc5Q==
X-Gm-Message-State: AN3rC/4vqtYG8aVnx87J/a1hXtIOyrhmMIHapomCXlDCY0wUelWUmWO3
        WtGhzurJrSb5w8hg0GYHSo8HSN8xvg==
X-Received: by 10.25.163.193 with SMTP id m184mr1937571lfe.114.1492130056294;
 Thu, 13 Apr 2017 17:34:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.17.155 with HTTP; Thu, 13 Apr 2017 17:33:55 -0700 (PDT)
In-Reply-To: <20170413202712.22192-1-dturner@twosigma.com>
References: <20170413202712.22192-1-dturner@twosigma.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 13 Apr 2017 17:33:55 -0700
Message-ID: <CA+P7+xomqvK=E0A_wPiyufzyF63yRLA=CQS3Sfec_Uub72DKrw@mail.gmail.com>
Subject: Re: [PATCH] repack: respect gc.pid lock
To:     David Turner <dturner@twosigma.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Martin Fick <mfick@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 1:27 PM, David Turner <dturner@twosigma.com> wrote:
> Git gc locks the repository (using a gc.pid file) so that other gcs
> don't run concurrently. Make git repack respect this lock.
>
> Now repack, by default, will refuse to run at the same time as a gc.
> This fixes a concurrency issue: a repack which deleted packs would
> make a concurrent gc sad when its packs were deleted out from under
> it.  The gc would fail with: "fatal: ./objects/pack/pack-$sha.pack
> cannot be accessed".  Then it would die, probably leaving a large temp
> pack hanging around.
>
> Git repack learns --no-lock, so that when run under git gc, it doesn't
> attempt to manage the lock itself.
>
> Martin Fick suggested just moving the lock into git repack, but this
> would leave parts of git gc (e.g. git prune) protected by only local
> locks.  I worried that a prune (part of git gc) concurrent with a
> repack could confuse the repack, so I decided to go with this
> solution.
>

The last paragraph could be reworded to be a bit less personal and
more as a direct statement of why moving the lock entirely to repack
is a bad idea.

> Signed-off-by: David Turner <dturner@twosigma.com>
> ---
>  Documentation/git-repack.txt |  5 +++
>  Makefile                     |  1 +
>  builtin/gc.c                 | 72 ++----------------------------------
>  builtin/repack.c             | 13 +++++++
>  repack.c                     | 88 ++++++++++++++++++++++++++++++++++++++++++++
>  repack.h                     |  8 ++++
>  t/t7700-repack.sh            |  8 ++++
>  7 files changed, 127 insertions(+), 68 deletions(-)
>  create mode 100644 repack.c
>  create mode 100644 repack.h
>
> diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
> index 26afe6ed54..b347ff5c62 100644
> --- a/Documentation/git-repack.txt
> +++ b/Documentation/git-repack.txt
> @@ -143,6 +143,11 @@ other objects in that pack they already have locally.
>         being removed. In addition, any unreachable loose objects will
>         be packed (and their loose counterparts removed).
>
> +--no-lock::
> +       Do not lock the repository, and do not respect any existing lock.
> +       Mostly useful for running repack within git gc.  Do not use this
> +       unless you know what you are doing.
> +

I would have phrased this more like:

  Used internally by git gc to call git repack while already holding
the lock. Do not use unless you know what you're doing.

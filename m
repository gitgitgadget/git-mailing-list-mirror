Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83E2820756
	for <e@80x24.org>; Fri,  6 Jan 2017 09:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033026AbdAFJGp (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 04:06:45 -0500
Received: from mail-ua0-f180.google.com ([209.85.217.180]:35004 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbdAFJFF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 04:05:05 -0500
Received: by mail-ua0-f180.google.com with SMTP id y9so70774419uae.2
        for <git@vger.kernel.org>; Fri, 06 Jan 2017 01:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=yZC7XyL+DwW9i7dRQUzj24uM7qaen+SjjGUFOiD1ZEM=;
        b=bhjZiuQP4BtUE4CCp3m/IqfN1GW8BL4rLUAeA8v+ztX8qzomQsepPSy5Dfc3wuNazw
         e4rk2yh610d3Tug7C7RPafzBArlMQIUF95tGE79PZMgRBVyIr5R1fI1mtUzk91T7RH/L
         2krglsKrUzkYFY4X2A8WlVDptGBFR3ooSMbGvHt7jbSqODzb/fE8QswxLOKVpiMCJQiH
         zV+aRuKJkgbocatstxE2FC51HNbjeq6Bk52LRtqQir5wytcnC4zf9SXbGvpWD6dBGnt4
         VWvgQRCC4S72IMvYBijPpzcc83g1USQb28pBwQOoke6Ys/RXwVmGICFU4zOh5qIBkJt0
         vE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=yZC7XyL+DwW9i7dRQUzj24uM7qaen+SjjGUFOiD1ZEM=;
        b=iWtLlFdzBTNt8GRKjsemNAQhy5BfSL2t7vyyEoIDHl9+9VuBVnaCKdZQuHgnJvux0S
         MMVOfi4YUoaD+kXj5JoX2BBk6A4QwiwWfkCpfbUSZ34+D0/O2Wxuf9TwZPTmVfSAzL5r
         o1ieY4nnYK0MBMsYfnyPOm2SNr5l+Jj+VDZ9Nl7lUhiXQrKM1xwDlLSLLjjBDCZ5j2Hx
         yepmLNxhuq7D//iTgEK48nSSSg8zgNeW9tMKBjcPLzKaZhVtk8+MK2joz8uURC5c4UM/
         GleFFCNn4d25BgH4oUfauXI2TD7MCoVz2JG8BWNPXvW378pZ7r+HZp6QgQmKeTCbUpIv
         4MAw==
X-Gm-Message-State: AIkVDXJzxF5EjHFzEXQ7JXiOzzP67TU1Xf+S1xGoOYYdYStf9dvd9Miip+prN3lo9OQB7a9rCK+MnkPW0/zB3A==
X-Received: by 10.176.16.66 with SMTP id g2mr45076879uab.99.1483693446036;
 Fri, 06 Jan 2017 01:04:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.31.47.144 with HTTP; Fri, 6 Jan 2017 01:04:05 -0800 (PST)
From:   Brandon Tolsch <btolsch@gmail.com>
Date:   Fri, 6 Jan 2017 01:04:05 -0800
Message-ID: <CAMWRQeRaQQQcJ-R8eHc7f0KqZF2eEkYJOyTb9n7ds78pTqV-AA@mail.gmail.com>
Subject: Squashing commits with git rebase -i may miscount commits in commit message
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git --version: 2.11.0

When using git rebase -i to squash a series of commits that includes
more than 10 commits, the generated commit message you are given to
edit counts the old messages incorrectly.  It will say the total
number of commits is (actual % 10) (if they were 0-based) and it will
also count the commits as (actual % 10).

For example, 15, 25, 35, etc. commits:
# This is a combination of 5 commits.
# This is the 1st commit message:
msg

# This is the commit message #2:
...
...
# This is commit message #10:
msg

# This is commit message #1:
...

# This is commit message #5:
msg

While not a big issue, it did make me double check what I was doing
when I saw "a combination of 10 commits" instead of 20 in the commit
message.

-Brandon Tolsch

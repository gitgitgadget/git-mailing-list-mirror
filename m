Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DAE91F403
	for <e@80x24.org>; Mon,  4 Jun 2018 05:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750899AbeFDFyD (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 01:54:03 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:40318 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbeFDFyD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 01:54:03 -0400
Received: by mail-wm0-f50.google.com with SMTP id n5-v6so374303wmc.5
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 22:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=TIJXxFp/OZrublFvF9iAmaIWCYpvLdBFiW7n/ScbI08=;
        b=ONvC2iHBo7kDVtB1/cYfBe7v8FF+51+qa55X6fipwVWVIBjv+GBYE5U2tiBvNijD3K
         kPt9mnPjPLBhcZnWX0887dI6TpudMiMNxWoC2hmaGiAR1c4podKAKMdhKwzWJzwJXgb6
         VEvLBKQEGLbvb93xG0MrQ0U2Tq5gMdgUXZXKfqh4wy0uamj+oJ3A6xGEeBJ9n5UGLdeD
         mWb/SiEsncTZSRV+5RfVty92oPazspQ7Ml/KV+WVlhEvHSQM2CWYG5WJqouLRzy+lTqg
         qJ8G+xUEaY2GhN2NJUG950Ley63A8GnAuQeQwOjMDhHWgGM9dgO7qmKX/MbRW3ltYkLK
         JdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TIJXxFp/OZrublFvF9iAmaIWCYpvLdBFiW7n/ScbI08=;
        b=ELA1EIm7Stq+jUAmGYQX6gA7Qy8yzTKqa5VJaKG74M0x3BbCnVkjDqB/N+U8r1LQYT
         g1c22aZr8wftdBZcuGjqpHsJsIEVLLm0SIvYD4d5dB+eab8J7caMep3+OYDjKCoYbUkg
         9FAk25KZf/GefTeB/IGg8fpXBMDs/kvLRbscCSSNPG1VbtX98m1W2jCRx3bNOPxJ7/oO
         0NsUnc3TTJqkVoi6C7bZJ3CZHQ28jL3aQjXxS5DAUaDH0zzMsS4SGBHApIn5Gc0TtNFm
         6eOkuRf5Yi3SbZYRAEFDPCZZL5sVOyjERFdsiLqb264rdrZ6yUtgTVVQhwFVveoyvKvX
         N3Aw==
X-Gm-Message-State: ALKqPwdpyoHaZExgarWJ787q0/KdlInYt1ZVxhkNkiE8WWU09C8mWojL
        ChX1iQEyEEktxG+cxoLjmOzhtqHU6C92OpgRdI0S015q
X-Google-Smtp-Source: ADUXVKK3Pgeivx6YXK4y0oY4BsHtIMlrJV8n0eIrwjxlwV3HcNyLPHtbNromFL6PVQFbN0dlNSsW1VRot9UwTJBNuew=
X-Received: by 2002:a1c:5b02:: with SMTP id p2-v6mr8108914wmb.20.1528091641296;
 Sun, 03 Jun 2018 22:54:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:ef04:0:0:0:0:0 with HTTP; Sun, 3 Jun 2018 22:54:00 -0700 (PDT)
From:   Anthony Sottile <asottile@umich.edu>
Date:   Sun, 3 Jun 2018 22:54:00 -0700
Message-ID: <CA+dzEBm_doNMjEs_OWwia_mm7u3ztAFpCpaFJP3DRpFhEo93jg@mail.gmail.com>
Subject: Regression (?) in core.safecrlf=false messaging
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm a bit unclear if I was depending on undocumented behaviour or not
here but it seems the messaging has recently changed with respect to
`core.safecrlf`

My reading of the documentation
https://git-scm.com/docs/git-config#git-config-coresafecrlf (I might
be wrong here)

- core.safecrlf = true -> fail hard when converting
- core.safecrlf = warn -> produce message when converting
- core.safecrlf = false -> convert silently

(note that these are all only relevant when `core.autocrlf = true`)

I've created a small script to demonstrate:

```
set -euxo pipefail

git --version

rm -rf repo
git init repo
cd repo
git config core.autocrlf input
git config core.safecrlf false
echo -en 'foo\r\nbar\r\n' > f
git add f
```

When run against 2.16.4:

```
$ PATH=$PWD/prefix/bin:$PATH bash test.sh
+ git --version
git version 2.16.4
+ rm -rf repo
+ git init repo
Initialized empty Git repository in /tmp/git/repo/.git/
+ cd repo
+ git config core.autocrlf input
+ git config core.safecrlf false
+ echo -en 'foo\r\nbar\r\n'
+ git add f
```

(notice how there are no messages about crlf conversion while adding
-- this is what I expect given I have core.safecrlf=false)


When run against master:

```console
$ PATH=$PWD/prefix/bin:$PATH bash test.sh
+ git --version
git version 2.18.0.rc0.42.gc2c7d17
+ rm -rf repo
+ git init repo
Initialized empty Git repository in /tmp/git/repo/.git/
+ cd repo
+ git config core.autocrlf input
+ git config core.safecrlf false
+ echo -en 'foo\r\nbar\r\n'
+ git add f
warning: CRLF will be replaced by LF in f.
The file will have its original line endings in your working directory.
```

A `git bisect` shows this as the first commit which breaks this
behaviour: 8462ff43e42ab67cecd16fdfb59451a53cc8a945

https://github.com/git/git/commit/8462ff43e42ab67cecd16fdfb59451a53cc8a945

The commit appears to be a refactor (?) that shouldn't have changed behaviour?

Here's the script I was using to bisect:
https://i.fluffy.cc/2L4ZtqV3cHfzNRkKPbHgTcz43HMQJxdK.html

```
git bisect start
git bisect bad v2.17.0
git bisect good v2.16.4
git bisect run ./test.sh
```

Noticed this due to test failures here:
https://github.com/pre-commit/pre-commit/pull/762#issuecomment-394236625

Thanks,

Anthony

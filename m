Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 285F9201C2
	for <e@80x24.org>; Sat, 11 Mar 2017 20:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752298AbdCKU0U (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Mar 2017 15:26:20 -0500
Received: from mail-ot0-f171.google.com ([74.125.82.171]:33397 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751266AbdCKU0T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2017 15:26:19 -0500
Received: by mail-ot0-f171.google.com with SMTP id 19so94754155oti.0
        for <git@vger.kernel.org>; Sat, 11 Mar 2017 12:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=ukNZhwkQtMvRr0CUpxpGBhnLXAQkZ5gF4l0tqDX2huY=;
        b=eajYoHjd5ORpspGq4FmNsPFi8MKIxWG45uq1FL7cASUP/SqDKIdnQlNK0jId8ncVgB
         N8zH9CGc+OnQl5tuFgPvHjE5YyqVoSowK3PZqAzJCe1RX/DxVhXaVeTZWWUHWDNDUrxU
         8w5hsY0wFC3tyEGDB7q0trh4N5Gxub+VCbZ9kGI8coG/rbnm4W6HLYrisiDiTvcH1mt8
         oRHUMeb8PMGXzkiztdwCxHwztmt6aHTgHxeva4bkZCO7gPJER8NCgEIX0TGqb/9IrZHM
         kqnbxDd6qujP3+pzkwfAXVeHn5gSAeqX4yjDo9TsgD9v9vIh5jc0bhwtyS48DTlptaOC
         XX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=ukNZhwkQtMvRr0CUpxpGBhnLXAQkZ5gF4l0tqDX2huY=;
        b=o1tbqlIgT5BDHdsizSos/v1Wew2GHajEVnKVNZunYqQNOQyOiLpbE0GTC0tBLriX2C
         o8/3GrhYe1rYUqQHVa6t5tM7LwcpOhBGP08WZVSvOP7J7NOUsq2g8Qwk1UkitaeeNj2z
         +ic7ubvhZPoub+Bm8JwEy4rLdFwo6S3LEWAPpD0yxDboYKIaDMQtO4Et7VisG9MCMbyL
         UOaDUDx11nDsl03uPW+gzXCgO+wAGr2SFLSqAFtlfl9iCPDQ7FP8uR5xjvbQuu8bDl3Z
         k59kfDyi8cLcikaohrihGBOE9JHWB3KGWn4p1j0QF367gpQvwWqWMOTjLTPyOGcIGAnd
         41ug==
X-Gm-Message-State: AMke39kBGjdR3E0qZu42qp3EJgQQz46+TVVPBhsz8tzxVP2wkR2HVKKBEegHKKCqfkl+TVpV2DGt463opUavhQ==
X-Received: by 10.157.17.72 with SMTP id p8mr13332520otp.138.1489263977494;
 Sat, 11 Mar 2017 12:26:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.202.74.85 with HTTP; Sat, 11 Mar 2017 12:25:57 -0800 (PST)
From:   Joel Teichroeb <joel@teichroeb.net>
Date:   Sat, 11 Mar 2017 12:25:57 -0800
X-Google-Sender-Auth: NijI-3w-X9fbm7PqBBOr7TMrLJM
Message-ID: <CA+CzEk9-SDj9FTC_ucu9oBDOe59ce4Jz_OxZbYrDpmbUJHTpFg@mail.gmail.com>
Subject: [RFC] Converting git stash to a builtin
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've been working on rewriting git stash as a c builtin and I have all
but three tests passing. I'm having a bit of trouble fixing them, as
well as a few other issues, so I'd really appreciate some help. Don't
bother commenting on the small details yet as I still need to go
though the code to make sure it matches the code style guidelines.

The commit is a bit big, so I'll just link to it on github.

https://github.com/klusark/git/commit/f74d65ae3e06d2c0ab000702ac5e756550e06454


Test Summary Report
-------------------
t7601-merge-pull-config.sh                       (Wstat: 256 Tests: 14
Failed: 2)
  Failed tests:  11-12
  Non-zero exit status: 1
t3903-stash.sh                                   (Wstat: 256 Tests: 74
Failed: 1)
  Failed test:  69
  Non-zero exit status: 1

It looks to be the same issue for both of these cases where
merge-recursive reports:
error: Your local changes to the following files would be overwritten by merge:
        file
        other-file

which doesn't make sense as those files didn't exist before the merge.
Furthermore if I take the existing git stash implementation and have
it stop before running the merge-recursive command and then run it on
the commandline manually, I get the same issue. I've tried setting all
the same environment variables that the existing git stash
implementation does, but it doesn't help. It seems like there could be
a bug in merge-recursive, but I'm not sure how to track it down.


git stash uses the GIT_INDEX_FILE environment variable in order to not
trash the main index. I ended up doing things like this:

    discard_cache();
    ret = read_cache_from(index_path);
    write_index_as_tree(orig_tree.hash, &the_index, index_path, 0, NULL);
    discard_cache();
    ret = read_cache_from(index_path);

in order to have an empty cache. Could someone take a look at my uses
of the index and point out better ways to do it?

My main goal right now is to cleanup the code and replace more of the
commands with native code.

Thanks,
Joel

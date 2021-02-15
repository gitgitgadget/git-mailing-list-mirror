Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130D7C433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 21:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1EEC64DEB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 21:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhBOVzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 16:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhBOVzo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 16:55:44 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2711DC061786
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 13:55:04 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id o12so7302932ote.12
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 13:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mabulous-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=sHF4dwljwmrUUoRD8niQW9hBVAo4a6TUIBxUuOD7pns=;
        b=hzfsR0VzFrYg9zpQzFFVSjvEeSmllNClpR3CFMxE83fn1AmJhgZpH0h/E8AVnWZ1z5
         kjNy8C9CXIb4Ye25lP0IdPsjiDRUD8dldgq3eCzs6pJtoil5a3NiZKC6iiuzFW3TA/oG
         EcepSD3NVYG4fOpaAScNIXJ6c9qk3ZOjYYPuQr8QXo9r7J5w3xRt6LICoYV3w0klDr73
         UMuK4AQHM90qKFPf+twbRiwLrhf2IJhakwm0s+zNlDe0cQPvLnRKEpMamUyK8bnSzazA
         QGBfCoW9V8++pBJ6iUJ5ZcApXiavMlKF8SQHFkIbAmEHW73PLqLyAK3Ymp/CUT6ZZ2vQ
         xqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=sHF4dwljwmrUUoRD8niQW9hBVAo4a6TUIBxUuOD7pns=;
        b=M/Ryr5Ktiv4b/+onyI1OV1GYGZz6G8TJDzbWoVQkrzLM8zJyy5jLcJv+XS4xvMYVu/
         WqPYfQqN5vnXoT6L7mKmg1IZkU13NcALeUDBMN4J4auMRGtsUMvwDDqLgHN5HaUigzf4
         35hffXwjwqmNHgt09WU3cYTCc3f42K7wgSiaoD5mye1Uwg7OEieV8bFc85mk6EbW26zd
         f1RSURfYO1eTk2lSkIRiwjivkY2bQH07P1uAJVr8pdVn4jSvLxu3fMFVvOS8izGAM0KT
         qMsDAkVoLTHZ8kRs1BHSGzZJcwK+JEjx0gDS1u/DaR+TjHugWQniOHvPbjzB+Em6wYCT
         ub7A==
X-Gm-Message-State: AOAM5329QuwMS9yrJi4u+adkVzi+qeY0x2En5/pShEO1nzTEW/yAOc/u
        rb9HK3tDqDkssi8iGxWK5iixi0P7FlaVnRJma2rXjixco/jTyPv4
X-Google-Smtp-Source: ABdhPJxAsc2yWXxpU39r3+4q0W8G/cw8VdCIhlwNmOmhWoTXuqJGLoRfnvWOCuqEb/zKgaAoWW7rq5lVcgGQNlm+TFY=
X-Received: by 2002:a05:6830:236b:: with SMTP id r11mr13272775oth.370.1613426103371;
 Mon, 15 Feb 2021 13:55:03 -0800 (PST)
MIME-Version: 1.0
From:   Matthias Buehlmann <Matthias.Buehlmann@mabulous.com>
Date:   Mon, 15 Feb 2021 22:54:52 +0100
Message-ID: <CALz+XyW+XU++58eEYm5=jxTckK-VuuPoA-ecj4QCZw1o44JFUQ@mail.gmail.com>
Subject: Bug Report: Multi-line trailers containing empty lines break parsing
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

    create a file containing multiline trailer:

    $ echo "Test" > test.txt
    $ git interpret-trailers --where end --if-exists addIfDifferent
--trailer "SingleLineTrailer: This is a single line trailer"
--in-place test.txt
    $ git interpret-trailers --where end --if-exists addIfDifferent
--trailer "MultiLineTrailer: This is"$'\n a folded multi-line\n
trailer' --in-place test.txt

    parse trailers:

    $ git interpret-trailers --parse test.txt
    SingleLineTrailer: This is a single line trailer
    MultiLineTrailer: This is a folded multi-line trailer

    (so far, all is as expected)

    now, adding multiline trailer containing empty line:

    $ git interpret-trailers --where end --if-exists addIfDifferent
--trailer "MultiLineTrailer: This is"$'\n a folded multi-line\n
trailer which\n \n contains an\n empty line' --in-place test.txt

    parse trailers again:

    $ git interpret-trailers --parse test.txt

What did you expect to happen? (Expected behavior)

I would expect the following output:

    $ git interpret-trailers --parse test.txt
    SingleLineTrailer: This is a single line trailer
    MultiLineTrailer: This is a folded multi-line trailer
    MultiLineTrailer: This is a folded multi-line trailer which
contains an empty line

What happened instead? (Actual behavior)

    no output is generated, but exit code is nevertheless 0:

    $ git interpret-trailers --parse test.txt
    $ echo $?
    0

What's different between what you expected and what actually happened?

    I would expect either to get an output or the call to exit non-zero

Anything else you want to add:

    According to my interpretation of the documentation of git
intepret-trailers, empty lines should be supported if properly folded,
in the same way as for example the PGP signature added to the commit
header contains a (properly folded) empty line

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.30.0.windows.2
cpu: x86_64
built from commit: f8cbc844b81bf6b9e72178bbe891a86c8bf5e9e7
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
uname: Windows 10.0 18363
compiler info: gnuc: 10.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]
post-commit

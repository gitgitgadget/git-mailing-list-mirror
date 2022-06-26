Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0AFC43334
	for <git@archiver.kernel.org>; Sun, 26 Jun 2022 19:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiFZTe2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jun 2022 15:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiFZTe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jun 2022 15:34:27 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48725594
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 12:34:26 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 59so12149323qvb.3
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 12:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=QvPtj1LBRwA7EKKBsHLRaz+45fiYvBEMlRetKgicIWw=;
        b=MgFPoRir+XrlUZAPS5McikwoFraqdHWmWQE5IZMj+om902mIZp4LKLuRd9oJZaXRLp
         RuzvuyHmH9voV/Arv2hC8bSDn/e+hAE6QchrFFzzxmQKGF8eapkC26RbC0gqFa0BXo1t
         9v3RUtJG9zHdcP7t+38ZFtzvQ57PcZsabfGQimteAHOJc+JehbP1kuh5W+pajhlHFoWH
         GSUexg0oDktP66uZTe5pxzc05xawQjkNO6pC1SorMNjAaaonguUHcP6XswhJHae8gv3X
         sH8XBbqWwBUQj+Q/4p+DA7sRakdVLpE4r0Yhb+UqbAVwpIOJKGyHz9oJu8jQsoU1diik
         1PAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=QvPtj1LBRwA7EKKBsHLRaz+45fiYvBEMlRetKgicIWw=;
        b=YmHgX2i/dFox4yHqMFNueoLh5s8PNeNBG2ROMBpM6zBxma8DTJRzLeMzFEZzBM11oC
         koKQVfjKkxQ3fzrOPyxaz+IR5+pP4DtQCcWXHA6gdjz4BnZ2++9TIqdlhUJeLjx/8gQJ
         wFNTHip+zVRGUjoVSuEH9/n6eLl/6pBKw3JORbssMUukBSMD7/k/M7vr5Fyd0DJhQhA7
         lUeatLDY5kVeORSn1FqBI/OaKwWmGy/H48QfJ63lOT0dzV5fey9h6txoMDiNvnp3kvAQ
         xf7JDLyCpgQX+JRth+K5pC4C/vd1xQLNSmiFjXeB3br2+ww7oq0wH7sfUG1cgYxnu2ZZ
         f0vQ==
X-Gm-Message-State: AJIora8F35G9pLLsRpSjjYXkOzGvFpgk49xoVJmHHT/rkBdlUP/2s7cy
        3nxtwVFoxPFkYZ0ju5uSNK5Y3r8gr0M=
X-Google-Smtp-Source: AGRyM1sAtsjhRgohy0Ev580DcmtK4ISJf1rIX2H1Gg5y6ddNk9WY5qJ7jSpxkazeglZQ8Lrl3H/0Ww==
X-Received: by 2002:a0c:fc03:0:b0:470:3be6:b70d with SMTP id z3-20020a0cfc03000000b004703be6b70dmr6776603qvo.95.1656272065483;
        Sun, 26 Jun 2022 12:34:25 -0700 (PDT)
Received: from smtpclient.apple ([2601:89:c600:f150:18aa:ad9:a3f9:8e65])
        by smtp.gmail.com with ESMTPSA id a186-20020a3766c3000000b006a37c908d33sm6857865qkc.28.2022.06.26.12.34.24
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Jun 2022 12:34:25 -0700 (PDT)
From:   John Thorvald Wodder II <jwodder@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Oddities in gitignore matching
Message-Id: <DC3C4CED-3781-4380-95E6-97F5CBE1B13C@gmail.com>
Date:   Sun, 26 Jun 2022 15:34:24 -0400
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git developers & fans,

I'm developing a Python library for performing gitignore-style path =
matching (because all the pre-existing ones I've found so far leave =
something to be desired), and, in my experiments to nail down Git's =
exact behavior, I've encountered three odd things that may be bugs or =
may be deficiencies in the documentation; let me know which.

First: I've found that the pattern "foo**/bar" causes the path =
"foo/glarch/bar" (as well as "foobie/glarch/bar") to be ignored.  =
However, the gitignore(5) documentation states that "**/" only has =
special meaning when it's "leading"; in other circumstances, the double =
star should be treated the same as a single star (and "foo*/bar" does =
not match "foo/glarch/bar").  Is this behavior of non-leading "**/" =
deliberate or a bug?

Interestingly, checking the pattern with the wildmatch test-tool =
(`t/helper/test-tool wildmatch wildmatch foo/glarch/bar 'foo**/bar'`) =
shows that the pattern should not match the path.

Second: The pattern "[[:space:]]" does not match 0x0B (\v, vertical tab) =
or 0x0C (\f, form feed) despite the fact that the C isspace() function =
accepts these characters, and I cannot figure out the cause for this =
discrepancy.  (The pattern does match the other characters that =
isspace() accepts, though =E2=80=94 tab, line feed, carriage return, and =
space character.)  The wildmatch test-tool agrees with this behavior, =
though.

Third: While the documentation for `git-check-ignore` only states that =
it works on files, I've found that it also works with directory paths, =
as well as treating any nonexistent path ending in a slash as a =
directory.  For example, in a fresh repository containing only a =
.gitignore file with the pattern "foo/", `git-check-ignore` will accept =
the path "foo/" but not "foo", and if `mkdir foo` is run, it will accept =
both.

However, I've found a case in which `git-check-ignore` deviates from the =
actual .gitignore behavior regarding ignoring directories.  If =
.gitignore contains only the pattern "foo/*", then (regardless of =
whether a directory named "foo" exists or not), `git-check-ignore` will =
accept "foo/" but not "foo" =E2=80=94 and yet, if you do `mkdir foo; =
touch foo/bar` and run `git status --ignored=3Dmatching --porcelain`, it =
shows "!! foo/bar", rather than "!! foo/" (which you get with the =
.gitignore pattern "foo/"), indicating that "foo/*" matches the contents =
of "foo" but not "foo" itself, in apparent disagreement with =
`git-check-ignore`.  Is this a flaw in `git-check-ignore`, or should it =
just not be trusted in the first place when it comes to directories?

These observations were made using Git version 2.36.1, installed via =
Homebrew on macOS 11.6.6, with test-tool compiled from commit 39c15e4855 =
of the Git source.

Thank you for your time reading & responding,

-- John Wodder


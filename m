Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A86C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 06:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbiLNGLN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 01:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiLNGLK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 01:11:10 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13B312D29
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 22:11:09 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id jr11so1765112qtb.7
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 22:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W+xBvkz/h033khx2TJ6mJLPksdUXJ6TcfHIiUelytm8=;
        b=GIh7+N00oT35QCFvcjROlc5VMtJpqCGWEFK2P6W44y2R9m7L/Ut8x4Z1E1JP0a+l2E
         OzOjzxuggUESedRs/pWop0Olt3zKzyJv+R/YN39IwG2+WxCpu9Xj4uyjPOoUv8OWuO9V
         zqRRAUIPZSmDpZuXGQlX3Q63qP5NUe5VZYr0ClQhgVEEzNwfsCUYgFWq5C9Deo4oqa+j
         PNcvOSOlwyAs2caH4dnVJFEb7yN/Zn7Cf4K9aT6EX5GDlvSgByHZh+C+0ZkM0DD/Pyit
         qm7anqPPqbG2xVBImk25jYY5c3GXfwXhycaIaKSOAiY+YakghTlW4Xgmj1wef8B9aTZA
         IgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W+xBvkz/h033khx2TJ6mJLPksdUXJ6TcfHIiUelytm8=;
        b=2YYmsgs95zXsYm5Yy9fLBPW60uPH+Kcq/Wg50wQFj43zrROTvCx6DL+aueqNPdCoGg
         /Jl+IHy2V7LZUv6NQlusiiMbjeBC9hF14aBEjhH4sN3PRAUqJcPw37unY6y8Ki51tzUd
         2OUKn8b7HwnX2xKmSwoutqhjbox2t0FGvaDPeFQvlFtWRcfD+xpUYha93hr5T3q6poPl
         Qo1dJ3k+yB+WRbVuM834T49yOQVUDQg8KI5zpxtL7yfKsCw0y3HoU3IvlOd53Q7zeCM2
         kJUOGemju+MeJUOEBDIK5s7jNSzIE1xuItUwfBDJDbVt+IC9MrQBXLAmxPy1bvRGq1G7
         mJ4g==
X-Gm-Message-State: ANoB5plIHImvIcl3Gap3jhKkLEnnihwY7OC6WitjYYIzl+1eQ1bLSTTL
        3v73/xuTktMS9Dk3hCJqRdd4+NldPzfxJdoGYl95QlGeQvs=
X-Google-Smtp-Source: AA0mqf4OQF6s66DQdpdAqspIngmN70d2tga/Mpw6aTbkLnEpmB2S0wZgNKICimLl5rm4O645w1knvjKlUQ8AHZF8hO8=
X-Received: by 2002:ac8:6641:0:b0:3a8:2bf2:333 with SMTP id
 j1-20020ac86641000000b003a82bf20333mr43859qtp.144.1670998268375; Tue, 13 Dec
 2022 22:11:08 -0800 (PST)
MIME-Version: 1.0
From:   Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Date:   Tue, 13 Dec 2022 22:10:56 -0800
Message-ID: <CAKu1iLWvd+PVOK405Q+SNDyyYnhbi=LtovZvWw55y6eQqoRpaA@mail.gmail.com>
Subject: Re: [PATCH] git-p4: preserve utf8 BOM when importing from p4 to git
To:     Git List <git@vger.kernel.org>
Cc:     Tao Klerks <tao@klerks.biz>, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>
> Perforce has a file type "utf8" which represents a text file with
> explicit BOM. utf8-encoded files *without* BOM are stored as
> regular file type "text". The "utf8" file type behaves like text
> in all but one important way: it is stored, internally, without
> the leading 3 BOM bytes.
>
> git-p4 has historically imported utf8-with-BOM files (files stored,
> in Perforce, as type "utf8") the same way as regular text files -
> losing the BOM in the process.
>
> Under most circumstances this issue has little functional impact,
> as most systems consider the BOM to be optional and redundant, but
> this *is* a correctness failure, and can have lead to practical
> issues for example when BOMs are explicitly included in test files,
> for example in a file encoding test suite.
>
> Fix the handling of utf8-with-BOM files when importing changes from
> p4 to git, and introduce a test that checks it is working correctly

I don't really understand the problem that this patch addresses, but I
feel it was incorrect to modify the behavior of git-p4 in this way.
This change has made git-p4 behave differently than the native
Perforce tools.

Perforce already has a "variable" (setting) to control this behavior.
If P4CHARSET is set to "utf8-bom", the BOM will be added to files in
the local workspace of type "utf8".  If P4CHARSET is set to "utf8",
the BOM will NOT be stored in the local workspace file, even if its
type is "utf8"!

Whatever the problem was that motivated this change, it should have
been solved using the Perforce variable P4CHARSET, not by modifying
the behavior of git-p4.  This new behavior has made it impossible for
me to submit changes to files of type "utf8"!  Any attempt fails with
"patch does not apply" and the erroneously added BOM is the cause.

I propose rolling back the patch that introduced this behavior, and if
that is not possible, I would like to submit a patch that adds a new
setting in the "git-p4" section that will enable users to opt out of
this new behavior (for example a boolean setting "git-p4.noUtf8Bom").

-- 
Tzadik

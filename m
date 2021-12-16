Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478F4C433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 14:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbhLPOyw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 09:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235033AbhLPOyw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 09:54:52 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1897FC061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 06:54:52 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j9so12569748wrc.0
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 06:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=55/TKX3rCsOvDMhAw4JONE324YkcRGszWMM8lwN91hI=;
        b=ICn4Q81zYkfhXDPerNXgeV+d7R/maNHzAbO+IossDVXaWMcQyaeGtOYXKjU4vX1EGc
         X9xNi/tquoAXXhI/SBRdDl7kOV0pRx/66yrDMxCGtncerNT9Q1vjYUV+ChqIWkX7GpVv
         gLkl0jcGUxZKTK47sC6UXoRPgaWJBVQRkCVld+mXhLNkrgZQBJOlL+l77U3x072SXPxJ
         huXYMfUMxnmVwCetaBCQwjcehWSHbLdcHnPx57f4kQoQ+2q7Y4yjqeUA2UsapOjEB+Jt
         katbLrl8zAUdNhIV1y7g5M/J/hpwNYYlvlGrFMV9fGyC5kTrY5hchvdSLV3ZAXWJVYni
         qmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=55/TKX3rCsOvDMhAw4JONE324YkcRGszWMM8lwN91hI=;
        b=S6ZBZZeKE6xDb+Tdz9/IZc+1lUDwoIOZKmyajcg0X1hic5C4nWwiW9UMRcUH6Dlf/y
         6/tZ4yLsxrFu7u7KfvZ0LOSmkMOAJ3aMx+Bk6ZkMMFPeQ2BqPi/xPMlzGLtXV6RJWoVz
         nUdr8wz+A8Ca/ZJK5WBWNbzrDrhK4rdUZ6dEM+ha2RxFnpLQOKvCCSIZyh1hYOgW80ki
         QJMVfh3ScdxrScFC/9EZmfoz79WftZ8oXEqQ7rvHUG33Cpse3L8ZK3Il5I+eCShvGudI
         U/Ce70idBq39lhEEIYRSOugcJoyR5rp/M7RbP3IM8ojTkNxpWmzPeNdSiZO0e1RJwpLI
         6qGw==
X-Gm-Message-State: AOAM530UTOOMtIHGjFf8EcAJHM6f/rY7Sv6IrmdyyLYpD+8xwAX9Kh7N
        i1oPrk053rVL5reWSr4+TUnzKb8tEOSfZf0M15yquG/w9V8=
X-Google-Smtp-Source: ABdhPJy4+Xeb+FekbzyFvwbVQx0Wmys1qgiVt/Vck1qjM2Ptuh6ZA5i5OTnxw2ml1dNpLacwKOsiLAGsxu2mZZreXvs=
X-Received: by 2002:a5d:6312:: with SMTP id i18mr9152930wru.475.1639666490641;
 Thu, 16 Dec 2021 06:54:50 -0800 (PST)
MIME-Version: 1.0
References: <CAKDXFkMvXJm5+5Qxz2N5NH-s+nptayG_7+yTSPxynZxkOcaVKw@mail.gmail.com>
 <xmqqzgp134i4.fsf@gitster.g>
In-Reply-To: <xmqqzgp134i4.fsf@gitster.g>
From:   Dotan Cohen <dotancohen@gmail.com>
Date:   Thu, 16 Dec 2021 16:54:39 +0200
Message-ID: <CAKDXFkOXNPTjQRvj7sy54YhH1QGFUsEXYeLKCShJP7_xueRseQ@mail.gmail.com>
Subject: Re: Git bug: Filter ignored when "--invert-grep" option is used.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think --author and --grep uses the same internal pattern matching
> engine, so with --invert-grep, I would not be surprised if the
> command looks for commits that do not have Revert and (or is that
> or?  I dunno) not authored by Shachar.

Possibly, but the flag is called --invert-grep not --invert-matches so
one would expect it to revert grep only. Though behaviour contrary to
user expectations is not an unusual property of git :)

Other than piping to e.g. awk or worse, how would one get the commits
by a particular author that do not have a specific string in the
commit message? Prettying to oneline would make the piping easier to
at least get the commit ids, but I'd like to see the whole commit
message and affected files.

Thanks, Junio.

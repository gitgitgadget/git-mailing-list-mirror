Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A926EC433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 20:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 807E52071A
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 20:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="VVQgJwdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbgFOU50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729692AbgFOU50 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 16:57:26 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4D4C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 13:57:26 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id h95so409719pje.4
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 13:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=oxcK9qmaLQAm9wl3j7MC7j9vAdSWkCoUQm+J+4kBvrY=;
        b=VVQgJwdxRUDRKvbKnl6sP+XQGpYJdUOmKMynSEBqUd2baRHXXyMbODviluq2odxhZj
         Cy8Y8qgO/eta1nkCD1W3It+ZCJ4CHWG39xbjK4pDw4ok7wfNszz+wxtlmIvEskI8ra97
         kLnEaTb/11fy1wqBFjq2ouQRm9a9Rjt4mqZGvP3r97Y1dnGNetfqNWmKqKqfFNJQR9Hd
         koxcuZwpb0Epu05qbn8i+936z5ZjY4NLN57QnH1zpNlkzM3J1d0PuFIl9jh/PkZ9ec8M
         0GUsWrTnbzcqz0nydf7r38CJ+Tyre0TSM2b9lmz9WV50dyqGhaYHooirqxYX+fNBmzFg
         XzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=oxcK9qmaLQAm9wl3j7MC7j9vAdSWkCoUQm+J+4kBvrY=;
        b=RVr3HHCeD/sa7tqBjv0QIpe19wDRF1YkRPOE5m4aDp90YHhTW+YzOPptYuBxjGPxxm
         kkKcoM4zU2P5dnwAbQCQlUhRPzbede+jYcCBCECmhNASUT58wTvEBio/7BqbQa3WNgvF
         qLlZI4PCPsfJsqSgZx/kC6bL88gTwd3CsYO7fDelhxb1JOCkugHlJPt3h+Zl2huV8l9d
         J2n82e0DdX+WD9c/DdYRiOHq4mNYYIenR0ANdwJK8efQs90tlnS9QDmc0q/EVxIP0sWZ
         6UAGkQNEWAPEx3aT3WPTk35mjQH25mxVZOrhU9wM5GMQvh6dH3anqOF6jBxbBZfF2s1i
         qNFQ==
X-Gm-Message-State: AOAM532nGaZ5prPFwZPkm7dHS/o5/BJjkuLOnNtr99magIGUH7kFbnOs
        C7YJUmKz5vZY1+mzEoV/yppo32Kropo=
X-Google-Smtp-Source: ABdhPJyk/6G/3XF/+VJWsgAwnrINRwBWBZd4Lb69D7hoy3YJ/u6FzHN80KhKxDXaPr7jFbpaijBf4w==
X-Received: by 2002:a17:90a:3261:: with SMTP id k88mr1126182pjb.0.1592254645112;
        Mon, 15 Jun 2020 13:57:25 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id x197sm14504750pfc.13.2020.06.15.13.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 13:57:24 -0700 (PDT)
Date:   Mon, 15 Jun 2020 14:57:22 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, James Ramsay <jramsay.com.au@syl.local>,
        Bryan Turner <bturner@atlassian.com>
Subject: Consensus on a new default branch name
Message-ID: <20200615205722.GG71506@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Over the past few days or so, there has been significant discussion [1] and
patches [2] about changing the name of the default branch away from 'master' and
towards something else.

Concurrently with this, GitHub, GitLab [3], and Bitbucket are working together
in order to make a similar change across our respective products. Because of
this, we are met with a bit of a challenge: we would like to make these changes
before the next version(s) (and so need to settle on a new default branch name),
but we also want to avoid a situation where the community is fractured (eg.,
GitHub uses 'main', Git uses 'default', etc).

A related question is whether or not we plan to change the default value of
'core.defaultBranchName' at all (once Johannes' patches land, of course). That
seems to be the intent in [4], but forming consensus around this would be good,
too.

So, I would like to form some consensus here as to what the new name should be,
if that is something we're committing to doing. This way, we can make this
decision now (and allow hosts to make their corresponding changes) while still
giving us on the list some time to work on the implementation across one or
more release boundaries.

My interpretation thus far is that 'main' is the planned replacement for
'master'. Consensus seems to have formed around this name [5], but if that's
incorrect--or there are yet-unvoiced opinions that you would like to share--now
is the time to discuss further.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com/
[2]: https://lore.kernel.org/git/pull.656.v2.git.1592225416.gitgitgadget@gmail.com/
[3]: https://gitlab.com/gitlab-org/gitlab/-/issues/222204
[4]: https://lore.kernel.org/git/nycvar.QRO.7.76.6.2006111610000.56@tvgsbejvaqbjf.bet/
[5]: https://lore.kernel.org/git/nycvar.QRO.7.76.6.2006091126540.482@ZVAVAG-DN14RQO.ybpnyqbznva/

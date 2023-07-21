Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA82FEB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 18:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjGUSdy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 14:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjGUSdw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 14:33:52 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2055030C8
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 11:33:51 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-579d5d89b41so25021457b3.2
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 11:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689964430; x=1690569230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2/v5hGOb2rDAdFXZfVQS2CQYZBoPkBC6jLzQzubs9HA=;
        b=p/ZAnEq/Tkh8t8lXGzxpVySeCMUT0P6QBnTcaw3QNn44HtFbkaTzFL6Zzc+iH3N9Jp
         zXE906VhUUgl1w5NH0gHiCwo+dMzMOzy/npJf1FVbStP5DXxX1/s7nxDebx1NaA6q404
         lJVi7C9tvXpGRGdnvXT3jp7auQspHjGEWt/q5vLu+uGEJ7LqqVykp9y3z72J2yUc7woO
         JEgOq3xGjg2/ZY4Zt9kNJqaiTDHRKkErUDiYYQv/heImzhgp7xvUX440O+kbI2QzJZwH
         FQnY5g3OCDPegahwiasLdBL9Cn7raFyYWDhLQzC2dYp8nf+jzJBt2bp6x3DfXiJF03UC
         hPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689964430; x=1690569230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/v5hGOb2rDAdFXZfVQS2CQYZBoPkBC6jLzQzubs9HA=;
        b=YaatPXgdmZBObcRmqCbHwM2I0EQNzD0B5aOCKdylR92wS1ohMVFlQUvyBE3BJP+MYA
         la8dM3hObLTSoSWJI1U3FY/82U6h+Iz0n9kSQraz2ZoLmKLPxqjQFCQdW1hKoP33qhUs
         LF5XgGxH7afVG9euC1sw1xMVGZy//fxvwSJnrpZVe6iBg2Eo1tFWWakmvjK3txny07di
         hNFc9MKUQ5lNSK4HC3QrWNpM4e3UFqiM/V0QuH8mVOeWyq40YE5uMNwfCqca98M6xY2a
         4b/26kzNglV+LgtE5PICSeluQE0/sWCpcmx8b7fsGDOU9aOpLYKoMbTcTbrIweauvWZC
         1h2w==
X-Gm-Message-State: ABy/qLYmhdtNIj77v91Oxhcen4Py0wraSB0HbD446aharv53Y0rJBaW0
        EOBBYN+gXHwIqnAROdQs+50obQ==
X-Google-Smtp-Source: APBJJlEGvvw40CNH8qri7+b3pqy6tw7+3kf7MLi6475esnq35N7lhSC7pB9LqPVXzfqI9ADVDn7JyA==
X-Received: by 2002:a0d:cf83:0:b0:56d:2e22:8b31 with SMTP id r125-20020a0dcf83000000b0056d2e228b31mr818615ywd.41.1689964430311;
        Fri, 21 Jul 2023 11:33:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m13-20020a819e0d000000b0057087e7691bsm1050422ywj.56.2023.07.21.11.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 11:33:50 -0700 (PDT)
Date:   Fri, 21 Jul 2023 14:33:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] t/lib-commit-graph.sh: allow `graph_read_expect()`
 in sub-directories
Message-ID: <ZLrPin9L9LtaDHaC@nand.local>
References: <cover.1689960606.git.me@ttaylorr.com>
 <084822126301c0e723155fd76942f2e259b77158.1689960606.git.me@ttaylorr.com>
 <CAPig+cQ2h+67Oxnt7FvZL-LrMF9RazfjLm5pkw4FUh3UU0T+4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQ2h+67Oxnt7FvZL-LrMF9RazfjLm5pkw4FUh3UU0T+4Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 21, 2023 at 01:41:06PM -0400, Eric Sunshine wrote:
> > diff --git a/t/lib-commit-graph.sh b/t/lib-commit-graph.sh
> > @@ -32,6 +32,13 @@ graph_git_behavior() {
> >  graph_read_expect() {
> > +       DIR="."
> > +       if test "$1" = -C
> > +       then
> > +               shift
> > +               DIR="$1"
> > +               shift
> > +       fi
> > @@ -47,12 +54,15 @@ graph_read_expect() {
> > -       cat >expect <<- EOF
> > +       cat >$DIR/expect <<- EOF
>
> It may not matter for any of the current callers, but we'd normally
> want to quote the expansion of $DIR. Also, as I recall, some versions
> of bash complain if the target of '>' is not quoted. So:
>
>     cat >"$DIR/expect" <<-EOF

Hmm. I'm certainly happy to make this change, but there are many other
spots within our tests that would need similar updates. Looking through
the output of:

    $ git grep -E '>\$[[:alnum:]_]+/.*' -- t/**/*.sh

I see 25 such instances (including this one) that would need similar
treatment.

Thanks,
Taylor

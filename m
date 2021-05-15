Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A69C433B4
	for <git@archiver.kernel.org>; Sat, 15 May 2021 12:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E32E613CD
	for <git@archiver.kernel.org>; Sat, 15 May 2021 12:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhEOMND (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 08:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbhEOMM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 08:12:58 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EC8C061573
        for <git@vger.kernel.org>; Sat, 15 May 2021 05:11:44 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so1662009oto.0
        for <git@vger.kernel.org>; Sat, 15 May 2021 05:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=yAmOZQMHAqWig6jW/Mw96Z4fmn4rc+QG2jy5zfF6iuY=;
        b=IUPQa9LGaLa6p8p/i7oj/PpUsWudW2i0PuD138/jIgeFc+EOoOOBdIEWc/kKSk7eB5
         8noCH1svKCziQSmDGdquZjDseY8vLHiXZ4NOZq6ulBJKWoJD5eyQf0t4yS5fAQCSBSTt
         Bc/hOL4ckTOoSyRJAzGHo7aEOfhqHvtuPreOhvrb/Y630jABCznd8AsW4ZxEJ1qfUs8x
         d9dtvW9L2TksgZhHYsmxSGz05CBS4CPdRHh6+sBkfBigSLou0e+uVJkALBRoqjIG5Fso
         C2ZFq8kCE75kmvCbQ3wqBOdCUIdGhwqSQYLTS2wCTcCalnXioNOpI94/AjDPgjnxhMxQ
         A/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=yAmOZQMHAqWig6jW/Mw96Z4fmn4rc+QG2jy5zfF6iuY=;
        b=hAWFNkrmZxQf72IvhFeN9i8HQcWZcoKyByValrAeKcDODi3gDBhjQbJkPAcjvZmyoT
         033Z5t3eQms1+DhmLI6tnygrNgMbqx3kZW7Z4EpWb6jciQpnhbp14HuL7uzKbD3tNIdQ
         bxz6Ojhj3PqSZjUMO1xu1lH04bdS6O/UAcw9TUQ8XnbnfAu0cE5EreA3ZQJneuflEK5h
         744X1sGPbAxErnbXE1zjnpd6/WZJefUaRrCAZdl/jZEeToNGfjFXjRMCG40UeaBiv7dK
         0o08Htu1dxFMOrhlAsXy69NG1s4xlLmbz4J09mq647OxP3uZqg127/0HOwN0J0B9YT9G
         g7Mw==
X-Gm-Message-State: AOAM530HuzYuPphMySi452zGDofw0zkLJkCXfxZK/NZ42vlbH3Z4g7dZ
        CwvztjFvDt7CY7H1k8iEjxKE4APM/qoHjA==
X-Google-Smtp-Source: ABdhPJxeaJQ1WCmIVEOo4G3W3cJYKXoGWK1gMwpAqj4KMSHJaS/w9mzXDBH2LwNfmGF4rtbZVAY1NQ==
X-Received: by 2002:a9d:c24:: with SMTP id 33mr42214382otr.289.1621080704001;
        Sat, 15 May 2021 05:11:44 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id r72sm1671745oie.20.2021.05.15.05.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 05:11:43 -0700 (PDT)
Date:   Sat, 15 May 2021 07:11:42 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <609fba7e89291_e173a208ce@natae.notmuch>
In-Reply-To: <YJ+WbMx+HTjbV2ZP@coredump.intra.peff.net>
References: <20210514121435.504423-1-felipe.contreras@gmail.com>
 <20210514121435.504423-3-felipe.contreras@gmail.com>
 <YJ+WbMx+HTjbV2ZP@coredump.intra.peff.net>
Subject: Re: [PATCH 02/11] doc: doc-diff: allow more than one flag
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Fri, May 14, 2021 at 07:14:26AM -0500, Felipe Contreras wrote:
> 
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  Documentation/doc-diff | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/doc-diff b/Documentation/doc-diff
> > index 1694300e50..ecd88b0524 100755
> > --- a/Documentation/doc-diff
> > +++ b/Documentation/doc-diff
> > @@ -146,7 +146,7 @@ render_tree () {
> >  	# through.
> >  	oid=$1 &&
> >  	dname=$2 &&
> > -	makemanflags=$3 &&
> > +	makemanflags="$3" &&
> 
> This line does nothing; the shell won't split whitespace here either
> way.

Right.

> > @@ -181,6 +181,6 @@ render_tree () {
> >  	fi
> >  }
> >  
> > -render_tree $from_oid $from_dir $from_makemanflags &&
> > -render_tree $to_oid $to_dir $to_makemanflags &&
> > +render_tree $from_oid $from_dir "$from_makemanflags" &&
> > +render_tree $to_oid $to_dir "$to_makemanflags" &&
> 
> This part is necessary (and sufficient).
> 
> It would be nice to mention in the commit message why the use of
> $makemanflags in render_tree must remain unquoted (as I did in mine when
> I made the same change).

Ahh, I didn't see exactly how you implemented it. Now I see it's very
similar.

-- 
Felipe Contreras

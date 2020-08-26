Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2417EC433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 10:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3BCE20786
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 10:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hm4WEBaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgHZKlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbgHZKlR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 06:41:17 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71B6C061574
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 03:41:16 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id t185so751463pfd.13
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 03:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4WUYd+136qXkxniauYO+99/FG98iT4va2QaFsOaq02I=;
        b=Hm4WEBaXBQh/UMNGHueMhyVuBcaZ7BK5o+QgRU3Zju8q0nQmRhVi5jpd8kdJPqLuUu
         4Ygota2ZylMiVNnPf7U6Gp2Lzbr1Re/La/zGB7G5HYt55Y4ll7/vo9n5mUEOWHn8gnLG
         SUcQNNpO8i5rddTtFJVjVrS93QpPywYAGj9Hj9tcMUYiZcjpe37KDs5ch2p7aHMEs1Jj
         xPHBzY52ASUUDnzUW93Xy/oqBimwJzWClhaRczXUTRC0N5NwzMy7sMAGLPeIGKvrdIj3
         kbgtcex65/U8uERA1pZDJ9T7UiC6YOx3VrzhEjSd4wZH/02UMxUiBcRnZ7By3TJQpEK2
         ieyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4WUYd+136qXkxniauYO+99/FG98iT4va2QaFsOaq02I=;
        b=p04tGx4PZh3BEkdp0V0b9rSMhFNl2y+LB5tyjO+Ao3qh2G1nM9TGSGJ+pR74jnGJv8
         W/srKOjOaw3uf4GOfYWB9N2poh/6Hk3kjl7diLr+drVqJAirNwuwrG5ZYA18si+2j2Io
         lpc839x4Z77T7VCaJBRqNuTRTBgzOlL9n4C9lOvI7qVlg7oGSgaPl/i+NADb9Zf4XC0y
         MzrKu6Y04wOfKstL0Nxq3zOmpjNWWMGrMyooBSdeTrbyyrqeeHmv0qiote5+44bxfVp8
         448R3NgzuJZGn1tJlhEgtmjM5JERDWoTCfSvSYnUiUgqLMsn0YEdWKSkicqv4+IckSIy
         spXw==
X-Gm-Message-State: AOAM5328L6T7stmvj8O4qWY8XsNCDZwp4gu/bZ2yNB5jU+zr4U9/g8vT
        glnvOBBUK/6FmCoP/+RTx8o=
X-Google-Smtp-Source: ABdhPJw0/kbL+AgQ66GhP/jBIGu4M+rq0RWLmkCVSKA6u+VrBsSChn8zkh0OdPmeinRZ3nRnd9mnLw==
X-Received: by 2002:a63:9a41:: with SMTP id e1mr7584478pgo.183.1598438475240;
        Wed, 26 Aug 2020 03:41:15 -0700 (PDT)
Received: from konoha ([2401:4900:4154:7a6d:4044:dd86:7023:5493])
        by smtp.gmail.com with ESMTPSA id q5sm2854806pfu.16.2020.08.26.03.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 03:41:14 -0700 (PDT)
Date:   Wed, 26 Aug 2020 16:10:47 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com,
        Johannes.Schindelin@gmx.de, peff@peff.net, liu.denton@gmail.com
Subject: Re: [PATCH 3/3] t7421: eliminate 'grep' check in t7421.4 for mingw
 compatibility
Message-ID: <20200826104047.GA315563@konoha>
References: <20200825113020.71801-1-shouryashukla.oo@gmail.com>
 <20200825113020.71801-4-shouryashukla.oo@gmail.com>
 <2a1ea501-4974-4d74-fe3c-d173bbe76855@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a1ea501-4974-4d74-fe3c-d173bbe76855@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/08 08:03, Kaartic Sivaraam wrote:
> On 25-08-2020 17:00, Shourya Shukla wrote:
> > The 'grep' check in test 4 of t7421 resulted in the failure of t7421 on
> > Windows due to a different error message
> > 
> >     error: cannot spawn git: No such file or directory
> > 
> > instead of
> > 
> >     fatal: exec 'rev-parse': cd to 'my-subm' failed: No such file or directory
> > 
> > Tighten up the check to compute '{src,dst}_abbrev' by guarding the
> 
> The change only affects `src_abbrev`. So, it's misleading to mention
> `dst_abbrev` here.

I forgot to change that. Thank you for pointing this out.

> > 'verify_submodule_committish()' call using `p->status !='D'`, so that
> > the former isn't called in case of non-existent submodule directory,
> > consequently, there is no such error message on any execution
> > environment.
> > 
> > Therefore, eliminate the 'grep' check in t7421. Instead, verify the
> > absence of an error message by doing a 'test_must_be_empty' on the
> > file containing the error.
> > 
> > Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Helped-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> > Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> > ---
> >  builtin/submodule--helper.c      | 7 ++++---
> >  t/t7421-submodule-summary-add.sh | 2 +-
> >  2 files changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> > index 93d0700891..f1951680f7 100644
> > --- a/builtin/submodule--helper.c
> > +++ b/builtin/submodule--helper.c
> > @@ -1035,7 +1035,7 @@ static void print_submodule_summary(struct summary_cb *info, char *errmsg,
> >  static void generate_submodule_summary(struct summary_cb *info,
> >  				       struct module_cb *p)
> >  {
> > -	char *displaypath, *src_abbrev, *dst_abbrev;
> > +	char *displaypath, *src_abbrev = NULL, *dst_abbrev = NULL;
> 
> Unlike `src_abbrev`, I don't think we need to initilialize `dst_abbrev`
> to NULL here as it would be assigned in all code paths.

Alright. Changed!


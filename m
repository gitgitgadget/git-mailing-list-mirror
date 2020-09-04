Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1555C433E2
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 08:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66CE0206D4
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 08:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBVPBsMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgIDIur (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 04:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgIDIuq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 04:50:46 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CC2C061244
        for <git@vger.kernel.org>; Fri,  4 Sep 2020 01:50:46 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p9so7546582ejf.6
        for <git@vger.kernel.org>; Fri, 04 Sep 2020 01:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=92JuzBNsFqC8SkGs0aySUW+8ZezgS3adNQMTeumTjOU=;
        b=jBVPBsMcLvxBj1gPYG7VYhHBieVtuR5Yf8Fe0c6Pk+JefOuz+/c0GmxmCo+wiQat3c
         CVVsM6Oz9Jx4AtnBpUrJ1WKEosAO2lDqLq8PeNgmpsPiUzFLbKPDth6ng7oQO6vjsI26
         28JQcmB/JH5fLZFES8VKRf33NCcOSjbbiU6gp2Ji+o1LbNboVLkUc3ozK3VmoDReUeJ2
         6dk2+uvwMtbObZMZGzbhn7uI5d5tx4Paz2RBSkQJvevqjC0naUbRPdFCjiZH/c/I+l+1
         Si0xbekaSyApD3fR8E/OLGyQ8baiwWYJLYkMgVLh77nXwwPJ2qP6cNQ+mbik0RbhW1hh
         6DZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=92JuzBNsFqC8SkGs0aySUW+8ZezgS3adNQMTeumTjOU=;
        b=kblYQyHlGEyJy1copMnYVOdR7HqQnRY39g513PmSZSyUSEvzWJL02ODf0gHHmU9pCW
         G3Nd8bRJmJlOjuQkVx+7TYcJIuTXNDe7wiVVjeoD8lOXeqgZAnqQf1PmuxGvEeFMUirC
         xDpCNRctO12GxJFH8lFp+EQneG7/31HGoyoAnL4G2/cSJef64JQRILkjIS/tMrLRGmS8
         U520S4nv+4OrGqFrb6+7ucbzJjExLM5eKGTyMfaSBHwPsR2B1SE70huSAXxEjPNSNK6C
         8gsAUFDQrAJmnaeGv6FbywNdjP2rooMLx2PN7jlcvOLz+r2+b/OlzW4mXCPejK6JQLTr
         sglA==
X-Gm-Message-State: AOAM531WRn6bzbu0ES55tUBwhNV4ylSfopA7CEWrnCt2d2iRZ0AKr71V
        t44nFnQKmDbMsWLBa6qbiWKy68jtqyM=
X-Google-Smtp-Source: ABdhPJzFXa5jZxjCkGT2VElqnQXLibvzjXUOaWxGa7JyxV0DIZ8QnQNmb5nh7t3QTQVOf1rqQibWMg==
X-Received: by 2002:a17:906:e103:: with SMTP id gj3mr6142871ejb.153.1599209443522;
        Fri, 04 Sep 2020 01:50:43 -0700 (PDT)
Received: from szeder.dev (84-236-109-131.pool.digikabel.hu. [84.236.109.131])
        by smtp.gmail.com with ESMTPSA id y9sm5409355edo.37.2020.09.04.01.50.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2020 01:50:42 -0700 (PDT)
Date:   Fri, 4 Sep 2020 10:50:36 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com
Subject: Re: [PATCH v3 14/14] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
Message-ID: <20200904085036.GA6209@szeder.dev>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
 <09f6871f66bff838c067a3e0d23cd4622171f3bd.1597178915.git.me@ttaylorr.com>
 <20200819082021.GA5238@szeder.dev>
 <20200903164225.GA7905@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200903164225.GA7905@nand.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 03, 2020 at 12:42:25PM -0400, Taylor Blau wrote:
> On Wed, Aug 19, 2020 at 10:20:21AM +0200, SZEDER Gábor wrote:
> > On Tue, Aug 11, 2020 at 04:52:14PM -0400, Taylor Blau wrote:
> > > Introduce a command-line flag and configuration variable to fill in the
> > > 'max_new_filters' variable introduced by the previous patch.
> > >
> > > The command-line option '--max-new-filters' takes precedence over
> > > 'commitGraph.maxNewFilters', which is the default value.
> > > '--no-max-new-filters' can also be provided, which sets the value back
> > > to '-1', indicating that an unlimited number of new Bloom filters may be
> > > generated. (OPT_INTEGER only allows setting the '--no-' variant back to
> > > '0', hence a custom callback was used instead).
> >
> > Forgot the most important thing: Why?  Please explain in the commit
> > message why this option is necesary, what problems does it solve,
> > how it is supposed to interact with other options and why so.
> 
> This is already explained in detail in the patch 'commit-graph: add
> large-filters bitmap chunk', although there is an error in the quoted
> part of your email (which I wrote) which refers the reader to the
> previous patch. The patch I'm actually referring two is the
> twice-previous patch.

The proposed log message of that patch only briefly mentions what this
option will do, and goes into detail about what problems it _causes_
and how that new chunk is supposed to solve _those_ problems.  It does
not explain what problems this new option is supposed to solve, and
why would anyone want to use this option.

> I'll fix that locally before re-sending.
> 
> Thanks,
> Taylor

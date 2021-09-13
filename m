Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1499C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8600561103
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241615AbhIMThe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 15:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbhIMThd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 15:37:33 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B94C061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 12:36:17 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id n24so13640845ion.10
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 12:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DobMWgzsS3js0i6s4et8Q0VeGF0AeaiZajWwvg5PRkQ=;
        b=x2aXharJTD4WN82IRM+8vkjrkX3MTJwDkmk94o3oEHDLvcKXIk8eLDCG6KB0Wxfcc3
         36Yl5EJO9zdeDaroNk4nsQ+DZPu4EWSug3xBVkpbW9GDEiIONJFwMoJscEiywAshIkei
         soYYL4PJiqmXbEWcLyMvlxHzzgrACsqTuZYLa+TFl7pBd21aYf0cmvpW4Sij/TjxMV/H
         E3YQQ56a27fH6cDyOwKfSHy4CZ29BXx4oA7vsDfG4jDa75aQRk4Oq50OtJzH+EY7I63d
         +iVZ4UNi0EkPRywXD95u0mrOPMGC6aV90JFD/LpvEJbGnLE583Imo+mDQRvUrwwP7OWf
         55Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DobMWgzsS3js0i6s4et8Q0VeGF0AeaiZajWwvg5PRkQ=;
        b=Mv1aRy8zvyqmEqa2/hRm0Ky+wwwI924PhbSij5Ul842ViXNjITyMHZLE7nLPv4bAup
         tKGD2T9GdGvRb2iMExQB+ZjIqg1/ZGRBThT8FfseHZ8JJTByJ4UmMYE24I28oLJ/dA9q
         80E5RJAYsCcqrBNjcxb9VpW8hVh/Jaf6ndBELNz6C6l0LJV7n+hxwAwgfcifjVj10SM+
         0Borg4GSvkygGrGgFOattQl1MggM0ldMKP2pjSsOAliXCbox+RxBeENJv3OPYsZHdwGR
         +uJVyr9vbh2u/2npAWejloTaP+CdfmKDoJBsFzrSfLg8YQrLb7OwoUmdf2T1aSD0pphr
         7gRw==
X-Gm-Message-State: AOAM530iV/8Vao1bVh+eoHbk9Ruq7LpMeyhn66JhoeTuhxjBO+WOgtCc
        i7LuUwf/5q8W6+KvjtXwKJKdMg==
X-Google-Smtp-Source: ABdhPJz8SHB+2cQLgVjnPnAaw/5DdkDmC57Dv3HKSmICP40yuiPTDU82K3AOpU0Vx6RB8ClJSCc94Q==
X-Received: by 2002:a6b:d915:: with SMTP id r21mr10440255ioc.76.1631561776706;
        Mon, 13 Sep 2021 12:36:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y27sm5082671iot.10.2021.09.13.12.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 12:36:16 -0700 (PDT)
Date:   Mon, 13 Sep 2021 15:36:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Glen Choo <chooglen@google.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/3] fsck: verify commit graph when implicitly enabled
Message-ID: <YT+oL15j6Xq05RmS@nand.local>
References: <20210913181221.42635-1-chooglen@google.com>
 <20210913181221.42635-2-chooglen@google.com>
 <YT+mlW851sRyt842@nand.local>
 <CAPig+cRbSUaahdRr9pj9==_7g0Om-Zax93zBRBiJg0-X7zXnOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRbSUaahdRr9pj9==_7g0Om-Zax93zBRBiJg0-X7zXnOA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 03:33:40PM -0400, Eric Sunshine wrote:
> On Mon, Sep 13, 2021 at 3:29 PM Taylor Blau <me@ttaylorr.com> wrote:
> > On Mon, Sep 13, 2021 at 11:12:19AM -0700, Glen Choo wrote:
> > > +test_expect_success 'git fsck (ignores commit-graph when config set to false)' '
> > > +     cd "$TRASH_DIRECTORY/full" &&
> > > +     git fsck &&
> > > +     corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
> > > +             "incorrect checksum" &&
> > > +     cp commit-graph-pre-write-test $objdir/info/commit-graph &&
> > > +     git -c core.commitGraph=false fsck
> >
> > Nit; I recommend replacing the `-c` style configuration with
> > `test_config`, which modifies `$GIT_DIR/config` but only for the
> > duration of the sub-shell.
>
> Small correction: There is no subshell here, so it would be more
> accurate to say "... for the duration of the test".

Yes, sorry about that: I did not mean to say "subshell" here (Glen:
hopefully you didn't read too far into that, since test_config() does
not work in subshells).

Thanks for catching that, Eric.

Thanks,
Taylor

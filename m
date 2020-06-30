Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF46C433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BB452073E
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2MHpSun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389163AbgF3PFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbgF3PFh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 11:05:37 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CD9C061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:05:37 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id o1so2012001plk.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2NNccbLjgDfOW90aMcoU/IpO+IJGY59oi1G5acg93/o=;
        b=I2MHpSununyg0pBYWBH58lTew8jDJk+wUQ0+ZZsiOgABxV8YLGAJ8PZ1OXdFlxUXzt
         KI2kif8XmCaOMl2Dg/cq76coESCFxMZEI2P0qPP+K71DJn8wTf7c0hR+snYO7k5BaSDF
         1Jz9o8ndvxQAmQGOlvWYZIq6xbew/gFR1523gr3gF2FAJolSnQ/uyihebuIYoWlZhpPF
         TrFF8IlpDZElrFG9AFcSD0tZvyuKKBzu+4l+/xP0Tzm3O6iuXaZWRMozZpzzWcsN66mV
         seJu79V44QnEgRuaRXNozc/po2IMhcLT5DrpVJkXor/12hBzRuFbVjjEh+bb3Lj+gOCx
         3k1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2NNccbLjgDfOW90aMcoU/IpO+IJGY59oi1G5acg93/o=;
        b=Cs6q1YxIemiq7Y0YQd5QIYCSsxUt4CVUqTtIMp0BCLWhHaoExvEKXo3Uc/+M1pbnVi
         l+AJLiR3o4oPHoYTzG+jsSUf+8a/VFMfiJgfitNCxlxZZqTqzqx3v2sgWah+RF+BsHZZ
         UMXAmsJP24GsMsLjy+3c6MvascWiqPO1WsxDDCJnVeiNh+FeIelDHGS+zlWwWXl2Cjbg
         3U+NIO0j+Br7yvwMflajJ+Tx8CTrWlDrLRPCkddPpUtSclZSjNd3RV8+YnBH4hBXYoes
         bCzQa9bxcowD9UZK4tH9/MJgO6hmSR0L6uWJF/LwQlz6isFUmAQHMHDWmjq+yjWCvm52
         5BNw==
X-Gm-Message-State: AOAM533aelHmwgpmBDirK/hLm2Eny2y2SWs4tasG42wQcDGT1NreI07B
        QK3JiYx8hNyMNhxrXrp0kAs=
X-Google-Smtp-Source: ABdhPJwEto+zLdbtQ7I6grVh7D18kdNYRBaEAEO3CL9WFZFUsqgYVvt8uvxrq9b6ZToqxqCT6suzGw==
X-Received: by 2002:a17:90b:705:: with SMTP id s5mr16164813pjz.11.1593529536661;
        Tue, 30 Jun 2020 08:05:36 -0700 (PDT)
Received: from localhost ([2402:800:6375:9968:2644:616c:71ad:c7e6])
        by smtp.gmail.com with ESMTPSA id g63sm2625438pje.14.2020.06.30.08.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 08:05:35 -0700 (PDT)
Date:   Tue, 30 Jun 2020 22:05:33 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v4 1/9] fmt-merge-msg: stop treating `master` specially
Message-ID: <20200630150533.GF20303@danh.dev>
References: <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
 <pull.656.v4.git.1593009996.gitgitgadget@gmail.com>
 <fffdb9944fc2672ccb7eac776cdd18855a1f99dc.1593009996.git.gitgitgadget@gmail.com>
 <20200629162003.GD20303@danh.dev>
 <nycvar.QRO.7.76.6.2006291520220.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2006291520220.56@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On 2020-06-29 15:27:44+0200, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > This change will also affect git-subtree test.
> 
> Good point. The patch looks good. I wonder whether we should also address
> these:
> 
> Documentation/git-rebase.txt:*   Merge branch 'report-a-bug'
> Documentation/git-rebase.txt:* | Merge branch 'refactor-button'
> Documentation/git-switch.txt:HEAD is now at 9fc9555312 Merge branch 'cc/shared-index-permbits'
> Documentation/howto/using-signed-tag-in-pull-request.txt: Merge tag 'frotz-for-xyzzy' of example.com:/git/froboz.git/
> Documentation/howto/using-signed-tag-in-pull-request.txt:     Merge tag 'frotz-for-xyzzy' of example.com:/git/froboz.git/
> t/t7606-merge-custom.sh:*   (HEAD, master) Merge commit 'c3'
> 
> The first three matches are in manual pages, the next two in technical
> documentation, and the last one in a comment in one of the test scripts.
> So none of them are super critical, but maybe there are different
> opinions?

In _my very opinion_, I don't think it's that critical.
We allow git merge --edit and git fmt-merge-msg -m.
Someone may have configured their Git to remove branch name already.
And some others may always remove the target branch manually.
We probably don't want to introduce another master occurence.
(For sideline watcher: Please not argue on this,
I don't have any opinions about the word: master.)

If there're a consensus on changing those documentation,
I won't mind to do that manual work ;)

The test is a different story, since some (or most?) distro enable
check (or test) phase for their build infrastructure.
And, we shouldn't break their infrastructures.

> 
> Ciao,
> Dscho
> 
> > We'll need this patch for subtree:
> > ----------------8<-------------------
> > From: =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?=
> >  <congdanhqx@gmail.com>
> > Date: Mon, 29 Jun 2020 22:56:37 +0700
> > Subject: [PATCH] contrib: subtree: adjust test to change in fmt-merge-msg
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=UTF-8
> > Content-Transfer-Encoding: 8bit
> >
> > We're starting to stop treating `master' specially in fmt-merge-msg.
> > Adjust the test to reflect that change.
> >
> > Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> > ---
> >  contrib/subtree/t/t7900-subtree.sh | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> > index 57ff4b25c1..53d7accf94 100755
> > --- a/contrib/subtree/t/t7900-subtree.sh
> > +++ b/contrib/subtree/t/t7900-subtree.sh
> > @@ -196,7 +196,8 @@ test_expect_success 'merge new subproj history into sub dir/ with --prefix' '
> >  		cd "$subtree_test_count" &&
> >  		git fetch ./"sub proj" master &&
> >  		git subtree merge --prefix="sub dir" FETCH_HEAD &&
> > -		check_equal "$(last_commit_message)" "Merge commit '\''$(git rev-parse FETCH_HEAD)'\''"
> > +		check_equal "$(last_commit_message)" \
> > +			"Merge commit '\''$(git rev-parse FETCH_HEAD)'\'' into master"
> >  	)
> >  '
> >
> > @@ -273,7 +274,8 @@ test_expect_success 'merge new subproj history into subdir/ with a slash appende
> >  		cd "$test_count" &&
> >  		git fetch ./subproj master &&
> >  		git subtree merge --prefix=subdir/ FETCH_HEAD &&
> > -		check_equal "$(last_commit_message)" "Merge commit '\''$(git rev-parse FETCH_HEAD)'\''"
> > +		check_equal "$(last_commit_message)" \
> > +			"Merge commit '\''$(git rev-parse FETCH_HEAD)'\'' into master"
> >  	)
> >  '
> >
> > --
> > 2.27.0.111.gc72c7da667
> > Danh
> >


-- 
Danh

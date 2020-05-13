Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD0EC433E1
	for <git@archiver.kernel.org>; Wed, 13 May 2020 23:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E5DC2053B
	for <git@archiver.kernel.org>; Wed, 13 May 2020 23:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WW+pysmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732783AbgEMXwV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 19:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732456AbgEMXwU (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 19:52:20 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F6EC061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 16:52:19 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fu13so11663587pjb.5
        for <git@vger.kernel.org>; Wed, 13 May 2020 16:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IreiLoHrkO0A2gbzvzJDExCi+Hx3Y8hEuJxSzjbLYt8=;
        b=WW+pysmMZT/sYxDfV97I7bQvYsQBmh2R9296Vkxs9UViRNm6kebpxhJh/Kt3Vev5Wx
         XXd0U7lXHq/vZYqZElZtmNQ3yiYHos4231ToWF3twgfsNFVkut7pMzGOnmOTyRr6hc3z
         Tx1T30IPvYHaXZpG7HyZYWdlP6uEiylvB2XI3FKbZzzqu7tOmAsQ6EMPMJLeZ/2Zr/qD
         03hgXk1NHFFG346kzyT5lID2YenUcN3MyKQpLhpbyNeSaUt6ewYC0a5j0q1wB6jGheq4
         GccXBvnq1buxZa3eUHfzPKf45l9QgIHSSk3Q9eb0kRWpKcEw+YIQzDbb/dCc2aFkwPum
         nkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IreiLoHrkO0A2gbzvzJDExCi+Hx3Y8hEuJxSzjbLYt8=;
        b=EEWBco7oCmz1ZusHDhrI79e+f4kMueqjy5CY7k7VUPMZhCAtH5XKnzdg/ef5lJb4Vm
         992W2iOzDFhZMeuzArOOVufsZYEm6hBMS90M212VgmcIdgJj1knpTnB+kEqXwzzYQPTv
         3f0mbSx4uoss+yrxaojcQ7KTqzh4QVgu7Cn/QJRj/4tAkwy7HFLWnU9kJ/EfmWhResGe
         9W9xrO40BHobSz3ZCdltiyKIdPYm9uLujiQHIAOHa4HcPzj6Fcok71R85q2wVJm04Ang
         TYsFwLmTSMMXuoeshcD3mQITNtDQi3eTV6pmidU5+mPccWnhnMiidkf05+fOadYAfXfv
         CmbA==
X-Gm-Message-State: AOAM5304rOsvh8axomBgw8AalBFXCOxqrpHyjekglaGfLtexFcgmfcy2
        CA5mhx1IRqOkbXQ+9uc/enG5hP0P
X-Google-Smtp-Source: ABdhPJyZAuh2uyQjGVQ6PocTJhSG0SPFddh87vJSMzbMoK5Bj8hpvU61AU9SZLW/r4szPzM1h4p8JQ==
X-Received: by 2002:a17:902:b694:: with SMTP id c20mr1502375pls.313.1589413938726;
        Wed, 13 May 2020 16:52:18 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id v64sm599185pfb.20.2020.05.13.16.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 16:52:17 -0700 (PDT)
Date:   Thu, 14 May 2020 06:52:15 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] CI: enable t1509 in Travis and GitHub Actions
Message-ID: <20200513235215.GA10618@danh.dev>
References: <cover.1589375923.git.congdanhqx@gmail.com>
 <fa2e1f7b44262eac1fa26161fc5d3f3b9b6bdb47.1589375923.git.congdanhqx@gmail.com>
 <xmqq8shvvkur.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8shvvkur.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-13 09:51:56-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> > +if test "$t1509_allowed" = YES
> > +then
> > +	case "$jobname" in
> > +	osx-*) ;;
> > +	*)
> > +		chmod a+w / || sudo chmod a+w / || true
> > +		export IKNOWWHATIAMDOING=YES
> 
> Eeeww ;-)  This makes readers wonder where we did not enable the
> test and why.  Perhaps throw in a matching
> 
> 	t1509_allowed=NO
> 
> in the azure thing for completeness?

I was thinking about allowing people set it via environment variable
and check, but it seems too risky, now.

Perhaps, always reset it to NO before the checking for $CI_TYPE,
and enable it selectively for only Travis, and GitHub Actions.

I didn't enable it for Azure because I can't assure it ;).

> Also, do we want to give a more descriptive name than t1509 to the
> variable, say, ROOT_WORK_TREE_TEST_ALLOWED?

Yeah, I think all caps is better for this risky variable.
I think using T1509_ROOT_WORK_TREE_TEST_ALLOWED is better, to point
out which test is risky. But it require future tests with root
work-tree must be written in t1509, since it's rare usecase, It'd be
fine, I think.

> 
> > diff --git a/ci/run-docker-build.sh b/ci/run-docker-build.sh
> > index 8d47a5fda3..026afe275a 100755
> > --- a/ci/run-docker-build.sh
> > +++ b/ci/run-docker-build.sh
> > @@ -58,6 +58,8 @@ else
> >  	test -n "$cache_dir" && chown -R $HOST_UID:$HOST_UID "$cache_dir"
> >  fi
> >  
> > +chmod a+w /
> > +
> >  # Build and test
> >  command $switch_cmd su -m -l $CI_USER -c "
> >  	set -ex
> > @@ -68,6 +70,7 @@ command $switch_cmd su -m -l $CI_USER -c "
> >  	export GIT_TEST_CLONE_2GB='$GIT_TEST_CLONE_2GB'
> >  	export MAKEFLAGS='$MAKEFLAGS'
> >  	export cache_dir='$cache_dir'
> > +	export IKNOWWHATIAMDOING=YES
> >  	cd /usr/src/git
> >  	test -n '$cache_dir' && ln -s '$cache_dir/.prove' t/.prove
> >  	make
> 
> Big EWWWWWWwwww.  Do we need to do this for _all_ tests, not
> selectively only while running t1509?  This makes me worried as a
> test by mistake can easily corrupt the VM and invalidating the
> tests; I know we get a fresh one every time, so there is no
> permanent harm done by corrupting it, but having one fewer thing we
> have to worry about is always better than having one more thing.

Perhaps pass this variable all the way down from ci/lib.sh?
Adding another variable into t1509 (except T1509_*) doesn't make it
less risky.
Or should we add T1509_ prefix to this env var?

-- 
Danh

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0663BC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 17:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2CAC610A3
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 17:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhHSRrS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 13:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhHSRrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 13:47:16 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4882BC061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 10:46:40 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s11so6586645pgr.11
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 10:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HADfxu1UypiSoWUY8O5CGyWv++JtgZUBMWtITezD6kM=;
        b=N70VBhMwcUuk8d6AnZXwW7gzCZ86dnzeu2Y+QcMpjFvnoKlpunY0IXsYQQ2zCVlKKR
         npb7NAa6EpGQ5FJ8Ha8thL7DVRvGV8TZZExuWawMBANRDu8spnXl7HTBX9BBBrBUUlTT
         MF6lP0CKdA4HGOzHDrdnNRaIUogkx/+VakMW+ZlgDcJzD1enMmpfgwoBFeyeYZLlDMRv
         7LsfYqWguSHevDcuUt4DMZHB5WXkfXbLmXf+W+Yo1P1qnBo+4OGA587rDnten2473vQq
         k6375NIJBBmEw3gKt4YN2oyMs2/urlhQ9wtO/JMeMiCMRlokAJlkCbAonwx9YWI2vl2e
         jBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HADfxu1UypiSoWUY8O5CGyWv++JtgZUBMWtITezD6kM=;
        b=WQPvX5he04TxFG31IdGZrRo3Q/zIrcY8+qQGfUvBIZCKoLVSRkcUarhpz3oWfMY2Wi
         xottzbtJnJ6UBG/CNNXvT83fS4btlW4ttH9Nq4JUm6ZOmQmpP2FDFYP0JDoeorWMTvPK
         wPUwPFf8em0KfD5eHTmAJ9AGfuoH1+1tiM1JQuCrsLVZBOqsXTvCbzW5j47/2VQqNqw/
         eqGiujxfn6fGTdtzLXsB7iDj0GiuTDUzp24oxOxDLrO9uNPcjlBQPmr3TOrSCyATe9F/
         Y5olTlps6BfQ/WkGx6Com3svVk2YW9LxsFzngSjrlxxbxmKOvmlj905aKMQ/uF/qeQXK
         2bHg==
X-Gm-Message-State: AOAM530n8qgJqFbVrFVKTUZOuMGwxeW+FviFzCgBcEJOFKlwqdA8ko/r
        gzCgO6rFTamU+rj3ynXmzSW1+g==
X-Google-Smtp-Source: ABdhPJxchyNQg7nYS1+Ox3MmWOdvuWL0En3m8HBy+4ls33j9ydoTutcmmg8O/JNxIfHFwpTaYotJVg==
X-Received: by 2002:a63:cf58:: with SMTP id b24mr15042761pgj.97.1629395199613;
        Thu, 19 Aug 2021 10:46:39 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a999:9b6d:55c3:b66c])
        by smtp.gmail.com with ESMTPSA id k4sm4166387pff.12.2021.08.19.10.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 10:46:38 -0700 (PDT)
Date:   Thu, 19 Aug 2021 10:46:31 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] t7400-submodule-basic: modernize inspect() helper
Message-ID: <YR6Y91D2Yt5K5vaS@google.com>
References: <20210616004508.87186-2-emilyshaffer@google.com>
 <20210727171225.2457893-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727171225.2457893-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 10:12:25AM -0700, Jonathan Tan wrote:
> 
> > diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> > index a924fdb7a6..f5dc051a6e 100755
> > --- a/t/t7400-submodule-basic.sh
> > +++ b/t/t7400-submodule-basic.sh
> > @@ -107,25 +107,18 @@ test_expect_success 'setup - repository to add submodules to' '
> >  # generates, which will expand symbolic links.
> >  submodurl=$(pwd -P)
> >  
> > -listbranches() {
> > -	git for-each-ref --format='%(refname)' 'refs/heads/*'
> > -}
> > -
> >  inspect() {
> >  	dir=$1 &&
> > -	dotdot="${2:-..}" &&
> >  
> > -	(
> > -		cd "$dir" &&
> > -		listbranches >"$dotdot/heads" &&
> > -		{ git symbolic-ref HEAD || :; } >"$dotdot/head" &&
> > -		git rev-parse HEAD >"$dotdot/head-sha1" &&
> > -		git update-index --refresh &&
> > -		git diff-files --exit-code &&
> > -		git clean -n -d -x >"$dotdot/untracked"
> > -	)
> > +	git -C "$dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
> > +	{ git -C "$dir" symbolic-ref HEAD || :; } >head &&
> > +	git -C "$dir" rev-parse HEAD >head-sha1 &&
> > +	git -C "$dir" update-index --refresh &&
> > +	git -C "$dir" diff-files --exit-code &&
> > +	git -C "$dir" clean -n -d -x >untracked
> >  }
> >  
> > +
> 
> Stray extra line.
> 
> Other than that, this is definitely a good simplification.

Ack, fixed locally. Thanks.

 - Emily

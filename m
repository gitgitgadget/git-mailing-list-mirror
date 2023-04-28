Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB2EC77B60
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 16:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346405AbjD1QyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 12:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346283AbjD1QyV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 12:54:21 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AC55FD0
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 09:54:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1a66e7a52d3so1587995ad.0
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 09:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682700851; x=1685292851;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioWjtzMhxVmZT2ioSOa0mL6t6dB8468xXOCAuVarLwM=;
        b=ZN2N/rifFEBfXnLQWAu1qzaOkbyS57hVKZg4XBO+e/uh7gT9ICdR1AGoOAzgiG7GIZ
         9Klli9gvFQegTJJJOBy8qol993vh+oBUnkJV3B8RqfYExOljLh1OfEzYY3kZhDs/+xKF
         QbdJW71wSLDf1NIkeAVC3nFDV5jyF5PNcna4cwaB06MHObGBM2r8fBySXoJTqSsB1vge
         JOgsu4i87p4nobngPs6TilxNC0oXSKcq5qJBJSsd6TBoJTC63NPcVOi6wx2kpmTFyFFx
         UruWczDu9fuiw3AqXYXx+nD1TJDLA8fS1i2PF2SPRIPpv7op6EwjLcjWz0mdMHvFyPyT
         nyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682700851; x=1685292851;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ioWjtzMhxVmZT2ioSOa0mL6t6dB8468xXOCAuVarLwM=;
        b=ZHQ0zkD56tiTmq8V4Y6uFELNowDy620POGQ6H01w4pimjDRUU0YONfFcH3f2W61fqU
         TlSZk/BE50pRd4pDMtUcUdy8p+GvYzgPrFK4rXk0uEvgjNw9BdSo3KjzUmNMMhY+qi6R
         Ld7/Qkdsg0plar08CJb5S+U9jmy0AwdvGXYM5LxccbrGd+yv+JKzTu4gYZFJOaqx9y6A
         XBc0LHGyLYt4P9Ie2ivZ1sdHI/v13cZrlusD1NAsOUONtr75MPeRVmo8wO8PHOEYgM3C
         poDdPXNkkAhbe2KLeI0Dci1NCWA0OvAPMrySsZ0K4swA+drksvfB/dAvHK+hdDcInuDA
         gTyQ==
X-Gm-Message-State: AC+VfDyeYx14eCz0ilNwfUK/dOIrwSJ1ZUOTSDDFzjOvLa8HEoRwmMSE
        WZCXLQdrgEJuNSqW40/GHrN3/r1KZTvqTDYXObkegA==
X-Google-Smtp-Source: ACHHUZ7cMTyJ9X9sRgjlGS1ujA1wWVE4+huIdCTY4WljPm7WKDLQbYqyBz0g8U5G35sQdfw5qtLtmA==
X-Received: by 2002:a17:903:228f:b0:1a9:20bc:798d with SMTP id b15-20020a170903228f00b001a920bc798dmr7144249plh.62.1682700851142;
        Fri, 28 Apr 2023 09:54:11 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:202:d2c3:4cc2:f9f7:57a9])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902654800b001aacb458b12sm556254pln.105.2023.04.28.09.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 09:54:10 -0700 (PDT)
Date:   Fri, 28 Apr 2023 09:54:05 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] setup: trace bare repository setups
Message-ID: <ZEv6LZTx1pZpJtIn@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <cb72bca46c6ff2a8cf3196408fb53411f7f91892.1682631601.git.steadmon@google.com>
 <xmqqttx1gcmr.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqttx1gcmr.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023.04.27 15:54, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > diff --git a/setup.c b/setup.c
> > index 59abc16ba6..458582207e 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -1352,6 +1352,7 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
> >  		}
> >  
> >  		if (is_git_directory(dir->buf)) {
> > +			trace2_data_string("setup", NULL, "implicit-bare-repository", dir->buf);
> >  			if (get_allowed_bare_repo() == ALLOWED_BARE_REPO_EXPLICIT)
> >  				return GIT_DIR_DISALLOWED_BARE;
> >  			if (!ensure_valid_ownership(NULL, NULL, dir->buf, report))
> 
> That is kind of obvious.
> 
> > diff --git a/t/t0035-safe-bare-repository.sh b/t/t0035-safe-bare-repository.sh
> > index 11c15a48aa..a1f3b5a4d6 100755
> > --- a/t/t0035-safe-bare-repository.sh
> > +++ b/t/t0035-safe-bare-repository.sh
> > @@ -7,13 +7,24 @@ TEST_PASSES_SANITIZE_LEAK=true
> >  
> >  pwd="$(pwd)"
> >  
> > -expect_accepted () {
> > -	git "$@" rev-parse --git-dir
> > +expect_accepted_implicit () {
> > +	test_when_finished "rm \"$pwd/trace.perf\"" &&
> 
> Why not
> 
> 	test_when_finished 'rm "$pwd/trace.perf"' &&
> 
> instead?  
> 
> In your version, $pwd is expanded before test_when_finished sees it,
> so you'd have to worry about things like backslashes and double quotes
> in it.  You can of course quote the '$' like so
> 
> 	test_when_finished "rm \"\$pwd/trace.perf\"" &&
> 
> to work it around, but it is equivalent to enclosing everything
> inside a pair of single quotes.  Either way your $pwd will be
> interpolated when "eval" sees the $test_cleanup script.
> 
> And it would be much easier to read without backslash and
> backslashed double quotes.
> 
> > +	GIT_TRACE2_PERF="$pwd/trace.perf" git "$@" rev-parse --git-dir &&
> > +	grep -F "implicit-bare-repository:$pwd" "$pwd/trace.perf"
> > +}
> 
> We ensure that we positively have such a trace in the output.  Good.
> 
> > +expect_accepted_explicit () {
> > +	test_when_finished "rm \"$pwd/trace.perf\"" &&
> > +	GIT_DIR="$@" GIT_TRACE2_PERF="$pwd/trace.perf" git rev-parse --git-dir &&
> > +	! grep -F "implicit-bare-repository:$pwd" "$pwd/trace.perf"
> >  }
> 
> When not asking for the magic behaviour of "$@" and instead doing a
> "squash everything into a single string, using the first letter in
> $IFS as the separator in between", please write "$*" instead.
> 
>     GIT_DIR="$*" GIT_TRACE2_PERF="..." git rev-parse --git-dir
> 
> But in this case, I do not think you are ever planning to send a
> directory name split into two or more, to be concatenated with SP,
> so writing it like
> 
>     GIT_DIR="$1" GIT_TRACE2_PERF="..." git rev-parse --git-dir
> 
> would be much less error prone and easier to follow, I think.
> 
> > @@ -22,12 +33,12 @@ test_expect_success 'setup bare repo in worktree' '
> >  '
> >  
> >  test_expect_success 'safe.bareRepository unset' '
> > -	expect_accepted -C outer-repo/bare-repo
> > +	expect_accepted_implicit -C outer-repo/bare-repo
> >  '
> 
> Perhaps futureproof this test piece by explicitly unsetting the
> variable before starting the test?  That way, this piece will not be
> broken even if earlier tests gets modified to set some value to
> safe.bareRepository in the future.
> 
> >  test_expect_success 'safe.bareRepository=all' '
> >  	test_config_global safe.bareRepository all &&
> > -	expect_accepted -C outer-repo/bare-repo
> > +	expect_accepted_implicit -C outer-repo/bare-repo
> >  '
> >  
> >  test_expect_success 'safe.bareRepository=explicit' '
> > @@ -47,7 +58,7 @@ test_expect_success 'safe.bareRepository in the repository' '
> >  
> >  test_expect_success 'safe.bareRepository on the command line' '
> >  	test_config_global safe.bareRepository explicit &&
> > -	expect_accepted -C outer-repo/bare-repo \
> > +	expect_accepted_implicit -C outer-repo/bare-repo \
> >  		-c safe.bareRepository=all
> >  '
> >  
> > @@ -60,4 +71,8 @@ test_expect_success 'safe.bareRepository in included file' '
> >  	expect_rejected -C outer-repo/bare-repo
> >  '
> >  
> > +test_expect_success 'no trace when GIT_DIR is explicitly provided' '
> > +	expect_accepted_explicit "$pwd/outer-repo/bare-repo"
> > +'
> > +
> >  test_done
> 
> All the expectations look sensible.  Thanks for a pleasant read.

Agreed with all the feedback points, will fix in V2. Thanks!

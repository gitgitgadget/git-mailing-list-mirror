Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6C1C432C3
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 08:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20DC2231D
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 08:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTENs+H2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfKTIAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 03:00:07 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54190 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfKTIAG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 03:00:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id u18so5937846wmc.3
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 00:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UgnvcqT2q9qsif46W7ZPK3xnvN+wPnKUiiJX6hGiC8s=;
        b=dTENs+H2hxSk6fMO98ijXyhC+/FQs7wgJBLL+A4TqmA7fAQN9CB1o7VW8iaxxPA8vv
         SrQjN26NggjxOeUlGkWsNIUU5hM02EbDhvBSXqocOpKy/qEZGq4hxSV9XuyLVQ4u+7lN
         V8eyQTwIZBppg6/5N5pOXXJv3MMcS5WoGN0Nn86HgT4y/InH9gG0cojGyV4aiQWfZTru
         ooBRe+wtwsdN9h1jwJXKfAZaM8qE+z2b6GRIvZ6vOjq1iJIWY7hCqptEwdL84tKnXFCp
         AVy8nug0By02P79/bHdbDOVhhE1dh+3zZUgMwMbKVb6YmO5a9t3r23GJNmF4LSBHroig
         GeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UgnvcqT2q9qsif46W7ZPK3xnvN+wPnKUiiJX6hGiC8s=;
        b=pRqLHBeAVzL59DwIh6uhyd6Rqiu86qD84P5cdk8gEoJc8T0l+XZHerRWtzxanXPMok
         nRbNvj0gyWMDoB4p9cMOaY0KVrNj893HV5svkv+XMW2A6WfNIHnhmynKQyXGwfbIrXlB
         Fbn8gtiv/omYtSuTkLWClm9rRl10mGiUY5yH3020xCl0srau+4MLJInmpecZ4XjVNM8J
         dd9eXbePPy07merXNI7JKBAnqXF0C+n6D//thmiTkrdEJl8BxFrMavFd+BkV7vOkzNjO
         XhsyuWOhoKfkUGUG2mO1NsNfs55ZjUjaf+tLiIW2nGUINSHjlzeuLVIj6UzgYfSkOR9d
         l3UA==
X-Gm-Message-State: APjAAAVgxheZyXuyReuG0YZM9wzofv4u4xDc8lEBoLTzrU1YrEKz7WZ2
        DnlzCdFtMsPqk69RKTuBGCzpIMhZ
X-Google-Smtp-Source: APXvYqz9n7LnykLIvUoiHJiMokzY2AaLNUiCOtcgw2E68pFJv315Ms9sG490FKYF2hXSCQLPqXiX5w==
X-Received: by 2002:a7b:cd86:: with SMTP id y6mr1530320wmj.163.1574236804901;
        Wed, 20 Nov 2019 00:00:04 -0800 (PST)
Received: from localhost ([46.69.175.162])
        by smtp.gmail.com with ESMTPSA id k18sm4578265wrm.82.2019.11.20.00.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Nov 2019 00:00:03 -0800 (PST)
Date:   Wed, 20 Nov 2019 08:00:03 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] perf-lib: remove old result files before running tests
Message-ID: <20191120080003.GA38901@cat>
References: <20191119185047.8550-1-t.gummerer@gmail.com>
 <xmqq5zjfchix.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5zjfchix.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/20, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > @@ -178,10 +178,11 @@ test_wrapper_ () {
> >  	export test_prereq
> >  	if ! test_skip "$@"
> >  	then
> 
> > -		base=$(basename "$0" .sh)
> 
> So we used to use $base to hold the number and the filename here
> 
> > -		echo "$test_count" >>"$perf_results_dir"/$base.subtests
> > -		echo "$1" >"$perf_results_dir"/$base.$test_count.descr
> >  		base="$perf_results_dir"/"$PERF_RESULTS_PREFIX$(basename "$0" .sh)"."$test_count"
> 
> and then redefined it to be the results-prefix specific one.
> 
> 
> > +		rm -f "$base".*
> 
> you now remove those results-prefix specific one for the $test_count
> (I guess that is as specific you can go) before writing the count
> and the description.  
> 
> So this "rm -f" is a no-op when perf-results-prefix is not empty?

No, not quite.  It is a no-op the first time a particular test runs
for a specific prefix.  The prefix is usually set by the 't/perf/run'
script, and indicates the revision that is tested.

So if we were running for example

    ./run deadbeef... p0001-rev-list.sh

we'd have a file 'test-results/build_deadbeef....p0001-rev-list.1.times' 
in the t/perf directory.

Now we add a 'test_size' test before the first 'test_perf' test, and
run the tests again.  After this run we'd still have that original
file from the test results from the previous run, as well as a
'test-results/build_deadbeef....p0001-rev-list.1.size'.

This duplicate file at the matching "$base" is what we want to avoid.
The "rm -f" above would remove
'test-results/build_deadbeef....p0001-rev-list.1.times' so we now only
have the '.size' file left, and 'aggregate.perl' gives us the right
result.

> > +		no_prefix_base="$perf_results_dir"/$(basename "$0" .sh)
> > +		echo "$test_count" >>$no_prefix_base.subtests
> > +		echo "$1" >$no_prefix_base.$test_count.descr
> >  		"$test_wrapper_func_" "$@"
> >  	fi

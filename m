Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D14B2018B
	for <e@80x24.org>; Mon, 18 Jul 2016 22:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbcGRWy0 (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 18:54:26 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53822 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290AbcGRWyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 18:54:25 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FAA42018B;
	Mon, 18 Jul 2016 22:54:24 +0000 (UTC)
Date:	Mon, 18 Jul 2016 22:54:24 +0000
From:	Eric Wong <e@80x24.org>
To:	git@vger.kernel.org
Cc:	Christian Couder <christian.couder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Stefan Beller <sbeller@google.com>,
	David Turner <novalis@novalis.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: t7063 failure on FreeBSD 10.3 i386/amd64
Message-ID: <20160718225424.GA813@plume>
References: <20160718223038.GA66056@plume>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160718223038.GA66056@plume>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Oops, forgot to Cc some folks who worked on this :x

Filesystem is ufs and it fails regardless of whether
soft-updates is enabled or not.

Eric Wong <e@80x24.org> wrote:
> Not sure what's going on, below is the relevant output when
> run with -i -v --tee (the rest succeeds without -i):
> 
> ok 26 - untracked cache correct after status
> 
> expecting success: 
> 	avoid_racy &&
> 	: >../trace &&
> 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
> 	git status --porcelain >../status.actual &&
> 	cat >../status.expect <<EOF &&
>  M done/two
> ?? .gitignore
> ?? done/five
> ?? dtwo/
> EOF
> 	test_cmp ../status.expect ../status.actual &&
> 	cat >../trace.expect <<EOF &&
> node creation: 0
> gitignore invalidation: 0
> directory invalidation: 0
> opendir: 0
> EOF
> 	test_cmp ../trace.expect ../trace
> 
> --- ../trace.expect	2016-07-18 22:23:28.679886000 +0000
> +++ ../trace	2016-07-18 22:23:28.677135000 +0000
> @@ -1,4 +1,4 @@
>  node creation: 0
>  gitignore invalidation: 0
> -directory invalidation: 0
> -opendir: 0
> +directory invalidation: 1
> +opendir: 1
> not ok 27 - test sparse status again with untracked cache

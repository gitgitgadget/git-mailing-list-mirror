Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49F5C2D0A3
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 00:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B84D206CB
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 00:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgKJAXO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 19:23:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:52212 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729831AbgKJAXO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 19:23:14 -0500
Received: (qmail 5165 invoked by uid 109); 10 Nov 2020 00:23:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Nov 2020 00:23:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29263 invoked by uid 111); 10 Nov 2020 00:23:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Nov 2020 19:23:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Nov 2020 19:23:12 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Hu Keping <hukeping@huawei.com>, zhengjunling@huawei.com,
        zhuangbiaowei@huawei.com, Patrick Hemmer <git@stormcloud9.net>,
        Rafael Ascensao <rafa.almas@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2] format-patch: make output filename configurable
Message-ID: <20201110002312.GA1267848@coredump.intra.peff.net>
References: <20201105201548.2333425-1-hukeping@huawei.com>
 <20201105150149.GA107127@coredump.intra.peff.net>
 <xmqqimajijwa.fsf@gitster.c.googlers.com>
 <xmqqwnyydxaw.fsf@gitster.c.googlers.com>
 <xmqqo8kadu9j.fsf_-_@gitster.c.googlers.com>
 <CAPig+cQAreDJn_tS_K4sR9HwsSVNoFid9sWSdxzwSqkJLRidgQ@mail.gmail.com>
 <xmqqwnyubagr.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwnyubagr.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 09, 2020 at 11:23:48AM -0800, Junio C Hamano wrote:

> @@ -1822,6 +1825,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  	init_display_notes(&notes_opt);
>  	git_config(git_format_config, NULL);
>  	repo_init_revisions(the_repository, &rev, prefix);
> +	rev.subject_prefix = fmt_patch_subject_prefix;
>  	rev.show_notes = show_notes;
>  	memcpy(&rev.notes_opt, &notes_opt, sizeof(notes_opt));
>  	rev.commit_format = CMIT_FMT_EMAIL;
> @@ -1831,7 +1835,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  	rev.diff = 1;
>  	rev.max_parents = 1;
>  	rev.diffopt.flags.recursive = 1;
> -	rev.subject_prefix = fmt_patch_subject_prefix;
>  	memset(&s_r_opt, 0, sizeof(s_r_opt));
>  	s_r_opt.def = "HEAD";
>  	s_r_opt.revarg_opt = REVARG_COMMITTISH;

It's not clear to me what these hunks are doing. I'm trying really hard
to find some subtle reason that we need to init this field sooner, but I
can't. It really looks like it might be leftover noise.

-Peff

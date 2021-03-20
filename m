Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98FFC433E6
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 05:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC7676197D
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 05:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhCTFGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 01:06:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:43194 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhCTFGH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 01:06:07 -0400
Received: (qmail 11649 invoked by uid 109); 20 Mar 2021 05:06:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 20 Mar 2021 05:06:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9395 invoked by uid 111); 20 Mar 2021 05:06:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 20 Mar 2021 01:06:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 20 Mar 2021 01:06:05 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: Re: [PATCH v10 2/3] interpret-trailers: add own-identity option
Message-ID: <YFWCvePMGvBY/I9v@coredump.intra.peff.net>
References: <pull.901.v9.git.1615891183320.gitgitgadget@gmail.com>
 <pull.901.v10.git.1616066156.gitgitgadget@gmail.com>
 <42590e95deeece6ba65e0432c3a59746e717fee3.1616066156.git.gitgitgadget@gmail.com>
 <xmqq1rcctgj7.fsf@gitster.g>
 <CAOLTT8RzvQzD0baWPdJzRLK3Q+WeJR_HNA4RVHMxRmwHeym9QQ@mail.gmail.com>
 <xmqq7dm3p344.fsf@gitster.g>
 <CAOLTT8TQdT1PkdfuOk92U89Lgk9o_YhdeMyHb6SrE7GW+6PQJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLTT8TQdT1PkdfuOk92U89Lgk9o_YhdeMyHb6SrE7GW+6PQJQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 20, 2021 at 10:54:38AM +0800, ZheNing Hu wrote:

> I am looking for how to extract each author or committer from the log.
> I just know I can use:
> 
> $ git log --pretty="%an %ae" | sort | uniq
> 
> get all unique author <email> from a git repo.
> Is there any function in the source code of git to get them?

If I understand Junio's suggestion correctly, it is very similar to how
"commit --author" works. See how it calls find_author_by_nickname(),
which finds the first commit matching the name, and then pulls out the
full name from format_commit_message().

-Peff

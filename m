Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E479DC433E3
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 18:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20813221E3
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 18:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="eQsHUl8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgHFSgL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgHFSfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 14:35:25 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7655BC061574
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 11:24:35 -0700 (PDT)
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1596738268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=QkJvT6BYclxG0GrSpHa9xFPf70IB/J8X6CI8BpdjlNY=;
        b=eQsHUl8Tx6RX4U0ciPFTHmIZOppFID73hO2BjDCDTn5Vl3JDk4ztViedmi7CySaINbRiKV
        lapZgZbctmhRY5dGSOH680Flq8K9TlpX2hxWLR4tnOOvFTnMNhFzcqqWeEEe7pR+ps4Ir5
        HHTdALEGCFfRvRNsuyR5MrNlY1RKpu0=
Content-Type: text/plain; charset=UTF-8
Subject: Re: Why is AuthorDate displayed on git-blame?
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     "Noam Soloveichik" <inoamsol@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
Date:   Thu, 06 Aug 2020 14:13:55 -0400
Message-Id: <C4Q493FC0N34.3GA87TXK6SJPJ@ziyou>
In-Reply-To: <6dabe718-6d6e-e76c-677d-f2dc4a5b83be@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu Aug 6, 2020 at 11:19 AM EDT, Noam Soloveichik wrote:
> I want to make sure I understand your proposal correctly -
> --first-parent would still show AuthorDate, but of the
> *merge-commit*, and not the commit that introduced the line of code
> to the history overall.

To be clear, I'm not proposing anything but surfacing a useful feature
that already exists in the documentation.

> If so, it's going to get the job done for commits which are applied
> by a merge-commit. Although I wonder what --first-parent would
> display for commits which are applied *not* by a merge.

--first-parent commands don't care about merges, except that they never
follow the second or later parents of a merge. blame just tries to find
the earliest commit that had this version of some line in it; if it only
follows first parents then that will often end up being a merge (if
you're on an integration branch) but doesn't have to be.

> Consider the linux kernel, where some of its commits are merge
> commits from pull requests, and some are applied patches: with
> different AuthorDate and CommitDate. For those commits, AuthorDate
> represents the date the patch was originally sent to review, not when
> it was introduced to the integration branch, which is represented by
> the CommitDate, which leads to inconsistencies.

I honestly don't make use of dates in my workflow at all, so I don't
really have an opinion on date issues. The author date is marginally
more interesting to me, but only marginally and only really in projects
that use email (where the author date "git am" records is the date on
the email the patch came in).

Of course an option to choose which author/date pair (author or
committer) to annotate the file with would be a fine addition benefiting
people who do look at the dates. I use first-parent histories all the
time, however, and I'd like to see this useful existing blame option
documented.

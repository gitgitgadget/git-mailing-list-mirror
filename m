Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8D1C47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 23:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA08420721
	for <git@archiver.kernel.org>; Tue,  5 May 2020 23:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgEEXKz convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 5 May 2020 19:10:55 -0400
Received: from elephants.elehost.com ([216.66.27.132]:57458 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgEEXKy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 19:10:54 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 045NAoW2037830
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 5 May 2020 19:10:51 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Roman Gelfand'" <rgelfand2@gmail.com>, <git@vger.kernel.org>
References: <CAJbW+rmN=QPDm0myka1=iOpvzqe2kN-yk8GisdH2VDLRc1ReHw@mail.gmail.com>
In-Reply-To: <CAJbW+rmN=QPDm0myka1=iOpvzqe2kN-yk8GisdH2VDLRc1ReHw@mail.gmail.com>
Subject: RE: GIT Branch Maintenance
Date:   Tue, 5 May 2020 19:10:44 -0400
Message-ID: <05fc01d62332$6b511060$41f33120$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHNA9Z/i6c1t8CBOHBvjSZf2FLFqaisWd/w
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 5, 2020 6:21 PM, Roman Gelfand Wrote:
> Subject: GIT Branch Maintenance
> I am in a process of designing a git strategy for our vs solution.
> The vs solution is a legacy asp .net webforms app which is enormous.
> CI is out of the question because of cumbersome db source  setup.  So, we
> are pretty much relying on integration testing.  We have roughly 6 people on
> development team.  Each of developers are assigned separate feature.
> Sometimes, a feature spans several releases.
> 
> Here are the branches:
> Master - source that made it to prod
> Feature - checked out from master Head.  The Head represents previous
> release.
> QA - synchronized with master at the beginning of release development.
> Upon completion, each active Feature branch is merged into QA.
> Bugfix - in case of bug in current development, QA branch is checked out to
> bugfix branch.  Upon completion, it is merged back into QA branch.
> 
> Over time these master and qa branches will be enormous.  How do I keep it
> concise preserving detailed history in case I need to hunt down a specific
> commit?

Answering a question with questions:

1. Have you looked up the GitFlow process, or perhaps in your case the GitLabFlow? The rest of the answer depends on this.

2. What enterprise git server are you using? GitHub, GitLab, BitBucket? You should consider one of those (no affiliation with any). My company uses all three brands of enterprise servers. Don't ask why - it's a very long discussion.

3. This is not a question: Look up merge --squash. You should consider using squashed merges going into master. If sequencing your features to multiple releases independently is important, then using a Pull Request (Merge Request in GitLab) is going to be important to you to pull in a change branch into a release.

However, I would consider distinct release branches and feature branches (or topic branches). They are sequenced independently, from what you wrote, and I don't think Feature means exactly what you intend. It is more like the development HEAD where developers get their starting point - this may be your default branch, whatever you call it. Each feature  would have its own branch rather than "Feature". So it BitBucket's GitFlow implementation, a branch would be like "feature/1234-topic-being-worked-on". You may not need your QA branch. Your definition of master may require some thought. It may actually represent the current prod release in general use (assuming multiple prod environments) rather than one "prod", somewhat like definitive prod, which is approximately what we use for the latest main release rather than just what made it to prod.

Regards,
Randall



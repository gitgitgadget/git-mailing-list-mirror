Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC5EC20A25
	for <e@80x24.org>; Thu, 14 Sep 2017 11:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbdINLcP (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 07:32:15 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:51456 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751792AbdINLcO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 07:32:14 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:44810 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1dsSNR-0002Ja-QX
        for git@vger.kernel.org; Thu, 14 Sep 2017 07:32:13 -0400
Date:   Thu, 14 Sep 2017 07:32:11 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: how to remove from history just *one* version of a file/dir?
Message-ID: <alpine.LFD.2.21.1709140721130.19770@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


  [is this the right place to ask questions about git usage? or is
there a different forum where one can submit possibly embarrassingly
silly questions?]

  i've been perusing "git filter-branch", and i'm curious if i have
the right idea about how to very selectively get rid of some useless
history.

  say, early on, one commits a sizable directory of content, call it
/mydir. that directory sits there for a while until it becomes obvious
it's out of date and worthless and should never have been committed.
the obvious solution would seem to be:

  $ git filter-branch --tree-filter 'rm -rf /mydir' HEAD

correct?

  however, say one version of that directory was committed early on,
then later tossed for being useless with "git rm", and subsequently
replaced by newer content under exactly the same name. now i'd like to
go back and delete the history related to that early version of
/mydir, but not the second.

  obviously, i can't use the above command as it would delete both
versions. so it appears the solution would be a trivial application of
the "--commit-filter" option:

   git filter-branch --commit-filter '
     if [ "$GIT_COMMIT" = "<commit-id>" ] ; then
       skip_commit "$@";
     else
       git commit-tree "$@";
     fi' HEAD

where <commit-id> is the commit that introduced the first verrsion of
/mydir. do i have that right? is there a simpler way to do this?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

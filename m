Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F35AA1FE90
	for <e@80x24.org>; Tue, 25 Apr 2017 17:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1952065AbdDYR0o (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 13:26:44 -0400
Received: from smtp74.iad3a.emailsrvr.com ([173.203.187.74]:48890 "EHLO
        smtp74.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1952017AbdDYR0m (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 25 Apr 2017 13:26:42 -0400
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Apr 2017 13:26:42 EDT
Received: from smtp18.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp18.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 2F84D254AB;
        Tue, 25 Apr 2017 13:21:10 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp18.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 0936F252C9;
        Tue, 25 Apr 2017 13:21:09 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Tue, 25 Apr 2017 13:21:10 -0400
To:     Git List <git@vger.kernel.org>
From:   Marc Branchaud <marcnarc@xiplink.com>
Subject: BUG: diff-{index,files,tree} (and git-gui) do not respect the
 diff.indentHeuristic config setting
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <19607a03-71e0-440b-7213-64d25f6fa8da@xiplink.com>
Date:   Tue, 25 Apr 2017 13:21:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So I have

	diff.indentHeuristic = true

and I noticed that git-gui was not using the heuristic.  This is because 
git-gui uses diff-index, and that does not respect the config setting, 
even though it supports the --indent-heuristic option.

And it looks like diff-files and diff-tree also have the same problem.

I tried a couple of quick-n-dirty things to fix it in diff-index, 
without success, and I've run out of git-hacking tame, so all I can do 
for now is throw out a bug report.

diff-index.c explicitly says "no 'diff' UI options" since 83ad63cfeb 
("diff: do not use configuration magic at the core-level", 2006-07-08), 
so maybe this needs to be fixed in git-gui (and maybe elsewhere), but to 
me it feels like the diff-foo commands should respect the setting.

(CC'ing Michael Haggerty, who added the heuristic.)

(This is git v2.12.2.)

		M.

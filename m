Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E7AC202AA
	for <e@80x24.org>; Sat,  2 Mar 2019 08:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfCBI0m (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 03:26:42 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:41386 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfCBI0l (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 03:26:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QJz+Qnq1zXFKZqwmWCncWMN1hXp1aLSLZDWJzKpNMpk=; b=nyDRu5T2xbDBKiZR08XMjgrKys
        LEmUTJWJeTz1/7AFyAMS1lZDEBEhdLUpKiqkg//Ucx+FjLdqMAqBiGJq1RnLxiDfurYuz/gR+QaVs
        ZKek6fJuJMf6kfP7vtHyK6yrU2PiZWdWEo1rYpvtoyK9i8E+2rkWqZ1xkbwu/oMy5ZkJtUzPtmaK0
        UIGL4Cn55BcP/CE6d7i7OONgL6F6q0DlbhqeBINVvK5Wv+k/FcxRS7QPTBlq9mTq2K406uXqMC2Jv
        M0O7cQ3vxolWMMH+k7ITNJRYJTllK2c+hC3cxcIiT2KscUgJdnqQC0VbtrbT3lzmmQcpBG6e/sUt9
        zMWb++xg==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:58466 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1gzzyh-004MK7-16
        for git@vger.kernel.org; Sat, 02 Mar 2019 03:26:40 -0500
Date:   Sat, 2 Mar 2019 03:26:37 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: is it "git gc --prune=now" or "git gc --prune=all"?
Message-ID: <alpine.LFD.2.21.1903020323110.16672@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


  more pedantry, but digging through "git gc", the man page reads:

       --prune=<date>
           Prune loose objects older than date (default is 2 weeks
           ago, overridable by the config variable gc.pruneExpire).
           --prune=all prunes loose objects regardless of their age
           ^^^^^^^^^^^

but the code for gc.c contains a check for "now" (which actually makes
more sense semantically):

  static void add_repack_all_option(struct string_list *keep_pack)
  {
        if (prune_expire && !strcmp(prune_expire, "now"))
                argv_array_push(&repack, "-a");
        else {
        ... snip ...

while the man page does not seem to mention the possible value of
"now".

  am i misreading something? should the man page mention the possible
value of "now" as opposed to "all"?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4A1920248
	for <e@80x24.org>; Fri,  8 Mar 2019 15:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfCHPgt (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 10:36:49 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:34392 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfCHPgt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 10:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=U5+gKP68EnFoaeOjIAvojo41XmU5pfIypfnkeY4OPQU=; b=In6WDFWojB08DI9N/aL5U6OQCS
        euNpuuGDVBx/uSow2cSA5wTRgafRfjn7DCT34JX9G8syAZ7QYICbMS+3ge+NaOFppuFuh8WHkBktH
        Nv1BEdbNTLquv8+4ICBvKSG9fwOhv0v+D+Maq/Q+cix5mqotYD1T1Fj98X+wUAoQVtUKU5+Zs25bt
        z9jBndBejPFu9HO2441hePKQXNu5cr8Ej9y5Cba1cQ8Lhgw32ogWtaTEb3gARNYSzBDHG28RFSDyu
        vDf7yhNvlBiaKiFzQjRqnCeErJqhfE5Rn177yElwKTAqFuwfW92fcb5vLC+MN1IYoMUCrJOQKuSw2
        q26nPJ1w==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:49752 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1h2HYD-00CQIY-TN
        for git@vger.kernel.org; Fri, 08 Mar 2019 10:36:47 -0500
Date:   Fri, 8 Mar 2019 10:36:44 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: how can i "gc" or "prune" objects related to a deleted remote?
Message-ID: <alpine.LFD.2.21.1903081029510.25426@localhost.localdomain>
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


  writing a short tutorial on how to add a remote and work with it
and, as a final step, show how, if one is uninterested in the remote
after all, one can simply delete it, but i also want to show how one
can then prune or garbage collect the objects related to that remote,
but i can't figure out how.

  as an example, i cloned the linux kernel source tree, then added
the linux-next repo as a remote -- the end result was two pack files
(the smaller one i'm assuming being for linux-next):

$ ls -l .git/objects/pack
total 2723632
-r--r--r--. 1 rpjday rpjday    1215376 Mar  8 09:44 pack-08cc266c0914e924961a1c8412fdf8746d327d7e.idx
-r--r--r--. 1 rpjday rpjday   38402840 Mar  8 09:44 pack-08cc266c0914e924961a1c8412fdf8746d327d7e.pack
-r--r--r--. 1 rpjday rpjday  204032716 Mar  8 09:42 pack-1036510bb74967c91093fc0cd8982683a66dbf5f.idx
-r--r--r--. 1 rpjday rpjday 2545333327 Mar  8 09:42 pack-1036510bb74967c91093fc0cd8982683a66dbf5f.pac
$

  after playing with a couple branches from the new remote, i deleted
the remote, then also did things like clear the reflog, delete any
local tracking branches related to the deleted remote, and so on, but
i can't seem to prune the objects that should no longer be reachable
now that i deleted that remote.

  what am i overlooking? is it because those objects are in a separate
pack file? do i need to repack first? what is hanging onto those
objects in that second pack file such that they can't be garbage
collected?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

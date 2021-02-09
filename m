Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDB7C433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 14:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA05F60C3F
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 14:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhBIOg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 09:36:28 -0500
Received: from cpanel8.indieserve.net ([199.212.143.3]:55470 "EHLO
        cpanel8.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbhBIOfv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 09:35:51 -0500
X-Greylist: delayed 2218 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Feb 2021 09:35:50 EST
Received: from cpeac202e043973-cmac202e043970.sdns.net.rogers.com ([174.114.100.179]:56260 helo=fedora)
        by cpanel8.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1l9TWq-0001Nh-CQ
        for git@vger.kernel.org; Tue, 09 Feb 2021 08:58:08 -0500
Date:   Tue, 9 Feb 2021 08:58:06 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
To:     Git Mailing list <git@vger.kernel.org>
Subject: how to most effectively cherry pick by selective patch hunk?
Message-ID: <566b38df-307c-f342-b583-3a50a81b5057@crashcourse.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel8.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel8.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel8.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


  (i'm looking for a solution not just for current git but, sadly,
going back to git-2.9.2, which is installed on my current contract
build system, and i have little authority to bump it up.)

  summary: made a couple dozen commits on branch, call it "oldb",
where i was relatively undisciplined about enforcing clean, modular
commits so i want to go back and clean things up -- refactor by
changing order, combining some trivial commits into one, breaking
large, unwieldy commits into smaller pieces, better commit messages
and so on, so i start a new branch "newb" at the same origin, and
here's the problem.

  every old commit consisted of adding a new patch to an existing
openembedded recipe, so every commit had two components:

  * a brand new patch file to be placed under "files/", and
  * adding a new line to SRC_URI variable, as in:

    SRC_URI += " \
	first.patch \
	second.patch \
	third.patch \
	... etc etc ...
    "

  i think you see the problem. a commit adding a brand new file will
never create a merge conflict, as it's a new file. but if i start
reordering commits, then the addition of that line to the .bbappend
file will *certainly* conflict as the patches will almost certainly be
renamed and in a different order.

  what would be great is some sort of "-p" (patch selection) option
with cherry-pick, but i don't see that.

  what would work for me is to auto-get the addition of the patch file
from the old branch, at which point i am more than happy to manually
fix the .bbappend file and manually do another commit. i'm thinking i
can just "git checkout" the new patch file from the old branch, and
take it from there.

  thoughts? am i overthinking this?

rday

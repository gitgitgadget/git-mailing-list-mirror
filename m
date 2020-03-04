Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2E5C3F2D1
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 22:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF6C20848
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 22:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388312AbgCDWNa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 17:13:30 -0500
Received: from elephants.elehost.com ([216.66.27.132]:42367 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387931AbgCDWNa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 17:13:30 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 024MDRQW056099
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Wed, 4 Mar 2020 17:13:28 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
References: 
In-Reply-To: 
Subject: RE: [Breakage] t0410 - subtests report unable to remove non-existent file.
Date:   Wed, 4 Mar 2020 17:13:22 -0500
Message-ID: <014d01d5f272$215c0550$64140ff0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdXuhURxBgI7XI7HSIemxPRsif5kDgD2jLWg
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 28, 2020 5:33 PM, I wrote:
> To: 'git@vger.kernel.org' <git@vger.kernel.org>
> Subject: [Breakage] t0410 - subtests report unable to remove non-existent
> file.
> 
> Starting at t0410, subtest 5 (missing ref object, but promised, passes
fsck), on
> the NonStop L-series platform, we are seeing errors like the following:
> 
> not ok 5 - missing ref object, but promised, passes fsck #
> #               rm -rf repo &&
> #               test_create_repo repo &&
> #               test_commit -C repo my_commit &&
> #
> #               A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
> #
> #               # Reference $A only from ref
> #               git -C repo branch my_branch "$A" &&
> #               promise_and_delete "$A" &&
> #
> #               git -C repo config core.repositoryformatversion 1 &&
> #               git -C repo config extensions.partialclone "arbitrary
string" &&
> #               git -C repo fsck
> #
> 
> With verbose output as follows:
> 
> Initialized empty Git repository in /home/ituglib/randall/git/t/trash
> directory.t0410-partial-clone/repo/.git/
> [master (root-commit) 9df77b9] my_commit
>  Author: A U Thor <author@example.com>
>  1 file changed, 1 insertion(+)
>  create mode 100644 my_commit.t
> Enumerating objects: 1, done.
> Counting objects: 100% (1/1), done.
> Writing objects: 100% (1/1), done.
> Total 1 (delta 0), reused 0 (delta 0)
> a391e3e0447189aa0050c8f206462a1b0530a34a
> rm: cannot remove
> 'repo/.git/objects/a3/91e3e0447189aa0050c8f206462a1b0530a34a': No
> such file or directory

This appears to be an incompatibility in the script between running with
/bin/sh (ksh on the platform) and bash. When we use make
SHELL=/usr/coreutils/bin/bash (where our bash is located), this test passes.
We will use this construct going forward, assuming we don't encounter
something weird. So far, only t0301 and t1091 are failing. These are new
failures. I will investigate and report on these separately.

Regards,
Randall


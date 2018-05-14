Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FB811F406
	for <e@80x24.org>; Mon, 14 May 2018 19:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeENTVA (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 15:21:00 -0400
Received: from avasout04.plus.net ([212.159.14.19]:36339 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752015AbeENTU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 15:20:57 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id IJ1ifEd4FE6DAIJ1jfWF55; Mon, 14 May 2018 20:20:56 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=D5Rp1MZj c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=nZzFw3krnl3a3AXlq7sA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] commit: fix sparse 'not declared' warning
Message-ID: <e2c4276f-bcfd-faaa-f9ee-cb50e99da663@ramsayjones.plus.com>
Date:   Mon, 14 May 2018 20:20:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJoFTxMitli7lAHdhWDrnGetOLKnr95QB7TBl1xiVWWjJaC58LppTB/Cc7g5jSh6w7bCI2YFvfiuPk4gXdE2PBcZMxXGPMQvEO4LeStiiTs3L56K21qp
 fpWNjqOeYdhHiRUiDyTEyAfyB1lL0jM8kisW+aznj8j9TAhbLkM2STz+ocgzlrfwo8+XZss32X9mIg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Duy,

If you need to re-roll your 'nd/commit-util-to-slab' branch, could
you please squash this into the relevant patch (commit 37de2f0a93,
"merge: use commit-slab in merge remote desc instead of commit->util",
2018-05-13).

Also, my 'static-check.pl' script has pinged on this series due
to the use of the 'implement_shared_commit_slab' macro in revision.c
(commit 85d055e876, "revision.c: use commit-slab for show_source",
2018-05-13).

This is because that macro only allows you to set the 'scope' of the
complete set of functions that are declared there - in this case three
of them are not called (well, two are actually called by another two
functions in the set) outside of revision.c.

In particular, the functions 'clear_revision_sources',
'init_revision_sources_with_stride' (used in init_##slabname) and
'revision_sources_at_peek' (used in slabname##_at).

I haven't thought too deeply about this issue, or if it even
matters, so I have no solutions to offer. ;-)

Thanks!

ATB,
Ramsay Jones

 commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 38a3c0e5e..c0582df16 100644
--- a/commit.c
+++ b/commit.c
@@ -1657,7 +1657,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 }
 
 define_commit_slab(merge_desc_slab, struct merge_remote_desc *);
-struct merge_desc_slab merge_desc_slab = COMMIT_SLAB_INIT(1, merge_desc_slab);
+static struct merge_desc_slab merge_desc_slab = COMMIT_SLAB_INIT(1, merge_desc_slab);
 
 struct merge_remote_desc *merge_remote_util(struct commit *commit)
 {
-- 
2.17.0

Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A32C2D0F4
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 18:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E361D2072F
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 18:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgDHSg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:36:29 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:56354 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgDHSg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 14:36:28 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 48yCfL3xHWz5tlC;
        Wed,  8 Apr 2020 20:36:26 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 81C764951;
        Wed,  8 Apr 2020 20:36:25 +0200 (CEST)
Subject: [PATCH] gitk: Un-hide selection in added and removed text and search
 results
From:   Johannes Sixt <j6t@kdbg.org>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     Stefan Dotterweich <stefandotterweich@gmx.de>, git@vger.kernel.org
References: <20200211212448.9288-1-stefandotterweich@gmx.de>
 <8b5b8d89-59c2-7349-25c1-2529db13fa6e@kdbg.org>
Message-ID: <2ecfbb59-3a65-9db0-4ff7-e649ab6dfb6e@kdbg.org>
Date:   Wed, 8 Apr 2020 20:36:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <8b5b8d89-59c2-7349-25c1-2529db13fa6e@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The recently introduced background for the tags that highlight
added and removed text takes precedence over the background color
of the selection. But selected text is more important than the
highlighted text. Make the highlighting tags the lowest priority.

The same argument holds for the highlight of search results. But
search results are a bit more important. Therefore, make them
also low-priority, but just above the added-and-removed tags.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 07.04.20 um 18:42 schrieb Johannes Sixt:
> There is one major gripe, though: the new background color overrides the
> selection background and makes the selection invisible. This is a
> showstopper.

Here is a fix for that on top of Stefan's patch. The patch text works
without Stefan's patch (and would un-hide the selection in search
results), but the commit message would have to be adjusted.

-- Hannes

 gitk | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/gitk b/gitk
index 4129c0ba95..d4dd9aca64 100755
--- a/gitk
+++ b/gitk
@@ -2468,6 +2468,11 @@ proc makewindow {} {
     $ctext tag conf currentsearchhit -back $currentsearchhitbgcolor
     $ctext tag conf wwrap -wrap word -lmargin2 1c
     $ctext tag conf bold -font textfontbold
+    # set these to the lowest priority:
+    $ctext tag lower currentsearchhit
+    $ctext tag lower found
+    $ctext tag lower dresult
+    $ctext tag lower d0
 
     .pwbottom add .bleft
     if {!$use_ttk} {
-- 
2.26.0.207.gdeb9c6cae9

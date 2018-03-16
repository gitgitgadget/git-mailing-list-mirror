Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16B871F42D
	for <e@80x24.org>; Fri, 16 Mar 2018 09:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbeCPJ7O (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 05:59:14 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:33380
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751165AbeCPJ7O (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Mar 2018 05:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1521194353;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=7TxmOR+p7+jJBaD1DRdstjWbb7/VcoKyHSOby16zfsw=;
        b=pIi371A+uUOKrR963G87z28oEypm4YPc4dtxRc3GxX5px4t7WpLY3yCtTjPu890P
        qGB9baHbGNxkUtMsGNfiRlrmON5gfShH/34okGICZ2uhZOYMQPfgZP4pKpa9+KcBKBO
        1M20fCNROfaaIsb077KZ5VX12J7IoUGedX9BIIJE=
From:   Kai <github@kai-annacker.de>
To:     git@vger.kernel.org
Message-ID: <010201622e3fc0a8-2804475a-8c37-4978-b5dd-b0fb254bfed2-000000@eu-west-1.amazonses.com>
Subject: [PATCH] mergetools: enable tortoisemerge as difftool
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 16 Mar 2018 09:59:12 +0000
X-SES-Outgoing: 2018.03.16-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

TortoiseMerge/TortoiseGitMerge can also be used to view and edit file differences.

This change allows configuring tortoisemerge not only as mergetool but as difftool as well.
---
 mergetools/tortoisemerge | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mergetools/tortoisemerge b/mergetools/tortoisemerge
index d7ab666a59a2c..d3dcec1407f2d 100644
--- a/mergetools/tortoisemerge
+++ b/mergetools/tortoisemerge
@@ -1,5 +1,13 @@
-can_diff () {
-	return 1
+diff_cmd () {
+	basename="$(basename "$merge_tool_path" .exe)"
+	if test "$basename" = "tortoisegitmerge"
+	then
+		"$merge_tool_path" \
+			-mine "$REMOTE" -base "$LOCAL"
+	else
+		"$merge_tool_path" \
+			-mine:"$REMOTE" -base:"$LOCAL"
+	fi
 }
 
 merge_cmd () {

--
https://github.com/git/git/pull/471

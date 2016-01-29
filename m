From: Dickson Wong <dicksonwong@gmail.com>
Subject: [PATCH] mergetool: reorder vim/gvim buffers in three-way diffs
Date: Thu, 28 Jan 2016 18:18:14 -0800
Message-ID: <1454033894-49954-1-git-send-email-dicksonwong@gmail.com>
Cc: Dickson Wong <dicksonwong@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 03:28:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOynO-0008Du-L6
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 03:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133AbcA2C2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 21:28:19 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34113 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbcA2CT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 21:19:59 -0500
Received: by mail-pf0-f176.google.com with SMTP id o185so28756012pfb.1
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 18:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/bSsCxnt6/+bmLLcH1h9tYb821M/sEVm1Xraxv1xyyU=;
        b=xGVWs6HTWpTTgSClWgreoXefDhKACLjOn2GDcuEniM8HGSU+41XvbF0QD8+QNA9t4/
         mhjg4xRbe4LZCsBxyxKg8fquh2rlvi5Hoz/+P+9xcTZHKQTCHurUKDO2B4o9m+nzoN9b
         5RB8tCLMjh0/dqP5pqkj9QO3YS5nSzGryN6h/S/0aso7ecQNJJf6vcsQWd10FAmsP+sk
         +ZMKB/AoisPvbZmXw1FWyhA2V9PSImfD2V+/sSN2rpkrARXxfuVEtTAAqBNXOUJHiNL6
         UT5DTKxUdYx0vMcj7yo/k+kUvFkH5+yYZUbL6PdvtsknX9a59YitfvjKa6EWK+Vw1tfo
         JGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/bSsCxnt6/+bmLLcH1h9tYb821M/sEVm1Xraxv1xyyU=;
        b=IKVUqYtsjXFm002he6UO6etv9irh5Xbab8O8pEVnmqwjlYqataQ93bnlb/DgbuKUhg
         Og9xRL0B2byotc/pxHbHvOs6cDBiJ04WraC5BNKesh3nYAWHFcW4E+aqPldWQgDONFD7
         bcau5uSSlO7E9BYzxM04wex8TjfGlNGQOa4DEfNC3fJLseUBRcBq3VV+KyMF1GtF92jI
         fnezEhGxW5Nez33Awe+GAr5y5g0Tl+uSto55+lb5UHTkQBDTYe1QWFiDn320R54N7uY4
         qj1VXCBfCqnpBgMqfPTy6N6eGu4CDlfafG2VBrSH8D8Nv6AF2DqyMYIp1pusKp6QtzLh
         K0vQ==
X-Gm-Message-State: AG10YORq/K4NLkbLVJAEhZg/tqUlqD603mgLbbKVJQ56V++cwfyRW6GhvsvlSMa4D6IQtw==
X-Received: by 10.98.67.153 with SMTP id l25mr9639736pfi.111.1454033998880;
        Thu, 28 Jan 2016 18:19:58 -0800 (PST)
Received: from Dicksons-MBP.local.net (elasticpath-gigabitethernet0-1.elasticpath.com. [192.43.190.221])
        by smtp.gmail.com with ESMTPSA id fc8sm19357653pab.21.2016.01.28.18.19.58
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 28 Jan 2016 18:19:58 -0800 (PST)
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285053>

When invoking default (g)vimdiff three-way merge, the merged file is
loaded as the first buffer but moved to the bottom as the fourth window.
This causes a disconnect between vim commands that operate on window
positions (e.g. CTRL-W_w) and those that operate on buffer index (e.g.
do/dp).

This change reorders the buffers to have the same index as windows while
keeping the cursor default to the merged result as the bottom window.

Signed-off-by: Dickson Wong <dicksonwong@gmail.com>
---
 mergetools/vimdiff | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 1ddfbfc..74ea6d5 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -2,22 +2,22 @@ diff_cmd () {
 	"$merge_tool_path" -R -f -d \
 		-c 'wincmd l' -c 'cd $GIT_PREFIX' "$LOCAL" "$REMOTE"
 }
 
 merge_cmd () {
 	touch "$BACKUP"
 	case "$1" in
 	gvimdiff|vimdiff)
 		if $base_present
 		then
-			"$merge_tool_path" -f -d -c 'wincmd J' \
-				"$MERGED" "$LOCAL" "$BASE" "$REMOTE"
+			"$merge_tool_path" -f -d -c '4wincmd w | wincmd J' \
+				"$LOCAL" "$BASE" "$REMOTE" "$MERGED"
 		else
 			"$merge_tool_path" -f -d -c 'wincmd l' \
 				"$LOCAL" "$MERGED" "$REMOTE"
 		fi
 		;;
 	gvimdiff2|vimdiff2)
 		"$merge_tool_path" -f -d -c 'wincmd l' \
 			"$LOCAL" "$MERGED" "$REMOTE"
 		;;
 	gvimdiff3|vimdiff3)
-- 
2.6.2

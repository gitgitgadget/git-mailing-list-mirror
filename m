From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] mergetools: stop setting $status in merge_cmd()
Date: Fri, 21 Nov 2014 01:03:10 -0800
Message-ID: <1416560590-26088-1-git-send-email-davvid@gmail.com>
References: <1416532829-68662-4-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 10:03:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xrk7g-0003FU-FM
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 10:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754753AbaKUJDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 04:03:17 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:59072 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbaKUJDO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2014 04:03:14 -0500
Received: by mail-pa0-f41.google.com with SMTP id rd3so4461965pab.28
        for <git@vger.kernel.org>; Fri, 21 Nov 2014 01:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7IfMMe6ZJtd7VBqcsgrnZamz0L2YZeh+QQs6myeejJ0=;
        b=BLiUva/AaVJe4yNoQrSwYk9WeW079Ifrf76Z/2p1kLXgJevnV7OxT2VVKDiiHdvIH0
         KS/ktVjM4tCtQxDifpZE2grSnQm3cZ8VIVZRic2WZaLJloGLqFZXfF6vTE47gD3nXOjY
         EgMBnAfIAyjB77N/vNv+zB55uPmbsMeIKPO8Y7Lc3B8jyZaL+oRs9w6qhBmqCLFWhs3E
         HDYCrN+fobtRuMXDK2MTf3EMujwLJ2UaOs1lwspv3ZSRUAdesWaHtKxQW0nQZkFKVXRV
         YWobYwYL+9jOqd6ajfj8AANPn1ukuBFE6z2GJKXl/apLOMkD++WDm4BjbzcIXn/kF+fW
         2W+A==
X-Received: by 10.68.98.196 with SMTP id ek4mr4997448pbb.150.1416560594162;
        Fri, 21 Nov 2014 01:03:14 -0800 (PST)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id i11sm4201691pbq.23.2014.11.21.01.03.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Nov 2014 01:03:12 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.26.g6d3471d.dirty
In-Reply-To: <1416532829-68662-4-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No callers rely on $status so there's don't need to set
it during merge_cmd() for diffmerge, emerge, and kdiff3.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This is based on the mergetool/difftool cleanup patches.

 mergetools/diffmerge | 1 -
 mergetools/emerge    | 1 -
 mergetools/kdiff3    | 1 -
 3 files changed, 3 deletions(-)

diff --git a/mergetools/diffmerge b/mergetools/diffmerge
index 85ac720..f138cb4 100644
--- a/mergetools/diffmerge
+++ b/mergetools/diffmerge
@@ -11,5 +11,4 @@ merge_cmd () {
 		"$merge_tool_path" --merge \
 			--result="$MERGED" "$LOCAL" "$REMOTE"
 	fi
-	status=$?
 }
diff --git a/mergetools/emerge b/mergetools/emerge
index f96d9e5..7b895fd 100644
--- a/mergetools/emerge
+++ b/mergetools/emerge
@@ -15,7 +15,6 @@ merge_cmd () {
 			"$LOCAL" "$REMOTE" \
 			"$(basename "$MERGED")"
 	fi
-	status=$?
 }
 
 translate_merge_tool_path() {
diff --git a/mergetools/kdiff3 b/mergetools/kdiff3
index a30034f..793d129 100644
--- a/mergetools/kdiff3
+++ b/mergetools/kdiff3
@@ -20,5 +20,4 @@ merge_cmd () {
 			-o "$MERGED" "$LOCAL" "$REMOTE" \
 		>/dev/null 2>&1
 	fi
-	status=$?
 }
-- 
2.2.0.rc2.26.g6d3471d.dirty

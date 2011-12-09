From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH] am: don't persist keepcr flag
Date: Thu,  8 Dec 2011 23:30:45 -0800
Message-ID: <1323415845-11826-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 09 08:31:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYuvf-00030V-74
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 08:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424Ab1LIHbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 02:31:31 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54830 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab1LIHba (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 02:31:30 -0500
Received: by iakc1 with SMTP id c1so3813147iak.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 23:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=aKHBIh9d9B9KVvmCxHYa1cLMaENp2CcIYktXq0iETpw=;
        b=xBxQ9gE+xtl5xuqgM4EsybmM44JYFVxU+2DU0ni7xJxskmpRmgKN1uoiL69ESpQdI7
         Ntk9EhpjXsJj99G8tE2StWv8/B0nNcniIxlBDUQGyIEq/HAOOjxi7SGsn7Ib5kWLW9cq
         gGvPeE/A7XnTIRTRNHl0iR/G5WIpYW1O6k64M=
Received: by 10.50.202.65 with SMTP id kg1mr2473733igc.1.1323415889958;
        Thu, 08 Dec 2011 23:31:29 -0800 (PST)
Received: from glucid-laptop-imager.hot.corp.google.com (c-24-6-103-122.hsd1.ca.comcast.net. [24.6.103.122])
        by mx.google.com with ESMTPS id 36sm6873945ibc.6.2011.12.08.23.31.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Dec 2011 23:31:29 -0800 (PST)
X-Mailer: git-send-email 1.7.8.237.gcc4e3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186613>

The keepcr flag is only used in the split_patches function, which is
only called before a patch application has to stopped for user input,
not after resuming. It is therefore unnecessary to persist the
flag. This seems to have been the case since it was introduced in
ad2c928 (git-am: Add command line parameter `--keep-cr` passing it to
git-mailsplit, 2010-02-27).

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-am.sh |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 9042432..1c13b13 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -530,7 +530,6 @@ else
 	echo "$sign" >"$dotest/sign"
 	echo "$utf8" >"$dotest/utf8"
 	echo "$keep" >"$dotest/keep"
-	echo "$keepcr" >"$dotest/keepcr"
 	echo "$scissors" >"$dotest/scissors"
 	echo "$no_inbody_headers" >"$dotest/no_inbody_headers"
 	echo "$GIT_QUIET" >"$dotest/quiet"
@@ -576,12 +575,6 @@ if test "$(cat "$dotest/keep")" = t
 then
 	keep=-k
 fi
-case "$(cat "$dotest/keepcr")" in
-t)
-	keepcr=--keep-cr ;;
-f)
-	keepcr=--no-keep-cr ;;
-esac
 case "$(cat "$dotest/scissors")" in
 t)
 	scissors=--scissors ;;
-- 
1.7.8.237.gcc4e3

From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2 15/23] contrib/subtree: Teach from-submodule to add new subtree to .gittrees
Date: Sun, 10 Mar 2013 23:41:23 +0000
Message-ID: <1362958891-26941-16-git-send-email-pcampbell@kemitix.net>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>,
	Herman van Rink <rink@initfour.nl>,
	Paul Campbell <pcampbell@kemitix.net>,
	"Peter Jaros" <pjaros@pivotallabs.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 11 00:45:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEpvp-0004rt-Pd
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 00:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423Ab3CJXpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 19:45:04 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:59776 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab3CJXpD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 19:45:03 -0400
Received: by mail-wg0-f42.google.com with SMTP id 12so1515245wgh.3
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 16:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=R2dtE4bX+HHSR27Qc8i9hNUTYICUjxKN9BuLGgHfDdo=;
        b=nEdaoV/BXvgIRda1oNbnndDULrQRWDqzNp7t+EFAggCsEm2Pm30XG+jguoX5f/i2bA
         v5tEzepd3G93w40Y9JSF7j/NQDSgtF6aGoNkvgta4Na9Hz11tsIgQ3wXZw+h2Gz/CXpr
         R1jfMNqwJ8TviBjCWELE/CjQtLfvMv0Id8aeB2t7b8y8EHUgwc7HtRJlyAzsCwaJFD9g
         ML6KK9iNUQ7DkB0avzyQsx2ApGm4r3l9YmqkeMltenhnIGD+G18obVS0+lRFGlcsV96+
         drtGRJhkPyTPuoD6WQ/lGauaSXhy/UnnyYCfauX/LUtUM8zi+MRDzWf5hnUcKhoeGofV
         Pqqw==
X-Received: by 10.194.89.169 with SMTP id bp9mr15616072wjb.57.1362959101544;
        Sun, 10 Mar 2013 16:45:01 -0700 (PDT)
Received: from coyote.home (host-2-102-87-75.as13285.net. [2.102.87.75])
        by mx.google.com with ESMTPS id r7sm13757148wiz.2.2013.03.10.16.44.58
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 10 Mar 2013 16:45:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.rc1
In-Reply-To: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQkzgkssEZuuX2vwqu283T2dQ1hhOapFAys7QnGZKHUFqURfQYPpFkwTWrio05hx7Lo5VtyP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217835>

From: Herman van Rink <rink@initfour.nl>

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>

Conflicts:
	git-subtree.sh
---
 contrib/subtree/git-subtree.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index ae7d1fe..84c90c7 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -806,6 +806,7 @@ cmd_from-submodule()
 	ensure_clean
 
 	local submodule_sha=$(git submodule status $prefix | cut -d ' ' -f 2)
+	local submodule_orig_repo=$(git config --file .gitmodules submodule.$prefix.url)
 
 	# Remove references to submodule.
 	git config --remove-section submodule.$prefix
@@ -824,6 +825,10 @@ cmd_from-submodule()
 	# subtree add from submodule repo.
 	cmd_add_repository $tmp_repo HEAD
 
+	# Update .gittrees with the original repo url
+	git config --file .gittrees --unset subtree.$prefix.url
+	git config --file .gittrees subtree.$prefix.url $submodule_orig_repo
+
 	# Remove submodule repo.
 	rm -rf $tmp_repo
 }
-- 
1.8.2.rc1

From: David Barr <davidbarr@google.com>
Subject: [PATCH] git-am: ignore leading whitespace before patch
Date: Wed,  3 Aug 2011 08:20:46 +1000
Message-ID: <1312323646-93427-1-git-send-email-davidbarr@google.com>
Cc: David Barr <davidbarr@google.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 03 00:21:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoNKy-0006CW-VC
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 00:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897Ab1HBWVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 18:21:17 -0400
Received: from smtp-out.google.com ([74.125.121.67]:34586 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770Ab1HBWVP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 18:21:15 -0400
Received: from kpbe15.cbf.corp.google.com (kpbe15.cbf.corp.google.com [172.25.105.79])
	by smtp-out.google.com with ESMTP id p72MLD3U010389
	for <git@vger.kernel.org>; Tue, 2 Aug 2011 15:21:14 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1312323674; bh=xHua8Jiabs+ooRKzBnaiCnkKaoY=;
	h=From:To:Cc:Subject:Date:Message-Id;
	b=OBJs3Vo80U3O74NghAp0bPV5pJaE0po47JitBlIGsyB9Xj7oy2uzR/hs6RK9vk/GV
	 TFXg+95dQCaypj0xvz2Zg==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=dkim-signature:from:to:cc:subject:date:message-id:x-mailer:x-system-of-record;
	b=M7ThT1l7xXPGH9D6V2e8ATH+/zK12ZxtEAC95WXErA2pjZQRs1fR1n4+aVp1SjB2o
	mc6IEw5O7/Y8PRR4G/Z4g==
Received: from yib12 (yib12.prod.google.com [10.243.65.76])
	by kpbe15.cbf.corp.google.com with ESMTP id p72MK4dN018032
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Tue, 2 Aug 2011 15:21:12 -0700
Received: by yib12 with SMTP id 12so239417yib.16
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 15:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=D7CTWqcX+ZQTiSJ9N2M24TmYxl/aZUUNU64yKHj1HTY=;
        b=gcCnfeO6//d4ZtDBOiA5yntHpEPtuYrxiMjN7AfZXz3WTF8CCMEBBz5YKp+Chq4XS+
         PDJ5LorN7os0wY3ewiJQ==
Received: by 10.68.5.98 with SMTP id r2mr8323pbr.98.1312323672062;
        Tue, 02 Aug 2011 15:21:12 -0700 (PDT)
Received: by 10.68.5.98 with SMTP id r2mr8316pbr.98.1312323671868;
        Tue, 02 Aug 2011 15:21:11 -0700 (PDT)
Received: from localhost.localdomain (davidbarr-macpro.syd.corp.google.com [172.23.124.75])
        by mx.google.com with ESMTPS id d3sm264905pbg.92.2011.08.02.15.21.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Aug 2011 15:21:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178528>

Some web-based email clients prepend whitespace to raw message
transcripts to workaround content-sniffing in some browsers.
Adjust the patch format detection logic to ignore leading
whitespace.

Signed-off-by: David Barr <davidbarr@google.com>
---
 git-am.sh |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 463c741..19b2f0f 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -199,7 +199,11 @@ check_patch_format () {
 	# otherwise, check the first few lines of the first patch to try
 	# to detect its format
 	{
-		read l1
+		# Start from first line containing non-whitespace
+		until [ -n "$l1" ]
+		do
+			read l1
+		done
 		read l2
 		read l3
 		case "$l1" in
-- 
1.7.6

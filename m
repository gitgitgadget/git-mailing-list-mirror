From: Justin Lebar <jlebar@google.com>
Subject: [PATCH 2/4] contrib: Fix misuses of "nor"
Date: Thu, 20 Mar 2014 15:16:23 -0700
Message-ID: <1395353785-23611-3-git-send-email-jlebar@google.com>
References: <1395353785-23611-1-git-send-email-jlebar@google.com>
Cc: Justin Lebar <jlebar@google.com>, Richard Hansen <rhansen@bbn.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 23:26:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQlPo-000330-3C
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 23:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760003AbaCTWY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 18:24:56 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:51315 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759994AbaCTWYT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 18:24:19 -0400
Received: by mail-pb0-f73.google.com with SMTP id rp16so198007pbb.2
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 15:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4zuj+2A/FgYo8JfcXhLuOkYXZM0mggSHS4gqsElLbWU=;
        b=TF6NnhmMP+LfwWWOggcm3d8YWzAUwzcQVWofVFKGdfA7s0Zodz/cb4jfJapvBAbgwc
         n5wqAyEpTdxuWS2MDIpBM4qUU6Uww4MjdbMqpp3CDRbwyYUb3lElYcIyUFBxM2/2rcKy
         4SQtgaUClTU6+cZH0zxFAode8aYhGqdaU6jBng3vEClMhdNWW9Pi+CmlTrDpi5QYZWrj
         zY4eFz9j6nnnFF9kL0G34nSj3FRplUReNBEuJxim0LvRhN2SfSJSCPFlnYpfD1YF1dWe
         VN446aa+71DRP5qTPead1KHWkXcu2q1bD+fnQ9/0ZxoGWjSOJ7h8jdb/hgVAy8acattR
         D1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4zuj+2A/FgYo8JfcXhLuOkYXZM0mggSHS4gqsElLbWU=;
        b=PpURCuYyTU9/LlLvGfMrBpuA6Z2LEeGnsBwHUSvbqR7KCBwwkFkKp9tioj49pOB3Oo
         fG1pwoB33ubdI2vcLyDRxoa5VWAFLvuZy1rhzBq4n47j3alLsydRvDCnLSejy1tfBQkk
         ScYOb7m3VLLGNM8fEduggUXlkkU9RiajAtJaP8+NyofuLF8mc1CGt1el6rrbX6JQxn9E
         /2mTyZ1XR5XeGitgjEjJG9tVTN40GB1RUgJD9rbvFeygSiQrnlw2g11NDgMtZWduxLGB
         RPVu6BMdF7nWN7/zV2a/jaNLAoTs9B+KTN48iToMY+7FMMHgSmLNl1IMWFkAS7vcSh2A
         f/Nw==
X-Gm-Message-State: ALoCoQmN9G3pQxYiHcqLqv3JKk0NTtnh1fF1q8/fg9H5J0Us+Ms7dXvnKJFo79QcrISu7dCve17ppO6EivUUKgWgQ3CJmmtHdfjJopQ6HDWsO6Ky3QlPpAb/m3bAiMkRQXweeC+16VdHBlnRK3Ahd43qWvC33wJ6IbS867BvPEIBTFDexbQmil8GAzXjxuk1Y7ipXO5VwRr0
X-Received: by 10.66.163.70 with SMTP id yg6mr12589798pab.44.1395353813394;
        Thu, 20 Mar 2014 15:16:53 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id x22si403863yhd.5.2014.03.20.15.16.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Mar 2014 15:16:53 -0700 (PDT)
Received: from jlebar0.mtv.corp.google.com (jlebar0.mtv.corp.google.com [172.17.132.58])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 364715A422C;
	Thu, 20 Mar 2014 15:16:53 -0700 (PDT)
Received: by jlebar0.mtv.corp.google.com (Postfix, from userid 214119)
	id EC6C51A1653; Thu, 20 Mar 2014 15:16:52 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.279.gdc9e3eb
In-Reply-To: <1395353785-23611-1-git-send-email-jlebar@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244593>

Signed-off-by: Justin Lebar <jlebar@google.com>
---
 contrib/examples/git-commit.sh | 2 +-
 contrib/svn-fe/svn-fe.txt      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/examples/git-commit.sh b/contrib/examples/git-commit.sh
index 23ffb02..4aab1a6 100755
--- a/contrib/examples/git-commit.sh
+++ b/contrib/examples/git-commit.sh
@@ -280,7 +280,7 @@ case "$#,$also,$only,$amend" in
 0,,,*)
 	;;
 *,,,*)
-	only_include_assumed="# Explicit paths specified without -i nor -o; assuming --only paths..."
+	only_include_assumed="# Explicit paths specified without -i or -o; assuming --only paths..."
 	also=
 	;;
 esac
diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index 1128ab2..a3425f4 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -40,8 +40,8 @@ manual page.
 NOTES
 -----
 Subversion dumps do not record a separate author and committer for
-each revision, nor a separate display name and email address for
-each author.  Like git-svn(1), 'svn-fe' will use the name
+each revision, nor do they record a separate display name and email
+address for each author.  Like git-svn(1), 'svn-fe' will use the name
 
 ---------
 user <user@UUID>
-- 
1.9.0.279.gdc9e3eb

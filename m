From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 01/24] t2104: Don't fail for index versions other than [23]
Date: Wed, 27 Nov 2013 13:00:36 +0100
Message-ID: <1385553659-9928-2-git-send-email-t.gummerer@gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, gitster@pobox.com, tr@thomasrast.ch,
	mhagger@alum.mit.edu, pclouds@gmail.com,
	robin.rosenberg@dewire.com, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 27 13:01:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VldoD-0001ch-UN
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 13:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538Ab3K0MB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 07:01:28 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:60401 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab3K0MB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 07:01:27 -0500
Received: by mail-lb0-f177.google.com with SMTP id w7so5225341lbi.8
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 04:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ikVypHlGhVssfZKl2zjdGnAq4DpN4QW9Y4qZ0n08zIA=;
        b=i3gjpQav6B3bQW7F+DvVvvoN2TgZmL1ondCgzG1/yqYwJLp3NqC/P8Qfos16cDS60y
         go/E39Itbqqi/SoqtvsH/coUE9d72CJ580hu+GSCWFwuNgK/ZjnLVeW9cMxFNuOj9pri
         Ho4CHC/hGgvpsSbdqdav/d/aUuXngN0sRDW0OwZsDHxKROO4/cH+z6tyZJ/CVtJXgfCl
         L3k5ZUm+zbyezof7BW08zxzNIK/FsJ2FfE/6+ub1EWJnGru0Y9/NlB7/vhBi7E4evTi6
         nEpA73zKbiYdTO2YCAhB8naBSsVeOOdNrFPa2/YttDusr7szcPmzw/RGRyHTdPCoqc7q
         pt8w==
X-Received: by 10.152.44.225 with SMTP id h1mr13001653lam.22.1385553685803;
        Wed, 27 Nov 2013 04:01:25 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id h11sm19380623lbg.8.2013.11.27.04.01.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2013 04:01:24 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238415>

t2104 currently checks for the exact index version 2 or 3,
depending if there is a skip-worktree flag or not. Other
index versions do not use extended flags and thus cannot
be tested for version changes.

Make this test update the index to version 2 at the beginning
of the test. Testing the skip-worktree flags for the default
index format is still covered by t7011 and t7012.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/t2104-update-index-skip-worktree.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t2104-update-index-skip-worktree.sh b/t/t2104-update-index-skip-worktree.sh
index 1d0879b..bd9644f 100755
--- a/t/t2104-update-index-skip-worktree.sh
+++ b/t/t2104-update-index-skip-worktree.sh
@@ -22,6 +22,7 @@ H sub/2
 EOF
 
 test_expect_success 'setup' '
+	git update-index --index-version=2 &&
 	mkdir sub &&
 	touch ./1 ./2 sub/1 sub/2 &&
 	git add 1 2 sub/1 sub/2 &&
-- 
1.8.4.2

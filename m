From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2] t1501: fix test with split index
Date: Tue, 24 Mar 2015 20:21:40 +0100
Message-ID: <1427224900-2206-1-git-send-email-t.gummerer@gmail.com>
References: <xmqqa8z26zwi.fsf@gitster.dls.corp.google.com>
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 20:21:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaUOd-0007bR-VT
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 20:21:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217AbbCXTVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 15:21:47 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:36741 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847AbbCXTVq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 15:21:46 -0400
Received: by wgra20 with SMTP id a20so2145313wgr.3
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 12:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Awwif5pQ1I5FzKQ0NeZLqmaQixKjMwjNH1UDEAfF20o=;
        b=O7Yq1gW1vPkcxXlqymgMbRoIXL8De34hK+hZ9ZobK6nb+vuvA/m5EA1WqPJdpxmUtV
         HTZ18yVQoN7RzlEYR9VxUw6VwBmofR1g4bJeXbAbGiN1oY/x3LgiWL21L2mYpg2esubL
         ZZikhIncgicxG0aYbU4KeEs8ehwm7V8v1tXwaLYBxL9E/ynCDmDSD7W71n7Bw2mc0j+K
         Gq/BEbJShBWXxZ2b6jVatSxUM5BrinJ28OWHMV8LXzhLBBcXN3yPmwXKYclaux3dwmHr
         hkXrE7q7kLJy0UV559oSIWI6Re8kVdy52wHq3vrBAMeoB8SoRkpJ1VwVx+WpHHx9Dhah
         U/1g==
X-Received: by 10.180.74.230 with SMTP id x6mr31340270wiv.58.1427224905351;
        Tue, 24 Mar 2015 12:21:45 -0700 (PDT)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id dc9sm17210209wib.9.2015.03.24.12.21.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2015 12:21:44 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.264.g0463184.dirty
In-Reply-To: <xmqqa8z26zwi.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266222>

t1501-worktree.sh does not copy the shared index in the "relative
$GIT_WORK_TREE and git subprocesses" test, which makes the test fail
when GIT_TEST_SPLIT_INDEX is set.  Copy the shared index as well in
order to fix this.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

> Is this a good place to use "test-might-fail", e.g.
>
>        test_might_fail cp repo.git/sharedindex.* repo.git/repos/foo &&
>
> or something?

Yeah that makes sense, thanks.

 t/t1501-worktree.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 4df7a2f..cc5b870 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -350,6 +350,7 @@ test_expect_success 'Multi-worktree setup' '
 	mkdir work &&
 	mkdir -p repo.git/repos/foo &&
 	cp repo.git/HEAD repo.git/index repo.git/repos/foo &&
+	test_might_fail cp repo.git/sharedindex.* repo.git/repos/foo &&
 	sane_unset GIT_DIR GIT_CONFIG GIT_WORK_TREE
 '
 
-- 
2.1.0.264.g0463184.dirty

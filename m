From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 01/28] cherry-pick: don't barf when there's nothing to do
Date: Fri, 30 Aug 2013 00:55:55 -0500
Message-ID: <1377842182-18724-2-git-send-email-felipe.contreras@gmail.com>
References: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:01:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHla-00070W-At
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755377Ab3H3GBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:01:03 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:40255 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755068Ab3H3GBC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:01:02 -0400
Received: by mail-oa0-f43.google.com with SMTP id i10so1788160oag.16
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j01qDL5VLkjZDH9Qc7boas+HpxA89nGALlpcSzjUJq4=;
        b=RuIGHvNGc8t8iVQwVSUIseVMEqonVlHlLFkBXuGHdzAKvxHBRrt1Sh0SnI5ILkx5qf
         EBBqk+/En+k9swnrus0jnpH+MRt7RJrXux4EwrNbhLuPFZ5mMq1PHa/If7zvqdprIXPp
         /Z8zT0m1gasJcsIcYZr1+Rg13dcupg9S7uWuVaGV3xfPUXQhCpf9BKu5Zf+dPqbtQvbU
         yv7X5Eb4KDI+seHR/BVB4oWXW2ctzwC4J2qthxEAPuHdhgdHmp3dgrAg/UI+IfedfZI/
         CJpAL4qe4dLz0MDB539epUku0uj/PXAIKtYg0/Q1LVkMq13fIrzkYkQe8qQNW2CPuo6V
         bl/Q==
X-Received: by 10.182.48.194 with SMTP id o2mr4792642obn.90.1377842462136;
        Thu, 29 Aug 2013 23:01:02 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rl1sm36951280oeb.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:01:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233397>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sequencer.c                     | 2 +-
 t/t3510-cherry-pick-sequence.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 351548f..a962b33 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -661,7 +661,7 @@ static void prepare_revs(struct replay_opts *opts)
 		die(_("revision walk setup failed"));
 
 	if (!opts->revs->commits)
-		die(_("empty commit set passed"));
+		error(_("empty commit set passed"));
 }
 
 static void read_and_refresh_cache(struct replay_opts *opts)
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 7b7a89d..33c5512 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -472,7 +472,7 @@ test_expect_success 'malformed instruction sheet 2' '
 
 test_expect_success 'empty commit set' '
 	pristine_detach initial &&
-	test_expect_code 128 git cherry-pick base..base
+	git cherry-pick base..base
 '
 
 test_expect_success 'malformed instruction sheet 3' '
-- 
1.8.4-fc

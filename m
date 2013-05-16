From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/3] remote: disable allow-local for pushes
Date: Thu, 16 May 2013 02:31:14 -0500
Message-ID: <1368689474-28911-4-git-send-email-felipe.contreras@gmail.com>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 09:33:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcsgP-0007wJ-SP
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 09:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755955Ab3EPHcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 03:32:54 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:58858 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755538Ab3EPHcx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 03:32:53 -0400
Received: by mail-oa0-f45.google.com with SMTP id j6so3384248oag.32
        for <git@vger.kernel.org>; Thu, 16 May 2013 00:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=stHbRRUagIGtwyKr70rZGyvBD4BxPPa502jfWraKRbo=;
        b=0MAgoPG//avptjQkCBj/DB0su4Xn/j03lMC/1J1vkpjEM4TebjrGFSgN/cNAaEwtka
         AbyngTTlsbEV2ElYNIFMRGnhVLhTfy/kMQ9z/rwvVzpYF5j0MHkaGortLU3EKEWum9Nk
         bXpjyekP7wP5gLaFRCvT+4heUkRymyE+hwbYczxNooEVRUsEbWVqEoWX5TfL073Ccmfj
         563C+dcY/dkSE4+yTs6GxFTJ8VyBbhxtoRpHWBtkEYUa5IMOP/GLHvUOFtUVT89r6/iO
         6fG8VYrgXO4HvZnNKJjiWf85k/LDQjw05lnF26CrCiaUp/3rvgviHZgz/YdPGaQpw6R9
         TfDg==
X-Received: by 10.60.116.138 with SMTP id jw10mr11462894oeb.64.1368689572762;
        Thu, 16 May 2013 00:32:52 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id nt17sm6740898obb.13.2013.05.16.00.32.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 May 2013 00:32:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224488>

So that 'git push' uses 'origin', instead of '.' by default.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 remote.c                | 2 +-
 t/t5528-push-default.sh | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index a7e59ab..c1458dc 100644
--- a/remote.c
+++ b/remote.c
@@ -729,7 +729,7 @@ struct remote *remote_get(const char *name)
 struct remote *pushremote_get(const char *name)
 {
 	read_config();
-	return remote_get_1(name, pushremote_name, 1);
+	return remote_get_1(name, pushremote_name, 0);
 }
 
 struct remote *fetchremote_get(const char *name, int allow_local)
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index 4736da8..61df2a7 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -115,4 +115,11 @@ test_expect_success 'push to existing branch, upstream configured with different
 	test_cmp expect-other-name actual-other-name
 '
 
+test_expect_success 'push to existing branch, upstream configured with same name' '
+	git remote add origin repo1 &&
+	git checkout -t -b local-tracking master &&
+	test_commit ten &&
+	test_push_success current local-tracking
+'
+
 test_done
-- 
1.8.3.rc1.579.g184e698

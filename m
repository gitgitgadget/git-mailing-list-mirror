From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 2/3] repack: retain the return value of pack-objects
Date: Sun, 15 Sep 2013 17:33:21 +0200
Message-ID: <1379259202-5042-2-git-send-email-stefanbeller@googlemail.com>
References: <1379259202-5042-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 15 17:33:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLEK6-0006NR-Mo
	for gcvg-git-2@plane.gmane.org; Sun, 15 Sep 2013 17:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757080Ab3IOPdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Sep 2013 11:33:15 -0400
Received: from mail-ee0-f49.google.com ([74.125.83.49]:59773 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756997Ab3IOPdO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Sep 2013 11:33:14 -0400
Received: by mail-ee0-f49.google.com with SMTP id d41so1494198eek.8
        for <git@vger.kernel.org>; Sun, 15 Sep 2013 08:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T3+FeFIriECmX+LFWWqOi5AN9PlPhhcpoOJBS2MuPLA=;
        b=rvoyaZ0pfCQUo8z0afUqudGrLxv99ZnQo+vESIKBpqnXjlhZpTCyJOtT3YzsAhDrdc
         oZQZ4gEg1/RNxIeXfr6TEgYXgkR7p/pjbzArdjldRdCjpWDCuB4TZlZRHpF3obIoPyMn
         369h41UFQ/6bVTjlQYBnRjacStU9ZnfA3kzftpFcfdkQka/fzfHHcq4kH9cO9Jmynjzl
         W8WZc2c67/puCp2HiI/wvUMWpasqPYdYqL4CcdqYJGoJVNh8jfdTFiFMdCTRm2Sdv9DG
         ujl9/3rc5LRJ6q4tAjXU85hvv0kSQsV3Bq3oEw0Qp2KqoNb55MG6B5BP1c3J/IUHu7yb
         JjOg==
X-Received: by 10.15.99.72 with SMTP id bk48mr36123115eeb.22.1379259193215;
        Sun, 15 Sep 2013 08:33:13 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id k7sm33695629eeg.13.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 15 Sep 2013 08:33:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.273.ga194ead
In-Reply-To: <1379259202-5042-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234818>

During the review process of the previous commit (repack: rewrite the
shell script in C), Johannes Sixt proposed to retain any exit codes from
the sub-process, which makes it probably more obvious in case of failure.

As the commit before should behave as close to the original shell
script, the proposed change is put in this extra commit.
The infrastructure however was already setup in the previous commit.
(Having a local 'ret' variable)

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/repack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index a15bd9b..d345d16 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -231,7 +231,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	ret = start_command(&cmd);
 	if (ret)
-		return 1;
+		return ret;
 
 	nr_packs = 0;
 	out = xfdopen(cmd.out, "r");
@@ -244,7 +244,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	fclose(out);
 	ret = finish_command(&cmd);
 	if (ret)
-		return 1;
+		return ret;
 	argv_array_clear(&cmd_args);
 
 	if (!nr_packs && !quiet)
-- 
1.8.4.273.ga194ead

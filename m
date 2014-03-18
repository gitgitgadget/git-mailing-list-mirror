From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 5/7] merge: fix GIT_EDITOR override for commit hook
Date: Tue, 18 Mar 2014 11:00:54 +0100
Message-ID: <1395136856-17225-5-git-send-email-benoit.pierre@gmail.com>
References: <xmqqmwgoejwq.fsf@gitster.dls.corp.google.com>
 <1395136856-17225-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 18 11:01:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPqq4-0003wX-Pb
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 11:01:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754656AbaCRKBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 06:01:31 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:35252 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647AbaCRKBa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 06:01:30 -0400
Received: by mail-wg0-f42.google.com with SMTP id y10so5608162wgg.13
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 03:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=yOnJTeIxULs8aYCF2bcc3pkQjFLFPGb0PxPrUdXAZbA=;
        b=yjHOUw8/WpH3Ojog8tB9TSNuUc7IZ5oE+V9IJETlHnXW6duUh4oPC7/aDX6MIO5aha
         4ktxv8nOZB3xRbrE6IuHXGjvnj2R4U0WArQesmrDTZFG6O077YwKngOW8tVzdrbeNH5e
         QPo5VQDtRtHIlP+PU8rvf2rY3EPJ2SHezg35YNtsLe0rp233QOd7mq08XGly/qnHBr50
         AzrxE9dEBXL5V7IoEuhxybBTqi6EFdpmRfxwxz1wR0EF/M3yx7bOSoOJpioH+1qh7KuF
         k0Kl7hWxsWKeujll6gMoqCpMmThr1x4sGaSCUXwyEd1pta/LzkohA56n3H+PvdI77SeL
         qW6A==
X-Received: by 10.195.13.103 with SMTP id ex7mr22540425wjd.3.1395136889463;
        Tue, 18 Mar 2014 03:01:29 -0700 (PDT)
Received: from localhost (121.12.70.86.rev.sfr.net. [86.70.12.121])
        by mx.google.com with ESMTPSA id bj3sm45829430wjb.14.2014.03.18.03.01.28
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Mar 2014 03:01:28 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395136856-17225-1-git-send-email-benoit.pierre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244344>

Don't set GIT_EDITOR to ":" when calling prepare-commit-msg hook if the
editor is going to be called (e.g. with "merge -e").

Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
---
 builtin/merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index bdf6655..e15d0e1 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -824,7 +824,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	if (0 < option_edit)
 		strbuf_commented_addf(&msg, _(merge_editor_comment), comment_line_char);
 	write_merge_msg(&msg);
-	if (run_commit_hook(1, get_index_file(), "prepare-commit-msg",
+	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
 			    git_path("MERGE_MSG"), "merge", NULL))
 		abort_commit(remoteheads, NULL);
 	if (0 < option_edit) {
-- 
1.9.0

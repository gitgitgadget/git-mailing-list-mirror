From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 5/7] merge: fix GIT_EDITOR override for commit hook
Date: Sat, 15 Mar 2014 22:42:28 +0100
Message-ID: <1394919750-28432-5-git-send-email-benoit.pierre@gmail.com>
References: <CA+SSzV1LcuTWMGrJrto3cJ13-MxgFsJP6z3zTYjHp=qZGPoraw@mail.gmail.com>
 <1394919750-28432-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 22:43:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOwMM-00026c-Bc
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 22:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756651AbaCOVnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 17:43:09 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:52363 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756190AbaCOVnI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 17:43:08 -0400
Received: by mail-wi0-f182.google.com with SMTP id d1so806348wiv.15
        for <git@vger.kernel.org>; Sat, 15 Mar 2014 14:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=yOnJTeIxULs8aYCF2bcc3pkQjFLFPGb0PxPrUdXAZbA=;
        b=gPw5FS1gK+O7idV/NVd/bn6f6TPJneVkxTjaAOiaF5ja4RuV/bdApRrrR9xgYqlaLN
         onXeqGg8PcFk+e/+7B7lUanVGyICXz4LPIh4YgFS/BMEFRGumV4GD8U9bYALhaRNfUqY
         0oibSDmp7t6kag0g+78AJptmTC6Jzfo72a/67i4LlpHrtxoUyt3XRZXmqv+3YTH184Qq
         yTjI+gKJwkg62prEtA2S1sh81cGV3VhlqbZIW8+7aaRCRZ8Va1QvbavL3J3VVUyCS8IA
         gmXSzme/leeV+Y6Ric8Uo2wka/FTJHfzlHwWDzt6luY/GyGYlFotQXMXW//kjZiMQr5m
         Pnyw==
X-Received: by 10.194.185.148 with SMTP id fc20mr12223874wjc.27.1394919786714;
        Sat, 15 Mar 2014 14:43:06 -0700 (PDT)
Received: from localhost (121.12.70.86.rev.sfr.net. [86.70.12.121])
        by mx.google.com with ESMTPSA id mw3sm9239737wic.7.2014.03.15.14.43.04
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Mar 2014 14:43:06 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394919750-28432-1-git-send-email-benoit.pierre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244173>

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

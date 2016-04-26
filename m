From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 09/15] submodule--helper init: respect submodule groups
Date: Tue, 26 Apr 2016 13:50:27 -0700
Message-ID: <1461703833-10350-10-git-send-email-sbeller@google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	pclouds@gmail.com, Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 26 22:51:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av9xA-0006kM-7o
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 22:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988AbcDZUvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 16:51:23 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36449 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811AbcDZUu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 16:50:58 -0400
Received: by mail-pf0-f178.google.com with SMTP id c189so11430484pfb.3
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 13:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dHHo2LF2rsJJSWQDLdP6dEZYbx/Wvif1SMivI6Gttqk=;
        b=O/Upcpc6d7iELOfArbgI6KXcxbn8VWUfe4HO3qemx/VGepVnLUvEf0MFW7mjwn+fwl
         RkfloynKSdjZuCnsH6Ho85VgMoGjhZpm1vqRcykDFZxCzH4WbcoQrbgPAFmuFgcjcbAJ
         yvAcaLFQSgNjE+dk6k5W0kROL7ilO3RdKnRlhNDNPpwRnqRugf8MtMGyPT/7CLkU1+mh
         q++qm/OwXF8l7n0HRHjjFyJBCuPfCdglo4l8eP9r+6OBJMfOBQApNg4gatKMbT7cURxc
         2udP1F4ugElui/u1m+Ok6gKYfrI+AP42kCTdShsL0pzOyO5em421g1dp+GuQ0xhQW6A2
         0VAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dHHo2LF2rsJJSWQDLdP6dEZYbx/Wvif1SMivI6Gttqk=;
        b=Y2jdDevm4fIjaE7qXua8E8Oj8vyi2X2dt3ydtmBqnowBuE5yCjh6Ec1JBp9kZc3132
         KsPnUyBuJyCmIIRnWPubZB4gWhYda4WYjRPcrx3Wu96ZeYcYCfnyY8fZS4IJcbac/A+v
         joEJ2ZXGme3hgLdrX0yHXH4YF0IIGJuj6NiWDM3YGjk+8YQ6KPGHXZPFsnicYntkikO/
         lrkclMIRcNV3dRgRxlrm5dfS1CAj41qiWitnLkN9JFs0nGNg4fPelXOserrZ4cjIgTiW
         PX2m8TefTEawCoQ/NT6tihyDGgG1roS/t5/OSOAKcncW5QGz/YGNqeMb+JbLa6Ifdvf+
         JjUQ==
X-Gm-Message-State: AOPr4FWRjmLZQB4JU7XkPc4h0hIU1C6RdQUsCYw1Wiy6q2GY8zC80rfBgZiEcqY3/dMfQjIv
X-Received: by 10.98.0.202 with SMTP id 193mr6512993pfa.120.1461703857140;
        Tue, 26 Apr 2016 13:50:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fcb4:82e7:2d29:45d6])
        by smtp.gmail.com with ESMTPSA id g70sm512713pfb.7.2016.04.26.13.50.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Apr 2016 13:50:56 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.41.g8d9aeb3
In-Reply-To: <1461703833-10350-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292680>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c  | 19 +++++++++++++++++--
 t/t7413-submodule--helper.sh | 15 +++++++++++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index adb6188..29a345e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -405,6 +405,7 @@ static int module_init(int argc, const char **argv, const char *prefix)
 {
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
+	struct string_list *group = NULL;
 	int quiet = 0;
 	int i;
 
@@ -427,8 +428,22 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
 		return 1;
 
-	for (i = 0; i < list.nr; i++)
-		init_submodule(list.entries[i]->name, prefix, quiet);
+	if (!pathspec.nr)
+		group = string_list_duplicate(
+			git_config_get_value_multi("submodule.defaultGroup"), 1);
+	if (group) {
+		gitmodules_config();
+		for (i = 0; i < list.nr; i++) {
+			const struct submodule *sub =
+				submodule_from_path(null_sha1,
+						    list.entries[i]->name);
+			if (submodule_in_group(group, sub))
+				init_submodule(list.entries[i]->name, prefix, quiet);
+		}
+		string_list_clear(group, 1);
+	} else
+		for (i = 0; i < list.nr; i++)
+			init_submodule(list.entries[i]->name, prefix, quiet);
 
 	return 0;
 }
diff --git a/t/t7413-submodule--helper.sh b/t/t7413-submodule--helper.sh
index 1b5d135..ef12c63 100755
--- a/t/t7413-submodule--helper.sh
+++ b/t/t7413-submodule--helper.sh
@@ -175,4 +175,19 @@ test_expect_success 'submodule sync respects groups' '
 	)
 '
 
+test_expect_success 'submodule--helper init respects groups' '
+	(
+		cd super_clone &&
+		git submodule deinit . &&
+		git config --add submodule.defaultGroup *bit1 &&
+		git config --add submodule.defaultGroup ./sub0 &&
+		git submodule init &&
+		git config --unset-all submodule.defaultGroup &&
+		test "$(git config submodule.sub0.url)" = "$suburl" &&
+		test "$(git config submodule.sub1.url)" = "$suburl" &&
+		test_must_fail git config submodule.sub2.url &&
+		test "$(git config submodule.sub3.url)" = "$suburl"
+	)
+'
+
 test_done
-- 
2.8.0.41.g8d9aeb3

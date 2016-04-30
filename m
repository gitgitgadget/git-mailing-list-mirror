From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 09/10] submodule sync: send messages to stderr
Date: Fri, 29 Apr 2016 17:40:44 -0700
Message-ID: <1461976845-18228-10-git-send-email-sbeller@google.com>
References: <1461976845-18228-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 02:41:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awIyT-0006q0-Cl
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 02:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009AbcD3AlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 20:41:20 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34467 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953AbcD3AlD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 20:41:03 -0400
Received: by mail-pa0-f52.google.com with SMTP id r5so52503107pag.1
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 17:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ufl7f/eXWrNQUyq9dcw7ctBmHWWZCVLvilqz9eAY7fQ=;
        b=anaBLlCfK9ld6qggFYwQNPYZ5x4l148gGSj0UIUfW8aVepBY9KY4VkULyBBk/gmr7l
         NH3iSoK/Wg+5OIsoAXHtsa7K0rYDTrdUl6AHUyS035/cfK5MmpmlWFCLyvdwtWEFryGz
         qf36wxJ03+SMfGHzy8xdCUo9u4a0iMOsDINj4XenqbXEqV9tV+hbrvBYI+/p6b+Nvukh
         K1Xz8SLKgUYeEqMSn5fhsMxV7jzwwE2m0ixjit28bUi0a9UusSydsock9rvVNUjHjsoK
         5E5X0WXKd3x58K7yR2N+mfrVQLvrWvExIKaCwbUwaprzbulaltMgTnM13CO2YyqgBdg4
         9JRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ufl7f/eXWrNQUyq9dcw7ctBmHWWZCVLvilqz9eAY7fQ=;
        b=d29yUyW9SdoaB3ac1GjQI8gEn/rVuh0pdSD4TFDLqLQv80GpC9rY44BYjPmnQc9QBT
         t1zOv/dqtW68ippoMh25PfuAcVWLLwOfAg58yOHuPLDTiZ6ON4e2lQPjmHPCBflRLcJ8
         O/Kjsw0tj0gz1lWV5WWMvH+E3BGeCZM3rMCEmU9L1Ll4XUrvWUNUbYl5zNjwL/VBFnzH
         ul38TDBcscyQT5yBcVA2/z+oc99DMpKcfwas9qF39IbPM111GUwOplBgCBl3esctgIOX
         ENbpULx3nJMlHJiLy2CDrWP15JxdOkv2CtozqYKrTE/WrsYoe3TwofkfbeD9pE7wqhzY
         WfAg==
X-Gm-Message-State: AOPr4FXmlbFGD9n9+tOFItcDkC+fBGHoONtP+o66wd0LZZH5XkRtsY8RHwJs5fO/bW74q4Kh
X-Received: by 10.67.13.144 with SMTP id ey16mr2053458pad.147.1461976862303;
        Fri, 29 Apr 2016 17:41:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1c8a:9b5c:52bb:4ac5])
        by smtp.gmail.com with ESMTPSA id 71sm26444699pfy.32.2016.04.29.17.41.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 17:41:01 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.32.g71f8beb.dirty
In-Reply-To: <1461976845-18228-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293096>

Reroute the output of stdout to stderr as it is just informative
messages, not to be consumed by machines.

This should not regress any scripts that try to parse the
current output, as the output is already internationalized
and therefore unstable.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh          | 2 +-
 t/t7403-submodule-sync.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index c86c2e5..f075924 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1095,7 +1095,7 @@ cmd_sync()
 		if git config "submodule.$name.url" >/dev/null 2>/dev/null
 		then
 			displaypath=$(relative_path "$prefix$sm_path")
-			say "$(eval_gettext "Synchronizing submodule url for '\$displaypath'")"
+			say >&2 "$(eval_gettext "Synchronizing submodule url for '\$displaypath'")"
 			git config submodule."$name".url "$super_config_url"
 
 			if test -e "$sm_path"/.git
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 79bc135..93c1dfa 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -155,7 +155,7 @@ test_expect_success '"git submodule sync" should update submodule URLs - subdire
 		git pull --no-recurse-submodules &&
 		mkdir -p sub &&
 		cd sub &&
-		git submodule sync >../../output
+		git submodule sync 2>../../output
 	) &&
 	grep "\\.\\./submodule" output &&
 	test -d "$(
@@ -186,7 +186,7 @@ test_expect_success '"git submodule sync --recursive" should update all submodul
 		) &&
 		mkdir -p sub &&
 		cd sub &&
-		git submodule sync --recursive >../../output
+		git submodule sync --recursive 2>../../output
 	) &&
 	grep "\\.\\./submodule/sub-submodule" output &&
 	test -d "$(
-- 
2.8.0.32.g71f8beb.dirty

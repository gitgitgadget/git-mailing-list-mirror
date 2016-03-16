From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] clone: Add t5614 to test cloning submodules with shallowness involved
Date: Tue, 15 Mar 2016 18:12:17 -0700
Message-ID: <1458090737-14030-4-git-send-email-sbeller@google.com>
References: <1458090737-14030-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de, pclouds@gmail.com,
	larsxschneider@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 16 02:12:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ag00y-00085A-9s
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 02:12:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934121AbcCPBMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 21:12:34 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:32865 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934096AbcCPBMa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 21:12:30 -0400
Received: by mail-pf0-f182.google.com with SMTP id 124so51690817pfg.0
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 18:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e9+1pSqAP3oFzGBUDCfCpjIr0HNHLV0A0M5B4NcZla0=;
        b=bIl6JjY+yCK3Iwhg1BASBWRx+jqDuoquOVmlQWX48QfBaq1vKLX7t8qO7njjn0tfjL
         B6EqmF0PuUt8HThrjmueRuFXHyolL8c1aWX3e4Tt+339BfwJqdITjsB1YG1psz6Ezt36
         4DCGfZwiICmICCbHBU+Q6i6BdLU6ILM/2mKBq0m+aKdJEoJ1sREoh2JDREfQaOER9opi
         iROyarMbT9o9T8kgRrDvgsbGpNqNNdlXHIRKcj7BJvh+sdNshMniQb0UTZ8SFMezqfpG
         kaOWHruWeNozburW9HsbtkruI3mzXgLL7ocd9wdSZNUufDjUCAraBC9N0yqpIclTK4wC
         RvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e9+1pSqAP3oFzGBUDCfCpjIr0HNHLV0A0M5B4NcZla0=;
        b=OlkezcB6RSocNgY5zgQtucZtPzBeebBYJgTySJU3MO3rGFh0rfunDppRVcMfrgGHn8
         h7WLY3T/MJuqapX1MJRKV2UKiSUuSRBI7Gg94q8dHoppunNToLLmjnVmsmYHrYuUz0/M
         S7iLNBvyv0vwT2xL6eIKsYFQY227LYGlxeconrYh5LLTOrS+lx3O7uvQ655Uqts1PrEy
         qls3vV3J26Mr5yYhaHs9ECq5YuC/qfbmd9rc0nTu8+Ffy7dgwGiY6NHMkE4pp771Guqu
         3OCA3WBBFlKhkyxsDZkVPBm28mINGBEQwUpqwn3kvU7Z3hL7Zz/yEluLOVoT8ExdbjWb
         KIJg==
X-Gm-Message-State: AD7BkJLaBp0s5zjuAqm1TYKvTxAXJvvZCxOC8uX8WS7RGzPE6D3sTiD3I02wHeoYsII989lw
X-Received: by 10.66.199.66 with SMTP id ji2mr1676404pac.34.1458090749386;
        Tue, 15 Mar 2016 18:12:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f8a9:c435:807a:de5e])
        by smtp.gmail.com with ESMTPSA id f66sm657686pff.8.2016.03.15.18.12.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Mar 2016 18:12:28 -0700 (PDT)
X-Mailer: git-send-email 2.7.0.rc0.42.g8e9204f.dirty
In-Reply-To: <1458090737-14030-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288941>

There are some inherent issues with shallow clones and submodules, such
as having not having a commit available the superproject may point to
in the submodule due to being shallow. Use the new file t5614 to document
and test expectations in this area.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    $gmane/288916 does renaming operations,
    "[PATCH] clone tests: rename t57* => t56*",
    such that the first 13 spots in t56* are taken.
    So we'll go with ..14 to not cause conflicts.
    (If not having that renaming patch in mind, you
    may end up aksing yourself "why ..14?")

 t/t5614-clone-submodules.sh | 82 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100755 t/t5614-clone-submodules.sh

diff --git a/t/t5614-clone-submodules.sh b/t/t5614-clone-submodules.sh
new file mode 100755
index 0000000..a66c2db
--- /dev/null
+++ b/t/t5614-clone-submodules.sh
@@ -0,0 +1,82 @@
+#!/bin/sh
+
+test_description='Test shallow cloning of repos with submodules'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	git checkout -b master &&
+	test_commit commit1 &&
+	test_commit commit2 &&
+	mkdir sub &&
+	(
+		cd sub &&
+		git init &&
+		test_commit subcommit1 &&
+		test_commit subcommit2
+	) &&
+	git submodule add ./sub &&
+	git commit -m "add submodule"
+'
+
+test_expect_success 'nonshallow clone implies nonshallow submodule' '
+	test_when_finished "rm -rf super_clone" &&
+	git clone --recurse-submodules . super_clone &&
+	(
+		cd super_clone &&
+		git log --oneline >lines &&
+		test_line_count = 3 lines
+	) &&
+	(
+		cd super_clone/sub &&
+		git log --oneline >lines &&
+		test_line_count = 2 lines
+	)
+'
+
+test_expect_success 'shallow clone implies shallow submodule' '
+	test_when_finished "rm -rf super_clone" &&
+	git clone --recurse-submodules --no-local --depth 1 . super_clone &&
+	(
+		cd super_clone &&
+		git log --oneline >lines &&
+		test_line_count = 1 lines
+	) &&
+	(
+		cd super_clone/sub &&
+		git log --oneline >lines &&
+		test_line_count = 1 lines
+	)
+'
+
+test_expect_success 'shallow clone with non shallow submodule' '
+	test_when_finished "rm -rf super_clone" &&
+	git clone --recurse-submodules --no-local --depth 1 --no-shallow-submodules . super_clone &&
+	(
+		cd super_clone &&
+		git log --oneline >lines &&
+		test_line_count = 1 lines
+	) &&
+	(
+		cd super_clone/sub &&
+		git log --oneline >lines &&
+		test_line_count = 2 lines
+	)
+'
+
+test_expect_success 'non shallow clone with shallow submodule' '
+	test_when_finished "rm -rf super_clone" &&
+	git clone --recurse-submodules --no-local --shallow-submodules . super_clone &&
+	(
+		cd super_clone &&
+		git log --oneline >lines &&
+		test_line_count = 3 lines
+	) &&
+	(
+		cd super_clone/sub &&
+		git log --oneline >lines &&
+		test_line_count = 1 lines
+	)
+'
+
+test_done
-- 
2.7.0.rc0.42.g8e9204f.dirty

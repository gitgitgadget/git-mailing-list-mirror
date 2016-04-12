From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] clone: add t5614 to test cloning submodules with shallowness involved
Date: Tue, 12 Apr 2016 16:48:49 -0700
Message-ID: <1460504929-19208-4-git-send-email-sbeller@google.com>
References: <1460504929-19208-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 01:49:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq83J-00036F-9M
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 01:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965736AbcDLXs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 19:48:57 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36514 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964951AbcDLXs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 19:48:56 -0400
Received: by mail-pf0-f174.google.com with SMTP id e128so22678350pfe.3
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 16:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=McgdZACwwpyMndm/EwAharLJO8pKL9D/XM9UbiBnuZg=;
        b=jqnJPCK8G6pbSsPMNRkj3LvA1xFDaX3+5YcDsZWFA3Wab2XTX/u/3UN8WLrQIEgRYl
         Ut451VnpsqMl+5yxIQnCad3X7XLBNXDeIeISsOHBIHggrIJXaAz4nHpxUQoF7BTz8Tnx
         iUA7n9l0WCM4lXwPhXBkupQVfe5hi5HqQ/qzuXmisWbeDotKG/l2bStHB8FP9vwCs9eN
         HtdsnkyYxuBbnBJdgv1JTu427iG1S8shRnbPJcwjPpzySywSfxGWZVVa6l2PC6Q/z5o6
         /yz7RZXwY0HOJVEQy2lBkldvQ9k65cxAvHUDzGNhQX3v3YwkbzBLRhmiJdZxsr9pXmFe
         8ZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=McgdZACwwpyMndm/EwAharLJO8pKL9D/XM9UbiBnuZg=;
        b=IgFXbmxXVcGNXLvY5TKFlDq/IBwScwXAETdxttEraxxaKZpC7G0OyFy/IIFbzUnTpz
         o079vYWUyMoTki3I+OIEL01kwdpOrpOJnLrzvrvy11z/aFZBjFOac7VUFUGibm7UCdqs
         puYzpZADJqsSPCm9GWh9h+YzkI9zzsSq6InJCIkYZq/XHRYpHBC5TvgALW9oXtyVLdcD
         zuCuCptnH2iPGKXykIHUWkKaVjuRaBUiIwPOH7MVoZ6w9ZS9Gc+fMcgycFcOMDPSRlW8
         4KuUhpqcOg0ZA+qQOGrMUZdXS0r9DHFqBeMsRgdK9Mn/v9jLnEyaIGTLQYw9atSTIpvI
         a/oA==
X-Gm-Message-State: AOPr4FUJmg3c5TOfL7jzm+3LAT0zip/nu8CWiASvS6Zz0EOj7LY4LF/nIdo+wnCEqHieqxEx
X-Received: by 10.98.68.71 with SMTP id r68mr8456385pfa.119.1460504935661;
        Tue, 12 Apr 2016 16:48:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:705c:1d3d:8d56:4629])
        by smtp.gmail.com with ESMTPSA id t1sm20809251paa.17.2016.04.12.16.48.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 12 Apr 2016 16:48:55 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.gc776916.dirty
In-Reply-To: <1460504929-19208-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291331>

There are some inherent issues with shallow clones and submodules, such
as having not having a commit available the superproject may point to
in the submodule due to being shallow. Use the new file t5614 to document
and test expectations in this area.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
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
2.5.0.264.gc776916.dirty

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF3AC433EF
	for <git@archiver.kernel.org>; Tue,  3 May 2022 06:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiECG70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 02:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiECG61 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 02:58:27 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EED19C1B
        for <git@vger.kernel.org>; Mon,  2 May 2022 23:54:56 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id hf18so12773752qtb.0
        for <git@vger.kernel.org>; Mon, 02 May 2022 23:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+3IjwABSO6B2aNfrvSEj/mrf8+cKqhnN3GxrN+/ZtnU=;
        b=Hzfo+Gbk7fIcJZAuv+LfDNNcRjm8xXO1TOQGTRcB7PS41TAZCW+m88A1L2FvMMIgGf
         1fjMwjR4qgqPLDBjvEsXV6lIUDO1RWhvTR3lgfDxTn5U7dd566ehaSEJvSFEaRqSChb1
         djxW9nrl0q2l5NuqU3RFWK+3PzWq1SNmQ0qlwYxC/vXlMg4EKZJzvQTs723bcMBoikCE
         1H65Og/R+P9xjr6CuGnag07ZtVtwFM/3JRupV3txHlhZxtNvI244GiaIQI9CtvXrUnLj
         1hdGGdB17WYRxFORVq3P2KP8V4crjHq7oWLmj8VJXluQILUsJG7baHsilmBZdSx3W/2I
         p7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+3IjwABSO6B2aNfrvSEj/mrf8+cKqhnN3GxrN+/ZtnU=;
        b=gBZsrLkpsGdp43gCJ8eBWbtKQJoNKuLos21xetWIUPJZq5O3u+giJCxjc/I9aElaNT
         +fXUWPDTf0jcLUfda+ZR8Hk4Q9lC+GMwRpkxNpj+0+fXlF5hX6PoOFeHP0ESgZDCHoMD
         IO5cRvfgzFCPZDmxkZW85uuGylu6mlEaBeZfiA/obF2uXKZQiudGhQ1ovGHMitnxo3o4
         f757yKZYXGo+Q0+xnVq6tsK2Ulq9gs2QSWOM5Kv/1nyd0TawKFt20FH6rR6GNvFHR/fu
         x0o1UCVoq4K5DZ4v6rgwS/OftWm8nqK5bmkChbEwQ3erICWvMEVaaz/Uz2WZqUm7hu54
         0hTQ==
X-Gm-Message-State: AOAM533ta3s9KscyVl5ShhFK1FgbBmMfaILOBFbTnPfXf55POvILSNua
        E05Q+/OiHkVfSisTrPya7A/ECH1WwkQ=
X-Google-Smtp-Source: ABdhPJyeuKM9VAOHj0NQYgFfXixKpW2+xK36D785OZj8JuBUQg1kh6jbz83HIhKrbc5Hn47RdmAPKQ==
X-Received: by 2002:a05:622a:1c5:b0:2f3:a570:a97b with SMTP id t5-20020a05622a01c500b002f3a570a97bmr7396637qtw.462.1651560895173;
        Mon, 02 May 2022 23:54:55 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id t1-20020ac85301000000b002f39b99f68bsm5333369qtn.37.2022.05.02.23.54.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 May 2022 23:54:54 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, bagasdotme@gmail.com, phillip.wood123@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 1/3] t: document regression git safe.directory when using sudo
Date:   Mon,  2 May 2022 23:54:40 -0700
Message-Id: <20220503065442.95699-2-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.352.g0cd7feaf86f
In-Reply-To: <20220503065442.95699-1-carenas@gmail.com>
References: <20220428105852.94449-1-carenas@gmail.com>
 <20220503065442.95699-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally reported after release of v2.35.2 (and other maint branches)
for CVE-2022-24765 and blocking otherwise harmless commands that were
done using sudo in a repository that was owned by the user.

Add a new test script with very basic support to allow running git
commands through sudo, so a reproduction could be implemented and that
uses only `git status` as a proxy of the issue reported.

Note that because of the way sudo interacts with the system, a much
more complete integration with the test framework will require a lot
more work and that was therefore intentionally punted for now.

The current implementation requires the execution of a special cleanup
function which should always be kept as the last "test" or otherwise
the standard cleanup functions will fail because they can't remove
the root owned directories that are used.  This also means that if
failures are found while running the specifics of the failure might
not be kept for further debugging and if the test was interrupted, it
will be necessary to clean the working directory manually before
restarting by running:

  $ sudo rm -rf trash\ directory.t0034-root-safe-directory/

The test file also uses at least one initial "setup" test that creates
a parallel execution directory, while ignoring the repository created
by the test framework, and special care should be taken when invoking
commands through sudo, since the environment is otherwise independent
from what the test framework expects.  Indeed `git status` was used
as a proxy because it doesn't even require commits in the repository
to work.

A new SUDO prerequisite is provided that does some sanity checking
to make sure the sudo command that will be used allows for passwordless
execution as root and doesn't mess with git execution paths, but
otherwise additional work will be required to ensure additional
commands behave as expected and that will be addressed in a later patch.

Most of those characteristics make this test mostly suitable only for
CI, but it could be executed locally if special care is taken to provide
for some of them in the local configuration and maybe making use of the
sudo credential cache by first invoking sudo, entering your password if
needed, and then invoking the test by doing:

  $ IKNOWWHATIAMDOING=YES ./t0034-root-safe-directory.sh

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/t0034-root-safe-directory.sh | 49 ++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100755 t/t0034-root-safe-directory.sh

diff --git a/t/t0034-root-safe-directory.sh b/t/t0034-root-safe-directory.sh
new file mode 100755
index 00000000000..6dac7a05cfd
--- /dev/null
+++ b/t/t0034-root-safe-directory.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+
+test_description='verify safe.directory checks while running as root'
+
+. ./test-lib.sh
+
+if [ "$IKNOWWHATIAMDOING" != "YES" ]
+then
+	skip_all="You must set env var IKNOWWHATIAMDOING=YES in order to run this test"
+	test_done
+fi
+
+# this prerequisite should be added to all the tests, it not only prevents
+# the test from failing but also warms up any authentication cache sudo
+# might need to avoid asking for a password
+test_lazy_prereq SUDO '
+	sudo -n id -u >u &&
+	id -u root >r &&
+	test_cmp u r &&
+	command -v git >u &&
+	sudo command -v git >r &&
+	test_cmp u r
+'
+
+test_expect_success SUDO 'setup' '
+	sudo rm -rf root &&
+	mkdir -p root/r &&
+	sudo chown root root &&
+	(
+		cd root/r &&
+		git init
+	)
+'
+
+test_expect_failure SUDO 'sudo git status as original owner' '
+	(
+		cd root/r &&
+		git status &&
+		sudo git status
+	)
+'
+
+# this MUST be always the last test, if used more than once, the next
+# test should do a full setup again.
+test_expect_success SUDO 'cleanup' '
+	sudo rm -rf root
+'
+
+test_done
-- 
2.36.0.352.g0cd7feaf86f


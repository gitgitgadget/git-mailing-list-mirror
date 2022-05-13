Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7A2C433FE
	for <git@archiver.kernel.org>; Fri, 13 May 2022 01:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359832AbiEMBAm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 21:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359838AbiEMBAi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 21:00:38 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3042E28BDDC
        for <git@vger.kernel.org>; Thu, 12 May 2022 18:00:35 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id l1so5679283qvh.1
        for <git@vger.kernel.org>; Thu, 12 May 2022 18:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4wmDxjP2mGvvbTbVAmUg7e2xipQK04OlptWFYCPhh70=;
        b=oUN85uvuIqSSHKSbFvcliBqXnrqdZDhvcVu41/f1wawsVJHv2xBdBaREdvjHHop00j
         XXlewCp+TvKIwHv6xL44d97rwJSJIP29RJAREpyibIo8yy/yXUvwhjPAUnxoQWwRyHnZ
         a2gAaoXQUVmxEav4iBCVgfLqroA8lApIJMWy6Xg3RXxiO9yUZ6nGTlM8JIFo3AnBphDm
         Kkau1+rxkejHGCKmZGiCPhY9SPa6Iz9AK5GHK9kIr0yixfk8pCAGe0Wpt+OUM3Y2ylJm
         yG3IWE2Ejr9E27WBepdH6hA3hXc+wH7M14aoCmCRvg7a7GXsXXaiuNr4InEUPVyqpUQA
         v4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4wmDxjP2mGvvbTbVAmUg7e2xipQK04OlptWFYCPhh70=;
        b=mcFk59T3ry0CW3PvfYn1B53O+JmxyXb+TILSbcP8bR3Zxoi5zBIQmvNkRxGWNUImGf
         o4qjAGeO9lNvbBoAo1vkC6d4flMzQF8xxZ7f8dNOXH5AWKQXGocR1y+mFfFabEZWhaTE
         iJQ3PxuqYSn3eXJDlbBUpxCS1Ys73edh1kU8gbuYMm6FyVdTbp75QUtlDufI6r00En3V
         /yLUOnYNM16BakVQpn50QRMX0L+gVH/niR0c6lX/QKqCD+NdF081kmTtdvzGWvVSjqij
         HKKHHSrUtAaBsdegZrj+97MqBZf1jheOdlEilqiUcXTQXBDg55e6babZqgsLI79fGFkJ
         vlIg==
X-Gm-Message-State: AOAM5317qu7ZKZCWLbOPMk2KHeglCIjmtG47PLZpjs9TOhILijqJfL9Z
        048kmTroFiS8ALx5jvYc4tjaROthSXg=
X-Google-Smtp-Source: ABdhPJyllTOjPjsO/BePgNIbrFgBEj5LeBU6dUq5D+C5q1LSr+t28vF2WIWrgniXGYkUA2pQ/wVCSA==
X-Received: by 2002:a05:6214:1bc7:b0:45b:85e:e5a4 with SMTP id m7-20020a0562141bc700b0045b085ee5a4mr2568824qvc.57.1652403633816;
        Thu, 12 May 2022 18:00:33 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id s202-20020a3745d3000000b0069fc13ce227sm583541qka.88.2022.05.12.18.00.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 May 2022 18:00:33 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, bagasdotme@gmail.com,
        johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v5 1/4] t: regression git needs safe.directory when using sudo
Date:   Thu, 12 May 2022 18:00:17 -0700
Message-Id: <20220513010020.55361-2-carenas@gmail.com>
X-Mailer: git-send-email 2.36.1.371.g0fb0ef0c8d
In-Reply-To: <20220513010020.55361-1-carenas@gmail.com>
References: <20220510174616.18629-1-carenas@gmail.com>
 <20220513010020.55361-1-carenas@gmail.com>
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
failures are found while running, the specifics of the failure might
not be kept for further debugging and if the test was interrupted, it
will be necessary to clean the working directory manually before
restarting by running:

  $ sudo rm -rf trash\ directory.t0034-root-safe-directory/

The test file also uses at least one initial "setup" test that creates
a parallel execution directory under the "root" sub directory, which
should be used as top level directory for all repositories that are
used in this test file.  Unlike all other tests the repository provided
by the test framework should go unused.

Special care should be taken when invoking commands through sudo, since
the environment is otherwise independent from what the test framework
setup and might have changed the values for HOME, SHELL and dropped
several relevant environment variables for your test.  Indeed `git status`
was used as a proxy because it doesn't even require commits in the
repository to work and usually doesn't require much from the environment
to run, but a future patch will add calls to `git init` and that will
fail to honor the default branch name, unless that setting is NOT
provided through an environment variable (which means even a CI run
could fail that test if enabled incorrectly).

A new SUDO prerequisite is provided that does some sanity checking
to make sure the sudo command that will be used allows for passwordless
execution as root without restrictions and doesn't mess with git's
execution path.  This matches what is provided by the macOS agents that
are used as part of GitHub actions and probably nowhere else.

Most of those characteristics make this test mostly only suitable for
CI, but it might be executed locally if special care is taken to provide
for all of them in the local configuration and maybe making use of the
sudo credential cache by first invoking sudo, entering your password if
needed, and then invoking the test with:

  $ GIT_TEST_ALLOW_SUDO=YES ./t0034-root-safe-directory.sh

If it fails to run, then it means your local setup wouldn't work for the
test because of the configuration sudo has or other system settings, and
things that might help are to comment out sudo's secure_path config, and
make sure that the account you are using has no restrictions on the
commands it can run through sudo, just like is provided for the user in
the CI.

For example (assuming a username of marta for you) something probably
similar to the following entry in your /etc/sudoers (or equivalent) file:

  marta	ALL=(ALL:ALL) NOPASSWD: ALL

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0034-root-safe-directory.sh | 44 ++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100755 t/t0034-root-safe-directory.sh

diff --git a/t/t0034-root-safe-directory.sh b/t/t0034-root-safe-directory.sh
new file mode 100755
index 00000000000..f6a5d63ff41
--- /dev/null
+++ b/t/t0034-root-safe-directory.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+
+test_description='verify safe.directory checks while running as root'
+
+. ./test-lib.sh
+
+if [ "$GIT_TEST_ALLOW_SUDO" != "YES" ]
+then
+	skip_all="You must set env var GIT_TEST_ALLOW_SUDO=YES in order to run this test"
+	test_done
+fi
+
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
+# this MUST be always the last test
+test_expect_success SUDO 'cleanup' '
+	sudo rm -rf root
+'
+
+test_done
-- 
2.36.1.371.g0fb0ef0c8d


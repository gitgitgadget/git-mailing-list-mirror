Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A7BC0015E
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 14:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbjG1OzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jul 2023 10:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237282AbjG1OzD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2023 10:55:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E081BF2
        for <git@vger.kernel.org>; Fri, 28 Jul 2023 07:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1690556057; x=1691160857; i=georgmueller@gmx.net;
 bh=vdtuVVjMNdCWG947AeAE/ltusmx8WHyqAjbbQpx2ahc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=DpzYn+riiM4NWLBXNteIysjFNuuMYKKIvxA1KnSIvJDZ1pTMlQ6Vh7y4buAVqRe5adkiTkr
 QKndAB/bt13G2/XpwCSHoEuBFi9lYaqrfr9/KrGyTHMrmuMULtxN4KeSCddqxjxZ7K3KbJt8o
 rnIimYop0UoN1dw26H+n3fYd5ZyCITcHE5bTadEHFKkVt/5R2/ZZM8X4V5rYS7G6gQoYl3ST4
 LSQB19CD452F0XLhVnne7Hf1l0B5q6mJc9G992MMqIlKC7/90zhmkZG49y67h2Q7F2PUAed0Q
 WNtrgeIldtTSRnB72lks0uT3fmR4qJdBBX2djBGT7ih1MjQaDSwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from nb-georg.intra.allegro-packets.com ([79.246.95.128]) by
 mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M6lpG-1qWXBu3xx0-008H5l; Fri, 28 Jul 2023 16:54:17 +0200
From:   =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] perf probe: skip test_uprobe_from_different_cu if there is no gcc
Date:   Fri, 28 Jul 2023 16:52:58 +0200
Message-ID: <20230728145305.449904-2-georgmueller@gmx.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8NUTDhXDpLEmovui9CiRrE+GpL0rteIJNSmdWPzQqSm9NH9qaC1
 KlwuXSDWnuPkyCSSGQdkBmle3dv8seAV3XE55XnBz+nZXD7JurHk6HFcPbUXBdzyvZie/US
 iefkUA1fPROdtHSNqG2r4E40qbl//i+d0k/sf8M2PjLTLxGRfqWPOQBGO3j+huh9vMSbOJC
 2kA9uu3B5GgYqp83+g5zw==
UI-OutboundReport: notjunk:1;M01:P0:QEBJ25EGcbs=;Yd33DJl+m+dn8tjO300UY3G+eaJ
 f/By3suboqutlYb7yR628v09fxGpnCoO76hsCxFE5zJpHOBxaRrTTyeduCkZRzChrcHGS2if5
 hFxx+YMHncmJPg8TFZyQEhY8yzVEvLQ1pSmb+VgnUN5T27a4gUrKmPbB3yQltSBSP3wcwWgl+
 9sQd4uMEz/Fz/uXOQV8fsfW+A/dRFUvjtM/oARQeLCOB/4qv+6eOWWrcyd09iq5Qa97AlzrZ2
 PUGv7le6HysSQ5tJdHZqYWVxeft04RXnzqnKJsPuVQ4WhAphE8ms9BP7Gcbk1SYszB9fngyl3
 Aowi+kajkc81YJIk6xPSvdPJc6bMvdb5KF6VaZZwIRAycopJo6KVKzvfZIY70+5OI2MRokZMv
 slBp7PlCMpL7jIUYXbkKQxXSzGX4E6OZbvxEGqnvWrzmBTab90Sus294HL9wlzZxbOURY5Muc
 TGA9Duj64/gPbn4aFrt7EoylUdWXCaE67oFg19LsfzqQZrjy9WMjp6/inRNukEmjn4JskSAnM
 dDGoEjzdovIAH94k+V8rGNKv8jy73Jk/WFENNId3CUCdyhrDY9QlQ24HGRXA7M/fNAv5Co+iE
 g7hAQq1zxadR5rIb4n0fW1i1na0Iv6voRJQ8lNCqex5I8NgKGjBsnUIZj9HNWjqQYEGHKCu6L
 fdlPuavgKOyKQgNJ9DKZu+QwxbJb2q7zjoxj4wYZbldO5FXk1Nzx7oXOCOk/dYMDS1Tw23y93
 2yHdelQO7q+bjtkVi9kxW2Xhp5vuTsLyI2AIBy2BaEHzrdsKg5XFwXOlQfwQmp+XmjVcN/Bau
 UqMmkKeUIDTBeR1JW6+zbX7YuGM9q9CugVBBT21P2HiADQMlB5eTZdQf7iLMw/hmj44iXViX6
 YS0SHUujwVWQ6VQcmrD3+G2X41SKE/9F1qwWKFvd2EM7Vmf6c5oEeE8Lmr7tUd6N+zBOvxb7u
 7gJfVn+VtjPCQx2KgXl+3SH3h30=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Without gcc, the test will fail.

On cleanup, ignore probe removal errors. Otherwise, in case of an error
adding the probe, the temporary directory is not removed.

Fixes: 56cbeacf1435 ("perf probe: Add test for regression introduced by sw=
itch to die_get_decl_file()")
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Georg M=C3=BCller <georgmueller@gmx.net>
Link: https://lore.kernel.org/r/CAP-5=3DfUP6UuLgRty3t2=3DfQsQi3k4hDMz415vW=
dp1x88QMvZ8ug@mail.gmail.com/
=2D--
 tools/perf/tests/shell/test_uprobe_from_different_cu.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh b/too=
ls/perf/tests/shell/test_uprobe_from_different_cu.sh
index 00d2e0e2e0c2..319f36ebb9a4 100755
=2D-- a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
+++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
@@ -4,6 +4,12 @@

 set -e

+# skip if there's no gcc
+if ! [ -x "$(command -v gcc)" ]; then
+        echo "failed: no gcc compiler"
+        exit 2
+fi
+
 temp_dir=3D$(mktemp -d /tmp/perf-uprobe-different-cu-sh.XXXXXXXXXX)

 cleanup()
@@ -11,7 +17,7 @@ cleanup()
 	trap - EXIT TERM INT
 	if [[ "${temp_dir}" =3D~ ^/tmp/perf-uprobe-different-cu-sh.*$ ]]; then
 		echo "--- Cleaning up ---"
-		perf probe -x ${temp_dir}/testfile -d foo
+		perf probe -x ${temp_dir}/testfile -d foo || true
 		rm -f "${temp_dir}/"*
 		rmdir "${temp_dir}"
 	fi
=2D-
2.41.0


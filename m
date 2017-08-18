Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55C21208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751867AbdHRWEg (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:04:36 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:32913 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbdHRWEf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:04:35 -0400
Received: by mail-pg0-f44.google.com with SMTP id t3so43957903pgt.0
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 15:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=85EITgOzq+KYKlc3ouxMlI74eaPM9BrEhjKXpMnbZEU=;
        b=YxPD+A04lk/PGpHZ1lL3AQk60IEponM2zOZyMQFjnu/5OcPAvs1vg7ldAcQlQIgfGd
         MN9JQcUWCTjgYmP4RX8/c9Ku9cekpX6AyCCoqvBtJ8eauZUeT4RgtKmwt8YSP28ERbXz
         TgNPgh3cvK8ZSaRzitMfZ7uv3Ziwjj5Shv/fM6jzYvo1TV2U7yvMRk2Rk97nUMXGUjr2
         VPEjhPUyRVbaMat379GRTcSk/WEZTCTlaAUyKfZYN2H2q0pJA8mrggv1p/CNtq7atVNL
         0zLu5a+bPvbmni/K3w2KAOt6n0Sv9z2L+PHLCDxrMBgJoNi5u6Vs6IMg1n8OKcBPuIoa
         ZaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=85EITgOzq+KYKlc3ouxMlI74eaPM9BrEhjKXpMnbZEU=;
        b=RaHmHBIyIZupvkVmFZnYvE9fnctSprbz4lO+efi33sXzVPnWDP7joPU/f5fPAFiMG1
         /JmV3ZqN0o/GgLmSMh20UgAtmSLzKgKwpHFGlotReZL6f1yycpStxyz2mxRYYR4ajzjX
         Pi/+GYTFx0o1gxLqMz9gE2qMv+5074vSVyNX/2H1CIlxe5AqCHrraAGxW+ZPvI99S9Xg
         dm7qJka5r+NVjuZjJ/mekgikhkLudA3u/573fyQAwJvKNkijQ3fHdEDsHWEgerIudB0S
         VAoDeHctvA9IF2fJAfMlSZQj6jMyARmmG2tE6z1lMiFcH6m+QUMzyaK3GqZBseLSrs+O
         YqmQ==
X-Gm-Message-State: AHYfb5hHdJ3nedJvODaFHJHmHpuVgeC1RrIhAGAsNT12zsQ+YBfLJhKv
        GwARUcMLWWXGk6hr
X-Received: by 10.98.81.1 with SMTP id f1mr9940169pfb.94.1503093874635;
        Fri, 18 Aug 2017 15:04:34 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:3c12:400f:220f:d264])
        by smtp.gmail.com with ESMTPSA id j80sm345218pfe.91.2017.08.18.15.04.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 15:04:33 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, git@vger.kernel.org, larsxschneider@gmail.com,
        sbeller@google.com
Subject: [PATCH] pull: respect submodule update configuration
Date:   Fri, 18 Aug 2017 15:04:31 -0700
Message-Id: <20170818220431.22157-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
In-Reply-To: <xmqqpobsbsk1.fsf@gitster.mtv.corp.google.com>
References: <xmqqpobsbsk1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Do not override the submodule configuration in the call to update
the submodules, but give a weaker default.

Reported-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
  
Personally I dislike this patch, but I have no better idea for the time
being.

Thanks,
Stefan 

 builtin/pull.c             |  6 ++++--
 git-submodule.sh           |  7 ++++++-
 t/t7400-submodule-basic.sh | 22 ++++++++++++++++++++++
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 9b86e519b1..be4f74d764 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -553,7 +553,8 @@ static int rebase_submodules(void)
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
 	argv_array_pushl(&cp.args, "submodule", "update",
-				   "--recursive", "--rebase", NULL);
+				   "--recursive", "--default-update",
+				   "rebase", NULL);
 
 	return run_command(&cp);
 }
@@ -565,7 +566,8 @@ static int update_submodules(void)
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
 	argv_array_pushl(&cp.args, "submodule", "update",
-				   "--recursive", "--checkout", NULL);
+				   "--recursive", "--default-update",
+				   "checkout", NULL);
 
 	return run_command(&cp);
 }
diff --git a/git-submodule.sh b/git-submodule.sh
index e131760eec..6dbc32e686 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -511,6 +511,7 @@ fetch_in_submodule () (
 cmd_update()
 {
 	# parse $args after "submodule ... update".
+	default_update="checkout"
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -552,6 +553,10 @@ cmd_update()
 		--checkout)
 			update="checkout"
 			;;
+		--default-update)
+			default_update="$2"
+			shift
+			;;
 		--recommend-shallow)
 			recommend_shallow="--recommend-shallow"
 			;;
@@ -619,7 +624,7 @@ cmd_update()
 			update_module=$(git config submodule."$name".update)
 			if test -z "$update_module"
 			then
-				update_module="checkout"
+				update_module="$default_update"
 			fi
 		fi
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index dcac364c5f..ff64bf8528 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1289,4 +1289,26 @@ test_expect_success 'init properly sets the config' '
 	test_must_fail git -C multisuper_clone config --get submodule.sub1.active
 '
 
+test_expect_success 'submodule update and git pull with disabled submodule' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	pwd=$(pwd) &&
+	cat <<-\EOF >expect &&
+	-sub0
+	 sub1 (test2)
+	 sub2 (test2)
+	 sub3 (test2)
+	 sub4 (test2)
+	 sub5 (test2)
+	EOF
+	git clone file://"$pwd"/multisuper multisuper_clone &&
+	(
+		cd multisuper_clone &&
+		git config --local submodule.sub0.update none &&
+		git submodule update --init --recursive &&
+		git pull --recurse-submodules &&
+		git submodule status | cut -c 1,43- >actual
+	) &&
+	test_cmp expect multisuper_clone/actual
+'
+
 test_done
-- 
2.14.0.rc0.3.g6c2e499285


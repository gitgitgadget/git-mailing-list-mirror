Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52455202AC
	for <e@80x24.org>; Tue, 11 Jul 2017 14:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932758AbdGKOLa (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 10:11:30 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36841 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755627AbdGKOL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 10:11:29 -0400
Received: by mail-pg0-f68.google.com with SMTP id y129so82004pgy.3
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 07:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F72mUzuxlCPPX7nxU+mwJz4R/fB7avNBQQB1zxy60Rk=;
        b=lhlOEIVyHC31WieIAhRqWTav4b6lTSEfZRj1YFGSk6WV0YUAGdXbqmy2U/YuTX3We+
         z0d7Wtj++rIgCCqOhoUg/ni6/qm13z+Sv0dWDBofiKTE+axHZmvgSRiuvXpQTAC4AWlf
         JLuqDj8ANyE4wYDlp/AUyFHur9boT8sXVft5kE9brojzjEFafMKv0E8J8kJVcmwvZME0
         oMeHLQwJYo5bUG7SYzLJZJ1cyBcpwk/KGuvyhOUlWrkik42f9g3J9kbx8VrJGiawkVJL
         qkRaDEXwKjBJZ/ugvcfDzyDcBpWOWYREsS/hZ2wRug7zssXMgFzeeDUBv4RVnodch7cq
         srIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F72mUzuxlCPPX7nxU+mwJz4R/fB7avNBQQB1zxy60Rk=;
        b=RTyhjKpufzXzd8c1ZqOE+/YkD4sJwigCgouBpgZrbdZgbDA9nyjogvDugQIprKAqJd
         VUpOPJmMvMLEuv4OWNNhD4qsTpss1j1ywV76L3Lgq3Zs5GrTYyAa5jMHwNeukO3MEimF
         yFF+s+CdQsSNjAu92ZuNS0Qe2/cAV+jzgyjE29napWw4hSjL/azZCvUBvi/touzK7uDY
         rnQH9Dq+2Q1tNNVBBRSruMFmfktQ9zwerDIl6tAGGek4fcGHTtzZ22ZbumGnhppwQIAV
         NyZQVnmC4AhaQAMK+4AoiuGIiuD5KEsO8hB/maFA/7OUHCUMfe7JkwkimDglyRwjDNPq
         kHvA==
X-Gm-Message-State: AIVw112146dz8/9bKoUBfadCNRjL0jHp3O05ZHvM6vtAvSQUd3Z2Fc6a
        mesyORv6UyRZ0Q==
X-Received: by 10.99.167.72 with SMTP id w8mr112763pgo.202.1499782289169;
        Tue, 11 Jul 2017 07:11:29 -0700 (PDT)
Received: from localhost.localdomain ([117.249.129.113])
        by smtp.gmail.com with ESMTPSA id i19sm98579pfj.78.2017.07.11.07.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jul 2017 07:11:28 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH 3/4] hook: add sign-off using "interpret-trailers"
Date:   Tue, 11 Jul 2017 19:41:10 +0530
Message-Id: <20170711141111.7538-3-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.13.2.957.g457671ade
In-Reply-To: <20170711141111.7538-1-kaarticsivaraam91196@gmail.com>
References: <xmqqfue45asd.fsf@gitster.mtv.corp.google.com>
 <20170711141111.7538-1-kaarticsivaraam91196@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sample hook to prepare the commit message before
a commit allows users to opt-in to add the sign-off
to the commit message. The sign-off is added at a place
that isn't consistent with the "-s" option of "git commit".
Further, it could go out of view in certain cases.

Add the sign-off in a way similar to "-s" option of
"git commit" using git's interpret-trailers command.

It works well in all cases except when the user invokes
"git commit" without any arguments. In that case manually
add a new line after the first line to ensure it's consistent
with the output of "-s" option.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 templates/hooks--prepare-commit-msg.sample | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
index eb5912163..87d770592 100755
--- a/templates/hooks--prepare-commit-msg.sample
+++ b/templates/hooks--prepare-commit-msg.sample
@@ -32,4 +32,8 @@ SHA1=$3
 # esac
 
 # SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
-# grep -qs "^$SOB" "$COMMIT_MSG_FILE" || echo "$SOB" >> "$COMMIT_MSG_FILE"
+# git interpret-trailers --in-place --trailer "$SOB" "$COMMIT_MSG_FILE"
+# if test -z "$COMMIT_SOURCE"
+# then
+#   @PERL_PATH@ -i.bak -pe 'print "\n" if !$first_line++' "$COMMIT_MSG_FILE"
+# fi
-- 
2.13.2.957.g457671ade


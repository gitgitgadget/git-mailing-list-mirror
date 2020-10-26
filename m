Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C798C5517A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F16872085B
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkD+COFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1793194AbgJZTdC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 15:33:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35800 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1793159AbgJZTc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 15:32:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id h22so2589731wmb.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 12:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3INWQREZtlbKjwYLMGN8xIHxujHJnSCBHYw5p83SoJ4=;
        b=hkD+COFrs1nUl5nNcXrDeqywBPlfPXFoJh7+EpP4WvHGtDW60DMa8+PdNFdQD1iiX9
         KCl11pvRigReFISIwkz+uL3w+8umC7mTz0JOLT4bCT727TBdGKpeJ1M4QPbv+FdLQmz+
         7Wez6mk9eUx2GoEtPm6KkbOOkVMQq/VqAx63INpSNF/Xt22rdr0JBVhexux52WdFS/aX
         vtoIkJsgpJgnshnyqGUPcrm8drk5qDxseKqXl34Mvw/2zX0C5+4+UuId/7fhNzC9dMId
         wYvH8j512KMsNDX9jDcgMl0hOCSJVETz4b2YVQTg6vuOifWknOoNoZjSNQgdBzC/6tm0
         BYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3INWQREZtlbKjwYLMGN8xIHxujHJnSCBHYw5p83SoJ4=;
        b=INKLHIJ3aI9fIQqD98Ede+KyVAdeFDUbSzr9pgDOVrua0SoTGRoU7Pys/Gz+XhpVEU
         njah4U4yuKHfOeom8G5dyJf+PYESio/zjsGBjV/v/tW8v3Z4aMJC0mGGOjRzZaK93uQb
         zBb4eP659Wx9btxXPw0kx5eW96ooP4Vdae9KSK9jhiTjAeCPFWZxJdTC1fpkJMXB646j
         BEqPB5Veli5Di2WoPK9EwUfn9/QYhixblTwc5CHZNgsIONijPZ4uE88okjS8wQtRJzDd
         RAENvwrVk+1KFoXnMISJLuW2pMXfjNtGxCF4TQRaIK4s6LE6NUkn2sWLS8OWN1RmgiOL
         nSqg==
X-Gm-Message-State: AOAM531xpLjSf5es6W3KCbhdfosf2zj9J/9nEg7ODLBSUvpc++vJ/Pmk
        QR2s5IqblRNNxqdjrQvfAX4nPipT5Q0=
X-Google-Smtp-Source: ABdhPJwNS1aZ4i/aX7QsczptZozUJYXOugt9ZPi63Zfc+YtP/EcC1A5WI/xuf+amPlpW8DAxmvzBIw==
X-Received: by 2002:a1c:3503:: with SMTP id c3mr17392506wma.43.1603740777127;
        Mon, 26 Oct 2020 12:32:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d30sm25033304wrc.19.2020.10.26.12.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 12:32:56 -0700 (PDT)
Message-Id: <79cc61f56adf7769521d2e2ba4c27c1a3bbc1d76.1603740773.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.772.git.1603740773.gitgitgadget@gmail.com>
References: <pull.772.git.1603740773.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Oct 2020 19:32:46 +0000
Subject: [PATCH 03/10] t/perf/fsmonitor: improve error message if typoing hook
 name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

Previously - it would silently run the perf suite w/o using
fsmonitor - fsmonitor errors are not hard failures.
Now it errors loudly.

GIT_PERF_7519_FSMONITOR="$HOME/rs-git-fsmonitorr"
./p7519-fsmonitor.sh -i -v

fatal: cannot run /home/nipunn/rs-git-fsmonitorr:
No such file or directory
not ok 2 - setup for fsmonitor

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 t/perf/p7519-fsmonitor.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 4030f569cf..88b3717e2a 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -126,7 +126,9 @@ test_expect_success "setup for fsmonitor" '
 	fi &&
 
 	git config core.fsmonitor "$INTEGRATION_SCRIPT" &&
-	git update-index --fsmonitor &&
+	git update-index --fsmonitor 2>error &&
+	cat error &&
+	[ ! -s error ] && # ensure no silent error
 	git status  # Warm caches
 '
 
-- 
gitgitgadget


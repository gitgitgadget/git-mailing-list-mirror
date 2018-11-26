Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 053541F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 20:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbeK0G64 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 01:58:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36621 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeK0G64 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 01:58:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id t3so20297153wrr.3
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 12:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1NMnukzOBXUG1Sz6WyAbLj72RG+DfgytC9PlA4iqj9E=;
        b=bjeCn6fyW6cJuV9vxJCBuMTRPasBwST/PKZhjEfu4czUoAeL7MDdmt1z6rN+P8KVCc
         vBucbvAeqCRr7r5zNtovDGVrTgFSoQ99s5ZyzdC5yF2RbudmnjFbqUE9V2Ug2NrPRLAD
         KA07z7/Lqe+nkQRkLOkfZ/jGeT+DJSyePOY9YyxyYu9nWsy2+9ouxV7a2nwnlKhvjqhl
         114+Mv5NK6wnlE0MSElPZBqPRnZQ6t8miVM/7AQqOk9sRSsG8kSzeDR8OWVt+E/2cm32
         y1rdq5GvT/7XKWo/UcCjq9zXJK0i/hNnavEyduQsFiUmVRAuysCqQhP+8PnwaB9mb96g
         fJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1NMnukzOBXUG1Sz6WyAbLj72RG+DfgytC9PlA4iqj9E=;
        b=r+JHJBljTtppAwb7aZam1YO06tMkjzBT0AaCdEo5vYCPo5nJ6pfixuuMO8GiS81wcq
         yIDlDGG9wxVtpIZGRUF4jMvMUkyOnNICPY9WApCzkfo8ydhQi48pB4VGgTiwlE+upnQq
         CH/D/3xZeVyEY2P3pwt0vMublgQugdpVBEH/wUry329c0wEcJXPGio5trUl9e2uBVHvP
         71rVKeksHpd5+l4+GGRqoT/O/tMlYWMg2rO92Bpk7s/PFE7LPiducKlu8IIoEZBs0Pxg
         emPyN7ECntye4vPUJsgVIUvm1PCukE8hTLIltZqalUSYkx2RSdKnnMp54HhHiVe+Jza2
         ZuVw==
X-Gm-Message-State: AA+aEWaLZ3tGV9NV/GkdphEc2C5PQa7L+1K/yKpwFXXdk3IzJMQOinQn
        h4y6SnNU6PY6yOUHOGsG3Yc=
X-Google-Smtp-Source: AFSGD/WxG6TVkwC5P3cl17l2xbw66nfloebdKn/HHTTPsw9lYCfDMvzdy6kau6r9jGDwoUdEt1U+DA==
X-Received: by 2002:adf:f308:: with SMTP id i8mr1635504wro.219.1543262621917;
        Mon, 26 Nov 2018 12:03:41 -0800 (PST)
Received: from localhost.localdomain (x4dbe6eb4.dyn.telefonica.de. [77.190.110.180])
        by smtp.gmail.com with ESMTPSA id n9sm1250635wrx.80.2018.11.26.12.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Nov 2018 12:03:41 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t/lib-git-daemon: fix signal checking
Date:   Mon, 26 Nov 2018 21:03:37 +0100
Message-Id: <20181126200337.32462-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.149.g55c2c038c2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test scripts checking 'git daemon' stop the daemon with a TERM signal,
and the 'stop_git_daemon' helper checks the daemon's exit status to
make sure that it indeed died because of that signal.

This check is bogus since 03c39b3458 (t/lib-git-daemon: use
test_match_signal, 2016-06-24), for two reasons:

  - Right after killing 'git daemon', 'stop_git_daemon' saves its exit
    status in a variable, but since 03c39b3458 the condition checking
    the exit status looks at '$?', which at this point is not the exit
    status of 'git daemon', but that of the variable assignment, i.e.
    it's always 0.

  - The unexpected exit status should abort the whole test script with
    'error', but it doesn't, because 03c39b3458 forgot to negate
    'test_match_signal's exit status in the condition.

This patch fixes both issues.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/lib-git-daemon.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index edbea2d986..f98de95c15 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -92,7 +92,7 @@ stop_git_daemon() {
 	kill "$GIT_DAEMON_PID"
 	wait "$GIT_DAEMON_PID" >&3 2>&4
 	ret=$?
-	if test_match_signal 15 $?
+	if ! test_match_signal 15 $ret
 	then
 		error "git daemon exited with status: $ret"
 	fi
-- 
2.20.0.rc1.149.g55c2c038c2


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 219B220248
	for <e@80x24.org>; Wed, 13 Mar 2019 12:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfCMMYp (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 08:24:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52293 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfCMMYn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 08:24:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id f65so1788923wma.2
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 05:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dwBy+CvhEtS19+ruMBS+Xz9lSt8nyOil1SKC09gJAZM=;
        b=seYCFhsnViJOVBU5pxI2+TglyW4/f86IvXCu2UucwIFfecuR1cVBd15vDNWIBv3WyA
         5npgnd4LFwwGAbXVYz+fCzF1PSSqgCGs/MXa/pAG0QleRLUclrVbNCSIyNaPB0x2jke6
         5+AnIin8E5mO50FxavPhkKuwr4eYvfTJlZfOgTnOPutu88t9uCfogvdx5dXYKzwiJQE/
         /noAJ/fDR2NjhZBwF6TTpgRqlT2q03Emo6UcgqtAwn1AadqFuxq8L1ufBc0+emq98mqj
         XLBCP5MBPTcVdka18gjMC7/Bi6RwUQqhjDd6Oyd2QozCwi5l6UObEpjm5+pWOHkpINtr
         GUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dwBy+CvhEtS19+ruMBS+Xz9lSt8nyOil1SKC09gJAZM=;
        b=qYySpMdYe3cCtTWSEIVFfVRL41R5DBr9Lw+XD00cQ7JimV/MZkW1JGrRfv5rXncYWl
         92Yag13KDWJg2SwvMH2DtQWgEfhUnRCoGdyEZYhgf53wWnvvB3VIiqLWWjzbxhtKRDSZ
         s2roy/0hYS2Mz7EO5WGDr8uhvjEo7QE16xIyrKCwCUB2nfyCkyektvOPGDRB2nn704JZ
         So8MZxyaUBy2uz9UzKdmz1jAtuD0+0eE1bhxUN6xYMCllLRKqWV2+erotfwhvR38COi6
         FwYmfwZ/CmnCplVMiS/p3WRnKKAkhSBnDD0nrA/fmSvXorXDZUEq2+BSKMFl1/dDOxvj
         VLRA==
X-Gm-Message-State: APjAAAUGTHVLiRvjHrUCXOPopXpPrm/wB0WyMiNu+IJNPKG0bUuW619S
        RY7GiMLCERd7yCqCxm8+KuyLtfqN
X-Google-Smtp-Source: APXvYqz+QCdo4NIqU78e0bbmwo5h5Ea1BQJnDnRRHpwNCbPVP9i0FKyIkqwfxhaQ0iIgu62Wm7XqBg==
X-Received: by 2002:a1c:cc1a:: with SMTP id h26mr2065053wmb.34.1552479881867;
        Wed, 13 Mar 2019 05:24:41 -0700 (PDT)
Received: from localhost.localdomain (x4d0c2b66.dyn.telefonica.de. [77.12.43.102])
        by smtp.gmail.com with ESMTPSA id t2sm8348287wra.9.2019.03.13.05.24.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Mar 2019 05:24:41 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 02/11] t/lib-git-daemon: make sure to kill the 'git-daemon' process
Date:   Wed, 13 Mar 2019 13:24:10 +0100
Message-Id: <20190313122419.2210-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.499.g4d310c7a8e.dirty
In-Reply-To: <20190313122419.2210-1-szeder.dev@gmail.com>
References: <20190313122419.2210-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After 'start_git_daemon' starts 'git daemon' (note the space in the
middle) in the background, it saves the background process' PID, so
the daemon can be stopped at the end of the test script.  However,
'git-daemon' is not a builtin but a dashed external command, which
means that the dashless 'git daemon' executes the dashed 'git-daemon'
command, and, consequently, the PID recorded is not the PID of the
"real" daemon process, but that of the main 'git' wrapper.  Now, if a
test script involving 'git daemon' is interrupted by ctrl-C, then only
the main 'git' process is stopped, but the real daemon process tends
to survive somehow, and keeps on running in the background
indefinitely, keeping the daemon's port to itself, and thus preventing
subsequent runs of the same test script.

Work this around by running 'git daemon' with the '--pidfile=...'
option to save the PID of the real daemon process, and kill that
process in 'stop_git_daemon' as well.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/lib-git-daemon.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index 79db3b7ae5..6dab8766e7 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -31,6 +31,7 @@ fi
 test_set_port LIB_GIT_DAEMON_PORT
 
 GIT_DAEMON_PID=
+GIT_DAEMON_PIDFILE="$PWD"/daemon.pid
 GIT_DAEMON_DOCUMENT_ROOT_PATH="$PWD"/repo
 GIT_DAEMON_HOST_PORT=127.0.0.1:$LIB_GIT_DAEMON_PORT
 GIT_DAEMON_URL=git://$GIT_DAEMON_HOST_PORT
@@ -49,7 +50,7 @@ start_git_daemon() {
 	mkfifo git_daemon_output
 	${LIB_GIT_DAEMON_COMMAND:-git daemon} \
 		--listen=127.0.0.1 --port="$LIB_GIT_DAEMON_PORT" \
-		--reuseaddr --verbose \
+		--reuseaddr --verbose --pid-file="$GIT_DAEMON_PIDFILE" \
 		--base-path="$GIT_DAEMON_DOCUMENT_ROOT_PATH" \
 		"$@" "$GIT_DAEMON_DOCUMENT_ROOT_PATH" \
 		>&3 2>git_daemon_output &
@@ -88,8 +89,9 @@ stop_git_daemon() {
 	then
 		error "git daemon exited with status: $ret"
 	fi
+	kill "$(cat "$GIT_DAEMON_PIDFILE")" 2>/dev/null
 	GIT_DAEMON_PID=
-	rm -f git_daemon_output
+	rm -f git_daemon_output "$GIT_DAEMON_PIDFILE"
 }
 
 # A stripped-down version of a netcat client, that connects to a "host:port"
-- 
2.21.0.499.g4d310c7a8e.dirty


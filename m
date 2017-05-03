Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9250207B3
	for <e@80x24.org>; Wed,  3 May 2017 03:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbdECD3t (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 23:29:49 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36828 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751932AbdECD3o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 23:29:44 -0400
Received: by mail-yw0-f194.google.com with SMTP id j9so13368985ywj.3
        for <git@vger.kernel.org>; Tue, 02 May 2017 20:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vrJlBSo+/bncGW5tgT5KGiQWbkkdRK1cTMCdbHmh/sQ=;
        b=FKgcQEdwILQ0TKrwlYbvyLrinNVbQPjMb9T/cLhnZz+NmFxhAUX5xyHs88BJ3RzxaG
         Fsboit8c29h54RetJqcE+8f1BZqbggDdggmtTuw1Czv0DX7B1Q22zDHUIC+EpE0OkQ5m
         wqAxB+pkTp5n55DnNEblVUZaF4DbfjrVChJH46kjEDBdEkj21eSK3CjtSssy+yqDU+D1
         gSp2lksUJhxXI2h/TJLf1XQZZV38B95I+6+VOqvY87wWXmTSGoZ5ith0gT5B9weoEUDV
         TazDzDN5ltxR9o97cP2+Za9YDLW85rOb2JCL4CVxivAasY8hThRTXrBjlvNxL02a5L3/
         JUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vrJlBSo+/bncGW5tgT5KGiQWbkkdRK1cTMCdbHmh/sQ=;
        b=ijP3f0ZGwAUkfLs4/iyDYmoJVwFBoSM2IkChy3rfVZSFH7zL1ls+EcdYoYUDyXIPhE
         T/Sbihts22vp+hpT6xTbJpIABaIqMv8b7X7z5p2Q5Kk2pcyOAmV990WtVKUoZlVcYWAK
         3kvfeQraFds6o7ArMvCjYDGLfESHKterqwXW9b/BVFObaD1RU6OnZHKjpWaFT8waeCvQ
         IePUHxjDGNM1Xu79SWQpE7fhF7Xq8/1f3wJF2Tm/MCZ1PCcpWqEqneVZbA6CsYSQoUH0
         PrkZ/sm+EN12gEnUHouQYsWosAWJ42dZ1ByU39J1BeG7xbtYwmDNlcT1OyPf8/txoBHQ
         s5BA==
X-Gm-Message-State: AN3rC/6fX+cRwKH0cUwuLq5h9T/AjPPY1YX8FL5DiWiKPzGgcLLbmFhy
        0LRdcSvJG6aUnQ==
X-Received: by 10.129.124.214 with SMTP id x205mr26906905ywc.8.1493782183342;
        Tue, 02 May 2017 20:29:43 -0700 (PDT)
Received: from localhost.localdomain ([129.59.122.23])
        by smtp.gmail.com with ESMTPSA id v3sm11329586ywi.79.2017.05.02.20.29.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 May 2017 20:29:42 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH 1/7] t7300: skip untracked dirs containing ignored files
Date:   Tue,  2 May 2017 22:29:26 -0500
Message-Id: <20170503032932.16043-2-sxlijin@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170503032932.16043-1-sxlijin@gmail.com>
References: <xmqqshkof6jd.fsf@gitster.mtv.corp.google.com>
 <20170503032932.16043-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If git sees a directory which contains only untracked and ignored
files, clean -d should not remove that directory.
---
 t/t7300-clean.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index b89fd2a6a..948a455e8 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -653,4 +653,14 @@ test_expect_success 'git clean -d respects pathspecs (pathspec is prefix of dir)
 	test_path_is_dir foobar
 '
 
+test_expect_success 'git clean -d skips untracked dirs containing ignored files' '
+	echo /foo/bar >.gitignore &&
+	rm -rf foo &&
+	mkdir -p foo &&
+	touch foo/bar &&
+	git clean -df &&
+	test_path_is_file foo/bar &&
+	test_path_is_dir foo
+'
+
 test_done
-- 
2.12.2


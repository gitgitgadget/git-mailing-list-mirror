Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9ECE20756
	for <e@80x24.org>; Tue, 10 Jan 2017 20:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbdAJUnD (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 15:43:03 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:34483 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751427AbdAJUmt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 15:42:49 -0500
Received: by mail-qt0-f175.google.com with SMTP id l7so128227507qtd.1
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 12:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EPOj5iuDA8uUM4XUtw8pS4XRrAEUMRxxSi55P2PUdoU=;
        b=Bcm49SysHEq0osiRagWg75YJOORt9ILwz/+RkvHNu5KZiUgAxGet2/qsXvkPHFaHMH
         XUYA8jwAq/5pkSkE8KsiUk/zsgzs69VgjcZY5wAlsCom2/3wW/tlQljwEo81ma9w9ajj
         gJVWXrhGBHYDUIpcBjpG78pIKfPP36CDjafrcqo1VzWiaAXa58Q/XrMN+FmypuQgGxjS
         BRZrBFlQeyaJn9+ku2Mtx1/4Ndg+zQpUwxh5aYkftT8Aax07JNhDU25Z+BZn+dxFbqHL
         jkj2fA+jy/lDhXptXy8PX4PiRn1KlmZCojbmpkmKTebAq0/VM1jWuVj2MFmx4vu3eHCV
         bt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EPOj5iuDA8uUM4XUtw8pS4XRrAEUMRxxSi55P2PUdoU=;
        b=pN4UkYYy/EEzN5wJipkSWnWGaSC6mk5r92+X8vaCKe0XwpWzxcutBEhw3xtqLAte9h
         WqhYlrM01usz5DxIOK0FEPa80kP5ro+pfHInRVpmdaagcJ2Z3wpuJmOlXmmDT3eC/nXY
         /45hgX3el0TEqAd13ncRUIZ7/ceq1xLJfyHGX/+SB83OqiyT/BKI6V0fqZshHRuan7TR
         TIB71cgWFMFeHJrhXhCquvGBiXIIjdMuYpRblXaWuVTnAMXxnkq/0wOnVxlyBggxVKUo
         uazY5ZGYbP9RsjQWVklG4w+gQ8utJF0AP7QRHf3cIgtrop6yPrJEHWOLez2jnS9cvsl3
         XrIQ==
X-Gm-Message-State: AIkVDXJfIPEl8lCplqTPU8jRPh1PVZSqps9DAn/1o64AyBHl3NRL+V+57LmcCF5aGZLo/mJW
X-Received: by 10.200.51.186 with SMTP id c55mr4585055qtb.270.1484080968604;
        Tue, 10 Jan 2017 12:42:48 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id z189sm2238137qkb.42.2017.01.10.12.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jan 2017 12:42:48 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, j6t@kdbg.org, hansenr@google.com,
        sbeller@google.com, simon@ruderich.org, gitster@pobox.com
Subject: [PATCH v5 13/14] mergetool: take the "-O" out of $orderfile
Date:   Tue, 10 Jan 2017 15:42:01 -0500
Message-Id: <20170110204202.21779-14-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170110204202.21779-1-hansenr@google.com>
References: <20170109232941.43637-1-hansenr@google.com>
 <20170110204202.21779-1-hansenr@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will make it easier for a future commit to convert a relative
orderfile pathname to either absolute or relative to the top-level
directory.  It also improves code readability.

Signed-off-by: Richard Hansen <hansenr@google.com>
---
 git-mergetool.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index e52b4e4f2..b506896dc 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -421,7 +421,7 @@ main () {
 			prompt=true
 			;;
 		-O*)
-			orderfile="$1"
+			orderfile="${1#-O}"
 			;;
 		--)
 			shift
@@ -465,7 +465,7 @@ main () {
 
 	files=$(git -c core.quotePath=false \
 		diff --name-only --diff-filter=U \
-		${orderfile:+"$orderfile"} -- "$@")
+		${orderfile:+"-O$orderfile"} -- "$@")
 
 	cd_to_toplevel
 
-- 
2.11.0.390.gc69c2f50cf-goog


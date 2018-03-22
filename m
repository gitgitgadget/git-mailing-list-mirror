Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B490F1F404
	for <e@80x24.org>; Thu, 22 Mar 2018 16:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751717AbeCVQ5l (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 12:57:41 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44046 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbeCVQ5j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 12:57:39 -0400
Received: by mail-pl0-f66.google.com with SMTP id 9-v6so5678802ple.11
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 09:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=uqb06WGfSlBVvO4ilj4Ioy3zkZxyQ/eRfl0sMdC80m8=;
        b=YrSwnzrsXmqXxnXhAJUX0UA/MwX4sLW7PKUoOxaQXAQ0iwMgNMKvFCgMCvAm006eiU
         gLYvswvfCCn1+vekIHHfLAIz4x8ivO52OZJF8LzS4hmdigsT9YPyxnBSV+xFJH0tk/lJ
         I4pR6yib2gdMRbWOfMRLJdB6CD9XqvEiiwDBi8EKr394nkASpbAQxvPubtOlRWc30b65
         vM/tbBJSXThVfoBS/5yLSWsqcGZsGHlKBoY10ym/+ONV1xUphpHEPvoZbNV7xm1qYiiS
         ypELfKNHvZixhg2Ba99RGmyo0P9UsjLjM1zlKnJbUtc9i704RnvBpSq4tw83QMerLPba
         P7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=uqb06WGfSlBVvO4ilj4Ioy3zkZxyQ/eRfl0sMdC80m8=;
        b=J+Zb4U8UwAqVIW5xdNymaiybN7UvmfmtshPx/uVJBIMtd/ZkRJVdsGpTIWByZyZf4b
         XFMi8E9WTEGhKgZyCQJy+sUHIHHCS0cLnpN332u6e6hWUrjK52JCbkWAzAKk7HnM1RYP
         vhZY47ZsVKLSdDiGqZEy1BAkmWXEY1wi3wBi2xL9y0b/kKcas6ZeedJ8pTQHLBHCO10y
         Zfe9UNBmp7Djeoqfk/lYmUzZ1YAVnzd8FsK/ChX17SU4mhjwns/S062pAvffYT2JrI+S
         sOAitxTQrnvnogOCKtucvk3Yjmk8JWABiaa9yvi0vbwc2v1/L49CIpcLHOxAzyJNaJXP
         FN7Q==
X-Gm-Message-State: AElRT7HOIkb1kUei3cu2rIW2TjNsYOmqA1A7/ubMJXuOdzHT+W9H+BeA
        Su3pZ2+YDyLcsLdme8Jnf64CgCykvfQ=
X-Google-Smtp-Source: AG47ELuUhO4VidYL8qj80tq6IiRw2kYjNT+Zw8YByvMZ7xGPII1P+zOwqvcX7X1s5XRCRdX1bTJGYw==
X-Received: by 2002:a17:902:3181:: with SMTP id x1-v6mr8474418plb.338.1521737857985;
        Thu, 22 Mar 2018 09:57:37 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id 2sm15043830pfo.70.2018.03.22.09.57.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Mar 2018 09:57:36 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de, gitster@pobox.com
Subject: [RFC PATCH v3 1/9] Simplify pick_on_preserving_merges
Date:   Thu, 22 Mar 2018 09:57:21 -0700
Message-Id: <41b0b34f7d56fd1600dc1dcadd9836f02f139fe3.1521690197.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521690197.git.wink@saville.com>
References: <cover.1521690197.git.wink@saville.com>
In-Reply-To: <cover.1521690197.git.wink@saville.com>
References: <cover.1521690197.git.wink@saville.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Wink Saville <wink@saville.com>
---
 git-rebase--interactive.sh | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 331c8dfea..561e2660e 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -307,17 +307,14 @@ pick_one_preserving_merges () {
 	esac
 	sha1=$(git rev-parse $sha1)
 
-	if test -f "$state_dir"/current-commit
+	if test -f "$state_dir"/current-commit && test "$fast_forward" = t
 	then
-		if test "$fast_forward" = t
-		then
-			while read current_commit
-			do
-				git rev-parse HEAD > "$rewritten"/$current_commit
-			done <"$state_dir"/current-commit
-			rm "$state_dir"/current-commit ||
-				die "$(gettext "Cannot write current commit's replacement sha1")"
-		fi
+		while read current_commit
+		do
+			git rev-parse HEAD > "$rewritten"/$current_commit
+		done <"$state_dir"/current-commit
+		rm "$state_dir"/current-commit ||
+			die "$(gettext "Cannot write current commit's replacement sha1")"
 	fi
 
 	echo $sha1 >> "$state_dir"/current-commit
-- 
2.16.2


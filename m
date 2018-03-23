Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D096D1FAE2
	for <e@80x24.org>; Fri, 23 Mar 2018 04:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeCWEkD (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 00:40:03 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37953 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751823AbeCWEkC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 00:40:02 -0400
Received: by mail-pf0-f196.google.com with SMTP id d26so4295391pfn.5
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 21:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=x8NtKPr4VGXIHC35+IkDP12M0p2R9r/1F6y0tBTUX7o=;
        b=hCsgenBnJjpebVG82TLr2rtV+ayesI6u1CbhdzxKAJuDEQKTNHfMdJDDiqiUssBTBu
         DOdfAcf36aGxjrl4l2lpcO1saVawJvkGYGnX5TpCg1IcH+kvWwXsgNgiG+Rcg9XdWlck
         M/x3LIzPqnZVDZa9NRO29ihTm79cBXlBlLVoStIwBmqcWJEfxg1sHdqD83ckJWYnglWI
         VGsEhQkn5fBTNRO/QKDstrYdpY4i9Tol0rmBcMSjChGluMMY857tpu001v5kHk/z+c/m
         A3DzOG7qoSNBRd75n0Ze4ELWbjxyOYCCVwKk16k9MBybKQ6Gnt5XYn/QBUw2aVakqV9H
         7GBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=x8NtKPr4VGXIHC35+IkDP12M0p2R9r/1F6y0tBTUX7o=;
        b=A7O7dbHmHhc/I+DSwJGakBBYZhtSq2U2IiJEoo1lFqNOwBJC3AzpaDvGH02tBq2UlQ
         p2p61IZWU5/NgFv2O5C7AUDr95w8QgoLkJGnZfkH7JIkkkkSRTXvuRs+luI76JLMA60J
         N9xlKwQITC9sL0lzGzj1nuqF7duHmya7Bq2YBoxGSzEnZU7zdx43neHEhjAW8r0mfWrk
         oPjVVMlVTDkgNEXb/zIKPQqgTS+TPmSVITLGFVE3KK+HXZ0rw0+ffydAqzmDLawrRXOZ
         97AJhQcaBUD6gH6D66jBev3bMzJJsXhqoBgGYetExl7s1eCbSqK3YTQxqHeNPf1/KCh6
         dq+Q==
X-Gm-Message-State: AElRT7EuK82Qyuc9bo4PTb9xd/vBcI7cEXxxUg2VfVqizQ77OVteg8/z
        /xHCO9pee60hzamWnjGLsPQ0pGtEGrw=
X-Google-Smtp-Source: AG47ELuPTOEUILL+6sBQr/+77zAcpZK3/cL3W/2jAxJKfDnS/0kHR50ga9pzYEyBsMrH0ytP9zI0ow==
X-Received: by 10.167.131.135 with SMTP id u7mr22709261pfm.50.1521780000797;
        Thu, 22 Mar 2018 21:40:00 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id l22sm16069901pfj.98.2018.03.22.21.39.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Mar 2018 21:39:59 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de
Subject: [RFC PATCH v4] rebase-interactive: Simplify pick_on_preserving_merges
Date:   Thu, 22 Mar 2018 21:39:52 -0700
Message-Id: <c49af83f3ca3d180cbd101d62eccc3b021373d9b.1521779249.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521779249.git.wink@saville.com>
References: <cover.1521779249.git.wink@saville.com>
In-Reply-To: <cover.1521779249.git.wink@saville.com>
References: <cover.1521779249.git.wink@saville.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use compound if statement instead of nested if statements to
simplify pick_on_preserving_merges.

Signed-off-by: Wink Saville <wink@saville.com>
Reviewed-by: Junio C Hamano <gister@pobox.com>
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


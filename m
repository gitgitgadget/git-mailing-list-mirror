Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7D8C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhLIFQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbhLIFPv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:15:51 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F87C061B38
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:12:18 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id j21so4284975ila.5
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dd2LMQUo+ZGzDrQAOLPbJYrY2QuAptJKsPI4itd+OTQ=;
        b=hLUY9SVHEhdR9WUKlK6SCjq+AcZ/7rybqMsuWqdQtO8UQ0trM0Cwotahda5vIvK3jv
         uCXaHOj2yA6TiOT39HXxJuPFAfzDoJwG758Pv5iPwL1/kewNvXBfxDBlW2QejJ05O+KY
         qjpd2BLX1SNS9ESyhrjs3sxl8beGTih3nDhYR+3jwL6G0+TtF2y98sQ6BZ1wCLLUD6ep
         rsB/dPi9QTXMBw1KQ+3B3PNm6Fbcf2JrReGFsZZte0hSAg59u1IW2lQ+z/JZXTsR4cj2
         /UjrZto+Hqz78KFVQ5quWn4kJICXIXvjnfENYQXc9T8O64xF0P42vMmYVbZeYB7g78um
         NQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=dd2LMQUo+ZGzDrQAOLPbJYrY2QuAptJKsPI4itd+OTQ=;
        b=0kzNylR1HnH5zubZg4DxIQBEVSROL0vaz4CfUE/iloU9B6/YASnIBAi5zf/YT9/Lng
         5X9C1L61MR/F8MkTI7QuwgwSzNH51Wis5T4nkGU6PRSOQcPnIvVhv4lkiMumM2U01VaB
         DV+EHLQ0zME7tddQpDFGpDpz1Mc4Wt+awrw7l9ofzaIIXLqi9et3CGNIWuROntU+QVgr
         llxYO5y3KxTKasIJJPhKGv+QKWl1BjBezvyPd2cWi8LMQy09wIH2jytRdzbGHCZpxl5t
         h5Qvv19AkE0VmYR7IvxxBGq2q+4T6SPPQUSk5HTBiNxRahPDxFp7SUpm8iKTv60b4/8V
         umkw==
X-Gm-Message-State: AOAM533UmZzosNT6nLbmarn55OJjXsq6qVtyoujaC2vQ/M2+9s9dh202
        j2aq3JMTOwCpqfVf4aK1FZi94KMkRV3Jtg==
X-Google-Smtp-Source: ABdhPJyb/xPIdBqDokdzL+WddinXbT/fnrIVE+u6LT5bNpYwM8q3galIfCl79pwe81g6dEjTXRUSMg==
X-Received: by 2002:a92:c012:: with SMTP id q18mr12186657ild.216.1639026737811;
        Wed, 08 Dec 2021 21:12:17 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id b8sm3127401iow.2.2021.12.08.21.12.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 21:12:17 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <ericsunshine@gmail.com>
Subject: [PATCH 13/19] tests: apply modern idiom for signaling test failure
Date:   Thu,  9 Dec 2021 00:11:09 -0500
Message-Id: <20211209051115.52629-14-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd
In-Reply-To: <20211209051115.52629-1-sunshine@sunshineco.com>
References: <20211209051115.52629-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplify the way these tests signal failure by employing the modern
idiom of making the `if` or `case` statement resolve to false when an
error is detected.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t2102-update-index-symlinks.sh | 2 +-
 t/t3402-rebase-merge.sh          | 8 ++++----
 t/t3700-add.sh                   | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t2102-update-index-symlinks.sh b/t/t2102-update-index-symlinks.sh
index 22f2c730ae..9b11130ab9 100755
--- a/t/t2102-update-index-symlinks.sh
+++ b/t/t2102-update-index-symlinks.sh
@@ -25,7 +25,7 @@ test_expect_success \
 'the index entry must still be a symbolic link' '
 case "$(git ls-files --stage --cached symlink)" in
 120000" "*symlink) echo pass;;
-*) echo fail; git ls-files --stage --cached symlink; (exit 1);;
+*) echo fail; git ls-files --stage --cached symlink; false;;
 esac'
 
 test_done
diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index cfde68f193..7e46f4ca85 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -68,7 +68,7 @@ test_expect_success 'merge and rebase should match' '
 	if test -s difference
 	then
 		cat difference
-		(exit 1)
+		false
 	else
 		echo happy
 	fi
@@ -102,7 +102,7 @@ test_expect_success 'merge and rebase should match' '
 	if test -s difference
 	then
 		cat difference
-		(exit 1)
+		false
 	else
 		echo happy
 	fi
@@ -117,7 +117,7 @@ test_expect_success 'picking rebase' '
 		echo happy
 	else
 		git show-branch
-		(exit 1)
+		false
 	fi &&
 	f=$(git diff-tree --name-only HEAD^ HEAD) &&
 	g=$(git diff-tree --name-only HEAD^^ HEAD^) &&
@@ -127,7 +127,7 @@ test_expect_success 'picking rebase' '
 	*)
 		echo "$f"
 		echo "$g"
-		(exit 1)
+		false
 	esac
 '
 
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 23c3c214c5..6902807ff8 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -177,7 +177,7 @@ test_expect_success 'git add --refresh' '
 	git read-tree HEAD &&
 	case "$(git diff-index HEAD -- foo)" in
 	:100644" "*"M	foo") echo pass;;
-	*) echo fail; (exit 1);;
+	*) echo fail; false;;
 	esac &&
 	git add --refresh -- foo &&
 	test -z "$(git diff-index HEAD -- foo)"
-- 
2.34.1.307.g9b7440fafd


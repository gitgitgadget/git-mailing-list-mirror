From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 3/5] submodule update: add test for recursive from non root dir
Date: Fri, 25 Mar 2016 11:39:14 -0700
Message-ID: <1458931156-29125-4-git-send-email-sbeller@google.com>
References: <1458931156-29125-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, Jens.Lehmann@web.de, jacob.keller@gmail.com,
	sunshine@sunshineco.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 25 19:39:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajWdw-0005K8-LE
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 19:39:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982AbcCYSj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 14:39:27 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35338 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbcCYSjY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 14:39:24 -0400
Received: by mail-pa0-f47.google.com with SMTP id td3so50990339pab.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 11:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9fP1FDh9IwtI3eG3swd565xLAatX8YqpNTJw3b9VEIg=;
        b=NoNttZ8EpHaRPlBNbdA6ZPfXil4rdadUJ5hvhsNPvvbCYhJtnS2e7kAt4Qa/3vKyas
         xbB7MDpuog7bE8ALpeHkvIbWEhUfZiNbaNn0TWhxClmJ0bDh1ajFZ9LiFQ3Ulk/3+6Fk
         KwaOYIc3zbK1QDt1PFv+yqORjQgmUGeXNW+2mqQXpjkn+z/pkJaLmYIyHg7+Iqk0wY5l
         VWmAHg5f4j0G+qfRO3IP/VPWTaqio5DUzqRDVqmZQlEUeTwwJGw+rgeNISugpYXnvTlv
         r8Z8j9svFva51ovHKaz4X6Y+lK1TpbaBzmYGoGbJGpxnVE9PEOgA3MZSWGFe1HE4d618
         e8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9fP1FDh9IwtI3eG3swd565xLAatX8YqpNTJw3b9VEIg=;
        b=V2gRmsMKAVWkSedfxZeY0VLtMx5vK+s/OePH84vNoilyRXgDGFFQMQb/Oa2ypyHjcK
         RzFzN+HnK871x47ZwVgAch584bjFALXiaTNbb3f9srq0cSXXDysTCuZCp3P8+TrWICPt
         BZEQyEZ2TxZDtO7hF/oc+LYd3yiqZUrM8tLFBNXxGBxBJ0TDSLRNwS+VRC/M4eTe9fbD
         jbt1RtSEwvplc1A7yHtkLt9DCssxBbslLtK8Ldprxb6xYqUTC+zMuGSbEAjpnpT5ynDO
         5u3wpn+JH75/Sixh3I+LWK5wHFvc5zuwoJhT1+QzWeYwZgtHCE0Kf2gyYZIkzTMrGGEQ
         6yYA==
X-Gm-Message-State: AD7BkJKnF/d5pf0iFjltt+6DcvsFT2zutdoY0xBTXlvJh4+pq6QyRTZJTVymrQ/TjGc4nFTe
X-Received: by 10.66.100.228 with SMTP id fb4mr22814030pab.84.1458931163165;
        Fri, 25 Mar 2016 11:39:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:e4a5:c9cf:82bb:5195])
        by smtp.gmail.com with ESMTPSA id p75sm17955435pfi.29.2016.03.25.11.39.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 25 Mar 2016 11:39:22 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.10.g52f3f33.dirty
In-Reply-To: <1458931156-29125-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289937>

Test "submodule update --recursive" being invoked from a
sub directory as this is currently not covered by the test
suite.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7406-submodule-update.sh | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 68ea31d..19d8552 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -767,11 +767,19 @@ test_expect_success 'submodule update clone shallow submodule' '
 
 test_expect_success 'submodule update --recursive drops module name before recursing' '
 	(cd super2 &&
-	 (cd deeper/submodule/subsubmodule &&
-	  git checkout HEAD^
-	 ) &&
+	 git -C deeper/submodule/subsubmodule checkout HEAD^
 	 git submodule update --recursive deeper/submodule >actual &&
 	 test_i18ngrep "Submodule path .deeper/submodule/subsubmodule.: checked out" actual
 	)
 '
+
+test_expect_success 'submodule update --recursive works from subdirectory' '
+	(cd super2 &&
+	 git -C deeper/submodule/subsubmodule checkout HEAD^
+	 mkdir untracked &&
+	 cd untracked &&
+	 git submodule update --recursive >actual &&
+	 test_i18ngrep "Submodule path .../deeper/submodule/subsubmodule.: checked out" actual
+	)
+'
 test_done
-- 
2.8.0.rc4.10.g52f3f33.dirty

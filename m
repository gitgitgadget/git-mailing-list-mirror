From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 6/6] submodule update: test recursive path reporting from subdirectory
Date: Tue, 29 Mar 2016 15:23:48 -0700
Message-ID: <1459290228-9069-7-git-send-email-sbeller@google.com>
References: <1459290228-9069-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, jacob.keller@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 30 00:24:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al23f-0002PT-GJ
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 00:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754361AbcC2WYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 18:24:10 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35795 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757877AbcC2WYC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 18:24:02 -0400
Received: by mail-pa0-f42.google.com with SMTP id td3so24061596pab.2
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 15:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7kI6Xmx6+ckDa9xxxUfn3apNkoPEPmgrL+C9pmV+NLo=;
        b=W170oiBIVCBbfneWgP300vNUvUWUQ1Md+YcbMmtVxV5GsliNbAmPp6l1EyvmF91/c3
         PjAd5DMbpWRrGyMOQVr9d6GZFNaxUZUyGuTJrJmphRUnH0+4LySl5NnXgmDPdpw0VO2A
         ZQwIk1uNHL13fuYThGjyXFg3hEBWrQgP6HUC9g6HFkAuARs/gPiEwkyb66PdO41VKr7l
         XpiZU9rB6e8W09IPZK+RLAKb47dbrWTFryYi5cPdLns0E/xcfvHyzSd84YO/DzPV4q5F
         xiUk7O3XzgrwvnDehq/tIvqU0VG75lImj0kbg7oIja/xjT4B+You/AKGpdPSQQ2ZZSYZ
         3Clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7kI6Xmx6+ckDa9xxxUfn3apNkoPEPmgrL+C9pmV+NLo=;
        b=NBfhp6Y5B7utfU+7D8B0CAkmVOz186wU60S60agayhR8JHroEfnb1vniTsiaKyTw7U
         oWfadw0i6BwC4VDieK865L5xI0mUC2wuJ4dYo2+r2HVfi41LzaZdWd253hbAJa/LV2sM
         5kDcB+qHI2SlnuIwNLS9Llw3MKARfvfYZrSkDJfSIoEF/QUgMTnL8pGkrVL3ZaOErZtq
         U7vCmlqTsmj3eH6AlZwpT+VZ2aPKuPy1255wrW23a2w/YHy1JejMn8jPiVOABdWXqM35
         2i5MNLVOSkGM48YN6sCFt3bNE35RIHfg1V389nRst5srMZOtXSfKKJkHI8RoVEIqGlME
         Kk1A==
X-Gm-Message-State: AD7BkJIVtTtOVHO6YL0beev2lOB+lwJOEbMWivywfLTGvRqZdYzzIYeUUkLCQcadEAvRyJm4
X-Received: by 10.66.66.167 with SMTP id g7mr1140767pat.111.1459290241444;
        Tue, 29 Mar 2016 15:24:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3dd0:2ad7:f302:a06])
        by smtp.gmail.com with ESMTPSA id x18sm662067pfi.42.2016.03.29.15.24.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 15:24:00 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.4.g5639dee.dirty
In-Reply-To: <1459290228-9069-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290209>

This patch is just a test and fixes no bug as there is currently no bug
in the path handling of `submodule update`.

In `submodule update` we make a call to `submodule--helper list --prefix
"$wt_prefix"` which looks a bit brittle and likely to introduce a bug
for the path handling. It is not a bug as the prefix is ignored inside
the submodule helper for now. If this test breaks eventually, we want
to make sure the `wt_prefix` is passed correctly into recursive submodules.
Hint: In recursive submodules we expect `wt_prefix` to be empty.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7406-submodule-update.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index f062065..239d31f 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -379,6 +379,27 @@ test_expect_success 'submodule update - command in .git/config catches failure -
 	test_cmp actual expect
 '
 
+cat << EOF >expect
+Execution of 'false $submodulesha1' failed in submodule path '../super/submodule'
+Failed to recurse into submodule path '../super'
+EOF
+
+test_expect_success 'recursive submodule update - command in .git/config catches failure -- subdirectory' '
+	(cd recursivesuper &&
+	 git submodule update --remote super &&
+	 git add super &&
+	 git commit -m "update to latest to have more than one commit in submodules"
+	) &&
+	git -C recursivesuper/super config submodule.submodule.update "!false" &&
+	git -C recursivesuper/super/submodule reset --hard $submodulesha1^ &&
+	(cd recursivesuper &&
+	 mkdir -p tmp && cd tmp &&
+	 test_pause &&
+	 test_must_fail git submodule update --recursive ../super 2>../../actual
+	) &&
+	test_cmp actual expect
+'
+
 test_expect_success 'submodule init does not copy command into .git/config' '
 	(cd super &&
 	 H=$(git ls-files -s submodule | cut -d" " -f2) &&
-- 
2.8.0.4.g5639dee.dirty

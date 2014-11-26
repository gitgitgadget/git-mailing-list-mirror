From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3] branch -d: test if we can delete broken refs
Date: Wed, 26 Nov 2014 10:37:04 -0800
Message-ID: <1417027024-17054-1-git-send-email-sbeller@google.com>
References: <54755F7C.3010803@web.de>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: mhagger@alum.mit.edu, gitster@pobox.com, tboegi@web.de,
	jrnieder@gmail.com, ronniesahlberg@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 26 19:37:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XthSn-00074k-Aa
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 19:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110AbaKZShK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 13:37:10 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:37056 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812AbaKZShI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 13:37:08 -0500
Received: by mail-ie0-f177.google.com with SMTP id rd18so3170919iec.36
        for <git@vger.kernel.org>; Wed, 26 Nov 2014 10:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wp0xcPsz9R1HrWr+Xm+eEpfeU8nOHHyoqU4v/7U+OFE=;
        b=DVCLg0Wai0B99/I5eKVtYbCS1RcqSGz8zLs44027eoibMeGTIkbWB9XKEwjXllkFe9
         e715EWN6FrU3FJ5wuo+3ddJ+yMbdKqiz4cyBSZVS9YilWsq2zjXcBpxokL1NgLKkZiB9
         tKpdjfvy+cvKkBPqhqGp/Tj876l6o7ztm8/kn8rdQlp58r+xsS384cQEFI3LNOZonVua
         G78QaeWvCEJcnVxFMEIfzx27DVM/GaFlr6IAmw2fPZ8aTB0UzcJ8YTHISDMAVXeN6vVA
         rzeBY6puY3KVZl5ssnULGDj7LyYihhv3tUEuWycRS8+Y/SL67XX14C6uRJsvo8nfhIA+
         JM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wp0xcPsz9R1HrWr+Xm+eEpfeU8nOHHyoqU4v/7U+OFE=;
        b=U/4S/+3kAv933F+zwLmgLfjf2OQShWvNpTAlP43EC94F9TajE8tFKVcaiKxcMonMwm
         gfeK5yKP82LrajwKdnXF2wonCds38gmcCFthDISv1yQqPLFBVQGiTln4OvXaY6nsrwWr
         SsbZ3cKw98PgBY4vNzGOw9Bnn2HXlewKseotzVSTUfzpfoIN9Vw5zVQ30yhu2acW3aVh
         36d4EZE97GgHDWZCTjrTB/lnBBKPhJStj9ecZqaglFWBWiW7jvYf+MEy/Id++J5qdo4r
         spuSFgcC0l64L8Dh6unuZymr6Ljf+nKn3P59ut83YHFnY7Iq9Q/nBvUhgsYD5EUOKzW0
         rvCA==
X-Gm-Message-State: ALoCoQkFYJb9AGnrJy+A8VuRL8PzZIRyydnH0A2j4KQtTJrIM3AWAaGC5KN6GNYAWKgg/0Cxoxi+
X-Received: by 10.42.136.133 with SMTP id u5mr35357616ict.33.1417027028080;
        Wed, 26 Nov 2014 10:37:08 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:6d15:6789:c0e7:ce68])
        by mx.google.com with ESMTPSA id kd5sm7939579igb.20.2014.11.26.10.37.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 26 Nov 2014 10:37:07 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc3
In-Reply-To: <54755F7C.3010803@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260290>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
Changes v1->v2
 * relocated the test from t1402 to t3200
 * reword the commit message title to fit in with similar commits touching 
   t/t3200-branch.sh 

Changes v2 -> v3
 * remove space nit pointed out by Michael
 * simplified grep expression as pointed out by Torsten
 
 I don't mind applying this one later as part of the series, where we actually
 introduce the feature. Thanks for all the feedback! 

Michael writes 
> On the other hand, this is kind of an "aspirational test"; I don't
> know that the tested functionality has ever worked or that anybody has
> ever claimed that it works. So my feeling is that the addition of the
> test would feel more natural in the patch series that implements the new
> feature. But I don't feel strongly about it.

 I don't have a strong oppinion on this one either. It's just my impression, that
 small single patches are digested easier by the mailing list rather than large series.
 So as the feedback is in, I'll put this patch at the end of the series, where the actual
 feature will be introduced.
 

 t/t3200-branch.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 432921b..fa7d7bd 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -163,6 +163,14 @@ test_expect_success 'git branch --list -d t should fail' '
 	test_path_is_missing .git/refs/heads/t
 '
 
+test_expect_failure 'git branch -d can delete ref with broken sha1' '
+	echo "pointing nowhere" >.git/refs/heads/brokensha1 &&
+	test_when_finished "rm -f .git/refs/heads/brokensha1" &&
+	git branch -d brokensha1 &&
+	git branch >output &&
+	! grep brokensha1 output
+'
+
 test_expect_success 'git branch --column' '
 	COLUMNS=81 git branch --column=column >actual &&
 	cat >expected <<\EOF &&
-- 
2.2.0.rc3

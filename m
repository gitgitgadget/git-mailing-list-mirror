From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/6] submodule update: test recursive path reporting from subdirectory
Date: Tue, 29 Mar 2016 16:02:37 -0700
Message-ID: <1459292558-5840-6-git-send-email-sbeller@google.com>
References: <1459292558-5840-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, jacob.keller@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 30 01:03:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al2f6-0000Wh-As
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 01:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758335AbcC2XCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 19:02:55 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33008 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758176AbcC2XCw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 19:02:52 -0400
Received: by mail-pf0-f170.google.com with SMTP id 4so26206169pfd.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 16:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G/gmshz3oNIYKplxIHVPaRqbbCVuZm2lPSieyej201I=;
        b=M55bzeBA861eZsK88eHfwM2aD6ckztb87MLF9MwesaBdvvbodsJHctn8C89niLLI3Y
         /pfX6xHURL4RoUgaEjPBpIOvWtVHcFnI3w9hewEknLHp/84s5wROmbJGHLvqcLPM/s1/
         CV+aKvRt7KO5WBRSFxqvTcGwyznwtgHvx8lr/oNjDG/+Nj12rh7RHwwmrR8s9wMcJfIw
         oSHxikclbinam0a8eMkH1oUpZPRilXSKUDjkKc5EI7PNmvKGX6Lhav9YZpXXNgPRtpEM
         Qy21bBuHMoWMLysFtenqYlrcko15Q4egr3R1yYgDmQE3GpNKiCDKreAhDAYXbVzDc3ep
         oU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G/gmshz3oNIYKplxIHVPaRqbbCVuZm2lPSieyej201I=;
        b=kTz1ULv/KX4uuVeRCurirV6ff/xRrlku6TyMYLnjNzspQa5wPXEgUCco46v0xTaBO4
         ehmFeIYBUsRZvSCtqWaJ3ROFXzFbILaoIJD5FCUWMFu2RtqhcxyqYN54oOwimwsebAy1
         Te6dFqLQtJgRbEKm0SlqRkWe+AmiPhyZ7XPjUU81kvO8dYxcHC+qWTOgbs3lF/odclyg
         BWIx4WNOYQUcFCY+RC+UIs/k+nKdoWDrbvu1saaxfF+JT+FOPnO0Ge57uaIBfBmM0w01
         RmJBx8vbx6hHNEXpq8HX8WAw+HM1+HwrLTPMTNCT+LRnPQxQKtioW8BPQUREqmMadPj2
         SOmw==
X-Gm-Message-State: AD7BkJJVD9Xmp+PQJ6Uldj4wpDbw3fYnlJ++NJSbIbfHlMPdHQbG1eO0IDgxEv3qwI+mVV4A
X-Received: by 10.98.89.129 with SMTP id k1mr7621609pfj.66.1459292570828;
        Tue, 29 Mar 2016 16:02:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3dd0:2ad7:f302:a06])
        by smtp.gmail.com with ESMTPSA id p85sm779314pfj.16.2016.03.29.16.02.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 16:02:50 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.6.g3d0b0ba
In-Reply-To: <1459292558-5840-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290218>

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
 t/t7406-submodule-update.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index f062065..6dcf2d4 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -379,6 +379,26 @@ test_expect_success 'submodule update - command in .git/config catches failure -
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
+	 test_must_fail git submodule update --recursive ../super 2>../../actual
+	) &&
+	test_cmp actual expect
+'
+
 test_expect_success 'submodule init does not copy command into .git/config' '
 	(cd super &&
 	 H=$(git ls-files -s submodule | cut -d" " -f2) &&
-- 
2.8.0.6.g3d0b0ba

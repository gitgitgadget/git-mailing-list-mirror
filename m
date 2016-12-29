Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B81D4200E0
	for <e@80x24.org>; Thu, 29 Dec 2016 10:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752431AbcL2KXq (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 05:23:46 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33346 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752346AbcL2KXp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 05:23:45 -0500
Received: by mail-wm0-f67.google.com with SMTP id u144so65808765wmu.0
        for <git@vger.kernel.org>; Thu, 29 Dec 2016 02:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eeN7jUxgjAaGEZrYPiFK13gSO+SDv3WR75wAzZgRgAQ=;
        b=BICZoYyJJAMrGx3gGBZIrviwDpYDa6fVPb6ZyDyWKdzBnu5zFlzYnc+6k6cQWwSGuE
         vy0sgErJqeYOCpFw0GcEE9VGCoc67BTAfg57/AqMwBZD0BP7SdR+2IFNBDr1CfNhq8FI
         NFkYs2RGgBpRC+ExwIHHZoPmqCBREd3bABQA3WpCAlUTmZd5z6M36OjL/yUzqh9CKuUV
         ktvWgYRtIqYv1TH8er7EHTnpv7Tibvk2gz7LiJdDSOJkDkKOQbzBFSEngJuG1yD+wOCJ
         9kfdgaGUrkd+njW5ddHUfEtGqAfxbgjOObCcTQya5q8WZHYhrQPLZ1L3cNUH1aPc23a1
         7ZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eeN7jUxgjAaGEZrYPiFK13gSO+SDv3WR75wAzZgRgAQ=;
        b=HnS9ZO13eafq6A7pqftb8wR5qBdbw2+jK/zesWRleip+JktmgfoKxa7MJ4ogZTwpp9
         aGbk7fHKVz65od5sAai0FLAmtnpKw5qeCfJ9u0XtJriy+HRzmY9U5kX6XB92iEP+R+2c
         5HoSp1Hy9OhKzTxIf24PIzxLu6YVDx93+1NF1+1CqdaUKDefG5bzJ0v8GSWUP//X765H
         KFk/Lv75fVDuNamSPGgzfrCv5haYFyO8HUcyd/kowJz0qhA3n0dMrUXzG88MPUgmpfvb
         QJ2we3q0pLWKdr6Vmj7/0tSpPowKokCbvaEffgZjngm0e1YOvA0NI1CNJ9gWTcYIp+9n
         CyRA==
X-Gm-Message-State: AIkVDXIktGxve3p6APV33KrwsPGAuFQcTngBN4c1bTl5beg3mRsbbfbrygwZ9cJwkUP4Aw==
X-Received: by 10.28.176.200 with SMTP id z191mr36956247wme.17.1483007024348;
        Thu, 29 Dec 2016 02:23:44 -0800 (PST)
Received: from localhost.localdomain ([77.123.83.51])
        by smtp.gmail.com with ESMTPSA id js10sm68174104wjb.19.2016.12.29.02.23.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Dec 2016 02:23:43 -0800 (PST)
From:   Igor Kushnir <igorkuo@gmail.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>,
        Ori Rawlings <orirawlings@gmail.com>,
        Igor Kushnir <igorkuo@gmail.com>
Subject: [PATCH v2] git-p4: do not pass '-r 0' to p4 commands
Date:   Thu, 29 Dec 2016 12:22:23 +0200
Message-Id: <20161229102223.6028-1-igorkuo@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-p4 crashes when used with a very old p4 client version
that does not support the '-r <number>' option in its commands.

Allow making git-p4 work with old p4 clients by setting git-p4.retries to 0.

Alternatively git-p4.retries could be made opt-in.
But since only very old, barely maintained p4 versions don't support
the '-r' option, the setting-retries-to-0 workaround would do.

The "-r retries" option is present in Perforce 2012.2 Command Reference,
but absent from Perforce 2012.1 Command Reference.

Signed-off-by: Igor Kushnir <igorkuo@gmail.com>
---
 Documentation/git-p4.txt | 2 ++
 git-p4.py                | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index bae862ddc..7436c64a9 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -479,6 +479,8 @@ git-p4.client::
 git-p4.retries::
 	Specifies the number of times to retry a p4 command (notably,
 	'p4 sync') if the network times out. The default value is 3.
+	Set the value to 0 to disable retries or if your p4 version
+	does not support retries (pre 2012.2).
 
 Clone and sync variables
 ~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/git-p4.py b/git-p4.py
index 22e3f57e7..7bda915bd 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -83,7 +83,9 @@ def p4_build_cmd(cmd):
     if retries is None:
         # Perform 3 retries by default
         retries = 3
-    real_cmd += ["-r", str(retries)]
+    if retries > 0:
+        # Provide a way to not pass this option by setting git-p4.retries to 0
+        real_cmd += ["-r", str(retries)]
 
     if isinstance(cmd,basestring):
         real_cmd = ' '.join(real_cmd) + ' ' + cmd
-- 
2.11.0


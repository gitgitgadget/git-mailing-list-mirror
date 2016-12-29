Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CB3B200E0
	for <e@80x24.org>; Thu, 29 Dec 2016 09:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752589AbcL2JGt (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 04:06:49 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35826 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbcL2JGr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 04:06:47 -0500
Received: by mail-lf0-f66.google.com with SMTP id x140so17457414lfa.2
        for <git@vger.kernel.org>; Thu, 29 Dec 2016 01:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TiWlMwZ5jM3aUjKSfx/LJNgHZEqjwvr+tlSzKF/Y2UI=;
        b=qBao/PBcCDqCHIM04+oikS3JNmB4Ve9LVheU54R4s0CRxnjr+c40T2jkhibKcE354D
         x87zYBwW622iiDOXs9pmoRVR5KLz8FRE/hm2vsxXKAs/pJOu/8qWFnupRm84ENLzqYgU
         1LuYMhzo94CH2a6Ti4LJvVqhwGiFBvFdFHi8dijKFV0RlmPt++qSwWEdCfOu2M3BWAAU
         k++4D3o+tQe8txxltPQQHm/JiKKhS0pV0tUZzQC6j3q1m47WMdlOhiCCpwz/FCSVchDs
         PhylnsS2N4wftEppTfJJoqsbXXqe8Cs1HKRdMZQLzxUfe3k0Q+cuH3RpTTsjm1Be9ybr
         6u5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TiWlMwZ5jM3aUjKSfx/LJNgHZEqjwvr+tlSzKF/Y2UI=;
        b=qPppwSzn+httrQLaer9OnlpH2lOWrP0ryXfjaoLnzv9NztWx9QRHja7qCal8i3jC1E
         SPM7ExN7nP726LugV3gxynnuikziB/NaX8d5Mp+kLGJRPlhA5/C1gDLsEvn4ERfCPLJL
         IsFSW5xcVNlatelMIiU6i9qsM5QzvWwEVUmwdQgC8yOtvW2l6pWvh2KOVUDR8gs39E3H
         bMyKaQfC1TBni2nR+SdRfNkbOuHzZyPiDCTfVRuWGZGpPMfA9w232W7dfZWPyvP3ZLpM
         rgRAF+8OKoRcUTX3GV11tF/hR5wwRG4VqjRQ60YtopMsSx9gg5oo4HCqRqFuHOkRFsSu
         74uw==
X-Gm-Message-State: AIkVDXIY5vLEuc3WhFcJBacFoXMeY+QKZNI+LYYyr5FAXba4RHGMfWgdILJneX3XYsMIQA==
X-Received: by 10.25.76.194 with SMTP id z185mr15135888lfa.182.1483002402295;
        Thu, 29 Dec 2016 01:06:42 -0800 (PST)
Received: from localhost.localdomain ([77.123.83.51])
        by smtp.gmail.com with ESMTPSA id z9sm12897969lja.1.2016.12.29.01.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Dec 2016 01:06:41 -0800 (PST)
From:   Igor Kushnir <igorkuo@gmail.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>,
        Ori Rawlings <orirawlings@gmail.com>,
        Igor Kushnir <igorkuo@gmail.com>
Subject: [PATCH] git-p4: do not pass '-r 0' to p4 commands
Date:   Thu, 29 Dec 2016 11:05:33 +0200
Message-Id: <20161229090533.4717-1-igorkuo@gmail.com>
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
 Documentation/git-p4.txt | 1 +
 git-p4.py                | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index bae862ddc..f4f1be5be 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -479,6 +479,7 @@ git-p4.client::
 git-p4.retries::
 	Specifies the number of times to retry a p4 command (notably,
 	'p4 sync') if the network times out. The default value is 3.
+	'-r 0' is not passed to p4 commands if this option is set to 0.
 
 Clone and sync variables
 ~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/git-p4.py b/git-p4.py
index 22e3f57e7..e5a9e1cce 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -83,7 +83,9 @@ def p4_build_cmd(cmd):
     if retries is None:
         # Perform 3 retries by default
         retries = 3
-    real_cmd += ["-r", str(retries)]
+    if retries != 0:
+        # Provide a way to not pass this option by setting git-p4.retries to 0
+        real_cmd += ["-r", str(retries)]
 
     if isinstance(cmd,basestring):
         real_cmd = ' '.join(real_cmd) + ' ' + cmd
-- 
2.11.0


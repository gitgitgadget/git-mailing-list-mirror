From: Kevin Wern <kevin.m.wern@gmail.com>
Subject: [PATCH 2/2] Resumable clone: add endpoints for prime clone (Draft)
Date: Wed, 18 May 2016 22:07:30 -0700
Message-ID: <1463634450-28265-3-git-send-email-kevin.m.wern@gmail.com>
References: <1463634450-28265-1-git-send-email-kevin.m.wern@gmail.com>
Cc: Kevin Wern <kevin.m.wern@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 07:08:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3GC6-0007ev-TS
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 07:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbcESFIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 01:08:13 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34792 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbcESFIL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 01:08:11 -0400
Received: by mail-pa0-f50.google.com with SMTP id qo8so25288838pab.1
        for <git@vger.kernel.org>; Wed, 18 May 2016 22:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VNKTzeKd+JoWQzXUZF62ik5IwDKaz8xImUAMpJ8Mwm8=;
        b=dXOwuHsDKbaQoezkHygONqxxfKO8PoOO65RBxA7ED8uu8HSPZSG32PbcT/fO1tdBfG
         lL6PnPEHPxLDB9PEsOPoKqk3z0ciCZkuK/84Y1sNkYCpqEkjSTiva0e6xOEso7YOeQP9
         7w8LJfcgOUQLorfIscTqEMiF1kZS6hEYTVSxGnYRwVv8DdEIWSycgFMP9IwN8lPQT85Z
         LdvCMFG+bEk+X6ISBsDjteQA5bUoIpqnTo4pIDDhbpO9kFULAFTfWYC40PIJPM4AzGIu
         s8i5KpNS1K1RN1pE1++ULeNWe6cj+F9m7iFbQKoPX8k4QmRejrajnVGicTHRZ00pTbOV
         3EIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VNKTzeKd+JoWQzXUZF62ik5IwDKaz8xImUAMpJ8Mwm8=;
        b=aLPTsmwXchUIT9WpjN61cGCgcpMYd36cB1GeziPJsSQbwtBbSSoayQpFLUOUeR7Ama
         wFU3/K4c689bAbR860+pBi5t4DckLN6lrymaaEMlVu1Cj33epzGZSrd/5YGteCpD2Rlr
         Hl5ejwDQwEB0EtkJkgXo1EF0NZx2+fFe0YxFuINFTuLA9v+5NGk7+FLBcb1SpLP6PbpU
         92rhYfTsOe3CLyTazJNLAbb5A/1MNX1MXvEZ9a4HTOmZvbZNf9eprTYzaat/DuDrBTuM
         lsMIKqsB9Wcm9b4A6SbnIqkVC/8AlEJW0b2aMv0Ku4iE35QLP00+oNIj6dq1/wrEN5M3
         GLTg==
X-Gm-Message-State: AOPr4FU5iKYhQsX3Lc3AyiW6zXVWOcfQCYvRAozn4is3FHM1CifwFzkQSQPMYGTJY+jcCA==
X-Received: by 10.66.254.1 with SMTP id ae1mr16641052pad.32.1463634490325;
        Wed, 18 May 2016 22:08:10 -0700 (PDT)
Received: from localhost.localdomain (47-35-3-42.dhcp.snlo.ca.charter.com. [47.35.3.42])
        by smtp.gmail.com with ESMTPSA id to9sm16078985pab.27.2016.05.18.22.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 May 2016 22:08:09 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1463634450-28265-1-git-send-email-kevin.m.wern@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295042>

Add endpoints for prime-clone in http service and git daemon
---
 daemon.c       | 7 +++++++
 http-backend.c | 1 +
 2 files changed, 8 insertions(+)

diff --git a/daemon.c b/daemon.c
index 8d45c33..2ddc7f7 100644
--- a/daemon.c
+++ b/daemon.c
@@ -475,10 +475,17 @@ static int receive_pack(void)
 	return run_service_command(argv);
 }
 
+static int prime_clone(void)
+{
+	static const char *argv[] = { "prime-clone", ".", NULL };
+	return run_service_command(argv);
+}
+
 static struct daemon_service daemon_service[] = {
 	{ "upload-archive", "uploadarch", upload_archive, 0, 1 },
 	{ "upload-pack", "uploadpack", upload_pack, 1, 1 },
 	{ "receive-pack", "receivepack", receive_pack, 0, 1 },
+	{ "prime-clone", "primeclone", prime_clone, 0, 1 },
 };
 
 static void enable_service(const char *name, int ena)
diff --git a/http-backend.c b/http-backend.c
index 2148814..a338e2a 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -27,6 +27,7 @@ struct rpc_service {
 static struct rpc_service rpc_service[] = {
 	{ "upload-pack", "uploadpack", 1, 1 },
 	{ "receive-pack", "receivepack", 0, -1 },
+	{ "prime-clone", "primeclone", 0, -1 },
 };
 
 static struct string_list *get_parameters(void)
-- 
1.9.1

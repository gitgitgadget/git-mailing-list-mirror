From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/6] remote.c: simplify a bit of code using git_config_string()
Date: Wed, 20 Mar 2013 18:14:56 +0530
Message-ID: <1363783501-27981-2-git-send-email-artagnon@gmail.com>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 20 13:44:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIINZ-0001lB-03
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 13:44:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758253Ab3CTMn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 08:43:58 -0400
Received: from mail-da0-f48.google.com ([209.85.210.48]:42852 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201Ab3CTMn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 08:43:57 -0400
Received: by mail-da0-f48.google.com with SMTP id p8so966111dan.35
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 05:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Gr5LlsBAil0V4mNMJ/Xa7xEdA7z03SCUbgptvMXw5pM=;
        b=qHtiSjOkSR2aITQSqcIk8CkNV3X+VygXuX2LT3zsc2hEhnhCUxm3r7P1WCvlS3hxqe
         lWxPCN13/RCN4jaM1bpQL4DLcxvQ6JdiF+8YdP+XDEzRhpbo6677xa9eOS5IPP/hMTQQ
         6rFSEtV9vfhEyunVXqEth9xy+foK8X/BbyjEMYx7n7SFdfj2bHdbX6E0wpHO9CoxIcNV
         jvWspuHRXclS/+IM5tZrO9tTmuve0iVftd3Z1XLLnvswDo3IrEqTJEPlh2jSR0WD70Rc
         WFbwit9h0cvHuMu3Rdw/gQFtuyiMOwfnRxh21ZVhGAyFLwYwOolDVPb7NyeDHdgmnn05
         nEXQ==
X-Received: by 10.68.211.225 with SMTP id nf1mr8702591pbc.104.1363783436433;
        Wed, 20 Mar 2013 05:43:56 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id y13sm2031559pbv.0.2013.03.20.05.43.53
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 05:43:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218600>

A small segment where handle_config() parses the branch.remote
configuration variable can be simplified using git_config_string().

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 remote.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index e53a6eb..45b69d6 100644
--- a/remote.c
+++ b/remote.c
@@ -356,9 +356,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 			return 0;
 		branch = make_branch(name, subkey - name);
 		if (!strcmp(subkey, ".remote")) {
-			if (!value)
-				return config_error_nonbool(key);
-			branch->remote_name = xstrdup(value);
+			git_config_string(&branch->remote_name, key, value);
 			if (branch == current_branch) {
 				default_remote_name = branch->remote_name;
 				explicit_default_remote_name = 1;
-- 
1.8.2

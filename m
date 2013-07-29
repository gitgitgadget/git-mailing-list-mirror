From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 4/4] name-rev: ease up condition
Date: Mon, 29 Jul 2013 21:49:58 +0200
Message-ID: <1375127398-31904-5-git-send-email-stefanbeller@googlemail.com>
References: <1375127398-31904-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 29 21:50:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3tSM-0001Dj-4k
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 21:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754183Ab3G2Tt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 15:49:58 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37545 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab3G2Tt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 15:49:57 -0400
Received: by mail-wi0-f171.google.com with SMTP id hr7so1833932wib.4
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 12:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=sVHRYuz6ODZgxOcHTtYJJYoaCJPFs3qxhmzMcG/KhaQ=;
        b=t/hoXj3m3B1X9PAk5haKprBd8ZPy+9ssC54/1U1WsrL99/3MoRs5T8qoYB6nZJxh0B
         84v8CL4j9pG2vImFgxKyGlVNb6kaWKYMgrpzuf74+TVTORUQNycN9/cd4WL42GT9QqIK
         6pCKlJiflf3seJ2BBHYI/f0Df13DLNGi5xqNRGO6WeaDb79/tDoF9GysES9af297O/eI
         HxWLKihn5mhowye/jM+2Lip1X7l5hKwvK4lIosSjfkd8VoSqMGHtdgjgunzSqp397zFa
         r0Y/1Lko+66vxcADtn8ZadopAYHw2M09eq9tDedtPIH5oqZZUBuca3trE987I2jkUiZa
         TP0A==
X-Received: by 10.180.198.79 with SMTP id ja15mr8150797wic.36.1375127395989;
        Mon, 29 Jul 2013 12:49:55 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id v9sm10540824wiw.8.2013.07.29.12.49.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 12:49:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.1.g8f6a3e5
In-Reply-To: <1375127398-31904-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231327>

Now that the internal variables 'all' and 'transform_stdin' are read in
by OPT_BOOL, which makes sure to have the variable being 0 or 1 after
reading, we do not need the double negation to map any other value to
1.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/name-rev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index a908a34..20fcf8c 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -331,7 +331,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, opts, name_rev_usage, 0);
-	if (!!all + !!transform_stdin + !!argc > 1) {
+	if (all + transform_stdin + !!argc > 1) {
 		error("Specify either a list, or --all, not both!");
 		usage_with_options(name_rev_usage, opts);
 	}
-- 
1.8.4.rc0.1.g8f6a3e5

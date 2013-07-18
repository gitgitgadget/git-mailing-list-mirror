From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 3/3] apply, find_name_traditional: Do not initialize len to the lines length.
Date: Thu, 18 Jul 2013 23:35:27 +0200
Message-ID: <1374183327-14939-3-git-send-email-stefanbeller@googlemail.com>
References: <1374183327-14939-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 23:36:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzvrl-0004oH-Di
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 23:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965392Ab3GRVfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 17:35:39 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:47982 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965387Ab3GRVfg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 17:35:36 -0400
Received: by mail-wi0-f182.google.com with SMTP id m6so3708118wiv.3
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 14:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NLPTkIYYWajX+Maeo8+2FDtdupTKp63hVcbJpjcgsOE=;
        b=UgKL404F2QJR2icYKHT5satZeTnC6LFq3VvDpjMxx9S0G4QV0pOfylK6XfiPCsCN+B
         kqOp4dRBdbCPmuZ/Xu6NcpVgYZqvFbkijNWKfJcXfO3TE5q1PTpBpInxVLgw0Ppf5d5K
         ibCjsw4la1md5FJAcgaPHkdBAoPmi4EWNztuQAvs2sSTth9DdFRdpLRIRWrsSF+vYXfE
         PwQPOyMFXMZqK0aOCAnN2i3LGFjjBcDLAGvkH0gjx/AeE93VLc1DKDumbyGTZsA4pylT
         P1I3kMg9IuG5+58Yck7ZuXFzxBMHedC4dmMLrC73rrKxds9g0ozm77iXIYRCgl76N1fl
         /Ciw==
X-Received: by 10.180.9.242 with SMTP id d18mr20493589wib.18.1374183335777;
        Thu, 18 Jul 2013 14:35:35 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id b20sm19248230wiw.4.2013.07.18.14.35.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 14:35:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.3.754.g9c3c367.dirty
In-Reply-To: <1374183327-14939-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230751>

The variable len is set to
len = strchrnul(line, '\n') - line;
unconditionally 9 lines later, hence we can remove the call to strlen.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 1218688..681a40b 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -722,7 +722,7 @@ static char *find_name(const char *line, char *def, int p_value, int terminate)
 
 static char *find_name_traditional(const char *line, char *def, int p_value)
 {
-	size_t len = strlen(line);
+	size_t len;
 	size_t date_len;
 
 	if (*line == '"') {
-- 
1.8.3.3.754.g9c3c367.dirty

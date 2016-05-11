From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 64/94] builtin/apply: make parse_traditional_patch() return -1 on error
Date: Wed, 11 May 2016 15:17:15 +0200
Message-ID: <20160511131745.2914-65-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:20:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U4H-00044c-RF
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbcEKNUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:20:43 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36626 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932299AbcEKNUk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:40 -0400
Received: by mail-wm0-f66.google.com with SMTP id w143so9353567wmw.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eIFVN27H51+Z4XfZiS31JiupujXm+bcWSua9NhHPByU=;
        b=l40jsBVkXp0Fy6U8U5SlBMOkKQ+C4uMVdQzeDvg/j6I31Z1b5qIACM4PJvVzZOFxKA
         T4x4aGgbkWPG7IuHnRFDfKXkf9QRmnRmFQwFj7ptWUqGZhv4NwNkVsN0/PPHpe71iyxi
         ma6Iu60+ufBBMvAN/8QKvGlemCI9yfRfUe0LKxMOXSDX5ddKf/gfdgcg/ZpSvJpnv8PK
         bhJ7e/Du8iRy5xxCj4ooTMnVcZaGMmaUH2mWZqBvAsmejBMVrgIxcyEjuoXo6b0rMUUW
         wIDZ2MNnFogdVAT0USruWmenqeO4KrPlBqCAsilnb6vFVanqjsid6b/z8pOXAYH1StCx
         3ipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eIFVN27H51+Z4XfZiS31JiupujXm+bcWSua9NhHPByU=;
        b=dOa+2aQV6ISMNVKUn+bclQj6oIy9Jsnwb656yo/v7YDixAiutb54nkDGIuIHeQlu+F
         q6kHhFkhxdSfXBV+EwCoVJVvuuS9JJHMpDzmKFOHzcl0D/pIo4Yyf5FOaSoQJQmKUP9B
         6zIChO5jTFFgA8Do0Cywsb9aVGKRf50P1LDWrbEIurl20dK7OhCw5/5Lwv43IPKSNv+I
         KbpiZ9poRFu9rr4BQe69BN3/3Wu/oOvvV1g1jEZIf2txT+vKc7qnFP67Y8zRE/omqESS
         rsF/9oophFdiwEPAw+5yIuFfUv5Xb0n0jxSoOmgsL4QnY69Hj3mj4wceHfuF1i8r3rwG
         7YTg==
X-Gm-Message-State: AOPr4FVXE1G+B13/AIDfg162GYz6jUoverBRcpokCn7srbIDbU+V3P5epv++aybo86a4/A==
X-Received: by 10.194.22.8 with SMTP id z8mr3742272wje.102.1462972839053;
        Wed, 11 May 2016 06:20:39 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:38 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294285>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", parse_traditional_patch() should return -1 using
error() instead of calling die().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index dd212c9..8e82eea 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -755,10 +755,10 @@ static int has_epoch_timestamp(const char *nameline)
  * files, we can happily check the index for a match, but for creating a
  * new file we should try to match whatever "patch" does. I have no idea.
  */
-static void parse_traditional_patch(struct apply_state *state,
-				    const char *first,
-				    const char *second,
-				    struct patch *patch)
+static int parse_traditional_patch(struct apply_state *state,
+				   const char *first,
+				   const char *second,
+				   struct patch *patch)
 {
 	char *name;
 
@@ -803,7 +803,9 @@ static void parse_traditional_patch(struct apply_state *state,
 		}
 	}
 	if (!name)
-		die(_("unable to find filename in patch at line %d"), state->linenr);
+		return error(_("unable to find filename in patch at line %d"), state->linenr);
+
+	return 0;
 }
 
 static int gitdiff_hdrend(struct apply_state *state,
@@ -1462,7 +1464,8 @@ static int find_header(struct apply_state *state,
 			continue;
 
 		/* Ok, we'll consider it a patch */
-		parse_traditional_patch(state, line, line+len, patch);
+		if (parse_traditional_patch(state, line, line+len, patch))
+			return -1;
 		*hdrsize = len + nextlen;
 		state->linenr += 2;
 		return offset;
-- 
2.8.2.490.g3dabe57

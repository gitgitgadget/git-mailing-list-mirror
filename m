From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 27/94] builtin/apply: move 'p_context' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:38 +0200
Message-ID: <20160511131745.2914-28-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:24:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U7f-0007yq-72
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbcEKNTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:19:25 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36742 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932147AbcEKNTW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:19:22 -0400
Received: by mail-wm0-f65.google.com with SMTP id w143so9346096wmw.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NYtOUL5djCIjDrYRhs1JpUwo7yZ98CkRirpoqzx7UJ0=;
        b=WdhyGUWdYIMbkFvcln1TZlgnseEG9XZHI6/Incaq3SLV5s4KwKptbPAf3JNpeO2cNy
         zYGEjY0fDBPfji6hUTpt04VLcdyVBSIpSUm/iVbEAOFY72UuwGRmQhKS7ZSOFvEk4cFb
         tu3lAgPq2SXLfeLFSm48hJETQpiItTRSiLslOCvepki2xhP+2DoemIlOMk26N7T5SDAh
         n7GpVSulH+UktGdtvvaoD77JmLzgOv9ZbDGoUJj2M8W3m2QtFWQcZvu4/7q25j+198nA
         ZfdxAV1d0m5rYi+kctKN7lgBrRNAzaaSCzRrzWwW6SXcnLpqrnJN/HYJ4ho8VXte90WG
         J6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NYtOUL5djCIjDrYRhs1JpUwo7yZ98CkRirpoqzx7UJ0=;
        b=ERorg51sCo5zwPJQmp71dLIJVXIKGOsg3CMwO2YGAkpuAK2wC7ddyxCB1IpUG6gijx
         /c2vbU6yt+SEceDUw0EAQv690xIawgR4P2X20WnPiGv5oAo4peXzb/tPDUC5Htiix2Ds
         WHclKZfZfq1UslWHHeMVDuTYWmigMTQDp8R5W9v5hnTWxQZ65RcA0uT7VyFc1Hxn+dfA
         l31THi6YjlFtzagK2yrg9HmZSOipZ/3NEPAJRT8CQ0rZn1kMQrWcS5ios+uUCnXXZQWJ
         AWnw+fWIQ7nGevWQtBbM39C2ulPv8dzXbkpz5pC2t7fcMjegBFVqMOlT1TH6TkmpJFu7
         C2bA==
X-Gm-Message-State: AOPr4FUA0Gz0mADU7IakagGnpetNlJTQKBvFeuwUBv7aB2hakvA8jNJ20OVFarcMukiyqA==
X-Received: by 10.194.11.36 with SMTP id n4mr4076958wjb.10.1462972760690;
        Wed, 11 May 2016 06:19:20 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:19:20 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294329>

To libify the apply functionality the 'p_context' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 6f9a090..2ba2b21 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -57,6 +57,8 @@ struct apply_state {
 	int update_index;
 	int unsafe_paths;
 	int line_termination;
+
+	unsigned int p_context;
 };
 
 static int newfd = -1;
@@ -64,7 +66,6 @@ static int newfd = -1;
 static int state_p_value = 1;
 static int p_value_known;
 static int apply = 1;
-static unsigned int p_context = UINT_MAX;
 static const char * const apply_usage[] = {
 	N_("git apply [<options>] [<patch>...]"),
 	NULL
@@ -2880,7 +2881,7 @@ static int apply_one_fragment(struct apply_state *state,
 			break;
 
 		/* Am I at my context limits? */
-		if ((leading <= p_context) && (trailing <= p_context))
+		if ((leading <= state->p_context) && (trailing <= state->p_context))
 			break;
 		if (match_beginning || match_end) {
 			match_beginning = match_end = 0;
@@ -4574,6 +4575,7 @@ static void init_apply_state(struct apply_state *state, const char *prefix)
 	state->prefix = prefix;
 	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
 	state->line_termination = '\n';
+	state->p_context = UINT_MAX;
 
 	git_apply_config();
 	if (apply_default_whitespace)
@@ -4631,7 +4633,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		/* Think twice before adding "--nul" synonym to this */
 		OPT_SET_INT('z', NULL, &state.line_termination,
 			N_("paths are separated with NUL character"), '\0'),
-		OPT_INTEGER('C', NULL, &p_context,
+		OPT_INTEGER('C', NULL, &state.p_context,
 				N_("ensure at least <n> lines of context match")),
 		{ OPTION_CALLBACK, 0, "whitespace", &whitespace_option, N_("action"),
 			N_("detect new or modified lines that have whitespace errors"),
-- 
2.8.2.490.g3dabe57

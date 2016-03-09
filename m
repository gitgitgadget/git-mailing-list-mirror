From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 22/48] builtin/apply: move 'unsafe_paths' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:48:50 +0100
Message-ID: <1457545756-20616-23-git-send-email-chriscool@tuxfamily.org>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 18:53:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiIL-00086h-HR
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:53:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933730AbcCIRxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:53:08 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37795 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933551AbcCIRw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:52:59 -0500
Received: by mail-wm0-f49.google.com with SMTP id p65so81810635wmp.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kM/wfUjdiD27z1FXgvdTQy390Di85mFPCkXIeU5jHXw=;
        b=sSBWQOk/AH8KChAyu7T2W6/EqZvdvUi2XADlODO/8eCMd14bvE5HlrFYWrqqpoMLm+
         Hi3WQChljvQRQS5t7+/2o3PBjd/NKvsuLHh+I9fLcRuHsJ/IHQpSlFqRFUwu2CR158e1
         z4gchF8VBZgLkcgxyWZNuwZnyYFclLMTvuUkaY+vhUDJ41thuBzaWQ0BmN37EngqCcHs
         aTlia7vPyq7jvD45Btrw7p0ExioZ5iEDliPLSdzZWupEMUcyQsGu0RtE4t9W8fGQt6u7
         CqmRV59HNZ/2UWHih54Ip6erBy2HhcWOlzy5HTYPRU0WLOcQYmUdgPrBS1mEXx4gwa5I
         SelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kM/wfUjdiD27z1FXgvdTQy390Di85mFPCkXIeU5jHXw=;
        b=Na029McOyeXWfR7DYGwmc+rbk4jq2T7b7zTlY8Imiifla7it4DpLSCDDBR0FbMcwKb
         W4CM38DrjPbTtPDTNkgl6X1vX7wpGx3ocdaojTc1aVXChHM7gHGnHCDN06a6vFUyYqGy
         osRHQldWs/iSEZB++V8kp4fc2QRcV0MoC+c9tV+d7fc1NoVI89edFRinR4b0jqR29nVa
         xaTQExAqycFNUqUX3NeZ52jC3V9c2Bge57jeMfCs+QmKIZlFuuY7zbOrHEFzWEmQ0YNE
         xRA+TC9Lb3dUf9rzo7Iwcf8H36eQrzS9UhsQIAY/ejigNa8ZuMqSt18fmgj7JscKwE8/
         FpWg==
X-Gm-Message-State: AD7BkJIzIVk6hcjINSeuiT+w2MRwqwYfRg4VuFRuhcmDw17oG+UrqvDg4w/BRTLJhOiJBQ==
X-Received: by 10.28.174.8 with SMTP id x8mr362403wme.49.1457545977881;
        Wed, 09 Mar 2016 09:52:57 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:52:57 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288509>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index ae734cf..0c2fa2e 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -58,6 +58,8 @@ struct apply_state {
 	int unidiff_zero;
 
 	int update_index;
+
+	int unsafe_paths;
 };
 
 /*
@@ -67,7 +69,6 @@ struct apply_state {
 static int p_value = 1;
 static int p_value_known;
 static int apply = 1;
-static int unsafe_paths;
 static const char *fake_ancestor;
 static int line_termination = '\n';
 static unsigned int p_context = UINT_MAX;
@@ -3844,7 +3845,7 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 		}
 	}
 
-	if (!unsafe_paths)
+	if (!state->unsafe_paths)
 		die_on_unsafe_path(patch);
 
 	/*
@@ -4610,7 +4611,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("make sure the patch is applicable to the current index")),
 		OPT_BOOL(0, "cached", &state.cached,
 			N_("apply a patch without touching the working tree")),
-		OPT_BOOL(0, "unsafe-paths", &unsafe_paths,
+		OPT_BOOL(0, "unsafe-paths", &state.unsafe_paths,
 			N_("accept a patch that touches outside the working area")),
 		OPT_BOOL(0, "apply", &force_apply,
 			N_("also apply the patch (use with --stat/--summary/--check)")),
@@ -4688,7 +4689,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		state.check_index = 1;
 	}
 	if (state.check_index)
-		unsafe_paths = 0;
+		state.unsafe_paths = 0;
 
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
-- 
2.8.0.rc1.49.gca61272

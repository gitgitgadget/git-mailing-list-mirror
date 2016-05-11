From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 24/94] builtin/apply: move 'unsafe_paths' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:35 +0200
Message-ID: <20160511131745.2914-25-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:19:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U31-0002X8-Eh
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbcEKNTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:19:18 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34720 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103AbcEKNTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:19:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id n129so9412767wmn.1
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iPIP8Po7VYxWb0+ixGcVW++LcuNr7BczGsK4FgPsi+I=;
        b=euoZ8Cqd8HAElZygq0TY6dqBNUN6ORdLaKeeDBRYccUI7QjQtMG6Yjs+ryndjp6F59
         Uo54WymcTl6QZOtlgrd7J6TI6WY10H5xGGMxlCKhuM/OBFdE2I61UzwBZS4auLvrL3zi
         d4+EVVACaoiFElJrtWxLHXNLksdrEQ35q3gfEu3thR0kSJaXWUCWKbeJR7x1YcCbU8b+
         ZnXIovADpXv+zd09oiTxl/tI3io0ezdODL+cMoDTjdF8u37WgLF8XT+xbZkr892gscOn
         c2dmCeO0JK+I2CR4mgwCMHPd8pMQnoVv8YY1Cp+fYBhuc00QxxDy/m+MDlIC7TaVa1Ze
         qcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iPIP8Po7VYxWb0+ixGcVW++LcuNr7BczGsK4FgPsi+I=;
        b=leEffa074UCuX1fKrQXL4CT+goGF1ORhSyhGItnCVgHPjXt5/V516IgM47l8yXUibx
         gXelXjHy0+oj4lrO14OnZ+3G5D/SOyIs5c7Fl9Qr0GtHQhiPW3sbzvSNAjbHLOn53Jpw
         Kjq4fH8v0EnGygN4tBGQnHcbNrZJiS5jwwIVNYxd+H7Ap+ZBkQ2zooer65jD8Gs9R1Gd
         EtMPfv6cb2O1NZqnc8k7ZN++ZY78+4Ilxdd/3lhreAf9B9RWTKde9LVYX/7fUrLZkI9G
         CyrOA9o0/2xOck3gaFh6QHE6ODJvYvSiKeGEVDadzIbYRLN9IpAgXOu09guxiHmu8XcA
         +Ksg==
X-Gm-Message-State: AOPr4FWiZJyet9CppmRVI05yzm5QjLY6Y2wRwnpV2Ka3tVhbfmSxdYtzx+pCBN5lDWysbg==
X-Received: by 10.28.39.196 with SMTP id n187mr4314895wmn.4.1462972754738;
        Wed, 11 May 2016 06:19:14 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:19:13 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294259>

To libify the apply functionality the 'unsafe_paths' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index d699cd9..9209af4 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -54,6 +54,7 @@ struct apply_state {
 
 	int unidiff_zero;
 	int update_index;
+	int unsafe_paths;
 };
 
 /*
@@ -64,7 +65,6 @@ static int newfd = -1;
 static int state_p_value = 1;
 static int p_value_known;
 static int apply = 1;
-static int unsafe_paths;
 static const char *fake_ancestor;
 static int line_termination = '\n';
 static unsigned int p_context = UINT_MAX;
@@ -3837,7 +3837,7 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 		}
 	}
 
-	if (!unsafe_paths)
+	if (!state->unsafe_paths)
 		die_on_unsafe_path(patch);
 
 	/*
@@ -4621,7 +4621,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("make sure the patch is applicable to the current index")),
 		OPT_BOOL(0, "cached", &state.cached,
 			N_("apply a patch without touching the working tree")),
-		OPT_BOOL(0, "unsafe-paths", &unsafe_paths,
+		OPT_BOOL(0, "unsafe-paths", &state.unsafe_paths,
 			N_("accept a patch that touches outside the working area")),
 		OPT_BOOL(0, "apply", &force_apply,
 			N_("also apply the patch (use with --stat/--summary/--check)")),
@@ -4690,7 +4690,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		state.check_index = 1;
 	}
 	if (state.check_index)
-		unsafe_paths = 0;
+		state.unsafe_paths = 0;
 
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
-- 
2.8.2.490.g3dabe57

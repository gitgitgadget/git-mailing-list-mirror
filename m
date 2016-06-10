From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 14/44] builtin/apply: make parse_traditional_patch() return -1 on error
Date: Fri, 10 Jun 2016 22:10:48 +0200
Message-ID: <20160610201118.13813-15-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:13:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSoG-0004Rt-Bd
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbcFJUMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:12:03 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33343 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932212AbcFJUMA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:00 -0400
Received: by mail-wm0-f65.google.com with SMTP id r5so1068179wmr.0
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7PcQTpdeoI+5VPRcHC1vZm1eg7llja+3Ab/ruKfQOAQ=;
        b=OxPSHqP93qTeyPhJYn3f0YfWWsYAE71TTnF9N0/ja39abBJDwMOSC0xoONAw/yt/Ub
         rLyZk6SVV73xYZm40pEIYKYCH8ITk0MiU6O9efSvXQv/7Hqu9vyufKkPexYVdU6Pk8/U
         Jzpi7i++H/7eDRTj9NS5Hd2m89++87xlw+7aAl75XRGinpA8ALPy3zIrySVqo+Oo3fGn
         6wk2j9L1R37IKO0s5QTE54nYj05H84DwxVnFZQ3gQzA2JjHZh8/VEztjWvEYEj9XQWsj
         0jVOwdQEhRjiLP6UPq+UQ0SmTF4QPw7hJIDRlmJTo25x7MooSmhiJ/TFWCClEv1/vjAM
         K4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7PcQTpdeoI+5VPRcHC1vZm1eg7llja+3Ab/ruKfQOAQ=;
        b=XqSBVEJ+pN4eooXviuhA+09SgJLQzdO5sS3A3hvICYAtOsL6gfs1lcEUokJAm7c4aY
         05weEWHq2N+wqZhBLVFfFSn2dgOyaWNt1TcOmrphVvrMbKycLVvtoQyw0cwgoODI3Fyv
         KJ+JPpcTuO3T/BDKVxxu9hKjf3O/rMlwtacYFDRfN1/wBk/k17/cQZwWvhc5xWw01O4S
         PQ9cIk7psq22LGEHC5b15zs8VkDGyc3T2oPUMSmhKgp5JA9buNo48W0AxJuQN2iP2ryg
         GHSZgxy0T70UW81OFYyHr5Md7rsYH6M2nT8YiKjS5FB7v4rri3+TD+Fv7q81Yug1dix2
         nqXQ==
X-Gm-Message-State: ALyK8tKOXQnhWJULa/X8vvzBAmhXXHUxbXaX0KXeUBi5dNdELbb0MMd41UxOtdEPbME0Aw==
X-Received: by 10.28.169.66 with SMTP id s63mr640811wme.87.1465589519325;
        Fri, 10 Jun 2016 13:11:59 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.11.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:11:58 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297059>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", parse_traditional_patch() should return -1
instead of calling die().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index c27be35..eb98116 100644
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
2.9.0.rc2.362.g3cd93d0

From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 07/94] builtin/apply: move 'read_stdin' global into cmd_apply()
Date: Wed, 11 May 2016 15:16:18 +0200
Message-ID: <20160511131745.2914-8-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:18:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U2H-0001gv-Eq
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbcEKNSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:18:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36194 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbcEKNSl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:18:41 -0400
Received: by mail-wm0-f67.google.com with SMTP id w143so9342188wmw.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=biriiPP3MlTVRlqfIA3JBADWpm5dU6ZrxTmR+NC38BY=;
        b=VQ0o3mAAt2rQu9AgbK5h7FJiUjLG4BBMu/4gpkmRolMMb/T93VAYryG78/M5cVdb8i
         jYtErJhWlKONF/sLelIlF9c5G2RyA3S+xDGxpou46N/6tU+un2zOtR58h3QxFnTo1qd8
         Zcp1sda/VVsHoaGCgRaXNw4pCBQDr2qjBFCDVEiRTGEkV2NBsM2Q5Ll8HNLvqdm6ah2O
         KQ5LajKUX0A/hiBvEyKWmDhxDSW+CLkXf3STqWbbiTP24vfb+ODI6LcLxtQ0RykbUSt0
         F1Wqi617KLEi+w7un0FIP4acNAr6gJxF/jMLnQ1W8ch698LJDhyf0Qp3tcdlFcviM2/S
         WOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=biriiPP3MlTVRlqfIA3JBADWpm5dU6ZrxTmR+NC38BY=;
        b=Lbb3s0qu9GN1DxRdHtAR38WOgHbaf0ARw+UVVev0KXcG+EiYMi4nBwlfmewiEmY7US
         yByU4OqcBjFw3It5fDJKBGuSTuTsIma/EGtHTWGThulCurTcxzpgAQC0452dMAVZASa3
         QK64B7gWBy8XoKQICq6Fn0Zvd1tK6y7jG+ftkaBk4Lc7TzpWH5sUvJ+WzR0jQH5gd1X3
         uFj4QSI1LJT6/KkfvZhTyplyL5TNHnfVei8F8ChrZDQUB0hExzCJtQ3z/3tbniBErmgC
         cj9sRVOOL7nOy052zfdy/BgWipi1nCmfHu3T79iXGIfNxXFowPT57gCGk7EfcsVzVIlx
         PTOw==
X-Gm-Message-State: AOPr4FUDRTUas+IQ/XNS2aLTt9MsN3CqP5E8k1mBxZKMwwMwR2u1YPplrSObKVywtn0Qlw==
X-Received: by 10.28.229.68 with SMTP id c65mr14525wmh.77.1462972720420;
        Wed, 11 May 2016 06:18:40 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:18:39 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294252>

The 'read_stdin' variable doesn't need to be static and global to the
file. It can be local to cmd_apply(), so let's move it there.

This will make it easier to libify the apply functionality.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 5a1d65a..c911e4e 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -78,7 +78,6 @@ static enum ws_ignore {
 
 static const char *patch_input_file;
 static struct strbuf root = STRBUF_INIT;
-static int read_stdin = 1;
 
 static void parse_whitespace_option(const char *option)
 {
@@ -4517,6 +4516,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	int is_not_gitdir = !startup_info->have_repository;
 	int force_apply = 0;
 	int options = 0;
+	int read_stdin = 1;
 
 	const char *whitespace_option = NULL;
 
-- 
2.8.2.490.g3dabe57

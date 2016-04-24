From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 06/83] builtin/apply: move 'options' variable into cmd_apply()
Date: Sun, 24 Apr 2016 15:33:06 +0200
Message-ID: <1461504863-15946-7-git-send-email-chriscool@tuxfamily.org>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:35:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKBj-0007i7-3J
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715AbcDXNe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:34:56 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38160 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680AbcDXNex (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:34:53 -0400
Received: by mail-wm0-f51.google.com with SMTP id u206so89919915wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5lg0jZhmmfqHu8VrD218GOLZhg+d6bHlK5AmMT+F6lM=;
        b=dxX71sfXlLQw4oMZ39Fl1rQjGdsMTAS0VogKYpwbRogrEh8pWkW9qSRSOxkxZ5qb46
         pGc85AQjfk5jPhVdJdhLyT/qCwTxoaN0E8OuPpP/IY5e9Ypn1kO69wdlGhtXqE/zlrpe
         4JPtfPA2dP4vW3R1RKguWtBbI7JEuj1hVlf1uyN0IpqbKQZFebgkLrXBiixnZGQQOpsf
         Y0ekoVsKVIIQpSSkO8BwBfzgV+4UCSlHgbgBXv+2Zrof9groo0KUJj29vKTSknreq/Ta
         +O8VsHRrKQDEPwgHknAMDL6gPbv2lGeGFsf19U53GUOSBdsP9zoLazowCNf5EQ981ItP
         f3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5lg0jZhmmfqHu8VrD218GOLZhg+d6bHlK5AmMT+F6lM=;
        b=WWomdpO+AtJ4VXIPCmsndE3rFYbpL75L3+4JhyJQQ7UnPBIyzuccHpSrlwy9xQ8+oL
         P0M/bVmmg6JkQuabfyogEcO5brBKg1PqwDRbFWBcP+Q1e58l8U51hfzQEr3H4lrpxpZv
         4KROqE6YgIIXz+vwV0ztHvrBgXptsNt7Ws6b7APjy3kr90WfibJBdMySTq0uL3w/Rxes
         PaJheumZ5ZvekBOSkuKszhJyd3jgdahrppLDwvu807vidhepy92EtMV1zNGnDwx3rQVs
         iC8gxmKSogbrEoekIKR3GowRFUO8xC6E0Z6aBsmut5I/TT+cVkkmfxvE1/ljImLLRMyy
         c9gg==
X-Gm-Message-State: AOPr4FU9u2yys9L5dtuphtewDKeGVqbe2NHzvNiq/DdXY3B7NTMIhcaHNFbPkwF/EBK8qg==
X-Received: by 10.195.17.166 with SMTP id gf6mr29134747wjd.124.1461504892325;
        Sun, 24 Apr 2016 06:34:52 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.34.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:34:51 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292327>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 02239d9..8fd8dbc 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -79,7 +79,6 @@ static enum ws_ignore {
 static const char *patch_input_file;
 static struct strbuf root = STRBUF_INIT;
 static int read_stdin = 1;
-static int options;
 
 static void parse_whitespace_option(const char *option)
 {
@@ -4518,6 +4517,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	int errs = 0;
 	int is_not_gitdir = !startup_info->have_repository;
 	int force_apply = 0;
+	int options = 0;
 
 	const char *whitespace_option = NULL;
 
-- 
2.8.1.300.g5fed0c0

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792C5E7D0A3
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 17:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjIURuH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 13:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjIURtw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 13:49:52 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF046CCBD
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 10:30:41 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 4685F23FF7;
        Thu, 21 Sep 2023 08:41:31 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qjHWp-JIT-00; Thu, 21 Sep 2023 13:07:27 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] am: fix error message in parse_opt_show_current_patch()
Date:   Thu, 21 Sep 2023 13:07:27 +0200
Message-ID: <20230921110727.789156-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.42.0.419.g70bf8a5751
In-Reply-To: <fff19abd-263d-48c7-81fd-35a2766b6b16@web.de>
References: <fff19abd-263d-48c7-81fd-35a2766b6b16@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The argument order was incorrect. This was introduced by 246cac8505
(i18n: turn even more messages into "cannot be used together" ones,
2022-01-05).

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

---
fwiw, this is currently the only message that actually uses the %s=%s
format, so as of now, factoring out the argument names has only
theoretical value.

Cc: Jean-Noël Avila <jn.avila@free.fr>
Cc: Johannes Sixt <j6t@kdbg.org>
Cc: René Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>
---
 builtin/am.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 202040b62e..6655059a57 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2303,7 +2303,8 @@ static int parse_opt_show_current_patch(const struct option *opt, const char *ar
 	if (resume->mode == RESUME_SHOW_PATCH && new_value != resume->sub_mode)
 		return error(_("options '%s=%s' and '%s=%s' "
 					   "cannot be used together"),
-					 "--show-current-patch", "--show-current-patch", arg, valid_modes[resume->sub_mode]);
+			     "--show-current-patch", arg,
+			     "--show-current-patch", valid_modes[resume->sub_mode]);
 
 	resume->mode = RESUME_SHOW_PATCH;
 	resume->sub_mode = new_value;
-- 
2.42.0.419.g70bf8a5751


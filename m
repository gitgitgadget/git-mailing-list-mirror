Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F1E02018E
	for <e@80x24.org>; Sun, 21 Aug 2016 14:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753260AbcHUOvI (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Aug 2016 10:51:08 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:61934 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753190AbcHUOvH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2016 10:51:07 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e35:2ef1:f910:86a6:c8ff:fe05:d3e0])
        by smtp1-g21.free.fr (Postfix) with ESMTP id 26C17B004E7;
        Sun, 21 Aug 2016 14:50:36 +0200 (CEST)
From:   Jean-Noel Avila <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     Jean-Noel Avila <jn.avila@free.fr>
Subject: [PATCH 3/3] i18n: simplify numeric error reporting
Date:   Sun, 21 Aug 2016 16:50:39 +0200
Message-Id: <20160821145039.12121-3-jn.avila@free.fr>
X-Mailer: git-send-email 2.10.0.rc0.37.gd7d1c14.dirty
In-Reply-To: <20160821145039.12121-1-jn.avila@free.fr>
References: <xmqqy43rxqqz.fsf@gitster.mtv.corp.google.com>
 <20160821145039.12121-1-jn.avila@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
---
 config.c | 43 +++++++++++++++----------------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/config.c b/config.c
index 584cacf..e33c703 100644
--- a/config.c
+++ b/config.c
@@ -655,43 +655,30 @@ static void die_bad_number(const char *name, const char *value)
 	if (!value)
 		value = "";
 
+	const char * error_type = (errno == ERANGE)? _("out of range"):_("invalid unit");
 	if (!(cf && cf->name))
-		die(errno == ERANGE
-		    ? _("bad numeric config value '%s' for '%s': out of range")
-		    : _("bad numeric config value '%s' for '%s': invalid unit"),
-		    value, name);
+		die(_("bad numeric config value '%s' for '%s': %s"),
+		    value, name, error_type);
 
 	switch (cf->origin_type) {
 	case CONFIG_ORIGIN_BLOB:
-		die(errno == ERANGE
-		    ? _("bad numeric config value '%s' for '%s' in blob %s: out of range")
-		    : _("bad numeric config value '%s' for '%s' in blob %s: invalid unit"),
-		    value, name, cf->name);
+		die(_("bad numeric config value '%s' for '%s' in blob %s: %s"),
+		    value, name, cf->name, error_type);
 	case CONFIG_ORIGIN_FILE:
-		die(errno == ERANGE
-		    ? _("bad numeric config value '%s' for '%s' in file %s: out of range")
-		    : _("bad numeric config value '%s' for '%s' in file %s: invalid unit"),
-		    value, name, cf->name);
+		die(_("bad numeric config value '%s' for '%s' in file %s: %s"),
+		    value, name, cf->name, error_type);
 	case CONFIG_ORIGIN_STDIN:
-		die(errno == ERANGE
-		    ? _("bad numeric config value '%s' for '%s' in standard input: out of range")
-		    : _("bad numeric config value '%s' for '%s' in standard input: invalid unit"),
-		    value, name);
+		die(_("bad numeric config value '%s' for '%s' in standard input: %s"),
+		    value, name, error_type);
 	case CONFIG_ORIGIN_SUBMODULE_BLOB:
-		die(errno == ERANGE
-		    ? _("bad numeric config value '%s' for '%s' in submodule-blob %s: out of range")
-		    : _("bad numeric config value '%s' for '%s' in submodule-blob %s: invalid unit"),
-		    value, name, cf->name);
+		die(_("bad numeric config value '%s' for '%s' in submodule-blob %s: %s"),
+		    value, name, cf->name, error_type);
 	case CONFIG_ORIGIN_CMDLINE:
-		die(errno == ERANGE
-		    ? _("bad numeric config value '%s' for '%s' in command line %s: out of range")
-		    : _("bad numeric config value '%s' for '%s' in command line %s: invalid unit"),
-		    value, name, cf->name);
+		die(_("bad numeric config value '%s' for '%s' in command line %s: %s"),
+		    value, name, cf->name, error_type);
 	default:
-		die(errno == ERANGE
-		    ? _("bad numeric config value '%s' for '%s' in %s: out of range")
-		    : _("bad numeric config value '%s' for '%s' in %s: invalid unit"),
-		    value, name, cf->name);
+		die(_("bad numeric config value '%s' for '%s' in %s: %s"),
+		    value, name, cf->name, error_type);
 	}
 }
 
-- 
2.10.0.rc0.37.gd7d1c14.dirty


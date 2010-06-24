From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH] Allow customizable commit decorations colors
Date: Thu, 24 Jun 2010 08:21:16 +0800
Message-ID: <1277338876-21958-1-git-send-email-ayiehere@gmail.com>
References: <1277253782-3330-1-git-send-email-ayiehere@gmail.com>
Cc: Nazri Ramliy <ayiehere@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 24 02:21:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORaCC-0008Jh-7j
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 02:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753789Ab0FXAV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 20:21:26 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:40083 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab0FXAVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 20:21:25 -0400
Received: by pvg2 with SMTP id 2so120368pvg.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 17:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/jWc6vhtBl03XOyO0t2dI+IHtMqCRfT5JafqZKbWtak=;
        b=BJw0XqpHAD7pHDrYdL3THqJkb/nbNurEvqaXA4uagXQIDuw9/xZ76W7SxdclUbFQQR
         VNZjLzdNomX3CiqTcCOYKQ0lU729A3aYx1DC0StzD5yshh/Mr9Tkb+ETqc6ke3UYZC+J
         xiHBJ04Y0LTbOKSShPg0PpNSw/qE9qpJCDMCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rC8zQhXv01/5VCF5UZG2NndL2tvsv0cTN2ifSUyvfJh7obiXiNi66Tnlq3EjqUjnIg
         ZZfo1lZ605wKOmWnPB4FcK01ClZiZeEOL/KP1yKrMRyrWJjXQmM79eaE+TktDpEgAOCp
         87qoT7L6tvYrF9emNVPLMsP5mZj6yZvPYsOTQ=
Received: by 10.142.209.9 with SMTP id h9mr8104550wfg.164.1277338885110;
        Wed, 23 Jun 2010 17:21:25 -0700 (PDT)
Received: from localhost.localdomain ([115.132.104.117])
        by mx.google.com with ESMTPS id y27sm2622799wfi.17.2010.06.23.17.21.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jun 2010 17:21:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.363.gac4b1
In-Reply-To: <1277253782-3330-1-git-send-email-ayiehere@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149558>

Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
---
Apologies for not catching this earlier.

My earlier version of this patch "Allow customizable commit decorations colors"
(message id: 1277253782-3330-1-git-send-email-ayiehere@gmail.com) has a bad
style for the opening braces in the functions parse_decorate_color_slot() and
parse_decorate_color_config() - the opening braces for these two functions were
at the same line as the function head.

This patch fixes these style violations (replaces
4938f6c98e4a6c4484bf652bdb887f0b8d8be822 in pu).

nazri.

 Documentation/config.txt |    5 +++++
 builtin/log.c            |    3 +++
 log-tree.c               |   36 ++++++++++++++++++++++++++++++++++++
 log-tree.h               |    1 +
 4 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7afd0a3..89cb487 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -683,6 +683,11 @@ color.diff.<slot>::
 	(highlighting whitespace errors). The values of these variables may be
 	specified as in color.branch.<slot>.
 
+color.decorate.<slot>::
+	Use customized color for 'git log --decorate' output.  `<slot>` is one
+	of `branch`, `remoteBranch`, `tag`, `stash` or `HEAD` for local
+	branches, remote tracking branches, tags, stash and HEAD, respectively.
+
 color.grep::
 	When set to `always`, always highlight matches.  When `false` (or
 	`never`), never.  When set to `true` or `auto`, use color only
diff --git a/builtin/log.c b/builtin/log.c
index 976e16f..0835866 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -296,6 +296,9 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		default_show_root = git_config_bool(var, value);
 		return 0;
 	}
+	if (!prefixcmp(var, "color.decorate."))
+		return parse_decorate_color_config(var, 15, value);
+
 	return git_diff_ui_config(var, value, cb);
 }
 
diff --git a/log-tree.c b/log-tree.c
index 61680f4..b46ed3b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -36,6 +36,42 @@ static const char *decorate_get_color(int decorate_use_color, enum decoration_ty
 	return "";
 }
 
+static int parse_decorate_color_slot(const char *slot)
+{
+	/*
+	 * We're comparing with 'ignore-case' on
+	 * (because config.c sets them all tolower),
+	 * but let's match the letters in the literal
+	 * string values here with how they are
+	 * documented in Documentation/config.txt, for
+	 * consistency.
+	 *
+	 * We love being consistent, don't we?
+	 */
+	if (!strcasecmp(slot, "branch"))
+		return DECORATION_REF_LOCAL;
+	if (!strcasecmp(slot, "remoteBranch"))
+		return DECORATION_REF_REMOTE;
+	if (!strcasecmp(slot, "tag"))
+		return DECORATION_REF_TAG;
+	if (!strcasecmp(slot, "stash"))
+		return DECORATION_REF_STASH;
+	if (!strcasecmp(slot, "HEAD"))
+		return DECORATION_REF_HEAD;
+	return -1;
+}
+
+int parse_decorate_color_config(const char *var, const int ofs, const char *value)
+{
+	int slot = parse_decorate_color_slot(var + ofs);
+	if (slot < 0)
+		return 0;
+	if (!value)
+		return config_error_nonbool(var);
+	color_parse(value, var, decoration_colors[slot]);
+	return 0;
+}
+
 /*
  * log-tree.c uses DIFF_OPT_TST for determining whether to use color
  * for showing the commit sha1, use the same check for --decorate
diff --git a/log-tree.h b/log-tree.h
index 3f7b400..5c4cf7c 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -7,6 +7,7 @@ struct log_info {
 	struct commit *commit, *parent;
 };
 
+int parse_decorate_color_config(const char *var, const int ofs, const char *value);
 void init_log_tree_opt(struct rev_info *);
 int log_tree_diff_flush(struct rev_info *);
 int log_tree_commit(struct rev_info *, struct commit *);
-- 
1.7.1.245.g7c42e.dirty

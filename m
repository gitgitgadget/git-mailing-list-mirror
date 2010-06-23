From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH] Allow customizable commit decorations colors
Date: Wed, 23 Jun 2010 08:43:02 +0800
Message-ID: <1277253782-3330-1-git-send-email-ayiehere@gmail.com>
References: <7vhbkvg1bd.fsf@alter.siamese.dyndns.org>
Cc: Nazri Ramliy <ayiehere@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 23 02:43:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORE3g-0004pa-Mp
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 02:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081Ab0FWAnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jun 2010 20:43:10 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64669 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab0FWAnI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jun 2010 20:43:08 -0400
Received: by pwj8 with SMTP id 8so1189696pwj.19
        for <git@vger.kernel.org>; Tue, 22 Jun 2010 17:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=leYmcrhgS2d/sH8DvTAQ/p2aHgGTh4nJbMqaSrqm8BA=;
        b=c1RuC2qgui4xst342wUHV69baSxVmEgbXyOKx3jziCpri6y4GeFpfk0ZFAbAiqVQ7m
         k7YcxaCOnuP209717AV7CBadj+ya7Ilj0mzkcdv5sHkw1YEjtuMVQHbk8LeDwjtq/rFl
         IkvMzsvSbN2mScO7LT74krlCVZVTPHcRBKS1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Ih7sH090Er7Dx+K2x/gTt7qbTnllpJRMNQdJ1DClht2oE8DvHnv0NgqGCDQFrJ9mE0
         5b1w9rAr6Npc0DeM4cwcKMCOId25o+062wFxTPM/UPjda1VKb5QGJnv3k5+89YLOi8UF
         uPDYI0gBXn07Po8rh0RlSS1gfaS9SFTAvbsoA=
Received: by 10.142.1.40 with SMTP id 40mr6210385wfa.229.1277253787772;
        Tue, 22 Jun 2010 17:43:07 -0700 (PDT)
Received: from localhost.localdomain ([115.132.104.117])
        by mx.google.com with ESMTPS id g14sm4038267rvb.1.2010.06.22.17.43.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Jun 2010 17:43:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.363.gac4b1
In-Reply-To: <7vhbkvg1bd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149497>

Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
---
On Tue, Jun 22, 2010 at 12:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nazri Ramliy <ayiehere@gmail.com> writes:
>>         color.decorate.reflocal
>>         color.decorate.refremote
>
> Wouldn't "(local) branch" and "remote (tracking) branch" be more natural
> way to call these things?
>
>>         color.decorate.reftag
>>         color.decorate.refstash
>>         color.decorate.refhead
>
> And these would just be "tag", "stash" and "head".

Makes sense. The names above are not user friendly. The new names are:

	color.decorate.branch
	color.decorate.remoteBranch
	color.decorate.tag
	color.decorate.stash
	color.decorate.HEAD

Documentation/config.txt explains how 'branch' and 'remoteBranch' are for local
branches and remote tracking branches, respectively.  Also the config entries
are shown as if the case matters while in fact it does not. But I think it
helps readability and at the same time it disambiguates 'head' vs. 'HEAD'.

This is to be applied on top of 67a4b5864f9423ccfe8090365029dae918504830:
"log --decorate: Colorize commit decorations" in pu.

Let me know if you want me to send the whole series again (4 patches).

 Documentation/config.txt |    5 +++++
 builtin/log.c            |    3 +++
 log-tree.c               |   34 ++++++++++++++++++++++++++++++++++
 log-tree.h               |    1 +
 4 files changed, 43 insertions(+), 0 deletions(-)

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
index 61680f4..28280e9 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -36,6 +36,40 @@ static const char *decorate_get_color(int decorate_use_color, enum decoration_ty
 	return "";
 }
 
+static int parse_decorate_color_slot(const char *slot) {
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
+int parse_decorate_color_config(const char *var, const int ofs, const char *value) {
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

From: Denis Cheng <crquan@gmail.com>
Subject: [PATCH 3/3] log/show/whatchanged: introduce format.pretty configuration
Date: Sun,  2 Mar 2008 17:05:53 +0800
Message-ID: <1204448753-4471-3-git-send-email-crquan@gmail.com>
References: <7vr6etvlgm.fsf@gitster.siamese.dyndns.org>
 <1204448753-4471-1-git-send-email-crquan@gmail.com>
 <1204448753-4471-2-git-send-email-crquan@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 02 10:07:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVk9x-0000KL-11
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 10:07:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835AbYCBJGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 04:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822AbYCBJGY
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 04:06:24 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:53251 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809AbYCBJGV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 04:06:21 -0500
Received: by wa-out-1112.google.com with SMTP id v27so6026473wah.23
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 01:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=thZhiO+ahnOfK12SnqhxuW+rC1fDCYMTzpxn7H6++JM=;
        b=lt9csjn97UZD4j0NWiO3AArvix9jSfDTZLZo73OJ01RmZo2+ijdJ6Y9QPdQEWQoBo9huV0YpsxJZodSd5iXwDKc8AnbuBNXyy9TBRqa0yRUzd4hk9wXvCBACfkfu6p90VOpg6Q+oExy+m30I67t+4Z0RmMsKQrxCuU7DBBhYiEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tc83k7PN4+GL4TFXim1e/K/PMuCYi8clBvYZXHa15CJONRjlvKFSO/Mtt51B8P+0OJL2hEgbHNOKeLsKG5JgPooN6E0yMjTsSitXEAa+ocXQxvm/To97Il5JclOfiQE1prbRIUjLMRDNYTOpdX1XSbT3F+mw6n8KEtPNCrHe9Ic=
Received: by 10.115.95.1 with SMTP id x1mr1361134wal.94.1204448780244;
        Sun, 02 Mar 2008 01:06:20 -0800 (PST)
Received: from tux ( [121.34.60.168])
        by mx.google.com with ESMTPS id k21sm18398804waf.31.2008.03.02.01.06.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Mar 2008 01:06:18 -0800 (PST)
Received: by tux (sSMTP sendmail emulation); Sun,  2 Mar 2008 17:06:09 +0800
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1204448753-4471-2-git-send-email-crquan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75752>

When running log/show/whatchanged from the command line, the user may
want to use a preferred format without having to pass --pretty=<fmt>
option every time from the command line.  This teaches these three
commands to honor a new configuration variable, format.pretty.

The --pretty option given from the command line will override the
configured format.

The earlier patch fixed the only in-tree caller that runs these
commands for a purpose other than showing the output directly to the
end user (the other in-tree caller is "git bisect visualize", whose
output directly goes to the end user and should be affected by this
patch).

Signed-off-by: Denis Cheng <crquan@gmail.com>
---
 Documentation/config.txt         |    5 +++++
 Documentation/pretty-options.txt |    8 ++++++++
 builtin-log.c                    |    5 +++++
 3 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4027726..8a0dff9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -556,6 +556,11 @@ format.suffix::
 	`.patch`. Use this variable to change that suffix (make sure to
 	include the dot if you want it).
 
+format.pretty::
+	The default pretty format for log/show/whatchanged command,
+	See linkgit:git-log[1], linkgit:git-show[1],
+	linkgit:git-whatchanged[1].
+
 gc.aggressiveWindow::
 	The window size parameter used in the delta compression
 	algorithm used by 'git gc --aggressive'.  This defaults
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 973d8dd..f86b0cc 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -4,6 +4,14 @@
 	where '<format>' can be one of 'oneline', 'short', 'medium',
 	'full', 'fuller', 'email', 'raw' and 'format:<string>'.
 	When omitted, the format defaults to 'medium'.
++
+Note: you can specify the default pretty format in the repository
+configuration (see linkgit:git-config[1]), like this in .git/config:
++
+-----------------------
+[format]
+	pretty = fuller
+-----------------------
 
 --abbrev-commit::
 	Instead of showing the full 40-byte hexadecimal commit object
diff --git a/builtin-log.c b/builtin-log.c
index bbadbc0..67f13ff 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -20,6 +20,7 @@
 
 static int default_show_root = 1;
 static const char *fmt_patch_subject_prefix = "PATCH";
+static const char *fmt_pretty;
 
 static void add_name_decoration(const char *prefix, const char *name, struct object *obj)
 {
@@ -54,6 +55,8 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 
 	rev->abbrev = DEFAULT_ABBREV;
 	rev->commit_format = CMIT_FMT_DEFAULT;
+	if (fmt_pretty)
+		rev->commit_format = get_commit_format(fmt_pretty);
 	rev->verbose_header = 1;
 	DIFF_OPT_SET(&rev->diffopt, RECURSIVE);
 	rev->show_root_diff = default_show_root;
@@ -221,6 +224,8 @@ static int cmd_log_walk(struct rev_info *rev)
 
 static int git_log_config(const char *var, const char *value)
 {
+	if (!strcmp(var, "format.pretty"))
+		return git_config_string(&fmt_pretty, var, value);
 	if (!strcmp(var, "format.subjectprefix")) {
 		if (!value)
 			config_error_nonbool(var);
-- 
1.5.4.3.368.g2bb0a


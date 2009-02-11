From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 3/3] builtin-remote: add sethead verb
Date: Wed, 11 Feb 2009 01:01:23 -0500
Message-ID: <1234332083-45147-4-git-send-email-jaysoffian@gmail.com>
References: <1234332083-45147-1-git-send-email-jaysoffian@gmail.com>
 <1234332083-45147-2-git-send-email-jaysoffian@gmail.com>
 <1234332083-45147-3-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 11 07:03:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX8Br-0008Je-I3
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 07:03:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbZBKGBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 01:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbZBKGBg
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 01:01:36 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:1300 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbZBKGBe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 01:01:34 -0500
Received: by yw-out-2324.google.com with SMTP id 5so30162ywh.1
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 22:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=4fq5+pjrQep1O5WReBCAa/TJQJ1eJlBzQogMjkT3HbM=;
        b=yIOp1gQkp6BKJD2jj49p2+LXiXcr/qm5astqegbtAyXz7nx3kbXDcfZGGBnZYuHEJw
         2oPrW9cYXFuiIV7kvP2nEsq+e3OrL4Fl25zCq7WV/tJIIFwf3rV+SHTQsMctJz1ecel/
         kVDETkWmqO3udzT1mUtB0Ex6MW1H2fCGwE57U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=q/iUGr7MPjphPkt44HMj90MJz8JPSQ9GZ2RsmnUR8e9H3BkUfIwxe8dIy8J0RoaU86
         EiQSG1jYrsn2gsoUVXrS7wn8ddAcoVOK5AJZVIAjZVHJb1Nb11t4wVzOldPy5UqXibIb
         oG5lfMXsKi/hGfvbc92fUH7DKgZz6HX7KWbHY=
Received: by 10.100.231.6 with SMTP id d6mr1747930anh.30.1234332093032;
        Tue, 10 Feb 2009 22:01:33 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c1sm13955049ana.20.2009.02.10.22.01.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Feb 2009 22:01:32 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.187.g9fcfb
In-Reply-To: <1234332083-45147-3-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109377>

Provide a porcelain command for setting/deleting
$GIT_DIR/remotes/<remote>/HEAD.

While we're at it, document what $GIT_DIR/remotes/<remote>/HEAD is all
about.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 Documentation/git-remote.txt |   20 ++++++++++++++-
 builtin-remote.c             |   51 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index fad983e..fa7ec46 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 'git remote add' [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>
 'git remote rename' <old> <new>
 'git remote rm' <name>
+'git remote sethead' <name> [-a | -d | <branch>]
 'git remote show' [-n] <name>
 'git remote prune' [-n | --dry-run] <name>
 'git remote update' [group]
@@ -53,8 +54,7 @@ is created.  You can give more than one `-t <branch>` to track
 multiple branches without grabbing all branches.
 +
 With `-m <master>` option, `$GIT_DIR/remotes/<name>/HEAD` is set
-up to point at remote's `<master>` branch instead of whatever
-branch the `HEAD` at the remote repository actually points at.
+up to point at remote's `<master>` branch. See also the sethead command.
 +
 In mirror mode, enabled with `\--mirror`, the refs will not be stored
 in the 'refs/remotes/' namespace, but in 'refs/heads/'.  This option
@@ -76,6 +76,22 @@ the configuration file format.
 Remove the remote named <name>. All remote tracking branches and
 configuration settings for the remote are removed.
 
+'sethead'::
+
+Sets or deletes the default branch (`$GIT_DIR/remotes/<name>/HEAD`) for
+the named remote. Having a default branch for a remote is not required,
+but allows the name of the remote to be specified in lieu of a specific
+branch. For example, if the default branch for `origin` is set to
+`master`, then `origin` may be specified wherever you would normally
+specify `origin/master`.
++
+With `-d`, `$GIT_DIR/remotes/<name>/HEAD` is deleted.
++
+With `-a`, the remote is queried to determine its `HEAD`, then
+`$GIT_DIR/remotes/<name>/HEAD` is set to the same branch.
++
+Use `<branch>` to set `$GIT_DIR/remotes/<name>/HEAD` explicitly.
+
 'show'::
 
 Gives some information about the remote <name>.
diff --git a/builtin-remote.c b/builtin-remote.c
index 0be8bfd..0715685 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -12,6 +12,7 @@ static const char * const builtin_remote_usage[] = {
 	"git remote add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>",
 	"git remote rename <old> <new>",
 	"git remote rm <name>",
+	"git remote sethead <name> [-a | -d | <branch>]",
 	"git remote show [-n] <name>",
 	"git remote prune [-n | --dry-run] <name>",
 	"git remote [-v | --verbose] update [group]",
@@ -791,6 +792,54 @@ static int show(int argc, const char **argv)
 	return result;
 }
 
+static int sethead(int argc, const char **argv)
+{
+	int opt_a = 0, opt_d = 0, result = 0;
+	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
+	char *head_name = NULL;
+
+	struct option options[] = {
+		OPT_GROUP("sethead specific options"),
+		OPT_BOOLEAN('a', 0, &opt_a,
+		           "set refs/remotes/<name>/HEAD according to remote"),
+		OPT_BOOLEAN('d', 0, &opt_d, "delete refs/remotes/<name>/HEAD"),
+		OPT_END()
+	};
+	argc = parse_options(argc, argv, options, builtin_remote_usage, 0);
+	if ((argc == 1 && !(opt_a || opt_d)) ||
+	   ((argc == 2 && (opt_a || opt_d))) || argc < 1 || argc > 2)
+		usage_with_options(builtin_remote_usage, options);
+
+	strbuf_addf(&buf, "refs/remotes/%s/HEAD", argv[0]);
+
+	if (opt_d) {
+		if (result |= delete_ref(buf.buf, NULL, REF_NODEREF))
+			error("Could not delete %s", buf.buf);
+	} else if (opt_a) {
+		struct ref_states states;
+		memset(&states, 0, sizeof(states));
+		get_remote_ref_states(argv[0], &states, 1);
+		head_name = xstrdup(states.head_name);
+		free_remote_ref_states(&states);
+	} else
+		head_name = xstrdup(argv[1]);
+
+	if (head_name) {
+		unsigned char sha1[20];
+		strbuf_addf(&buf2, "refs/remotes/%s/%s", argv[0], head_name);
+		/* make sure it's valid */
+		if (!resolve_ref(buf2.buf, sha1, 1, NULL))
+			result |= error("Not a valid ref: %s", buf2.buf);
+		else if (create_symref(buf.buf, buf2.buf, "remote sethead"))
+			result |= error("Could not setup %s", buf.buf);
+		free(head_name);
+	}
+
+	strbuf_release(&buf);
+	strbuf_release(&buf2);
+	return result;
+}
+
 static int prune(int argc, const char **argv)
 {
 	int dry_run = 0, result = 0;
@@ -955,6 +1004,8 @@ int cmd_remote(int argc, const char **argv, const char *prefix)
 		result = mv(argc, argv);
 	else if (!strcmp(argv[0], "rm"))
 		result = rm(argc, argv);
+	else if (!strcmp(argv[0], "sethead"))
+		result = sethead(argc, argv);
 	else if (!strcmp(argv[0], "show"))
 		result = show(argc, argv);
 	else if (!strcmp(argv[0], "prune"))
-- 
1.6.2.rc0.187.g9fcfb

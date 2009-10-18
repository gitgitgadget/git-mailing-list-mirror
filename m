From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] check_filename(): make verify_filename() callable
 without dying
Date: Sun, 18 Oct 2009 01:00:15 -0700
Message-ID: <7veip1xhbk.fsf_-_@alter.siamese.dyndns.org>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
 <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
 <7vzl7pyvzl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 18 10:01:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzQhm-0006qo-5s
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 10:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843AbZJRIAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 04:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752777AbZJRIAW
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 04:00:22 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55131 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbZJRIAV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 04:00:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5E5FE7BE32;
	Sun, 18 Oct 2009 04:00:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VWP2gbh4Ttx2JNpaUstJrs1hZG8=; b=eJXal1
	th6YRFGu9w0UdNaVV3wGp1S4crl4h3Pm6JJEhOzt/AfZ6MWCH6zybR2X83h6NnYE
	kXuTA4DzlMYQ+mos/J/GQWT1IchOkC8BR/HU0C9hOOmA0gz0RXTyeKUGDyjTbdDU
	YOjXU/VTZIl9D5WfvvFakfn5TM2RtcfzPuWsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v1LIFRLGNYYSTUZqYHhaAw49f1Os2iSw
	adHR8w0SDwEsjtG4waaJI38XHh9ECj3xiXZ4Yk7lZcC9syhOQxRfOjaCxC+mwVKj
	LgVMsr6wi4BavxlLOTJjXbH3onRxoKj4L2XbZKFL9AAMuq55HUhlSH1EEQB9G8wJ
	u03jAMyXHnY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 349257BE31;
	Sun, 18 Oct 2009 04:00:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D2AF07BE30; Sun, 18 Oct 2009
 04:00:16 -0400 (EDT)
In-Reply-To: <7vzl7pyvzl.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 18 Oct 2009 00\:58\:06 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 48746FA8-BBBC-11DE-B1FA-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130587>

Make it possible to invole the logic of verify_filename() to make sure the
pathname arguments are unambiguous without actually dying.  The caller may
want to do something different.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h |    1 +
 setup.c |   38 ++++++++++++++++++++------------------
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/cache.h b/cache.h
index 96840c7..71a731d 100644
--- a/cache.h
+++ b/cache.h
@@ -396,6 +396,7 @@ extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
 extern const char *prefix_path(const char *prefix, int len, const char *path);
 extern const char *prefix_filename(const char *prefix, int len, const char *path);
+extern int check_filename(const char *prefix, const char *name);
 extern void verify_filename(const char *prefix, const char *name);
 extern void verify_non_filename(const char *prefix, const char *name);
 
diff --git a/setup.c b/setup.c
index 029371e..f67250b 100644
--- a/setup.c
+++ b/setup.c
@@ -61,6 +61,19 @@ const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
 	return path;
 }
 
+int check_filename(const char *prefix, const char *arg)
+{
+	const char *name;
+	struct stat st;
+
+	name = prefix ? prefix_filename(prefix, strlen(prefix), arg) : arg;
+	if (!lstat(name, &st))
+		return 1; /* file exists */
+	if (errno == ENOENT || errno == ENOTDIR)
+		return 0; /* file does not exist */
+	die_errno("failed to stat '%s'", arg);
+}
+
 /*
  * Verify a filename that we got as an argument for a pathspec
  * entry. Note that a filename that begins with "-" never verifies
@@ -70,18 +83,12 @@ const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
  */
 void verify_filename(const char *prefix, const char *arg)
 {
-	const char *name;
-	struct stat st;
-
 	if (*arg == '-')
 		die("bad flag '%s' used after filename", arg);
-	name = prefix ? prefix_filename(prefix, strlen(prefix), arg) : arg;
-	if (!lstat(name, &st))
+	if (check_filename(prefix, arg))
 		return;
-	if (errno == ENOENT)
-		die("ambiguous argument '%s': unknown revision or path not in the working tree.\n"
-		    "Use '--' to separate paths from revisions", arg);
-	die_errno("failed to stat '%s'", arg);
+	die("ambiguous argument '%s': unknown revision or path not in the working tree.\n"
+	    "Use '--' to separate paths from revisions", arg);
 }
 
 /*
@@ -91,19 +98,14 @@ void verify_filename(const char *prefix, const char *arg)
  */
 void verify_non_filename(const char *prefix, const char *arg)
 {
-	const char *name;
-	struct stat st;
-
 	if (!is_inside_work_tree() || is_inside_git_dir())
 		return;
 	if (*arg == '-')
 		return; /* flag */
-	name = prefix ? prefix_filename(prefix, strlen(prefix), arg) : arg;
-	if (!lstat(name, &st))
-		die("ambiguous argument '%s': both revision and filename\n"
-		    "Use '--' to separate filenames from revisions", arg);
-	if (errno != ENOENT && errno != ENOTDIR)
-		die_errno("failed to stat '%s'", arg);
+	if (!check_filename(prefix, arg))
+		return;
+	die("ambiguous argument '%s': both revision and filename\n"
+	    "Use '--' to separate filenames from revisions", arg);
 }
 
 const char **get_pathspec(const char *prefix, const char **pathspec)
-- 
1.6.5.1.95.g09fbd

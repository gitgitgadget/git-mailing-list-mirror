From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH 05/15] config.c: rearrange xcalloc arguments
Date: Tue, 27 May 2014 00:33:46 +0900
Message-ID: <1401118436-66090-6-git-send-email-modocache@gmail.com>
References: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Cc: Brian Gesiak <modocache@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 26 17:36:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WowwH-0006Md-HP
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 17:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188AbaEZPfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 11:35:43 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34284 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951AbaEZPew (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 11:34:52 -0400
Received: by mail-pa0-f52.google.com with SMTP id fa1so7722511pad.25
        for <git@vger.kernel.org>; Mon, 26 May 2014 08:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9EIUbuO0Uz0iW+SQ54B188FW9W2OI1Z5Wqee5bfrjRE=;
        b=D6uGElopGQhzZZGrTHR3JYVB71zmgN5ZGOIii4kS5sOsQtjjmLZZPsnVnjy1JCs7Mw
         3yWQY5LemmiymJGSqSB5konKbMa0QGBgBWJQkBrme0kLKTcFLKcKwLh/M0xPm7EiZnmb
         bl86Ikj4QyPWE3WIAUfdodaMgLeTalfZ0DglbuWuxufXETPtGKMdGjRAHWmfWl+Doxaz
         HSqafGVV8D4MUNXGoz/d/EuyBpBbh9XYlC3fY2+PaeEqQ/5LiEjri49b3ow6DtQvkdGb
         RAbGcpWgbDtics3skXZFISnYwx32jRE+lo9DIVDhbZlmoIUYIbKu6FdS0Q7t0B6elGn1
         mkMw==
X-Received: by 10.68.110.65 with SMTP id hy1mr28651086pbb.67.1401118492526;
        Mon, 26 May 2014 08:34:52 -0700 (PDT)
Received: from localhost.localdomain (p3080-ipbf5805marunouchi.tokyo.ocn.ne.jp. [60.46.42.80])
        by mx.google.com with ESMTPSA id mt1sm18850446pbb.31.2014.05.26.08.34.50
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 08:34:52 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.543.gc8042da
In-Reply-To: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250107>

xcalloc takes two arguments: the number of elements and their size.
config.c includes several calls to xcalloc that pass the arguments
in reverse order: the size of a struct lock_file*, followed by the
number to allocate. Rearrgange them so they are in the correct order.

Signed-off-by: Brian Gesiak <modocache@gmail.com>
---
 config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 314d8ee..c3612cc 100644
--- a/config.c
+++ b/config.c
@@ -1536,7 +1536,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
 	 * The lock serves a purpose in addition to locking: the new
 	 * contents of .git/config will be written into it.
 	 */
-	lock = xcalloc(sizeof(struct lock_file), 1);
+	lock = xcalloc(1, sizeof(struct lock_file));
 	fd = hold_lock_file_for_update(lock, config_filename, 0);
 	if (fd < 0) {
 		error("could not lock config file %s: %s", config_filename, strerror(errno));
@@ -1791,7 +1791,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 	if (!config_filename)
 		config_filename = filename_buf = git_pathdup("config");
 
-	lock = xcalloc(sizeof(struct lock_file), 1);
+	lock = xcalloc(1, sizeof(struct lock_file));
 	out_fd = hold_lock_file_for_update(lock, config_filename, 0);
 	if (out_fd < 0) {
 		ret = error("could not lock config file %s", config_filename);
-- 
2.0.0.rc1.543.gc8042da

From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2 00/11] git_config callers rewritten with the new config-set API
Date: Thu,  7 Aug 2014 09:21:15 -0700
Message-ID: <1407428486-19049-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 18:23:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFQSv-0005WF-LT
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 18:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbaHGQWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 12:22:54 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:60312 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757414AbaHGQWx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 12:22:53 -0400
Received: by mail-pa0-f52.google.com with SMTP id bj1so5681155pad.39
        for <git@vger.kernel.org>; Thu, 07 Aug 2014 09:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=PPqDRhYfpR4GUrRPpNUobtUVUBnUbbWyYx5KCawE04g=;
        b=hFiLOTSLqqrlpzlwvxr4Wpg0oPABnmMygKbxX/EL8i+SyGln0ue3cooTIjY+qESGCZ
         NpKVIHMxR5cu01Vr1ydSV+pXC3zEmUvwahEBELjC6hmYKFQJKtK6VLfXF7RUcJiV151C
         kOCy5XFbA33fMTXVTFd22WEEcbvDyL8EYnnWpYT4ieOHuBawy+mpRURywnP4li3H8QCE
         QlSO/lKz7vJk3dfvlv0anxrECnPzsVjQE57Sb+4mFcadk7tT2SaGCPSjfPSKjPjVP8d7
         AYwtZUkm7X58UdXzPxYOA1dKkzDbVCh8uXP6nU1VUPSx+beTQKQxmsJmL8//0iqVKBKx
         QRYQ==
X-Received: by 10.66.180.34 with SMTP id dl2mr18721061pac.124.1407428572577;
        Thu, 07 Aug 2014 09:22:52 -0700 (PDT)
Received: from localhost.localdomain ([223.176.226.83])
        by mx.google.com with ESMTPSA id zt5sm16022338pac.31.2014.08.07.09.22.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Aug 2014 09:22:51 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254963>

[v2]: git_die_config() messages changed. Diff between v1 and v2 is at the bottom.

The ta/config-set API is more or less solidified.

This series builds on the top of 4c715ebb in pu (ta/config-set). On top of it,
it also requires series [1] (Rewrite `git_config()` using config-set API) for
proper error checking.

This series is the first batch of patches which rewrites the existing callers
using a non-callback approach.
This series aims to,

* rewrite the existing callers, as you can see from the diff stat the bew API
  provides a much concise and clear control flow.

* stress test the new API, see if any corner cases or deficiencies arise or not.

The series passes all the tests, only thing to watch is that the config variables
that have been rewritten are single valued only. Though I have tried my best to
ascertain it, still mistakes may arise.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/254633/

Tanay Abhra (11):
  daemon.c: replace `git_config()` with `git_config_get_bool()` family
  http-backend.c: replace `git_config()` with `git_config_get_bool()`
    family
  read-cache.c: replace `git_config()` with `git_config_get_*()` family
  archive.c: replace `git_config()` with `git_config_get_bool()` family
  fetchpack.c: replace `git_config()` with `git_config_get_*()` family
  rerere.c: replace `git_config()` with `git_config_get_*()` family
  builtin/gc.c: replace `git_config()` with `git_config_get_*()` family
  pager.c: replace `git_config()` with `git_config_get_value()`
  imap-send.c: replace `git_config()` with `git_config_get_*()` family
  alias.c: replace `git_config()` with `git_config_get_string()`
  branch.c: replace `git_config()` with `git_config_get_string()

 alias.c        | 25 ++++++------------------
 archive.c      | 12 +++---------
 branch.c       | 27 +++++++-------------------
 builtin/gc.c   | 51 ++++++++++++++++++++-----------------------------
 daemon.c       | 26 ++++---------------------
 fetch-pack.c   | 35 ++++++++--------------------------
 http-backend.c | 31 ++++++++++++------------------
 imap-send.c    | 60 +++++++++++++++++++++++++---------------------------------
 pager.c        | 40 +++++++++++++--------------------------
 read-cache.c   | 14 +++-----------
 rerere.c       | 43 ++++++++++++-----------------------------
 11 files changed, 114 insertions(+), 250 deletions(-)

-- 
1.9.0.GIT


-- 8< --
diff --git a/builtin/gc.c b/builtin/gc.c
index 4612ef5..5173657 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -76,8 +76,8 @@ static void gc_config(void)
    if (strcmp(prune_expire, "now")) {
      unsigned long now = approxidate("now");
      if (approxidate(prune_expire) >= now) {
-       error(_("Invalid %s: '%s'"), "gc.pruneexpire", prune_expire);
-       git_die_config("gc.pruneexpire");
+       git_die_config("gc.pruneexpire", _("Invalid gc.pruneexpire: '%s'"),
+                       prune_expire);
      }
    }
  }


diff --git a/daemon.c b/daemon.c
index fb16664..6f78b61 100644
--- a/daemon.c
+++ b/daemon.c
@@ -342,7 +342,6 @@ static int run_service(const char *dir, struct daemon_service *service)
    git_config_get_bool(var.buf, &enabled);
    strbuf_release(&var);
  }
-
  if (!enabled) {
    logerror("'%s': service not enabled for '%s'",
       service->name, path);
diff --git a/imap-send.c b/imap-send.c
index 586bdd8..618d75b 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1336,8 +1336,7 @@ static void git_imap_config(void)
 
  if (!git_config_get_value("imap.host", &val)) {
    if (!val) {
-     config_error_nonbool("imap.host");
-     git_die_config("imap.host");
+     git_die_config("imap.host", "Missing value for 'imap.host'");
    } else {
      if (starts_with(val, "imap:"))
  val += 5;
-- 8< --

From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v7 06/16] sha1_file: change GIT_TRACE_PACK_ACCESS
 logging to use trace API
Date: Wed, 02 Jul 2014 00:58:41 +0200
Message-ID: <53B33D21.4050405@gmail.com>
References: <53B33C05.5090900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBIP2ZSOQKGQEEJ3BKKA@googlegroups.com Wed Jul 02 00:58:42 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBIP2ZSOQKGQEEJ3BKKA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f186.google.com ([209.85.217.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBIP2ZSOQKGQEEJ3BKKA@googlegroups.com>)
	id 1X270c-0002Te-7V
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2014 00:58:42 +0200
Received: by mail-lb0-f186.google.com with SMTP id z11sf1101139lbi.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 01 Jul 2014 15:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=6jq8RTFcviG6UryNHE38pfFV0qjH8C/po8GQTSF7bGY=;
        b=X8+uuOdT/4M/7tdh2OrRZFYAGo6dAi9nzWrJ2cGsXLS3tTMobG/bVA/qtn+/qmlPMl
         Ndqm/fgLVIlIQpyML6j8MEFvD0/QBfRSblsTJuJadnzlGL4ZjAGbZlhBI6cD6nI8Ljzs
         zQgmwa9zb/lpZwAesluoFP42yPoNoEVNq3Zk2yvWf+OEe1m8kG+KKQe8WNcZCIQOVTC9
         oJthfKEmnuoWqgJFPBCK41ivXYpXYrCIMSKXtZb9o8ctf+n1d8K3nTbHweEAsi7mC/ND
         LneN9+vzbJMxMe2z2b1xYNGcB7B6nH2dkjZxTy5FOFO3rI3YpTA7HY7R9/AE96DUlGE5
         GEgg==
X-Received: by 10.152.183.196 with SMTP id eo4mr33lac.42.1404255522007;
        Tue, 01 Jul 2014 15:58:42 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.45.100 with SMTP id l4ls436887lam.49.gmail; Tue, 01 Jul
 2014 15:58:41 -0700 (PDT)
X-Received: by 10.152.87.226 with SMTP id bb2mr5332790lab.5.1404255521076;
        Tue, 01 Jul 2014 15:58:41 -0700 (PDT)
Received: from mail-wg0-x22a.google.com (mail-wg0-x22a.google.com [2a00:1450:400c:c00::22a])
        by gmr-mx.google.com with ESMTPS id m9si888116wiw.0.2014.07.01.15.58.41
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 15:58:41 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22a as permitted sender) client-ip=2a00:1450:400c:c00::22a;
Received: by mail-wg0-x22a.google.com with SMTP id z12so10218932wgg.13
        for <msysgit@googlegroups.com>; Tue, 01 Jul 2014 15:58:41 -0700 (PDT)
X-Received: by 10.180.83.105 with SMTP id p9mr39231676wiy.8.1404255520990;
        Tue, 01 Jul 2014 15:58:40 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id wz3sm50989239wjc.39.2014.07.01.15.58.39
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 15:58:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53B33C05.5090900@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22a
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252755>

This changes GIT_TRACE_PACK_ACCESS functionality as follows:
 * supports the same options as GIT_TRACE (e.g. printing to stderr)
 * no longer supports relative paths
 * appends to the trace file rather than overwriting

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 Documentation/git.txt |  4 ++--
 sha1_file.c           | 30 ++++--------------------------
 2 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 75633e6..9d073f6 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -925,11 +925,11 @@ Unsetting the variable, or setting it to empty, "0" or
 "false" (case insensitive) disables trace messages.
 
 'GIT_TRACE_PACK_ACCESS'::
-	If this variable is set to a path, a file will be created at
-	the given path logging all accesses to any packs. For each
+	Enables trace messages for all accesses to any packs. For each
 	access, the pack file name and an offset in the pack is
 	recorded. This may be helpful for troubleshooting some
 	pack-related performance problems.
+	See 'GIT_TRACE' for available trace output options.
 
 'GIT_TRACE_PACKET'::
 	Enables trace messages for all packets coming in or out of a
diff --git a/sha1_file.c b/sha1_file.c
index 34d527f..7a110b5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -36,9 +36,6 @@ static inline uintmax_t sz_fmt(size_t s) { return s; }
 
 const unsigned char null_sha1[20];
 
-static const char *no_log_pack_access = "no_log_pack_access";
-static const char *log_pack_access;
-
 /*
  * This is meant to hold a *small* number of objects that you would
  * want read_sha1_file() to be able to return, but yet you do not want
@@ -2085,27 +2082,9 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
 
 static void write_pack_access_log(struct packed_git *p, off_t obj_offset)
 {
-	static FILE *log_file;
-
-	if (!log_pack_access)
-		log_pack_access = getenv("GIT_TRACE_PACK_ACCESS");
-	if (!log_pack_access)
-		log_pack_access = no_log_pack_access;
-	if (log_pack_access == no_log_pack_access)
-		return;
-
-	if (!log_file) {
-		log_file = fopen(log_pack_access, "w");
-		if (!log_file) {
-			error("cannot open pack access log '%s' for writing: %s",
-			      log_pack_access, strerror(errno));
-			log_pack_access = no_log_pack_access;
-			return;
-		}
-	}
-	fprintf(log_file, "%s %"PRIuMAX"\n",
-		p->pack_name, (uintmax_t)obj_offset);
-	fflush(log_file);
+	static struct trace_key pack_access = TRACE_KEY_INIT(PACK_ACCESS);
+	trace_printf_key(&pack_access, "%s %"PRIuMAX"\n",
+			 p->pack_name, (uintmax_t)obj_offset);
 }
 
 int do_check_packed_object_crc;
@@ -2130,8 +2109,7 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 	int delta_stack_nr = 0, delta_stack_alloc = UNPACK_ENTRY_STACK_PREALLOC;
 	int base_from_cache = 0;
 
-	if (log_pack_access != no_log_pack_access)
-		write_pack_access_log(p, obj_offset);
+	write_pack_access_log(p, obj_offset);
 
 	/* PHASE 1: drill down to the innermost base object */
 	for (;;) {
-- 
2.0.0.406.ge74f8ff

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

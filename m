From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v8 06/17] sha1_file: change GIT_TRACE_PACK_ACCESS
 logging to use trace API
Date: Sat, 12 Jul 2014 02:01:38 +0200
Message-ID: <53C07AE2.4070107@gmail.com>
References: <53C079C5.8090503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBXXVQGPAKGQEVHVJFBI@googlegroups.com Sat Jul 12 02:01:36 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBXXVQGPAKGQEVHVJFBI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f190.google.com ([209.85.212.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBXXVQGPAKGQEVHVJFBI@googlegroups.com>)
	id 1X5kky-00026f-F1
	for gcvm-msysgit@m.gmane.org; Sat, 12 Jul 2014 02:01:36 +0200
Received: by mail-wi0-f190.google.com with SMTP id n15sf806wiw.27
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2014 17:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=pN6zqj+2a4dm/YUYEAEy3COb8pTU5U24lYRhqy4v8tI=;
        b=a+fBL0I0ufMnmByA6TPM/kOMyorzP6ctL6EZZWf8lF48RIkXlBZ0B+Ad63Hf7H6giL
         4I4D6yt64x5glAq0Jp/sA8l84pOVMPZLjEwviAg2DhekcUj+S7ylnwEW6m5wi87PoGPZ
         6OsIbSFsK9UJg5sfD0pKSCGg1OuQzjk4VR+u6E1Y0lHGb897QTIefsSUOZpJy6EdDctU
         MtzC5WtVUqJe8hhhHlsxPpFWiBq02212P8ehrWYcIPxH5lRr12wn0/v60A124pMFH+fo
         2YywG50Xw4bhOStgbVHCQ1c0MjFX/X9dgP8+wp+la9/dprJRs9C3Olztnq0I1LRJ8b4b
         JVwg==
X-Received: by 10.180.205.142 with SMTP id lg14mr30447wic.1.1405123294652;
        Fri, 11 Jul 2014 17:01:34 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.20.43 with SMTP id k11ls163518wie.21.canary; Fri, 11 Jul
 2014 17:01:33 -0700 (PDT)
X-Received: by 10.180.87.7 with SMTP id t7mr805787wiz.5.1405123293942;
        Fri, 11 Jul 2014 17:01:33 -0700 (PDT)
Received: from mail-wi0-x233.google.com (mail-wi0-x233.google.com [2a00:1450:400c:c05::233])
        by gmr-mx.google.com with ESMTPS id cj4si6504wid.0.2014.07.11.17.01.33
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 17:01:33 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::233 as permitted sender) client-ip=2a00:1450:400c:c05::233;
Received: by mail-wi0-f179.google.com with SMTP id cc10so20704wib.6
        for <msysgit@googlegroups.com>; Fri, 11 Jul 2014 17:01:33 -0700 (PDT)
X-Received: by 10.194.60.110 with SMTP id g14mr2631919wjr.101.1405123293887;
        Fri, 11 Jul 2014 17:01:33 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id v14sm8184749wjw.38.2014.07.11.17.01.32
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 17:01:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53C079C5.8090503@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::233
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253361>

This changes GIT_TRACE_PACK_ACCESS functionality as follows:
 * supports the same options as GIT_TRACE (e.g. printing to stderr)
 * no longer supports relative paths
 * appends to the trace file rather than overwriting

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.0.0.406.g2e9ef9b

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

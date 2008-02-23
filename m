From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] pack-objects: Add runtime detection of online CPU's
Date: Fri, 22 Feb 2008 20:11:56 -0600
Message-ID: <47BF80EC.4080608@nrlssc.navy.mil>
References: <47B1BEC6.6080906@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Feb 23 03:13:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSjsp-0007kw-3m
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 03:12:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754003AbYBWCMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 21:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbYBWCMX
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 21:12:23 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:59655 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803AbYBWCMW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 21:12:22 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m1N2Bv30000668;
	Fri, 22 Feb 2008 20:11:57 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 22 Feb 2008 20:11:56 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <47B1BEC6.6080906@nrlssc.navy.mil>
X-OriginalArrivalTime: 23 Feb 2008 02:11:56.0292 (UTC) FILETIME=[76D5CC40:01C875C1]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15736001
X-TM-AS-Result: : Yes--7.396800-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTE1MDIzNi03MDQ5?=
	=?us-ascii?B?MjctNzA1NDUwLTcwMDUyMS03MDUxMDItNzEwNTcxLTcwMTAwNS03?=
	=?us-ascii?B?MDE2MDQtNzAxNTk0LTcwMzc4OC03MDc2NjMtNzAyNjA5LTcwNjI0?=
	=?us-ascii?B?OS03MDU1ODEtNzA1MjkxLTcwNzc4OC03MDc0NTEtMTEzMjg1LTcw?=
	=?us-ascii?B?MTQ5My0xMzk3MDMtNzAwMTYwLTcwMjEzNC03MDA0NzYtNzA2ODkx?=
	=?us-ascii?B?LTEwNTcwMC03MDQ0MTAtNzA0MjU3LTcwMzUyOS0xODgwMTktNzAz?=
	=?us-ascii?B?MTc5LTcwOTg1MC03MDI3NjItNzAzOTY1LTcwMjM3OS03MDMzNzIt?=
	=?us-ascii?B?NzA4NzkxLTcwMjgwNy03MDA5NzAtNzA1MzE0LTcwMTI5OS03MDYy?=
	=?us-ascii?B?OTAtNzA0NzQ3LTcwMjkwMC03MDIxMTgtMTg4MTk5LTcwMjkyMC03?=
	=?us-ascii?B?MDg1NTgtNzA0NDI1LTcwMDk3MS03MDAzMjQtNzAwNTM4LTcwMDA1?=
	=?us-ascii?B?NS03MDMzNzgtNzA5MDY1LTcwNzgwMC03MDg3OTctMzAwMDE1LTcw?=
	=?us-ascii?B?MDA1Ny03MDAyNjQtMTQ4MDM5LTE0ODA1MQ==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74785>

From: Andreas Ericsson <ae@op5.se>

Packing objects can be done in parallell nowadays, but it's
only done if the config option pack.threads is set to a value
above 1. Because of that, the code-path used is often not the
most optimal one.

This patch adds a routine to detect the number of online CPU's
at runtime (online_cpus()). When pack.threads (or --threads=) is
given a value of 0, the number of threads is set to the number of
online CPU's. This feature is also documented.

As per Nicolas Pitre's recommendations, the default is still to
run pack-objects single-threaded unless explicitly activated,
either by configuration or by command line parameter.

The routine online_cpus() is a rework of "numcpus.c", written by
one Philip Willoughby <pgw99@doc.ic.ac.uk>. numcpus.c is in the
public domain and can presently be downloaded from
http://csgsoft.doc.ic.ac.uk/numcpus/

Signed-off-by: Andreas Ericsson <ae@op5.se>
Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


I reworked this patch from Andreas for detecting the number of online CPU's.
I kept the commit message and the Signed-off-by and added my own. I'm not sure
what the procedure is here.

-brandon


 Documentation/config.txt           |    2 +
 Documentation/git-pack-objects.txt |    2 +
 Makefile                           |    1 +
 builtin-pack-objects.c             |   14 +++++++---
 thread-utils.c                     |   48 ++++++++++++++++++++++++++++++++++++
 thread-utils.h                     |    6 ++++
 6 files changed, 69 insertions(+), 4 deletions(-)
 create mode 100644 thread-utils.c
 create mode 100644 thread-utils.h

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7b67671..62b697c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -808,6 +808,8 @@ pack.threads::
 	warning. This is meant to reduce packing time on multiprocessor
 	machines. The required amount of memory for the delta search window
 	is however multiplied by the number of threads.
+	Specifying 0 will cause git to auto-detect the number of CPU's
+	and set the number of threads accordingly.
 
 pack.indexVersion::
 	Specify the default pack index version.  Valid values are 1 for
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 8353be1..5c1bd3b 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -177,6 +177,8 @@ base-name::
 	This is meant to reduce packing time on multiprocessor machines.
 	The required amount of memory for the delta search window is
 	however multiplied by the number of threads.
+	Specifying 0 will cause git to auto-detect the number of CPU's
+	and set the number of threads accordingly.
 
 --index-version=<version>[,<offset>]::
 	This is intended to be used by the test suite only. It allows
diff --git a/Makefile b/Makefile
index d33a556..2dc8247 100644
--- a/Makefile
+++ b/Makefile
@@ -741,6 +741,7 @@ endif
 ifdef THREADED_DELTA_SEARCH
 	BASIC_CFLAGS += -DTHREADED_DELTA_SEARCH
 	EXTLIBS += -lpthread
+	LIB_OBJS += thread-utils.o
 endif
 
 ifeq ($(TCLTK_PATH),)
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index d2bb12e..586ae11 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -16,6 +16,7 @@
 #include "progress.h"
 
 #ifdef THREADED_DELTA_SEARCH
+#include "thread-utils.h"
 #include <pthread.h>
 #endif
 
@@ -1852,11 +1853,11 @@ static int git_pack_config(const char *k, const char *v)
 	}
 	if (!strcmp(k, "pack.threads")) {
 		delta_search_threads = git_config_int(k, v);
-		if (delta_search_threads < 1)
+		if (delta_search_threads < 0)
 			die("invalid number of threads specified (%d)",
 			    delta_search_threads);
 #ifndef THREADED_DELTA_SEARCH
-		if (delta_search_threads > 1)
+		if (delta_search_threads != 1)
 			warning("no threads support, ignoring %s", k);
 #endif
 		return 0;
@@ -2122,10 +2123,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		if (!prefixcmp(arg, "--threads=")) {
 			char *end;
 			delta_search_threads = strtoul(arg+10, &end, 0);
-			if (!arg[10] || *end || delta_search_threads < 1)
+			if (!arg[10] || *end || delta_search_threads < 0)
 				usage(pack_usage);
 #ifndef THREADED_DELTA_SEARCH
-			if (delta_search_threads > 1)
+			if (delta_search_threads != 1)
 				warning("no threads support, "
 					"ignoring %s", arg);
 #endif
@@ -2235,6 +2236,11 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!pack_to_stdout && thin)
 		die("--thin cannot be used to build an indexable pack.");
 
+#ifdef THREADED_DELTA_SEARCH
+	if (!delta_search_threads)	/* --threads=0 means autodetect */
+		delta_search_threads = online_cpus();
+#endif
+
 	prepare_packed_git();
 
 	if (progress)
diff --git a/thread-utils.c b/thread-utils.c
new file mode 100644
index 0000000..55e7e29
--- /dev/null
+++ b/thread-utils.c
@@ -0,0 +1,48 @@
+#include "cache.h"
+
+#ifdef _WIN32
+#  define WIN32_LEAN_AND_MEAN
+#  include <windows.h>
+#elif defined(hpux) || defined(__hpux) || defined(_hpux)
+#  include <sys/pstat.h>
+#endif
+
+/*
+ * By doing this in two steps we can at least get
+ * the function to be somewhat coherent, even
+ * with this disgusting nest of #ifdefs.
+ */
+#ifndef _SC_NPROCESSORS_ONLN
+#  ifdef _SC_NPROC_ONLN
+#    define _SC_NPROCESSORS_ONLN _SC_NPROC_ONLN
+#  elif defined _SC_CRAY_NCPU
+#    define _SC_NPROCESSORS_ONLN _SC_CRAY_NCPU
+#  endif
+#endif
+
+int online_cpus(void)
+{
+#ifdef _SC_NPROCESSORS_ONLN
+	long ncpus;
+#endif
+
+#ifdef _WIN32
+	SYSTEM_INFO info;
+	GetSystemInfo(&info);
+
+	if ((int)info.dwNumberOfProcessors > 0)
+		return (int)info.dwNumberOfProcessors;
+#elif defined(hpux) || defined(__hpux) || defined(_hpux)
+	struct pst_dynamic psd;
+
+	if (!pstat_getdynamic(&psd, sizeof(psd), (size_t)1, 0))
+		return (int)psd.psd_proc_cnt;
+#endif
+
+#ifdef _SC_NPROCESSORS_ONLN
+	if ((ncpus = (long)sysconf(_SC_NPROCESSORS_ONLN)) > 0)
+		return (int)ncpus;
+#endif
+
+	return 1;
+}
diff --git a/thread-utils.h b/thread-utils.h
new file mode 100644
index 0000000..cce4b77
--- /dev/null
+++ b/thread-utils.h
@@ -0,0 +1,6 @@
+#ifndef THREAD_COMPAT_H
+#define THREAD_COMPAT_H
+
+extern int online_cpus(void);
+
+#endif /* THREAD_COMPAT_H */
-- 
1.5.4.2.199.g0941

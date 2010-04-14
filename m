From: tip-bot for Ian Munsie <imunsie@au.ibm.com>
Subject: [tip:perf/core] perf: Fix endianness argument compatibility with OPT_BOOLEAN() and introduce OPT_INCR()
Date: Wed, 14 Apr 2010 09:36:38 GMT
Message-ID: <tip-c05556421742eb47f80301767653a4bcb19de9de@git.kernel.org>
References: <1271147857-11604-1-git-send-email-imunsie@au.ibm.com>
Reply-To: mingo@redhat.com, acme@redhat.com, jkacur@redhat.com,
	  a.p.zijlstra@chello.nl, rusty@rustcorp.com.au, efault@gmx.de,
	  mitake@dcl.info.waseda.ac.jp, imunsie@au1.ibm.com,
	  fweisbec@gmail.com, rostedt@goodmis.org,
	  hirofumi@mail.parknet.co.jp, imunsie@au.ibm.com,
	  tglx@linutronix.de, mhiramat@redhat.com, paulus@samba.org,
	  hpa@zytor.com, linux-kernel@vger.kernel.org, anton@samba.org,
	  tzanussi@gmail.com, arjan@linux.intel.com, lizf@cn.fujitsu.com,
	  tfransosi@gmail.com, xiaoguangrong@cn.fujitsu.com,
	  git@vger.kernel.org, amwang@redhat.com, davem@davemloft.net,
	  jaswinderrajput@gmail.com, ebmunson@us.ibm.com,
	  kosaki.motohiro@jp.fujitsu.com, mingo@elte.hu
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: acme@redhat.com, mingo@redhat.com, jkacur@redhat.com,
	rusty@rustcorp.com.au, a.p.zijlstra@chello.nl, efault@gmx.de,
	mitake@dcl.info.waseda.ac.jp, imunsie@au1.ibm.com,
	fweisbec@gmail.com, rostedt@goodmis.org,
	hirofumi@mail.parknet.co.jp, imunsie@au.ibm.com,
	tglx@linutronix.de, mhiramat@redhat.com,
	linux-kernel@vger.kernel.org, anton@samba.org, hpa@zytor.com,
	paulus@samba.org, tzanussi@gmail.com, lizf@cn.fujitsu.com,
	arjan@linux.intel.com, tfransosi@gmail.com,
	xiaoguangrong@cn.fujitsu.com, git@vger.kernel.org,
	jaswinderrajput@gmail.com, davem@davemloft.net, amwang@redhat.com,
	ebmunson@us.ibm.com, kosaki.motohiro@jp.fujitsu.com, mingo@elte.hu
To: linux-tip-commits@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 14 11:38:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1z2w-0005Zs-35
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 11:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798Ab0DNJhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 05:37:48 -0400
Received: from hera.kernel.org ([140.211.167.34]:38182 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754769Ab0DNJho (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 05:37:44 -0400
Received: from hera.kernel.org (localhost [127.0.0.1])
	by hera.kernel.org (8.14.3/8.14.3) with ESMTP id o3E9adEW031518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 14 Apr 2010 09:36:40 GMT
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.2 at hera.kernel.org
Received: (from hpa@localhost)
	by hera.kernel.org (8.14.3/8.14.2/Submit) id o3E9acaW031514;
	Wed, 14 Apr 2010 09:36:38 GMT
X-Authentication-Warning: hera.kernel.org: hpa set sender to bounces.tip@hpa.at.zytor.com using -f
In-Reply-To: <1271147857-11604-1-git-send-email-imunsie@au.ibm.com>
Git-Commit-ID: c05556421742eb47f80301767653a4bcb19de9de
X-Mailer: tip-git-log-daemon
Content-Disposition: inline
X-Spam-Status: No, score=0.3 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	DATE_IN_FUTURE_96_Q autolearn=no version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on hera.kernel.org
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.3 (hera.kernel.org [127.0.0.1]); Wed, 14 Apr 2010 09:36:41 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144860>

Commit-ID:  c05556421742eb47f80301767653a4bcb19de9de
Gitweb:     http://git.kernel.org/tip/c05556421742eb47f80301767653a4bcb19de9de
Author:     Ian Munsie <imunsie@au.ibm.com>
AuthorDate: Tue, 13 Apr 2010 18:37:33 +1000
Committer:  Ingo Molnar <mingo@elte.hu>
CommitDate: Wed, 14 Apr 2010 11:26:44 +0200

perf: Fix endianness argument compatibility with OPT_BOOLEAN() and introduce OPT_INCR()

Parsing an option from the command line with OPT_BOOLEAN on a
bool data type would not work on a big-endian machine due to the
manner in which the boolean was being cast into an int and
incremented. For example, running 'perf probe --list' on a
PowerPC machine would fail to properly set the list_events bool
and would therefore print out the usage information and
terminate.

This patch makes OPT_BOOLEAN work as expected with a bool
datatype. For cases where the original OPT_BOOLEAN was
intentionally being used to increment an int each time it was
passed in on the command line, this patch introduces OPT_INCR
with the old behaviour of OPT_BOOLEAN (the verbose variable is
currently the only such example of this).

I have reviewed every use of OPT_BOOLEAN to verify that a true
C99 bool was passed. Where integers were used, I verified that
they were only being used for boolean logic and changed them to
bools to ensure that they would not be mistakenly used as ints.
The major exception was the verbose variable which now uses
OPT_INCR instead of OPT_BOOLEAN.

Signed-off-by: Ian Munsie <imunsie@au.ibm.com>
Acked-by: David S. Miller <davem@davemloft.net>
Cc: <stable@kernel.org> # NOTE: wont apply to .3[34].x cleanly, please backport
Cc: Git development list <git@vger.kernel.org>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Eric B Munson <ebmunson@us.ibm.com>
Cc: Valdis.Kletnieks@vt.edu
Cc: WANG Cong <amwang@redhat.com>
Cc: Thiago Farina <tfransosi@gmail.com>
Cc: Masami Hiramatsu <mhiramat@redhat.com>
Cc: Xiao Guangrong <xiaoguangrong@cn.fujitsu.com>
Cc: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Tom Zanussi <tzanussi@gmail.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: John Kacur <jkacur@redhat.com>
Cc: Li Zefan <lizf@cn.fujitsu.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
LKML-Reference: <1271147857-11604-1-git-send-email-imunsie@au.ibm.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 tools/perf/bench/mem-memcpy.c       |    2 +-
 tools/perf/bench/sched-messaging.c  |    4 ++--
 tools/perf/builtin-annotate.c       |    8 ++++----
 tools/perf/builtin-buildid-cache.c  |    2 +-
 tools/perf/builtin-buildid-list.c   |    4 ++--
 tools/perf/builtin-diff.c           |    4 ++--
 tools/perf/builtin-help.c           |    2 +-
 tools/perf/builtin-lock.c           |    2 +-
 tools/perf/builtin-probe.c          |    2 +-
 tools/perf/builtin-record.c         |   24 ++++++++++++------------
 tools/perf/builtin-report.c         |    6 +++---
 tools/perf/builtin-sched.c          |    6 +++---
 tools/perf/builtin-stat.c           |   10 +++++-----
 tools/perf/builtin-timechart.c      |    2 +-
 tools/perf/builtin-top.c            |   14 +++++++-------
 tools/perf/builtin-trace.c          |    2 +-
 tools/perf/util/debug.c             |    2 +-
 tools/perf/util/debug.h             |    3 ++-
 tools/perf/util/parse-options.c     |    6 ++++++
 tools/perf/util/parse-options.h     |    4 +++-
 tools/perf/util/trace-event-parse.c |    2 +-
 tools/perf/util/trace-event.h       |    3 ++-
 22 files changed, 62 insertions(+), 52 deletions(-)

diff --git a/tools/perf/bench/mem-memcpy.c b/tools/perf/bench/mem-memcpy.c
index 52e646e..38dae74 100644
--- a/tools/perf/bench/mem-memcpy.c
+++ b/tools/perf/bench/mem-memcpy.c
@@ -23,7 +23,7 @@
 
 static const char	*length_str	= "1MB";
 static const char	*routine	= "default";
-static int		use_clock	= 0;
+static bool		use_clock	= false;
 static int		clock_fd;
 
 static const struct option options[] = {
diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
index 81cee78..da1b2e9 100644
--- a/tools/perf/bench/sched-messaging.c
+++ b/tools/perf/bench/sched-messaging.c
@@ -31,9 +31,9 @@
 
 #define DATASIZE 100
 
-static int use_pipes = 0;
+static bool use_pipes = false;
 static unsigned int loops = 100;
-static unsigned int thread_mode = 0;
+static bool thread_mode = false;
 static unsigned int num_groups = 10;
 
 struct sender_context {
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index ee0d917..06eaebe 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -28,11 +28,11 @@
 
 static char		const *input_name = "perf.data";
 
-static int		force;
+static bool		force;
 
-static int		full_paths;
+static bool		full_paths;
 
-static int		print_line;
+static bool		print_line;
 
 struct sym_hist {
 	u64		sum;
@@ -595,7 +595,7 @@ static const struct option options[] = {
 	OPT_STRING('s', "symbol", &sym_hist_filter, "symbol",
 		    "symbol to annotate"),
 	OPT_BOOLEAN('f', "force", &force, "don't complain, do it"),
-	OPT_BOOLEAN('v', "verbose", &verbose,
+	OPT_INCR('v', "verbose", &verbose,
 		    "be more verbose (show symbol address, etc)"),
 	OPT_BOOLEAN('D', "dump-raw-trace", &dump_trace,
 		    "dump raw trace in ASCII"),
diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index 30a05f5..f8e3d18 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -27,7 +27,7 @@ static const struct option buildid_cache_options[] = {
 		   "file list", "file(s) to add"),
 	OPT_STRING('r', "remove", &remove_name_list_str, "file list",
 		    "file(s) to remove"),
-	OPT_BOOLEAN('v', "verbose", &verbose, "be more verbose"),
+	OPT_INCR('v', "verbose", &verbose, "be more verbose"),
 	OPT_END()
 };
 
diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index d0675c0..af2ad8b 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -16,7 +16,7 @@
 #include "util/symbol.h"
 
 static char const *input_name = "perf.data";
-static int force;
+static bool force;
 static bool with_hits;
 
 static const char * const buildid_list_usage[] = {
@@ -29,7 +29,7 @@ static const struct option options[] = {
 	OPT_STRING('i', "input", &input_name, "file",
 		    "input file name"),
 	OPT_BOOLEAN('f', "force", &force, "don't complain, do it"),
-	OPT_BOOLEAN('v', "verbose", &verbose,
+	OPT_INCR('v', "verbose", &verbose,
 		    "be more verbose"),
 	OPT_END()
 };
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 1ea15d8..3a1d94d 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -19,7 +19,7 @@
 static char const *input_old = "perf.data.old",
 		  *input_new = "perf.data";
 static char	  diff__default_sort_order[] = "dso,symbol";
-static int  force;
+static bool  force;
 static bool show_displacement;
 
 static int perf_session__add_hist_entry(struct perf_session *self,
@@ -188,7 +188,7 @@ static const char * const diff_usage[] = {
 };
 
 static const struct option options[] = {
-	OPT_BOOLEAN('v', "verbose", &verbose,
+	OPT_INCR('v', "verbose", &verbose,
 		    "be more verbose (show symbol address, etc)"),
 	OPT_BOOLEAN('m', "displacement", &show_displacement,
 		    "Show position displacement relative to baseline"),
diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index 215b584..81e3ecc 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -29,7 +29,7 @@ enum help_format {
 	HELP_FORMAT_WEB,
 };
 
-static int show_all = 0;
+static bool show_all = false;
 static enum help_format help_format = HELP_FORMAT_MAN;
 static struct option builtin_help_options[] = {
 	OPT_BOOLEAN('a', "all", &show_all, "print all available commands"),
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index e12c844..6c38e4f 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -744,7 +744,7 @@ static const char * const lock_usage[] = {
 
 static const struct option lock_options[] = {
 	OPT_STRING('i', "input", &input_name, "file", "input file name"),
-	OPT_BOOLEAN('v', "verbose", &verbose, "be more verbose (show symbol address, etc)"),
+	OPT_INCR('v', "verbose", &verbose, "be more verbose (show symbol address, etc)"),
 	OPT_BOOLEAN('D', "dump-raw-trace", &dump_trace, "dump raw trace in ASCII"),
 	OPT_END()
 };
diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index b3ba25a..bfc47ff 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -133,7 +133,7 @@ static const char * const probe_usage[] = {
 };
 
 static const struct option options[] = {
-	OPT_BOOLEAN('v', "verbose", &verbose,
+	OPT_INCR('v', "verbose", &verbose,
 		    "be more verbose (show parsed arguments, etc)"),
 	OPT_BOOLEAN('l', "list", &params.list_events,
 		    "list up current probe events"),
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index dc61f1b..9a95136 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -38,22 +38,22 @@ static int			output;
 static const char		*output_name			= "perf.data";
 static int			group				=      0;
 static unsigned int		realtime_prio			=      0;
-static int			raw_samples			=      0;
-static int			system_wide			=      0;
+static bool			raw_samples			=  false;
+static bool			system_wide			=  false;
 static int			profile_cpu			=     -1;
 static pid_t			target_pid			=     -1;
 static pid_t			target_tid			=     -1;
 static pid_t			*all_tids			=      NULL;
 static int			thread_num			=      0;
 static pid_t			child_pid			=     -1;
-static int			inherit				=      1;
-static int			force				=      0;
-static int			append_file			=      0;
-static int			call_graph			=      0;
-static int			inherit_stat			=      0;
-static int			no_samples			=      0;
-static int			sample_address			=      0;
-static int			multiplex			=      0;
+static bool			inherit				=   true;
+static bool			force				=  false;
+static bool			append_file			=  false;
+static bool			call_graph			=  false;
+static bool			inherit_stat			=  false;
+static bool			no_samples			=  false;
+static bool			sample_address			=  false;
+static bool			multiplex			=  false;
 static int			multiplex_fd			=     -1;
 
 static long			samples				=      0;
@@ -465,7 +465,7 @@ static int __cmd_record(int argc, const char **argv)
 			rename(output_name, oldname);
 		}
 	} else {
-		append_file = 0;
+		append_file = false;
 	}
 
 	flags = O_CREAT|O_RDWR;
@@ -701,7 +701,7 @@ static const struct option options[] = {
 		    "number of mmap data pages"),
 	OPT_BOOLEAN('g', "call-graph", &call_graph,
 		    "do call-graph (stack chain/backtrace) recording"),
-	OPT_BOOLEAN('v', "verbose", &verbose,
+	OPT_INCR('v', "verbose", &verbose,
 		    "be more verbose (show counter open errors, etc)"),
 	OPT_BOOLEAN('s', "stat", &inherit_stat,
 		    "per thread counts"),
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index e93c69a..daee082 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -32,11 +32,11 @@
 
 static char		const *input_name = "perf.data";
 
-static int		force;
+static bool		force;
 static bool		hide_unresolved;
 static bool		dont_use_callchains;
 
-static int		show_threads;
+static bool		show_threads;
 static struct perf_read_values	show_threads_values;
 
 static char		default_pretty_printing_style[] = "normal";
@@ -418,7 +418,7 @@ static const char * const report_usage[] = {
 static const struct option options[] = {
 	OPT_STRING('i', "input", &input_name, "file",
 		    "input file name"),
-	OPT_BOOLEAN('v', "verbose", &verbose,
+	OPT_INCR('v', "verbose", &verbose,
 		    "be more verbose (show symbol address, etc)"),
 	OPT_BOOLEAN('D', "dump-raw-trace", &dump_trace,
 		    "dump raw trace in ASCII"),
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 5e59c0c..09ddc8e 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1790,7 +1790,7 @@ static const char * const sched_usage[] = {
 static const struct option sched_options[] = {
 	OPT_STRING('i', "input", &input_name, "file",
 		    "input file name"),
-	OPT_BOOLEAN('v', "verbose", &verbose,
+	OPT_INCR('v', "verbose", &verbose,
 		    "be more verbose (show symbol address, etc)"),
 	OPT_BOOLEAN('D', "dump-raw-trace", &dump_trace,
 		    "dump raw trace in ASCII"),
@@ -1805,7 +1805,7 @@ static const char * const latency_usage[] = {
 static const struct option latency_options[] = {
 	OPT_STRING('s', "sort", &sort_order, "key[,key2...]",
 		   "sort by key(s): runtime, switch, avg, max"),
-	OPT_BOOLEAN('v', "verbose", &verbose,
+	OPT_INCR('v', "verbose", &verbose,
 		    "be more verbose (show symbol address, etc)"),
 	OPT_INTEGER('C', "CPU", &profile_cpu,
 		    "CPU to profile on"),
@@ -1822,7 +1822,7 @@ static const char * const replay_usage[] = {
 static const struct option replay_options[] = {
 	OPT_INTEGER('r', "repeat", &replay_repeat,
 		    "repeat the workload replay N times (-1: infinite)"),
-	OPT_BOOLEAN('v', "verbose", &verbose,
+	OPT_INCR('v', "verbose", &verbose,
 		    "be more verbose (show symbol address, etc)"),
 	OPT_BOOLEAN('D', "dump-raw-trace", &dump_trace,
 		    "dump raw trace in ASCII"),
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 1036ca7..e619ac8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -67,19 +67,19 @@ static struct perf_event_attr default_attrs[] = {
 
 };
 
-static int			system_wide			=  0;
+static bool			system_wide			=  false;
 static unsigned int		nr_cpus				=  0;
 static int			run_idx				=  0;
 
 static int			run_count			=  1;
-static int			inherit				=  1;
-static int			scale				=  1;
+static bool			inherit				=  true;
+static bool			scale				=  true;
 static pid_t			target_pid			= -1;
 static pid_t			target_tid			= -1;
 static pid_t			*all_tids			=  NULL;
 static int			thread_num			=  0;
 static pid_t			child_pid			= -1;
-static int			null_run			=  0;
+static bool			null_run			=  false;
 
 static int			*fd[MAX_NR_CPUS][MAX_COUNTERS];
 
@@ -528,7 +528,7 @@ static const struct option options[] = {
 		    "system-wide collection from all CPUs"),
 	OPT_BOOLEAN('c', "scale", &scale,
 		    "scale/normalize counters"),
-	OPT_BOOLEAN('v', "verbose", &verbose,
+	OPT_INCR('v', "verbose", &verbose,
 		    "be more verbose (show counter open errors, etc)"),
 	OPT_INTEGER('r', "repeat", &run_count,
 		    "repeat command and print average + stddev (max: 100)"),
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 369c1b4..96f4a09 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -42,7 +42,7 @@ static u64		turbo_frequency;
 
 static u64		first_time, last_time;
 
-static int		power_only;
+static bool		power_only;
 
 
 struct per_pid;
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 4abdd9b..40f24dd 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -57,7 +57,7 @@
 
 static int			*fd[MAX_NR_CPUS][MAX_COUNTERS];
 
-static int			system_wide			=      0;
+static bool			system_wide			=  false;
 
 static int			default_interval		=      0;
 
@@ -68,18 +68,18 @@ static int			target_pid			=     -1;
 static int			target_tid			=     -1;
 static pid_t			*all_tids			=      NULL;
 static int			thread_num			=      0;
-static int			inherit				=      0;
+static bool			inherit				=  false;
 static int			profile_cpu			=     -1;
 static int			nr_cpus				=      0;
 static unsigned int		realtime_prio			=      0;
-static int			group				=      0;
+static bool			group				=  false;
 static unsigned int		page_size;
 static unsigned int		mmap_pages			=     16;
 static int			freq				=   1000; /* 1 KHz */
 
 static int			delay_secs			=      2;
-static int			zero                            =      0;
-static int			dump_symtab                     =      0;
+static bool			zero                            =  false;
+static bool			dump_symtab                     =  false;
 
 static bool			hide_kernel_symbols		=  false;
 static bool			hide_user_symbols		=  false;
@@ -854,7 +854,7 @@ static void handle_keypress(int c)
 			display_weighted = ~display_weighted;
 			break;
 		case 'z':
-			zero = ~zero;
+			zero = !zero;
 			break;
 		default:
 			break;
@@ -1335,7 +1335,7 @@ static const struct option options[] = {
 		    "display this many functions"),
 	OPT_BOOLEAN('U', "hide_user_symbols", &hide_user_symbols,
 		    "hide user symbols"),
-	OPT_BOOLEAN('v', "verbose", &verbose,
+	OPT_INCR('v', "verbose", &verbose,
 		    "be more verbose (show counter open errors, etc)"),
 	OPT_END()
 };
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 407041d..8fc50d8 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -505,7 +505,7 @@ static const char * const trace_usage[] = {
 static const struct option options[] = {
 	OPT_BOOLEAN('D', "dump-raw-trace", &dump_trace,
 		    "dump raw trace in ASCII"),
-	OPT_BOOLEAN('v', "verbose", &verbose,
+	OPT_INCR('v', "verbose", &verbose,
 		    "be more verbose (show symbol address, etc)"),
 	OPT_BOOLEAN('L', "Latency", &latency_format,
 		    "show latency attributes (irqs/preemption disabled, etc)"),
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 033d66d..dd824cf 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -13,7 +13,7 @@
 #include "util.h"
 
 int verbose = 0;
-int dump_trace = 0;
+bool dump_trace = false;
 
 int eprintf(int level, const char *fmt, ...)
 {
diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
index 5cb0a1b..047ac33 100644
--- a/tools/perf/util/debug.h
+++ b/tools/perf/util/debug.h
@@ -2,10 +2,11 @@
 #ifndef __PERF_DEBUG_H
 #define __PERF_DEBUG_H
 
+#include <stdbool.h>
 #include "event.h"
 
 extern int verbose;
-extern int dump_trace;
+extern bool dump_trace;
 
 int dump_printf(const char *fmt, ...) __attribute__((format(printf, 1, 2)));
 void trace_event(event_t *event);
diff --git a/tools/perf/util/parse-options.c b/tools/perf/util/parse-options.c
index 79dfa0c..ed88764 100644
--- a/tools/perf/util/parse-options.c
+++ b/tools/perf/util/parse-options.c
@@ -49,6 +49,7 @@ static int get_value(struct parse_opt_ctx_t *p,
 				break;
 			/* FALLTHROUGH */
 		case OPTION_BOOLEAN:
+		case OPTION_INCR:
 		case OPTION_BIT:
 		case OPTION_SET_INT:
 		case OPTION_SET_PTR:
@@ -73,6 +74,10 @@ static int get_value(struct parse_opt_ctx_t *p,
 		return 0;
 
 	case OPTION_BOOLEAN:
+		*(bool *)opt->value = unset ? false : true;
+		return 0;
+
+	case OPTION_INCR:
 		*(int *)opt->value = unset ? 0 : *(int *)opt->value + 1;
 		return 0;
 
@@ -478,6 +483,7 @@ int usage_with_options_internal(const char * const *usagestr,
 		case OPTION_GROUP:
 		case OPTION_BIT:
 		case OPTION_BOOLEAN:
+		case OPTION_INCR:
 		case OPTION_SET_INT:
 		case OPTION_SET_PTR:
 		case OPTION_LONG:
diff --git a/tools/perf/util/parse-options.h b/tools/perf/util/parse-options.h
index 948805a..b2da725 100644
--- a/tools/perf/util/parse-options.h
+++ b/tools/perf/util/parse-options.h
@@ -8,7 +8,8 @@ enum parse_opt_type {
 	OPTION_GROUP,
 	/* options with no arguments */
 	OPTION_BIT,
-	OPTION_BOOLEAN, /* _INCR would have been a better name */
+	OPTION_BOOLEAN,
+	OPTION_INCR,
 	OPTION_SET_INT,
 	OPTION_SET_PTR,
 	/* options with arguments (usually) */
@@ -95,6 +96,7 @@ struct option {
 #define OPT_GROUP(h)                { .type = OPTION_GROUP, .help = (h) }
 #define OPT_BIT(s, l, v, h, b)      { .type = OPTION_BIT, .short_name = (s), .long_name = (l), .value = (v), .help = (h), .defval = (b) }
 #define OPT_BOOLEAN(s, l, v, h)     { .type = OPTION_BOOLEAN, .short_name = (s), .long_name = (l), .value = (v), .help = (h) }
+#define OPT_INCR(s, l, v, h)        { .type = OPTION_INCR, .short_name = (s), .long_name = (l), .value = (v), .help = (h) }
 #define OPT_SET_INT(s, l, v, h, i)  { .type = OPTION_SET_INT, .short_name = (s), .long_name = (l), .value = (v), .help = (h), .defval = (i) }
 #define OPT_SET_PTR(s, l, v, h, p)  { .type = OPTION_SET_PTR, .short_name = (s), .long_name = (l), .value = (v), .help = (h), .defval = (p) }
 #define OPT_INTEGER(s, l, v, h)     { .type = OPTION_INTEGER, .short_name = (s), .long_name = (l), .value = (v), .help = (h) }
diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index 3b81250..17d6d66 100644
--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -42,7 +42,7 @@ int header_page_overwrite_size;
 int header_page_data_offset;
 int header_page_data_size;
 
-int latency_format;
+bool latency_format;
 
 static char *input_buf;
 static unsigned long long input_buf_ptr;
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index c3269b9..81f2fd2 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -1,6 +1,7 @@
 #ifndef __PERF_TRACE_EVENTS_H
 #define __PERF_TRACE_EVENTS_H
 
+#include <stdbool.h>
 #include "parse-events.h"
 
 #define __unused __attribute__((unused))
@@ -241,7 +242,7 @@ extern int header_page_size_size;
 extern int header_page_data_offset;
 extern int header_page_data_size;
 
-extern int latency_format;
+extern bool latency_format;
 
 int parse_header_page(char *buf, unsigned long size);
 int trace_parse_common_type(void *data);

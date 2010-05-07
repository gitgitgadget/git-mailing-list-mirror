From: Knittl <knittl89@googlemail.com>
Subject: Re: [PATCH] Show branch information in short output of git status
Date: Fri, 7 May 2010 18:05:51 +0200
Message-ID: <AANLkTilQZQzijU_xMz34eajpD05ogK01GRByDddoGGmI@mail.gmail.com>
References: <AANLkTikM3B-9wFBuUzwpP2j9FpT34p9yysX-oLg5hZRj@mail.gmail.com> 
	<20100505050640.GC8779@coredump.intra.peff.net> <AANLkTikDkrNrzPmIhmcBRKtLKV70f4Kp8wTw6I6ctB4O@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 18:06:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAQ4B-0006An-H3
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 18:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755348Ab0EGQGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 12:06:13 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:41920 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517Ab0EGQGN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 12:06:13 -0400
Received: by ewy20 with SMTP id 20so330140ewy.1
        for <git@vger.kernel.org>; Fri, 07 May 2010 09:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type;
        bh=dhBxZRh2ABizaj1KRI2i/Fb1MYfgQ015OcBMJEFiszI=;
        b=XihND6E5fZGohqMb19O9JK0le4n/KIvGv5oSTHE7RxHgNZvhDN1HkQqpDguQ7HtJry
         0y+SEWnybLl9CJAvldcxZHT7//y8VPQohU8c5ZrKHunCHMvJmoie77RLM/ygvV6o7niI
         vUJjjJP3sRt4pIj9bbkXLC5A9vy7ZmxK/b5Pc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=KgZd7MnSDCAAWyiZCd2i/0F8SrVOJcMZN3c+sPd+1mq3UN2z+A4qt0PWV7RTK6hBva
         agSCRVliFCDFegUkDK5kj+n+ApgcE9N7pqw2rt4hxwAwZjske9fcyWQYxt3Mp3Gy6Ghz
         Ul3C5iQtxlfft+1X9Pt3xd0/RPiXdJap94XT4=
Received: by 10.213.43.210 with SMTP id x18mr160936ebe.64.1273248371121; Fri, 
	07 May 2010 09:06:11 -0700 (PDT)
Received: by 10.213.3.5 with HTTP; Fri, 7 May 2010 09:05:51 -0700 (PDT)
In-Reply-To: <AANLkTikDkrNrzPmIhmcBRKtLKV70f4Kp8wTw6I6ctB4O@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146536>

hi all,

here's the second part of the branch, so it will only show branch
information in `git status -s` if the additional option `-b` is given.

open for suggestions,
daniel

----------8<-------------
From 00d7aa6872a8aaf98c7e5550ba64ec6e093ca897 Mon Sep 17 00:00:00 2001
From: Daniel Knittl-Frank <knittl89+git@googlemail.com>
Date: Tue, 20 Apr 2010 22:40:54 +0200
Subject: [PATCH 2/2] Hide branch information per default in short
output of status

Branch information remains hidden, unless the command line option `-b`
is given to `git status -s`. This way the command does not change from
older versions.

Also hide branch information in `--porcelain` output

Signed-off-by: Daniel Knittl-Frank <knittl89+git@googlemail.com>
---
 builtin/commit.c |    8 ++++++--
 wt-status.c      |    7 ++++---
 wt-status.h      |    2 +-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index c5ab683..b058e66 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -92,6 +92,7 @@ static enum {
 	STATUS_FORMAT_SHORT,
 	STATUS_FORMAT_PORCELAIN,
 } status_format = STATUS_FORMAT_LONG;
+static int status_show_branch;

 static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 {
@@ -133,6 +134,7 @@ static struct option builtin_commit_options[] = {
 	OPT_BOOLEAN(0, "dry-run", &dry_run, "show what would be committed"),
 	OPT_SET_INT(0, "short", &status_format, "show status concisely",
 		    STATUS_FORMAT_SHORT),
+	OPT_BOOLEAN(0, "branch", &status_show_branch, "show branch information"),
 	OPT_SET_INT(0, "porcelain", &status_format,
 		    "show porcelain output format", STATUS_FORMAT_PORCELAIN),
 	OPT_BOOLEAN('z', "null", &null_termination,
@@ -417,7 +419,7 @@ static int run_status(FILE *fp, const char
*index_file, const char *prefix, int

 	switch (status_format) {
 	case STATUS_FORMAT_SHORT:
-		wt_shortstatus_print(s, null_termination);
+		wt_shortstatus_print(s, null_termination, status_show_branch);
 		break;
 	case STATUS_FORMAT_PORCELAIN:
 		wt_porcelain_print(s, null_termination);
@@ -1022,6 +1024,8 @@ int cmd_status(int argc, const char **argv,
const char *prefix)
 		OPT__VERBOSE(&verbose),
 		OPT_SET_INT('s', "short", &status_format,
 			    "show status concisely", STATUS_FORMAT_SHORT),
+		OPT_BOOLEAN('b', "branch", &status_show_branch,
+		            "show branch information"),
 		OPT_SET_INT(0, "porcelain", &status_format,
 			    "show porcelain output format",
 			    STATUS_FORMAT_PORCELAIN),
@@ -1063,7 +1067,7 @@ int cmd_status(int argc, const char **argv,
const char *prefix)

 	switch (status_format) {
 	case STATUS_FORMAT_SHORT:
-		wt_shortstatus_print(&s, null_termination);
+		wt_shortstatus_print(&s, null_termination, status_show_branch);
 		break;
 	case STATUS_FORMAT_PORCELAIN:
 		wt_porcelain_print(&s, null_termination);
diff --git a/wt-status.c b/wt-status.c
index f7f1269..e1b8188 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -781,11 +781,12 @@ static void wt_shortstatus_print_tracking(struct
wt_status *s)
 	color_fprintf_ln(s->fp, header_color, "]");
 }

-void wt_shortstatus_print(struct wt_status *s, int null_termination)
+void wt_shortstatus_print(struct wt_status *s, int null_termination,
int show_branch)
 {
 	int i;

-	wt_shortstatus_print_tracking(s);
+	if(show_branch)
+		wt_shortstatus_print_tracking(s);

 	for (i = 0; i < s->change.nr; i++) {
 		struct wt_status_change_data *d;
@@ -811,5 +812,5 @@ void wt_porcelain_print(struct wt_status *s, int
null_termination)
 	s->use_color = 0;
 	s->relative_paths = 0;
 	s->prefix = NULL;
-	wt_shortstatus_print(s, null_termination);
+	wt_shortstatus_print(s, null_termination, 0);
 }
diff --git a/wt-status.h b/wt-status.h
index ca5db99..4272539 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -61,7 +61,7 @@ void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);

-void wt_shortstatus_print(struct wt_status *s, int null_termination);
+void wt_shortstatus_print(struct wt_status *s, int null_termination,
int show_branch);
 void wt_porcelain_print(struct wt_status *s, int null_termination);

 #endif /* STATUS_H */
-- 
1.7.1.12.g82b44.dirty

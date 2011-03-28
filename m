From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH/RFC 2/9] add support for --date=unix to complement %at
Date: Tue, 29 Mar 2011 00:17:24 +0100
Message-ID: <1301354251-23380-3-git-send-email-wmpalmer@gmail.com>
References: <1301354251-23380-1-git-send-email-wmpalmer@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Will Palmer <wmpalmer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 01:18:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4LhK-0000rH-1O
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 01:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755526Ab1C1XR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 19:17:57 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61581 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab1C1XRz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 19:17:55 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so3294008wya.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 16:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=+yoT7reqIYLzcRi1hsImRvjy56OS/hxwHqi1zq9+Ftg=;
        b=XutychsyFcoZp9N2gzp2dEWo3ic2Lv/IMPBEVW79gDvPeo8StFhV0u2oKINEINEm9j
         zgnNRQw3dbrTfm15pZkaCCzKInyJQtUDOz5xjNdRrhzl3PwinyhtCzegIih2L7YlG3Q3
         KjlZsQ/QcPa6FmGrOxtGMFDCP5hdocaRtrmcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=o0iF2Vi30NJaSoP4+D4w4SPs2P+0iGjjwxi50rTZrRzl6eae/NMDzRRS4dm/De4lz2
         rLN3mtxbWKhJIrFcFXUUqd/6qhpzlc3vocrAp5msSOSfrFst12BQJDUZN/uF8Kql9PQ/
         Hi1cPBnWiLSVpWAkXKQwAGIAu6Hr25ScdbGEU=
Received: by 10.216.81.69 with SMTP id l47mr3183804wee.78.1301354275020;
        Mon, 28 Mar 2011 16:17:55 -0700 (PDT)
Received: from localhost.localdomain (5acc3aad.bb.sky.com [90.204.58.173])
        by mx.google.com with ESMTPS id b54sm1678272wer.45.2011.03.28.16.17.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 16:17:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.2
In-Reply-To: <1301354251-23380-1-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170199>

this adds support for --date=unix to the "git log" family of commands,
which would cause %ad and %cd to act like %at and %ct respectively.

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
---
 Documentation/blame-options.txt    |    2 +-
 Documentation/git-rev-list.txt     |    2 +-
 Documentation/rev-list-options.txt |    4 +++-
 builtin/blame.c                    |    3 +++
 cache.h                            |    3 ++-
 date.c                             |    7 +++++++
 6 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index e11a3da..2586606 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -72,7 +72,7 @@ of lines before or after the line given by <start>.
 
 --date <format>::
 	The value is one of the following alternatives:
-	{relative,local,default,iso,rfc,short,raw}. If --date is
+	{relative,local,default,iso,rfc,short,unix,raw}. If --date is
 	not provided, the value of the blame.date config variable is
 	used. If the blame.date config variable is also not set, the
 	iso format is used. For more information, See the discussion
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index ce3692c..7e1d4bf 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -37,7 +37,7 @@ SYNOPSIS
 	     [ \--regexp-ignore-case | -i ]
 	     [ \--extended-regexp | -E ]
 	     [ \--fixed-strings | -F ]
-	     [ \--date=(local|relative|default|iso|rfc|short|raw) ]
+	     [ \--date=(local|relative|default|iso|rfc|short|unix|raw) ]
 	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
 	     [ \--pretty | \--header ]
 	     [ \--bisect ]
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 9c47ad8..9ad68a7 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -13,7 +13,7 @@ include::pretty-options.txt[]
 
 	Synonym for `--date=relative`.
 
---date=(relative|local|default|iso|rfc|short|raw)::
+--date=(relative|local|default|iso|rfc|short|unix|raw)::
 
 	Only takes effect for dates shown in human-readable format, such
 	as when using "--pretty". `log.date` config variable sets a default
@@ -31,6 +31,8 @@ format, often found in E-mail messages.
 +
 `--date=short` shows only date but not time, in `YYYY-MM-DD` format.
 +
+`--date=unix` shows the date as a UNIX timestamp, ignoring timezone.
++
 `--date=raw` shows the date in the internal raw git format `%s %z` format.
 +
 `--date=default` shows timestamps in the original timezone
diff --git a/builtin/blame.c b/builtin/blame.c
index f6b03f7..c6e43a0 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2366,6 +2366,9 @@ parse_done:
 	case DATE_RAW:
 		blame_date_width = sizeof("1161298804 -0700");
 		break;
+	case DATE_UNIX:
+		blame_date_width = sizeof("1161298804");
+		break;
 	case DATE_SHORT:
 		blame_date_width = sizeof("2006-10-19");
 		break;
diff --git a/cache.h b/cache.h
index f2dabef..fa564fa 100644
--- a/cache.h
+++ b/cache.h
@@ -814,7 +814,8 @@ enum date_mode {
 	DATE_LOCAL,
 	DATE_ISO8601,
 	DATE_RFC2822,
-	DATE_RAW
+	DATE_RAW,
+	DATE_UNIX
 };
 
 const char *show_date(unsigned long time, int timezone, enum date_mode mode);
diff --git a/date.c b/date.c
index 00f9eb5..ce48220 100644
--- a/date.c
+++ b/date.c
@@ -157,6 +157,11 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 		return timebuf;
 	}
 
+	if (mode == DATE_UNIX) {
+		snprintf(timebuf, sizeof(timebuf), "%lu", time);
+		return timebuf;
+	}
+
 	if (mode == DATE_RELATIVE) {
 		struct timeval now;
 		gettimeofday(&now, NULL);
@@ -672,6 +677,8 @@ enum date_mode parse_date_format(const char *format)
 		return DATE_NORMAL;
 	else if (!strcmp(format, "raw"))
 		return DATE_RAW;
+	else if (!strcmp(format, "unix"))
+		return DATE_UNIX;
 	else
 		die("unknown date format %s", format);
 }
-- 
1.7.4.2

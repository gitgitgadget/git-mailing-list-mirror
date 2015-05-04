From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] prefix_path(): Unconditionally free result of prefix_path
Date: Mon,  4 May 2015 12:11:54 -0700
Message-ID: <1430766714-22368-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: peff@peff.net, git@vger.kernel.org, gitster@pobox.com,
	sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Mon May 04 21:12:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpLmg-0007Gh-7B
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 21:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbbEDTMC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 15:12:02 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38053 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbbEDTMA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 15:12:00 -0400
Received: by igbhj9 with SMTP id hj9so91962069igb.1
        for <git@vger.kernel.org>; Mon, 04 May 2015 12:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=OzavUyqSi6iDhBk5MSwhSVQg/4k29wxSvPDRvcc8HW8=;
        b=h3Auz2cDfz144M8kjxAOKHdLG20/JdsEUUX/d+A/K0W1pO7rpNhx5x5GS0do8TT2JT
         Tkkyq7EezPWYs/3JWzOxDKETHVVx0IRuZOqRW7ilQBYVum4qGwJaPMXefYEfySLcyKlr
         FJnX1ljCNZhlNt2WQkGZ5MSP83vEFYdq+nr5YVmm31/pKO6yeC5lO1ONFJm9DHGv+tAN
         FY68dYQynEl0b9uwXXAApEoFrvDaVdwqE2Ei4xsiEB+18R+DeT8LVDSfNrI5IQ3uqRKa
         waomQB2HvhxoT7XFb/GdGrRXeAyI11onR5RHLYdzuNl9iNd0D77W7MIAm8QA4TCE2Z85
         VmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OzavUyqSi6iDhBk5MSwhSVQg/4k29wxSvPDRvcc8HW8=;
        b=YBQrjOxGl14BeDxXbUBzvD74IUze7hviK4+TRSZ7wgjLIdjwAE0Xyyl7tNwMsTru04
         mt1MdlZaTfNImNCosv8QsgR8ZJpbzgNnlm2u1Q7nFW53K0ScC7WREKHhMddb4Wk1cRFL
         33cj0SRKM6udLa6EoPSTK2f9NehAw0OAGtGHU5xZEr1Mu8PUPCUN3j4vEbXVetUtuEvd
         EZFk8biVQIqWmCAWbJUXofX3vGi5GGJkt/mkBsZaUTNaoIW49yE1NVa9TaQzqy5iIGHp
         YIazvX3mC5mF4BpPS7E7mJiE2NOvRx48cD0Wa60APgZmN6dQIedq/3tzMRm5g3HDvbjZ
         CDGg==
X-Gm-Message-State: ALoCoQkpGL2dRFqp25MyN0Oae+xDgWJQVrRFIKxR7TL1h56hGIdO56JT+PVTC5Vv9x2MdW7VyknV
X-Received: by 10.42.119.2 with SMTP id z2mr28647444icq.1.1430766719660;
        Mon, 04 May 2015 12:11:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:24b4:1bb1:2e2c:3021])
        by mx.google.com with ESMTPSA id p74sm10176075ioe.27.2015.05.04.12.11.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 04 May 2015 12:11:59 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc3.16.g0ab00b9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268340>

prefix_path() always returns a newly allocated string since
d089eba (setup: sanitize absolute and funny paths in get_pathspec(),
2008-01-28)

Additionally the const is dropped from the pointers, so the call to
free doesn't need a cast.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    Thanks for all the suggestions!
    They are incorporated into this version of the patch.

 builtin/checkout-index.c | 10 ++++------
 builtin/update-index.c   |  5 ++---
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 9ca2da1..8028c37 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -241,7 +241,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	/* Check out named files first */
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
-		const char *p;
+		char *p;
 
 		if (all)
 			die("git checkout-index: don't mix '--all' and explicit filenames");
@@ -249,8 +249,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 			die("git checkout-index: don't mix '--stdin' and explicit filenames");
 		p = prefix_path(prefix, prefix_length, arg);
 		checkout_file(p, prefix);
-		if (p < arg || p > arg + strlen(arg))
-			free((char *)p);
+		free(p);
 	}
 
 	if (read_from_stdin) {
@@ -260,7 +259,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 			die("git checkout-index: don't mix '--all' and '--stdin'");
 
 		while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
-			const char *p;
+			char *p;
 			if (line_termination && buf.buf[0] == '"') {
 				strbuf_reset(&nbuf);
 				if (unquote_c_style(&nbuf, buf.buf, NULL))
@@ -269,8 +268,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 			}
 			p = prefix_path(prefix, prefix_length, buf.buf);
 			checkout_file(p, prefix);
-			if (p < buf.buf || p > buf.buf + buf.len)
-				free((char *)p);
+			free(p);
 		}
 		strbuf_release(&nbuf);
 		strbuf_release(&buf);
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 6271b54..a92eed2 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -532,10 +532,9 @@ static int do_unresolve(int ac, const char **av,
 
 	for (i = 1; i < ac; i++) {
 		const char *arg = av[i];
-		const char *p = prefix_path(prefix, prefix_length, arg);
+		char *p = prefix_path(prefix, prefix_length, arg);
 		err |= unresolve_one(p);
-		if (p < arg || p > arg + strlen(arg))
-			free((char *)p);
+		free(p);
 	}
 	return err;
 }
-- 
2.4.0.rc3.16.g0ab00b9

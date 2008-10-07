From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH 2/2 v2] check-attr: Add --stdin-paths option
Date: Tue, 7 Oct 2008 04:16:52 +0400
Message-ID: <20081007001652.GR21650@dpotapov.dyndns.org>
References: <bb6f213e0809220312m6cb8022csa3843cfaccc5b69b@mail.gmail.com> <1223173855-6173-1-git-send-email-dpotapov@gmail.com> <1223173855-6173-2-git-send-email-dpotapov@gmail.com> <48E9B997.1010006@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 07 02:18:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn0HB-0002P6-Gt
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 02:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979AbYJGAQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 20:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752953AbYJGAQ6
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 20:16:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:34535 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbYJGAQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 20:16:58 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2128148fgg.17
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 17:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=s1Duwrb4C0CX+CtHVqPyVyDtuDNcPDNQ2R1Wxr8XTeg=;
        b=Wb6msj1xqCia5kobEDqZ5/FopenpGJ+cUU5Fg4xbammOE+4WKgFVZ4dqpwdASg/nMF
         lUjDVfYNP4qiIO85pij+NzjHIHCJ/JjZo9zPHFlJvDNg4kl089ECHz/ZHbbK2kM9jbC9
         YmVvJMaa3+TPgX3hrC/J0YpyZtyRSxGEMOJek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fdLj+Dz+nH3OTYDpzPgLoOEG3jpp1HcMUA1EMYWYR0Rw6Iut4g+sdrPlHWb88Kc7ng
         zbdzUHP6h+wUdHwGxFQgnnQvQyAcIvWGQyCEqzQDY0EL+piWZ+/320MxaMUEhL0WxO7j
         OtL7FUolJjoG+UdrojcUzvMz3u+XrbfF4hRVw=
Received: by 10.86.28.2 with SMTP id b2mr5183540fgb.31.1223338616318;
        Mon, 06 Oct 2008 17:16:56 -0700 (PDT)
Received: from localhost (ppp91-77-160-5.pppoe.mtu-net.ru [91.77.160.5])
        by mx.google.com with ESMTPS id l19sm12458100fgb.7.2008.10.06.17.16.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Oct 2008 17:16:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48E9B997.1010006@viscovery.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97645>

This allows multiple paths to be specified on stdin.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
On Mon, Oct 06, 2008 at 09:09:11AM +0200, Johannes Sixt wrote:
> 
> The least that is needed is fflush(stdout) in this loop (after each
> iteration!)

Thanks. Somehow, I forgot about it though it is quite obvious.
I have added maybe_flush_or_die().

 Documentation/git-check-attr.txt |    4 ++
 builtin-check-attr.c             |   70 ++++++++++++++++++++++++++++++++------
 t/t0003-attributes.sh            |   17 +++++++++
 3 files changed, 80 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 2b821f2..0839a57 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -9,6 +9,7 @@ git-check-attr - Display gitattributes information.
 SYNOPSIS
 --------
 'git check-attr' attr... [--] pathname...
+'git check-attr' --stdin-paths attr... < <list-of-paths
 
 DESCRIPTION
 -----------
@@ -17,6 +18,9 @@ For every pathname, this command will list if each attr is 'unspecified',
 
 OPTIONS
 -------
+--stdin-paths::
+	Read file names from stdin instead of from the command-line.
+
 \--::
 	Interpret all preceding arguments as attributes, and all following
 	arguments as path names. If not supplied, only the first argument will
diff --git a/builtin-check-attr.c b/builtin-check-attr.c
index 786256e..fa1e4d5 100644
--- a/builtin-check-attr.c
+++ b/builtin-check-attr.c
@@ -2,9 +2,19 @@
 #include "cache.h"
 #include "attr.h"
 #include "quote.h"
+#include "parse-options.h"
 
-static const char check_attr_usage[] =
-"git check-attr attr... [--] pathname...";
+static int stdin_paths;
+static const char * const check_attr_usage[] = {
+"git check-attr attr... [--] pathname...",
+"git check-attr --stdin-paths attr... < <list-of-paths>",
+NULL
+};
+
+static const struct option check_attr_options[] = {
+	OPT_BOOLEAN(0 , "stdin-paths", &stdin_paths, "read file names from stdin"),
+	OPT_END()
+};
 
 static void check_attr(int cnt, struct git_attr_check *check,
 	const char** name, const char *file)
@@ -27,17 +37,44 @@ static void check_attr(int cnt, struct git_attr_check *check,
 	}
 }
 
+static void check_attr_stdin_paths(int cnt, struct git_attr_check *check,
+	const char** name)
+{
+	struct strbuf buf, nbuf;
+
+	strbuf_init(&buf, 0);
+	strbuf_init(&nbuf, 0);
+	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
+		if (buf.buf[0] == '"') {
+			strbuf_reset(&nbuf);
+			if (unquote_c_style(&nbuf, buf.buf, NULL))
+				die("line is badly quoted");
+			strbuf_swap(&buf, &nbuf);
+		}
+		check_attr(cnt, check, name, buf.buf);
+		maybe_flush_or_die(stdout, "attribute to stdout");
+	}
+	strbuf_release(&buf);
+	strbuf_release(&nbuf);
+}
+
 int cmd_check_attr(int argc, const char **argv, const char *prefix)
 {
 	struct git_attr_check *check;
 	int cnt, i, doubledash;
+	const char *errstr = NULL;
+
+	argc = parse_options(argc, argv, check_attr_options, check_attr_usage,
+		PARSE_OPT_KEEP_DASHDASH);
+	if (!argc)
+		usage_with_options(check_attr_usage, check_attr_options);
 
 	if (read_cache() < 0) {
 		die("invalid cache");
 	}
 
 	doubledash = -1;
-	for (i = 1; doubledash < 0 && i < argc; i++) {
+	for (i = 0; doubledash < 0 && i < argc; i++) {
 		if (!strcmp(argv[i], "--"))
 			doubledash = i;
 	}
@@ -45,26 +82,37 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	/* If there is no double dash, we handle only one attribute */
 	if (doubledash < 0) {
 		cnt = 1;
-		doubledash = 1;
+		doubledash = 0;
 	} else
-		cnt = doubledash - 1;
+		cnt = doubledash;
 	doubledash++;
 
-	if (cnt <= 0 || argc < doubledash)
-		usage(check_attr_usage);
+	if (cnt <= 0)
+		errstr = "No attribute specified";
+	else if (stdin_paths && doubledash < argc)
+		errstr = "Can't specify files with --stdin-paths";
+	if (errstr) {
+		error (errstr);
+		usage_with_options(check_attr_usage, check_attr_options);
+	}
+
 	check = xcalloc(cnt, sizeof(*check));
 	for (i = 0; i < cnt; i++) {
 		const char *name;
 		struct git_attr *a;
-		name = argv[i + 1];
+		name = argv[i];
 		a = git_attr(name, strlen(name));
 		if (!a)
 			return error("%s: not a valid attribute name", name);
 		check[i].attr = a;
 	}
 
-	for (i = doubledash; i < argc; i++)
-		check_attr(cnt, check, argv+1, argv[i]);
-	maybe_flush_or_die(stdout, "attribute to stdout");
+	if (stdin_paths)
+		check_attr_stdin_paths(cnt, check, argv);
+	else {
+		for (i = doubledash; i < argc; i++)
+			check_attr(cnt, check, argv, argv[i]);
+		maybe_flush_or_die(stdout, "attribute to stdout");
+	}
 	return 0;
 }
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 3d8e06a..f6901b4 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -47,6 +47,23 @@ test_expect_success 'attribute test' '
 
 '
 
+test_expect_success 'attribute test: read paths from stdin' '
+
+	cat <<EOF > expect
+f: test: f
+a/f: test: f
+a/c/f: test: f
+a/g: test: a/g
+a/b/g: test: a/b/g
+b/g: test: unspecified
+a/b/h: test: a/b/h
+a/b/d/g: test: a/b/d/*
+EOF
+
+	sed -e "s/:.*//" < expect | git check-attr --stdin-paths test > actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'root subdir attribute test' '
 
 	attr_check a/i a/i &&
-- 
1.6.0.2.447.g3befd

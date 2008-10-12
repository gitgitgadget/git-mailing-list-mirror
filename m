From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 2/2 v2] check-attr: Add --stdin-paths option
Date: Sun, 12 Oct 2008 20:35:05 +0400
Message-ID: <20081012163504.GF21650@dpotapov.dyndns.org>
References: <bb6f213e0809220312m6cb8022csa3843cfaccc5b69b@mail.gmail.com> <1223173855-6173-1-git-send-email-dpotapov@gmail.com> <1223173855-6173-2-git-send-email-dpotapov@gmail.com> <48E9B997.1010006@viscovery.net> <20081007001652.GR21650@dpotapov.dyndns.org> <20081008152443.GA4795@spearce.org> <20081012141952.GD21650@dpotapov.dyndns.org> <gct3lk$s16$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 12 18:36:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp3vm-0006q8-8T
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 18:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035AbYJLQfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 12:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752482AbYJLQfU
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 12:35:20 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:4056 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbYJLQfT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 12:35:19 -0400
Received: by fg-out-1718.google.com with SMTP id 19so948136fgg.17
        for <git@vger.kernel.org>; Sun, 12 Oct 2008 09:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=RJ2+g5hEX4yZ7W+Xo0WlJsxn3fWnXXss2Az8ZnJdwVw=;
        b=WEMW+aL+RRt5uTk9YU24Q7kxGfvIiAL5iYNfPHy27/S2a67WIVrVaAgFzK+8l3Vbae
         I6EzLG1j598H3R1Vr0J9p7njcEteh+u8fmFHImhESDlKeLY9BJQ5A0l79fgGCilnlOFs
         wfNYICx5WHiH9JWoIbphCuCbJ6d6MHEN+n/lo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RJKFoFyaYBr+bqcjuhtkHoQXsi5Ak0S3wkywcBJFNBEjWlF626Bo3sXaT1uBQX+68J
         3B1Ldhd1kbLM07d7hFr4/ElwxOU7RabmQzV8iajGSTIA7PB/xXam46XtG4C9OaQfilH8
         plJimHL25rllGpY6tjJdSl7dXGH7v2qtAhaNc=
Received: by 10.86.57.9 with SMTP id f9mr4069027fga.66.1223829317303;
        Sun, 12 Oct 2008 09:35:17 -0700 (PDT)
Received: from localhost (ppp91-77-162-44.pppoe.mtu-net.ru [91.77.162.44])
        by mx.google.com with ESMTPS id 3sm5722884fge.3.2008.10.12.09.35.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Oct 2008 09:35:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <gct3lk$s16$1@ger.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98035>

On Sun, Oct 12, 2008 at 05:04:21PM +0200, Jakub Narebski wrote:
> Dmitry Potapov wrote:
> 
> >> And since its being
> >> used mostly by automated tools (gitk/git-gui) I wonder if a -z should
> >> also be supported for input termination with NUL instead of LF.
> > 
> > I have added it, but after I did, I start to wonder whether it is the
> > right thing to do to unquote NUL terminated input line?
> 
> I think that -z should be not quoted (like git-diff-tree or git-ls-tree
> _output_); if it is, then IMHO it is a bug.

I am sorry. I was obviously wrong about 'git checkout-index', as it does
not try to unquote if '-z' is specified. So, my previous patch was wrong.
The corrected patch is below.

It still uses the same output format whether '-z' is specified or not.
Maybe I should change that too to use '\0' as the separator if '-z' is
specified?

Dmitry
PS Please, add me to 'To:' or 'Cc:' when you reply to my email.


-- >8 --
From: Dmitry Potapov <dpotapov@gmail.com>
Date: Sun, 12 Oct 2008 18:08:43 +0400
Subject: [PATCH] check-attr: Add --stdin option

---
This patch is meant to be squash on top of dp/checkattr in pu.

 Documentation/git-check-attr.txt |    8 ++++++--
 builtin-check-attr.c             |   15 ++++++++++-----
 t/t0003-attributes.sh            |    2 +-
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 0839a57..14e4374 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -9,7 +9,7 @@ git-check-attr - Display gitattributes information.
 SYNOPSIS
 --------
 'git check-attr' attr... [--] pathname...
-'git check-attr' --stdin-paths attr... < <list-of-paths
+'git check-attr' --stdin [-z] attr... < <list-of-paths
 
 DESCRIPTION
 -----------
@@ -18,9 +18,13 @@ For every pathname, this command will list if each attr is 'unspecified',
 
 OPTIONS
 -------
---stdin-paths::
+--stdin::
 	Read file names from stdin instead of from the command-line.
 
+-z::
+	Only meaningful with `--stdin`; paths are separated with
+	NUL character instead of LF.
+
 \--::
 	Interpret all preceding arguments as attributes, and all following
 	arguments as path names. If not supplied, only the first argument will
diff --git a/builtin-check-attr.c b/builtin-check-attr.c
index fa1e4d5..4921341 100644
--- a/builtin-check-attr.c
+++ b/builtin-check-attr.c
@@ -7,12 +7,16 @@
 static int stdin_paths;
 static const char * const check_attr_usage[] = {
 "git check-attr attr... [--] pathname...",
-"git check-attr --stdin-paths attr... < <list-of-paths>",
+"git check-attr --stdin attr... < <list-of-paths>",
 NULL
 };
 
+static int null_term_line;
+
 static const struct option check_attr_options[] = {
-	OPT_BOOLEAN(0 , "stdin-paths", &stdin_paths, "read file names from stdin"),
+	OPT_BOOLEAN(0 , "stdin", &stdin_paths, "read file names from stdin"),
+	OPT_BOOLEAN('z', NULL, &null_term_line,
+		"input paths are terminated by a null character"),
 	OPT_END()
 };
 
@@ -41,11 +45,12 @@ static void check_attr_stdin_paths(int cnt, struct git_attr_check *check,
 	const char** name)
 {
 	struct strbuf buf, nbuf;
+	int line_termination = null_term_line ? 0 : '\n';
 
 	strbuf_init(&buf, 0);
 	strbuf_init(&nbuf, 0);
-	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
-		if (buf.buf[0] == '"') {
+	while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
+		if (line_termination && buf.buf[0] == '"') {
 			strbuf_reset(&nbuf);
 			if (unquote_c_style(&nbuf, buf.buf, NULL))
 				die("line is badly quoted");
@@ -90,7 +95,7 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	if (cnt <= 0)
 		errstr = "No attribute specified";
 	else if (stdin_paths && doubledash < argc)
-		errstr = "Can't specify files with --stdin-paths";
+		errstr = "Can't specify files with --stdin";
 	if (errstr) {
 		error (errstr);
 		usage_with_options(check_attr_usage, check_attr_options);
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index f6901b4..1c77192 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -60,7 +60,7 @@ a/b/h: test: a/b/h
 a/b/d/g: test: a/b/d/*
 EOF
 
-	sed -e "s/:.*//" < expect | git check-attr --stdin-paths test > actual &&
+	sed -e "s/:.*//" < expect | git check-attr --stdin test > actual &&
 	test_cmp expect actual
 '
 
-- 
1.6.0.2.521.g739d3

-- >8 --

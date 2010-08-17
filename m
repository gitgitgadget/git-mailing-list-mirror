From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/24 v2] fmt-merge-msg -m to override merge title
Date: Tue, 17 Aug 2010 18:00:34 -0500
Message-ID: <20100817230034.GG2221@burratino>
References: <20100817065147.GA18293@burratino>
 <20100817070245.GK22057@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 18 01:02:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlVAf-0007ue-KY
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 01:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379Ab0HQXCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 19:02:13 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:65079 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab0HQXCL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 19:02:11 -0400
Received: by vws3 with SMTP id 3so5110711vws.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 16:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=AEd3irf9RAZ6EX2AVvaIP14CvFMT9u/3GjzY8uE5cCk=;
        b=UGaav2RAf8LYJpcWq5CyTC1qkX2S5IM69jEiMvFb5r6UHPFLYAhcS9lWiQNq+YbRK5
         7wR0Sp7wT5QhjC6qnSz1NtUrmj5NW7dR86ybqgkGf+uwNeG0CFoIamVhcTGMoKaNW+jd
         or5oHLwlChWcB9i9nd9jU8JL3gNII6HxH4RQA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lEFW5AicydElpso09r9lDezd0tisht76txoWnksVs7okgcRozuO41h0GmgmRNdER7Q
         2mCa+feDEisnT/jo5XfEB/B0pj+6P00Ai5gaesF3/er81+bzMxE+8MA2MW88F4o6dW57
         E599TopNrvCeEWU2DyUBqh/4Xd/jCbNKx8UuI=
Received: by 10.220.62.136 with SMTP id x8mr4462644vch.10.1282086130856;
        Tue, 17 Aug 2010 16:02:10 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id v11sm4592921vbb.11.2010.08.17.16.02.09
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 16:02:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100817070245.GK22057@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153785>

Since v1.7.1.1~23^2 (merge: --log appends shortlog to message if
specified, 2010-05-11), the fmt-merge-msg backend supports custom text
to override the merge title "Merge <foo> into <bar>".

Expose this functionality for scripted callers.  Example:

 git fmt-merge-msg --log -m \
	"$(printf '%s\n' \
	    "Merge branch 'api-cleanup' into feature" \
	    '' \
	    'This is to use a few functions refactored for this purpose.'
	)" <.git/FETCH_HEAD

Cc: Tay Ray Chuan <rctay89@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jonathan Nieder wrote:

> +'git fmt-merge-msg' [-m <subject>] [--log ]| --no-log] -F <file>

Oops.

> +-m <subject>::
> +--message <subject>::

Since the message is used to start the body of the message in
addition to the subject, the generic word <message> seems clearer.

> -	"git fmt-merge-msg [--log|--no-log] [--file <file>]",
> +	"git fmt-merge-msg [-m <online>] [--log|--no-log] [--file <file>]",

Likewise.

> +		OPT_STRING('m', "message", &oneline_msg, "oneline",
> +			"use <oneline> as subject line"),

Likewise.

 Documentation/git-fmt-merge-msg.txt |    9 +++++++--
 builtin/fmt-merge-msg.c             |   18 ++++++++++++++++--
 t/t6200-fmt-merge-msg.sh            |   32 ++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index a585dbe..302f56b 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -9,8 +9,8 @@ git-fmt-merge-msg - Produce a merge commit message
 SYNOPSIS
 --------
 [verse]
-'git fmt-merge-msg' [--log | --no-log] <$GIT_DIR/FETCH_HEAD
-'git fmt-merge-msg' [--log | --no-log] -F <file>
+'git fmt-merge-msg' [-m <message>] [--log | --no-log] <$GIT_DIR/FETCH_HEAD
+'git fmt-merge-msg' [-m <message>] [--log | --no-log] -F <file>
 
 DESCRIPTION
 -----------
@@ -38,6 +38,11 @@ OPTIONS
 	Synonyms to --log and --no-log; these are deprecated and will be
 	removed in the future.
 
+-m <message>::
+--message <message>::
+	Use <message> instead of the branch names for the first line
+	of the log message.  For use with `--log`.
+
 -F <file>::
 --file <file>::
 	Take the list of merged objects from <file> instead of
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index bc3c5e6..937d5a7 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -7,7 +7,7 @@
 #include "string-list.h"
 
 static const char * const fmt_merge_msg_usage[] = {
-	"git fmt-merge-msg [--log|--no-log] [--file <file>]",
+	"git fmt-merge-msg [-m <message>] [--log|--no-log] [--file <file>]",
 	NULL
 };
 
@@ -319,11 +319,14 @@ int fmt_merge_msg_shortlog(struct strbuf *in, struct strbuf *out) {
 int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 {
 	const char *inpath = NULL;
+	const char *message = NULL;
 	struct option options[] = {
 		OPT_BOOLEAN(0, "log",     &merge_summary, "populate log with the shortlog"),
 		{ OPTION_BOOLEAN, 0, "summary", &merge_summary, NULL,
 		  "alias for --log (deprecated)",
 		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
+		OPT_STRING('m', "message", &message, "text",
+			"use <text> as start of message"),
 		OPT_FILENAME('F', "file", &inpath, "file to read from"),
 		OPT_END()
 	};
@@ -337,6 +340,12 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 			     0);
 	if (argc > 0)
 		usage_with_options(fmt_merge_msg_usage, options);
+	if (message && !merge_summary) {
+		char nl = '\n';
+		write_in_full(STDOUT_FILENO, message, strlen(message));
+		write_in_full(STDOUT_FILENO, &nl, 1);
+		return 0;
+	}
 
 	if (inpath && strcmp(inpath, "-")) {
 		in = fopen(inpath, "r");
@@ -346,7 +355,12 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 
 	if (strbuf_read(&input, fileno(in), 0) < 0)
 		die_errno("could not read input file");
-	ret = fmt_merge_msg(merge_summary, &input, &output);
+	if (message) {
+		strbuf_addstr(&output, message);
+		ret = fmt_merge_msg_shortlog(&input, &output);
+	} else {
+		ret = fmt_merge_msg(merge_summary, &input, &output);
+	}
 	if (ret)
 		return ret;
 	write_in_full(STDOUT_FILENO, output.buf, output.len);
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 5553dff..71f6cad 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -129,6 +129,38 @@ test_expect_success '[merge] summary/log configuration' '
 	test_cmp expected actual2
 '
 
+test_expect_success 'fmt-merge-msg -m' '
+	echo "Sync with left" >expected &&
+	cat >expected.log <<-EOF &&
+	Sync with left
+
+	* ${apos}left${apos} of $(pwd):
+	  Left #5
+	  Left #4
+	  Left #3
+	  Common #2
+	  Common #1
+	EOF
+
+	test_might_fail git config --unset merge.log &&
+	test_might_fail git config --unset merge.summary &&
+	git checkout master &&
+	git fetch "$(pwd)" left &&
+	git fmt-merge-msg -m "Sync with left" <.git/FETCH_HEAD >actual &&
+	git fmt-merge-msg --log -m "Sync with left" \
+					<.git/FETCH_HEAD >actual.log &&
+	git config merge.log true &&
+	git fmt-merge-msg -m "Sync with left" \
+					<.git/FETCH_HEAD >actual.log-config &&
+	git fmt-merge-msg --no-log -m "Sync with left" \
+					<.git/FETCH_HEAD >actual.nolog &&
+
+	test_cmp expected actual &&
+	test_cmp expected.log actual.log &&
+	test_cmp expected.log actual.log-config &&
+	test_cmp expected actual.nolog
+'
+
 test_expect_success 'setup: expected shortlog for two branches' '
 	cat >expected <<-EOF
 	Merge branches ${apos}left${apos} and ${apos}right${apos}
-- 
1.7.2.1.544.ga752d.dirty

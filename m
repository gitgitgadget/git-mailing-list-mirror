Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6923C20986
	for <e@80x24.org>; Tue,  4 Oct 2016 17:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752755AbcJDR5Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 13:57:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53170 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752072AbcJDR5P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 13:57:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 294F5411D1;
        Tue,  4 Oct 2016 13:57:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iWixm0nrk5jqSqyC5G4sV0fR+XM=; b=Jw3Le4
        xZdU7+G0uh3GgK6uaEAWzukdqMa3BBiYxS53vnarQuolDYcHTdoV31Eptt/pxupa
        DyXtLVSzzK0Kkm5EVTEB2cY/Qy97qdfILlwVZ+cRCGYsVfBoObkNHCO1KdGkQyyv
        BF+y7xwtgESCtyhdFODv8KYOGfRNJgOgkOwyM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g5PjO+sPBvZ9Dnus5qKd/Byo3yJ1O405
        0+OGxwGvAo2L7tBNrRgd6LCI/PleO0tESD3iODEh3q5BtxxWnZMwUV8dMA0xcDd5
        Lrtgv4/xJhgkRsmRQcZEdreVQTGzIvRI5T5ql9PAwDs6WmBgWPqGkMmgPbajz4pI
        frG874qkqEs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 20C81411D0;
        Tue,  4 Oct 2016 13:57:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7D5C5411CF;
        Tue,  4 Oct 2016 13:57:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Sandro Santilli <strk@kbt.io>, git@vger.kernel.org
Subject: Re: color.diff.whitespace unused on removed lines
References: <20161004081429.GC17002@localhost>
        <20161004152954.74bojbyagxr2xefz@sigill.intra.peff.net>
        <20161004153523.GA2798@localhost>
        <20161004161323.53qec37i2tujaxcy@sigill.intra.peff.net>
Date:   Tue, 04 Oct 2016 10:57:11 -0700
In-Reply-To: <20161004161323.53qec37i2tujaxcy@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 4 Oct 2016 12:13:24 -0400")
Message-ID: <xmqqk2douhe0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FAC55A12-8A5B-11E6-8C6E-60E27A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Oct 04, 2016 at 05:35:23PM +0200, Sandro Santilli wrote:
>
>> > We later did b8767f7 (diff.c: --ws-error-highlight=<kind> option,
>> > 2015-05-26) to let you see them on other lines, though. I think that
>> > would do what you want.
>> 
>> Thanks, it does do what I want.
>> Any chance to specify it in the config file that I want it
>> always to behave in a certain way ?
>
> No, I don't think there's currently a matching config option. You can
> use an alias, or propose a patch to add a config option.

The final shape of such a patch would include something like the
attached.  It would need to be split into a few patches and then get
additional tests and documentation written, so I won't be committing
it myself in this shape.


 diff.c | 84 +++++++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 50 insertions(+), 34 deletions(-)

diff --git a/diff.c b/diff.c
index a178ed39bc..a2193c3aea 100644
--- a/diff.c
+++ b/diff.c
@@ -43,6 +43,7 @@ static int diff_stat_graph_width;
 static int diff_dirstat_permille_default = 30;
 static struct diff_options default_diff_options;
 static long diff_algorithm;
+static unsigned ws_error_highlight_default = WSEH_NEW;
 
 static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
@@ -172,6 +173,42 @@ long parse_algorithm_value(const char *value)
 	return -1;
 }
 
+static int parse_one_token(const char **arg, const char *token)
+{
+	const char *rest;
+	if (skip_prefix(*arg, token, &rest) && (!*rest || *rest == ',')) {
+		*arg = rest;
+		return 1;
+	}
+	return 0;
+}
+
+static int parse_ws_error_highlight(const char *arg)
+{
+	const char *orig_arg = arg;
+	unsigned val = 0;
+	while (*arg) {
+		if (parse_one_token(&arg, "none"))
+			val = 0;
+		else if (parse_one_token(&arg, "default"))
+			val = WSEH_NEW;
+		else if (parse_one_token(&arg, "all"))
+			val = WSEH_NEW | WSEH_OLD | WSEH_CONTEXT;
+		else if (parse_one_token(&arg, "new"))
+			val |= WSEH_NEW;
+		else if (parse_one_token(&arg, "old"))
+			val |= WSEH_OLD;
+		else if (parse_one_token(&arg, "context"))
+			val |= WSEH_CONTEXT;
+		else {
+			return (orig_arg - arg);
+		}
+		if (*arg)
+			arg++;
+	}
+	return val;
+}
+
 /*
  * These are to give UI layer defaults.
  * The core-level commands such as git-diff-files should
@@ -254,6 +291,11 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "diff.wserrorhighlight")) {
+		ws_error_highlight_default = parse_ws_error_highlight(value);
+		return 0;
+	}
+
 	if (git_diff_heuristic_config(var, value, cb) < 0)
 		return -1;
 	if (git_color_config(var, value, cb) < 0)
@@ -3307,7 +3349,7 @@ void diff_setup(struct diff_options *options)
 	options->rename_limit = -1;
 	options->dirstat_permille = diff_dirstat_permille_default;
 	options->context = diff_context_default;
-	options->ws_error_highlight = WSEH_NEW;
+	options->ws_error_highlight = ws_error_highlight_default;
 	DIFF_OPT_SET(options, RENAME_EMPTY);
 
 	/* pathchange left =NULL by default */
@@ -3698,40 +3740,14 @@ static void enable_patch_output(int *fmt) {
 	*fmt |= DIFF_FORMAT_PATCH;
 }
 
-static int parse_one_token(const char **arg, const char *token)
+static int parse_ws_error_highlight_opt(struct diff_options *opt, const char *arg)
 {
-	const char *rest;
-	if (skip_prefix(*arg, token, &rest) && (!*rest || *rest == ',')) {
-		*arg = rest;
-		return 1;
-	}
-	return 0;
-}
+	int val = parse_ws_error_highlight(arg);
 
-static int parse_ws_error_highlight(struct diff_options *opt, const char *arg)
-{
-	const char *orig_arg = arg;
-	unsigned val = 0;
-	while (*arg) {
-		if (parse_one_token(&arg, "none"))
-			val = 0;
-		else if (parse_one_token(&arg, "default"))
-			val = WSEH_NEW;
-		else if (parse_one_token(&arg, "all"))
-			val = WSEH_NEW | WSEH_OLD | WSEH_CONTEXT;
-		else if (parse_one_token(&arg, "new"))
-			val |= WSEH_NEW;
-		else if (parse_one_token(&arg, "old"))
-			val |= WSEH_OLD;
-		else if (parse_one_token(&arg, "context"))
-			val |= WSEH_CONTEXT;
-		else {
-			error("unknown value after ws-error-highlight=%.*s",
-			      (int)(arg - orig_arg), orig_arg);
-			return 0;
-		}
-		if (*arg)
-			arg++;
+	if (val < 0) {
+		error("unknown value after ws-error-highlight=%.*s",
+		      -val, arg);
+		return 0;
 	}
 	opt->ws_error_highlight = val;
 	return 1;
@@ -3950,7 +3966,7 @@ int diff_opt_parse(struct diff_options *options,
 	else if (skip_prefix(arg, "--submodule=", &arg))
 		return parse_submodule_opt(options, arg);
 	else if (skip_prefix(arg, "--ws-error-highlight=", &arg))
-		return parse_ws_error_highlight(options, arg);
+		return parse_ws_error_highlight_opt(options, arg);
 
 	/* misc options */
 	else if (!strcmp(arg, "-z"))

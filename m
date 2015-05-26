From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Mark trailing whitespace error in del lines of diff
Date: Tue, 26 May 2015 10:34:32 -0700
Message-ID: <xmqq617fkztj.fsf@gitster.dls.corp.google.com>
References: <9b8e349e223dc9cd871fc5f7915e590548322932.1432585659.git.cb@256bit.org>
	<20150525222215.GI26436@vauxhall.crustytoothpaste.net>
	<xmqqbnh89r0z.fsf@gitster.dls.corp.google.com>
	<20150526162937.GA24439@256bit.org>
	<xmqqegm3l06u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Christian Brabandt <cblists@256bit.org>
X-From: git-owner@vger.kernel.org Tue May 26 19:34:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxIkR-0004jr-QQ
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 19:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbbEZRef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 13:34:35 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35733 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbbEZRee (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 13:34:34 -0400
Received: by igbyr2 with SMTP id yr2so64413857igb.0
        for <git@vger.kernel.org>; Tue, 26 May 2015 10:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=riGVrizBFGPiTgtC5WOjMJII6lhs/fqcaiFGB3G3YDA=;
        b=eklXfQlFEhOvC7XC4W8GQcaBsMYcdbDTK/lA3XXNHDjRxQyJKN1FMsenAlL1XDS/ke
         ducwsdc4GHpZK4ZBYCbb1QJm0p0EEn+0VTKYAPtbGVkaUb4/my4rbKlzE1J+eAcRtsIP
         FwyUBi9Ruw2H59unZC+Y60eoqbU6T4EkhUBWf3hmgwQbuhGrd0PYicYrZqnC0Xh4Z/iC
         jiwR4TU8alVhWbtpJddmNMjpz9ItKELYb5QEhl8GXcW+BR/d3KD+Xv+PFoRZbYZPBPYV
         rskKxZUpd02iSSJ/OT9db73w0pw1f+rlC6cIBxqBWIeaAdPdH0g9QWloVQxFpX9eqALq
         qtRQ==
X-Received: by 10.50.102.68 with SMTP id fm4mr31249408igb.25.1432661674186;
        Tue, 26 May 2015 10:34:34 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f93e:abc0:fe54:4a5a])
        by mx.google.com with ESMTPSA id u35sm1672441iou.7.2015.05.26.10.34.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 10:34:33 -0700 (PDT)
In-Reply-To: <xmqqegm3l06u.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 26 May 2015 10:26:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269956>

Junio C Hamano <gitster@pobox.com> writes:

> I'll send out two patch series to do the painting part (I didn't
> want to touch "--check", as its utility is even more dubious
> compared to painting, at least to me).

And here is the second one.

-- >8 --
Subject: [PATCH 2/2] diff.c: --ws-check-deleted option

Traditionally, we only cared about whitespace breakages introduced
in new lines.  Some people want to paint whitespace breakages on old
lines, too.  When they see a whitespace breakage on a new line, they
can spot the same kind of whitespace breakage on the corresponding
old line and want to say "Ah, that breakage is there but was
inherited from the original, so let's not fix that for now."

Enable such use with the new option, "--ws-check-deleted".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-options.txt |  7 +++++++
 diff.c                         | 21 ++++++++++++++++++++-
 diff.h                         |  1 +
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index b7c3afe..617cbc6 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -282,6 +282,13 @@ ifndef::git-format-patch[]
 	initial indent of the line are considered whitespace errors.
 	Exits with non-zero status if problems are found. Not compatible
 	with --exit-code.
+
+--ws-check-deleted::
+--no-ws-check-deleted::
+	Highlight whitespace errors in deleted lines in the color
+	specified by `color.diff.whitespace`, as well as in added
+	lines.
+
 endif::git-format-patch[]
 
 --full-index::
diff --git a/diff.c b/diff.c
index 93c1eb4..44cc234 100644
--- a/diff.c
+++ b/diff.c
@@ -503,8 +503,22 @@ static void emit_del_line(const char *reset,
 			  const char *line, int len)
 {
 	const char *set = diff_get_color(ecbdata->color_diff, DIFF_FILE_OLD);
+	const char *ws = NULL;
 
-	emit_line_0(ecbdata->opt, set, reset, '-', line, len);
+	if (ecbdata->opt->ws_check_deleted) {
+		ws = diff_get_color(ecbdata->color_diff, DIFF_WHITESPACE);
+		if (!*ws)
+			ws = NULL;
+	}
+
+	if (!ws)
+		emit_line_0(ecbdata->opt, set, reset, '-', line, len);
+	else {
+		/* Emit just the prefix, then the rest. */
+		emit_line_0(ecbdata->opt, set, reset, '-', "", 0);
+		ws_check_emit(line, len, ecbdata->ws_rule,
+			      ecbdata->opt->file, set, reset, ws);
+	}
 }
 
 static void emit_hunk_header(struct emit_callback *ecbdata,
@@ -3819,6 +3833,11 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	else if (skip_prefix(arg, "--submodule=", &arg))
 		return parse_submodule_opt(options, arg);
 
+	else if (!strcmp(arg, "--ws-check-deleted"))
+		options->ws_check_deleted = 1;
+	else if (!strcmp(arg, "--no-ws-check-deleted"))
+		options->ws_check_deleted = 0;
+
 	/* misc options */
 	else if (!strcmp(arg, "-z"))
 		options->line_termination = 0;
diff --git a/diff.h b/diff.h
index f6fdf49..baca5ec 100644
--- a/diff.h
+++ b/diff.h
@@ -138,6 +138,7 @@ struct diff_options {
 	int dirstat_permille;
 	int setup;
 	int abbrev;
+	int ws_check_deleted;
 	const char *prefix;
 	int prefix_length;
 	const char *stat_sep;
-- 
2.4.1-511-gc1146d5

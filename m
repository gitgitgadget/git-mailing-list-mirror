From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] log: add log.follow config option
Date: Thu, 09 Jul 2015 10:23:24 -0700
Message-ID: <xmqqegkhw8hf.fsf@gitster.dls.corp.google.com>
References: <1436377321-8495-1-git-send-email-dturner@twopensource.com>
	<vpqfv4xafpp.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 09 19:23:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDFXp-0000SE-Lk
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 19:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbbGIRX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 13:23:29 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36033 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbbGIRX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 13:23:27 -0400
Received: by igrv9 with SMTP id v9so228664488igr.1
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 10:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=xMCQI9r25gwDe40VR05yzdPYfbErg2GQsm/MdD4QpxM=;
        b=Yv69zMSCN5ZGWPCWqrbbjF5hoW1BTSsTEKA3nMWLJtGEFWbMnqXH6McOSh+hC0wJhj
         K9gbBL77ABVopCvz89b7e0nSGlbqMSPOIMJyi8sykVTtr5e3uK8Zoux26Ftyu9dDbpO8
         J63ZGsyPPtXatEsxjnIGq/tr7bBCBn2DpucJKj2u512Kto3WxJ0/9jbS0/a2gBuKZj5l
         xUXSnE8PToCvEBxH3zklAhkWbw0bcz4hfKlajbX4LkeSI9lf9Yk1QhuVi41fFv73Q875
         LXjU/VQ9NwRA9RVMa50pNPx50yXQAzF+UgJPaOhBMT/NgVa8O++T1dbouaeA3ptzsynE
         XA2g==
X-Received: by 10.50.79.129 with SMTP id j1mr97266042igx.12.1436462606773;
        Thu, 09 Jul 2015 10:23:26 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:647a:d824:a8a3:7bb0])
        by smtp.gmail.com with ESMTPSA id c12sm4584746ioj.39.2015.07.09.10.23.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 09 Jul 2015 10:23:25 -0700 (PDT)
In-Reply-To: <vpqfv4xafpp.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	09 Jul 2015 10:38:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273761>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> David Turner <dturner@twopensource.com> writes:
>
>> This version uses tweak, and also includes Matthieu Moy's suggested
>> whitespace fix.
>
> This comment should come below the --- after the commit message (right
> before the diffstat). Otherwise, Junio will get this as the commit
> message when applying, and your actual commit message will be ignored.
>
>> ---
>> Many users prefer to always use --follow with logs.  Rather than
>> aliasing the command, an option might be more convenient for some.
>>
>> Junio C Hamano <gitster@pobox.com> suggested using the tweak
>> functionality for this, which is much nicer than what I had before.
>
> I would avoid using "what I had before" in the commit message: readers
> of "git log" do not know what you had before.

That, together with "This version uses...", should go below the
three-dash line after the real log message.  "compared to what I had
before" is a perfectly good thing to say to help reviewers there.

> OTOH, crediting Junio for the idea is good.

I do not think I deserve anything more than a Helped-by on this
particular one, if any.

More importantly, the "real log message" part somewhat lacking, I
think.  The commit author is in no position to declare "Many users
prefer X" as if it were a fact.  But the author is in a very good
position to explain:

 - why users might want to do X under what condition;
 - how the new feature helps them do so; and
 - how the implementation carefully avoids not doing unwanted things
   when inappropriate.

all of which would give good justifications for the change.

If I were David and sending this v4 patch, it would have looked like
this.

-- >8 --

From: David Turner <dturner@twopensource.com>
Date: Tue, 7 Jul 2015 21:29:34 -0400
Subject: [PATCH v4] log: add "log.follow" configuration variable

People who work on projects with mostly linear history with frequent
whole file renames may want to always use "git log --follow" when
inspecting the life of the content that live in a single path.

Teach the command to behave as if "--follow" was given from the
command line when log.follow configuration variable is set *and*
there is one (and only one) path on the command line.

Signed-off-by: David Turner <dturner@twopensource.com>
---

 * Changes from v3:
   - fixed whitespace breakage in test, pointed out by Matthieu
   - revert all changes to revision.c; instead use the existing
     opt->tweak() mechanism, suggested by Junio

 Documentation/git-log.txt |  6 ++++++
 builtin/log.c             | 16 ++++++++++++++++
 diff.c                    |  5 +++--
 diff.h                    |  1 +
 t/t4202-log.sh            | 23 +++++++++++++++++++++++
 5 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 5692945..79bf4d4 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -184,6 +184,12 @@ log.date::
 	`--date` option.)  Defaults to "default", which means to write
 	dates like `Sat May 8 19:35:34 2010 -0500`.
 
+log.follow::
+	If a single <path> is given to git log, it will act as
+	if the `--follow` option was also used.  This has the same
+	limitations as `--follow`, i.e. it cannot be used to follow
+	multiple files and does not work well on non-linear history.
+
 log.showRoot::
 	If `false`, `git log` and related commands will not treat the
 	initial commit as a big creation event.  Any root commits in
diff --git a/builtin/log.c b/builtin/log.c
index 8781049..d06248a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -31,6 +31,7 @@ static const char *default_date_mode = NULL;
 
 static int default_abbrev_commit;
 static int default_show_root = 1;
+static int default_follow;
 static int decoration_style;
 static int decoration_given;
 static int use_mailmap_config;
@@ -102,6 +103,8 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 {
 	if (fmt_pretty)
 		get_commit_format(fmt_pretty, rev);
+	if (default_follow)
+		DIFF_OPT_SET(&rev->diffopt, DEFAULT_FOLLOW_RENAMES);
 	rev->verbose_header = 1;
 	DIFF_OPT_SET(&rev->diffopt, RECURSIVE);
 	rev->diffopt.stat_width = -1; /* use full terminal width */
@@ -390,6 +393,10 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		default_show_root = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "log.follow")) {
+		default_follow = git_config_bool(var, value);
+		return 0;
+	}
 	if (skip_prefix(var, "color.decorate.", &slot_name))
 		return parse_decorate_color_config(var, slot_name, value);
 	if (!strcmp(var, "log.mailmap")) {
@@ -618,6 +625,14 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	return cmd_log_walk(&rev);
 }
 
+static void default_follow_tweak(struct rev_info *rev,
+				 struct setup_revision_opt *opt)
+{
+	if (DIFF_OPT_TST(&rev->diffopt, DEFAULT_FOLLOW_RENAMES) &&
+	    rev->prune_data.nr == 1)
+		DIFF_OPT_SET(&rev->diffopt, FOLLOW_RENAMES);
+}
+
 int cmd_log(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
@@ -631,6 +646,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
 	opt.revarg_opt = REVARG_COMMITTISH;
+	opt.tweak = default_follow_tweak;
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
 	return cmd_log_walk(&rev);
 }
diff --git a/diff.c b/diff.c
index 87b16d5..135b222 100644
--- a/diff.c
+++ b/diff.c
@@ -3815,9 +3815,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_SET(options, FIND_COPIES_HARDER);
 	else if (!strcmp(arg, "--follow"))
 		DIFF_OPT_SET(options, FOLLOW_RENAMES);
-	else if (!strcmp(arg, "--no-follow"))
+	else if (!strcmp(arg, "--no-follow")) {
 		DIFF_OPT_CLR(options, FOLLOW_RENAMES);
-	else if (!strcmp(arg, "--color"))
+		DIFF_OPT_CLR(options, DEFAULT_FOLLOW_RENAMES);
+	} else if (!strcmp(arg, "--color"))
 		options->use_color = 1;
 	else if (skip_prefix(arg, "--color=", &arg)) {
 		int value = git_config_colorbool(NULL, arg);
diff --git a/diff.h b/diff.h
index c7ad42a..f7208ad 100644
--- a/diff.h
+++ b/diff.h
@@ -91,6 +91,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_DIRSTAT_BY_LINE     (1 << 28)
 #define DIFF_OPT_FUNCCONTEXT         (1 << 29)
 #define DIFF_OPT_PICKAXE_IGNORE_CASE (1 << 30)
+#define DIFF_OPT_DEFAULT_FOLLOW_RENAMES (1 << 31)
 
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_TOUCHED(opts, flag)    ((opts)->touched_flags & DIFF_OPT_##flag)
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 1b2e981..35d2d7c 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -146,7 +146,30 @@ test_expect_success 'git log --follow' '
 	actual=$(git log --follow --pretty="format:%s" ichi) &&
 	expect=$(echo third ; echo second ; echo initial) &&
 	verbose test "$actual" = "$expect"
+'
+
+test_expect_success 'git config log.follow works like --follow' '
+	test_config log.follow true &&
+	actual=$(git log --pretty="format:%s" ichi) &&
+	expect=$(echo third ; echo second ; echo initial) &&
+	verbose test "$actual" = "$expect"
+'
 
+test_expect_success 'git config log.follow does not die with multiple paths' '
+	test_config log.follow true &&
+	git log --pretty="format:%s" ichi ein
+'
+
+test_expect_success 'git config log.follow does not die with no paths' '
+	test_config log.follow true &&
+	git log --
+'
+
+test_expect_success 'git config log.follow is overridden by --no-follow' '
+	test_config log.follow true &&
+	actual=$(git log --no-follow --pretty="format:%s" ichi) &&
+	expect="third" &&
+	verbose test "$actual" = "$expect"
 '
 
 cat > expect << EOF
-- 
2.5.0-rc1-326-g3cdaa82

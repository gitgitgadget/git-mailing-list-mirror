Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18E141F461
	for <e@80x24.org>; Mon,  2 Sep 2019 18:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfIBSIe (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 14:08:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36785 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfIBSId (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 14:08:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id y19so14863952wrd.3
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 11:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vf97wzirWfpezZC26PrtHlhqmkxMAChIBNK3wVS74KY=;
        b=U7UTrq12u71X2f9F/v5CWFAvdcGaFP6jsvvWRiuo5FW50w0zQbwpwfpWic1fsY/HMA
         fj99E9BO6EUOWFWCnmTa2B2L2TWuDsAiE1071SG6rgWk4ri7986/yCJsi1m/1kwNMgCD
         Lo8eAawN8kLXZ6W8vVMeiAmJnLP71OqjMw0hYJrIBcMQkHRApHovirdpcpgDo2jfe/bJ
         rkdPBk3mpdpK31bm1G1Q6XIO/wR5SElBvF8JIiSUT37uDjG98gPgArhLoBtNOKW+PUX/
         giWqnXi2vlHyIqzSlE8TLtxHvJgqkl1yg70GofkkuRliHNWr7laDG5NgrHgAufYljujG
         k7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vf97wzirWfpezZC26PrtHlhqmkxMAChIBNK3wVS74KY=;
        b=F7rsCrC+jXajyhDfAeJf0NliZBzxommEpr3JE6agZfiZ8wa/QGkx4WjOXRisXBkyyj
         6IlWbrSona+73JccWnL+K5GxkH9OKb8dnlYhZGXFG3/UbqPvwynNGxpL5CPDITgIVhey
         6fKLIsvP1AoPKZYPkcZX9K7ANmph2AN1ro9Z14M1M0l6VvuKuj+3XZ5MoFjBAcTjxhuO
         sVWqXHukNczuEGWl0+UTr0b8xY7G59aAysO3yEn55cGtf7eCsY6mHfGe2Dh0oUKBPnp5
         aEClfKP043AsY/nG3pKgbBSmbtcX6xIiwKaB0ULhEtYRFAr0H4F0i8OQ3Z0TT7Tb/uoC
         dBZA==
X-Gm-Message-State: APjAAAWbSRDG4GRhCpeXwxMe6bOZVz3nSMUjrdR6AJLsXwIiiGrXvyWo
        iyfTwfZE1C4jMZw6O4VWqEyCuHIm
X-Google-Smtp-Source: APXvYqy1eX/Oln7Pdr8jbJozfXeh1FtNJteafotr7WAFnNIgFZEIej0fWHqgg123Zn/+mKbeROr6PA==
X-Received: by 2002:a5d:6088:: with SMTP id w8mr3594728wrt.31.1567447710640;
        Mon, 02 Sep 2019 11:08:30 -0700 (PDT)
Received: from localhost ([2.31.128.175])
        by smtp.gmail.com with ESMTPSA id w13sm35771622wre.44.2019.09.02.11.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 11:08:29 -0700 (PDT)
Date:   Mon, 2 Sep 2019 19:08:28 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Filippo Valsorda <filippo@ml.filippo.io>
Cc:     git@vger.kernel.org, Brandon Williams <bwilliams.eng@gmail.com>
Subject: [PATCH] push: disallow --all and refspecs when remote.<name>.mirror
 is set
Message-ID: <20190902180828.GC77876@cat>
References: <4d995a0b-0ac4-45a0-9ead-1bc76bd720c7@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d995a0b-0ac4-45a0-9ead-1bc76bd720c7@www.fastmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/20, Filippo Valsorda wrote:
> When used in a repository cloned with --mirror, git push with refs on
> the command line deletes all unmentioned refs.
> 
> This was investigated by @saleemrash1d on Twitter. I'm reporting
> their findings here and a reproduction below.
> 
> > seems to be a regression.
> > TRANSPORT_PUSH_MIRROR is set by remote->mirror
> > (https://github.com/git/git/blob/5fa0f5238b0/builtin/push.c#L410)
> > AFTER the check for refspecs provided on the command-line
> > (https://github.com/git/git/blob/5fa0f5238/builtin/push.c#L615).
> > introduced by 800a4ab399e954b8970897076b327bf1cf18c0ac.
> 
> > it's mirroring only the refspecs you provided on the command-line to
> > the server. i.e. all local refs that aren't stated on the command-line
> > will still be deleted
> 
> > this unexpected behaviour is why --mirror isn't allowed to be used
> > when refspecs are specified on the command-line. but the above commit
> > moves the sanity check so it doesn't catch the implied --mirror when
> > remote.<remote>.mirror is set (i.e. cloned with --mirror)
> 
> https://twitter.com/saleemrash1d/status/1163963105849876481

Thanks for the report.  This indeed looks like a regression, as
pointed out by @saleemrash1d.

Here's a patch to fix it:

--- >8 ---
Pushes with --all, or refspecs are disallowed when --mirror is given
to 'git push', or when 'remote.<name>.mirror' is set in the config of
the repository, because they can have surprising
effects. 800a4ab399 ("push: check for errors earlier", 2018-05-16)
refactored this code to do that check earlier, so we can explicitly
check for the presence of flags, instead of their sideeffects.

However when 'remote.<name>.mirror' is set in the config, the
TRANSPORT_PUSH_MIRROR flag would only be set after we calling
'do_push()', so the checks would miss it entirely.

This leads to surprises for users [*1*].

Fix this by making sure we set the flag (if appropriate) before
checking for compatibility of the various options.

*1*: https://twitter.com/FiloSottile/status/1163918701462249472

Reported-by: Filippo Valsorda <filippo@ml.filippo.io>
Helped-by: Saleem Rashid
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/push.c         | 69 ++++++++++++++++++++++--------------------
 t/t5517-push-mirror.sh | 10 ++++++
 2 files changed, 46 insertions(+), 33 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 021dd3b1e4..3742daf7b0 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -385,30 +385,14 @@ static int push_with_options(struct transport *transport, struct refspec *rs,
 }
 
 static int do_push(const char *repo, int flags,
-		   const struct string_list *push_options)
+		   const struct string_list *push_options,
+		   struct remote *remote)
 {
 	int i, errs;
-	struct remote *remote = pushremote_get(repo);
 	const char **url;
 	int url_nr;
 	struct refspec *push_refspec = &rs;
 
-	if (!remote) {
-		if (repo)
-			die(_("bad repository '%s'"), repo);
-		die(_("No configured push destination.\n"
-		    "Either specify the URL from the command-line or configure a remote repository using\n"
-		    "\n"
-		    "    git remote add <name> <url>\n"
-		    "\n"
-		    "and then push using the remote name\n"
-		    "\n"
-		    "    git push <name>\n"));
-	}
-
-	if (remote->mirror)
-		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
-
 	if (push_options->nr)
 		flags |= TRANSPORT_PUSH_OPTIONS;
 
@@ -548,6 +532,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	struct string_list push_options_cmdline = STRING_LIST_INIT_DUP;
 	struct string_list *push_options;
 	const struct string_list_item *item;
+	struct remote *remote;
 
 	struct option options[] = {
 		OPT__VERBOSITY(&verbosity),
@@ -602,20 +587,6 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		die(_("--delete is incompatible with --all, --mirror and --tags"));
 	if (deleterefs && argc < 2)
 		die(_("--delete doesn't make sense without any refs"));
-	if (flags & TRANSPORT_PUSH_ALL) {
-		if (tags)
-			die(_("--all and --tags are incompatible"));
-		if (argc >= 2)
-			die(_("--all can't be combined with refspecs"));
-	}
-	if (flags & TRANSPORT_PUSH_MIRROR) {
-		if (tags)
-			die(_("--mirror and --tags are incompatible"));
-		if (argc >= 2)
-			die(_("--mirror can't be combined with refspecs"));
-	}
-	if ((flags & TRANSPORT_PUSH_ALL) && (flags & TRANSPORT_PUSH_MIRROR))
-		die(_("--all and --mirror are incompatible"));
 
 	if (recurse_submodules == RECURSE_SUBMODULES_CHECK)
 		flags |= TRANSPORT_RECURSE_SUBMODULES_CHECK;
@@ -632,11 +603,43 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		set_refspecs(argv + 1, argc - 1, repo);
 	}
 
+	remote = pushremote_get(repo);
+	if (!remote) {
+		if (repo)
+			die(_("bad repository '%s'"), repo);
+		die(_("No configured push destination.\n"
+		    "Either specify the URL from the command-line or configure a remote repository using\n"
+		    "\n"
+		    "    git remote add <name> <url>\n"
+		    "\n"
+		    "and then push using the remote name\n"
+		    "\n"
+		    "    git push <name>\n"));
+	}
+
+	if (remote->mirror)
+		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
+
+	if (flags & TRANSPORT_PUSH_ALL) {
+		if (tags)
+			die(_("--all and --tags are incompatible"));
+		if (argc >= 2)
+			die(_("--all can't be combined with refspecs"));
+	}
+	if (flags & TRANSPORT_PUSH_MIRROR) {
+		if (tags)
+			die(_("--mirror and --tags are incompatible"));
+		if (argc >= 2)
+			die(_("--mirror can't be combined with refspecs"));
+	}
+	if ((flags & TRANSPORT_PUSH_ALL) && (flags & TRANSPORT_PUSH_MIRROR))
+		die(_("--all and --mirror are incompatible"));
+
 	for_each_string_list_item(item, push_options)
 		if (strchr(item->string, '\n'))
 			die(_("push options must not have new line characters"));
 
-	rc = do_push(repo, flags, push_options);
+	rc = do_push(repo, flags, push_options, remote);
 	string_list_clear(&push_options_cmdline, 0);
 	string_list_clear(&push_options_config, 0);
 	if (rc == -1)
diff --git a/t/t5517-push-mirror.sh b/t/t5517-push-mirror.sh
index c05a661400..e4edd56404 100755
--- a/t/t5517-push-mirror.sh
+++ b/t/t5517-push-mirror.sh
@@ -265,4 +265,14 @@ test_expect_success 'remote.foo.mirror=no has no effect' '
 
 '
 
+test_expect_success 'push to mirrored repository with refspec fails' '
+	mk_repo_pair &&
+	(
+		cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git config --add remote.up.mirror true &&
+		test_must_fail git push up master
+	)
+'
+
 test_done
-- 
2.23.0.rc2.194.ge5444969c9


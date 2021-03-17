Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5ECC433E9
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 19:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07F6A64F59
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 19:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbhCQTRY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 15:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbhCQTRD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 15:17:03 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E79EC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 12:17:03 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id j25so1816000pfe.2
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 12:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=K1QIV9YBSxwrx7cw/IAvGsI4znXzihiopsGq3RenEH4=;
        b=LAfbmLwJSgGIyDgDC5LljN/AIQJ/k6L3upmYdhaZyytGTAAmCWhv5mOJqGMIv0pwJm
         8PAFdvwwsmUxA5Yk6Lwvdn8ZeoHPdcJFc8+Q+BliYUcNYCr+OAlSw05CDWGLumE9kGJh
         cJ3jyaBRwsGYNqTgzyVmGbROPsFp3rIkt5VBirVbaVKcpzv6AaEUyp/ODArcNPMOk1SF
         3Cpb7YKqE/eCQOgU9SX9OZ9XnEYr++oWnSHxEd/XZIQQ1hY8hdf0g1i2iIT7WsgP5veR
         XSTOjseheTQqTaHIWnqgV55hcbU0gvQdGUrhgbGYm5F1fwI42Od+nw2rpzSFnFRHcWcB
         4ZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=K1QIV9YBSxwrx7cw/IAvGsI4znXzihiopsGq3RenEH4=;
        b=UDMTG5I+hFNzeBdHBeZuydlDtlgLrJUd7eFfr61wVF89uIZcwysEFORvu+DJWcX5B1
         uwzQ8NG1KMVJyA1w2bAAkKPSspStul0MTZDSmQ4XEQJo3hmShsZm8NRR37I4jmXQbjrR
         JFCstUz/QCd+m+Nuwa/bznPVmJYWSgdQQ1ZXS9NRoibraolyd9cPZUwSLbImX9MunRz2
         jm6kVX3N7bLe0BV61eH21/4YxGSdMPzr5qEY1xQHkiJ1PNtl5/B1YPT8YARKTwExoa2R
         wLRSMrrdkDwcOGnVfsVJe1/8Oc1cqT23Sc3bigK7ILK9nf02TN4GvrqQRRI33W+u9xAC
         xBcA==
X-Gm-Message-State: AOAM533/cn1nXNS0KmeJfVCSjg6gQwrX4nNgRvNNdX0UnPRR5IelidMr
        AQOgmKVbAMhvhWXQqIFp8g/bvA==
X-Google-Smtp-Source: ABdhPJxmYSDTla4G5GQySrS05sYbsL6uxhzBkafd0GVGLo13iN10SomJW1DrrPGRnFxoxOZX0PFufA==
X-Received: by 2002:a63:4c55:: with SMTP id m21mr3857354pgl.29.1616008621881;
        Wed, 17 Mar 2021 12:17:01 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:51f7:2133:700b:3769])
        by smtp.gmail.com with ESMTPSA id b186sm20871623pfb.170.2021.03.17.12.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 12:17:01 -0700 (PDT)
Date:   Wed, 17 Mar 2021 12:16:55 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v8 00/37] config-based hooks
Message-ID: <YFJVp+5IVJux9Vbe@google.com>
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <87pn04g0r1.fsf@evledraar.gmail.com>
 <YFJNd6an0eGRC4/p@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YFJNd6an0eGRC4/p@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 17, 2021 at 11:41:59AM -0700, Emily Shaffer wrote:
> 
> On Fri, Mar 12, 2021 at 10:49:38AM +0100, �var Arnfj�r� Bjarmason wrote:
> > 
> > 
> > On Thu, Mar 11 2021, Emily Shaffer wrote:
> > 
> > > Since v7:
> > > - Addressed Jonathan Tan's review of part I
> > > - Addressed Junio's review of part I and II
> > > - Combined parts I and II
> > >
> > > I think the updates to patch 1 between the rest of the work I've been
> > > doing probably have covered �var's comments.
> > 
> > A range-diff between iterations of such a large series would be most
> > useful. Do you have a public repo with tags or whatever the different
> > versions, for those who'd like an easier way to follow along the
> > differing versions than scraping the ML archive?
> 
> I am really embarrassed to say that I don't have the
> branches/tags/whatever up. I have not succeeded in building that habit
> yet. I'll generate one from my local patches today and send it here.

 1:  be907f68b9 !  1:  a5e8c233c3 doc: propose hooks managed by the config
    @@ Documentation/technical/config-based-hooks.txt (new)
     +[[motivation]]
     +== Motivation
     +
    -+Replace the .git/hook/hookname path as the only source of hooks to execute;
    ++Replace the `.git/hook/hookname` path as the only source of hooks to execute;
     +allow users to define hooks using config files, in a way which is friendly to
    -+users with multiple repos which have similar needs.
    ++users with multiple repos which have similar needs - hooks can be easily shared
    ++between multiple Git repos.
     +
     +Redefine "hook" as an event rather than a single script, allowing users to
     +perform multiple unrelated actions on a single event.
     +
    -+Take a step closer to safety when copying zipped Git repositories from untrusted
    -+users by making it more apparent to users which scripts will be run during
    -+normal Git operations.
    -+
     +Make it easier for users to discover Git's hook feature and automate their
     +workflows.
     +
    @@ Documentation/technical/config-based-hooks.txt (new)
     +number of cases:
     +
     +- "no": the legacy hook will not be run
    ++- "error": Git will print a warning to stderr before ignoring the legacy hook
     +- "interactive": Git will prompt the user before running the legacy hook
     +- "warn": Git will print a warning to stderr before running the legacy hook
     +- "yes" (default): Git will silently run the legacy hook
    @@ Documentation/technical/config-based-hooks.txt (new)
     +given which Git does not recognize, Git should discard that config entry. For
     +example, if "warn" was specified at system level and "junk" was specified at
     +global level, Git would resolve the value to "warn"; if the only time the config
    -+was set was to "junk", Git would use the default value of "yes".
    ++was set was to "junk", Git would use the default value of "yes" (but print a
    ++warning to the user first to let them know their value is wrong).
     +
     +`struct hookcmd` is expected to grow in size over time as more functionality is
     +added to hooks; so that other parts of the code don't need to understand the
    @@ Documentation/technical/config-based-hooks.txt (new)
     +=== Security and repo config
     +
     +Part of the motivation behind this refactor is to mitigate hooks as an attack
    -+vector;footnote:[https://lore.kernel.org/git/20171002234517.GV19555@aiede.mtv.corp.google.com/]
    -+however, as the design stands, users can still provide hooks in the repo-level
    -+config, which is included when a repo is zipped and sent elsewhere.  The
    ++vector.footnote:[https://lore.kernel.org/git/20171002234517.GV19555@aiede.mtv.corp.google.com/]
    ++However, as the design stands, users can still provide hooks in the repo-level
    ++config, which is included when a repo is zipped and sent elsewhere. The
     +security of the repo-level config is still under discussion; this design
    -+generally assumes the repo-level config is secure, which is not true yet. The
    -+goal is to avoid an overcomplicated design to work around a problem which has
    -+ceased to exist.
    ++generally assumes the repo-level config is secure, which is not true yet. This
    ++assumption was made to avoid overcomplicating the design. So, this series
    ++doesn't particularly improve security or resistance to zip attacks.
     +
     +[[ease-of-use]]
     +=== Ease of use
    @@ Documentation/technical/config-based-hooks.txt (new)
     +A previous summary of alternatives exists in the
     +archives.footnote:[https://lore.kernel.org/git/20191116011125.GG22855@google.com]
     +
    -+[[status-quo]]
    -+=== Status quo
    -+
    -+Today users can implement multihooks themselves by using a "trampoline script"
    -+as their hook, and pointing that script to a directory or list of other scripts
    -+they wish to run.
    -+
    -+[[hook-directories]]
    -+=== Hook directories
    -+
    -+Other contributors have suggested Git learn about the existence of a directory
    -+such as `.git/hooks/<hookname>.d` and execute those hooks in alphabetical order.
    -+
    -+[[comparison]]
    -+=== Comparison table
    ++The table below shows a number of goals and how they might be achieved with
    ++config-based hooks, by implementing directory support (i.e.
    ++'.git/hooks/pre-commit.d'), or as hooks are run today.
     +
     +.Comparison of alternatives
     +|===
    @@ Documentation/technical/config-based-hooks.txt (new)
     +|Natively
     +|With user effort
     +
    ++|Supports parallelization
    ++|Natively
    ++|Natively
    ++|No (user's multihook trampoline script would need to handle parallelism)
    ++
     +|Safer for zipped repos
     +|A little
     +|No
    @@ Documentation/technical/config-based-hooks.txt (new)
     +
     +|Can install one hook to many repos
     +|Yes
    -+|No
    -+|No
    ++|With symlinks or core.hooksPath
    ++|With symlinks or core.hooksPath
     +
     +|Discoverability
    -+|Better (in `git help git`)
    -+|Same as before
    ++|Findable with 'git help git' or tab-completion via 'git hook' subcommand
    ++|Findable via improved documentation
     +|Same as before
     +
     +|Hard to run unexpected hook
     +|If configured
    -+|No
    ++|Could be made to warn or look for a config
     +|No
     +|===
     +
    ++[[status-quo]]
    ++=== Status quo
    ++
    ++Today users can implement multihooks themselves by using a "trampoline script"
    ++as their hook, and pointing that script to a directory or list of other scripts
    ++they wish to run.
    ++
    ++[[hook-directories]]
    ++=== Hook directories
    ++
    ++Other contributors have suggested Git learn about the existence of a directory
    ++such as `.git/hooks/<hookname>.d` and execute those hooks in alphabetical order.
    ++
     +[[future-work]]
     +== Future work
     +
    @@ Documentation/technical/config-based-hooks.txt (new)
     +dependencies. If we decide to solve this problem, we may want to look to modern
     +build systems for inspiration on how to manage dependencies and parallel tasks.
     +
    ++[[nontrivial-hooks]]
    ++=== Multihooks and nontrivial output
    ++
    ++Some hooks - like 'proc-receive' - don't lend themselves well to multihooks at
    ++all. In the case of 'proc-receive', for now, multiple hook definitions are
    ++disallowed. In the future we might be able to conceive a better approach, for
    ++example, running the hooks in series and using the output from one hook as the
    ++input to the next.
    ++
     +[[securing-hookdir-hooks]]
     +=== Securing hookdir hooks
     +
 2:  b1d37c3911 =  2:  a3e858d056 hook: scaffolding for git-hook subcommand
 3:  fea411c598 !  3:  60b28a652b hook: add list command
    @@ Commit message
         run in config order. If more properties need to be set on a given hook
         in the future, commands can also be specified by providing
         "hook.<hookname>.command = <hookcmd-name>", as well as a "[hookcmd
    -    <hookcmd-name>]" subsection; at minimum, this subsection must contain a
    +    <hookcmd-name>]" subsection; this subsection should contain a
         "hookcmd.<hookcmd-name>.command = <path-to-hook>" line.
     
         For example:
    @@ Makefile: LIB_OBJS += hash-lookup.o
      ## builtin/hook.c ##
     @@
      #include "cache.h"
    - 
    +-
      #include "builtin.h"
     +#include "config.h"
     +#include "hook.h"
    @@ builtin/hook.c
      {
     -	struct option builtin_hook_options[] = {
     +	struct list_head *head, *pos;
    -+	struct hook *item;
     +	struct strbuf hookname = STRBUF_INIT;
     +
     +	struct option list_options[] = {
    @@ builtin/hook.c
     +	}
     +
     +	list_for_each(pos, head) {
    -+		item = list_entry(pos, struct hook, list);
    ++		struct hook *item = list_entry(pos, struct hook, list);
     +		if (item)
     +			printf("%s: %s\n",
     +			       config_scope_name(item->origin),
    @@ hook.c (new)
     +		    list_del(pos);
     +		    /* we'll simply move the hook to the end */
     +		    to_add = it;
    ++		    break;
     +		}
     +	}
     +
     +	if (!to_add) {
     +		/* adding a new hook, not moving an old one */
    -+		to_add = xmalloc(sizeof(struct hook));
    ++		to_add = xmalloc(sizeof(*to_add));
     +		strbuf_init(&to_add->command, 0);
     +		strbuf_addstr(&to_add->command, command);
     +	}
    @@ hook.c (new)
     +	/* re-set the scope so we show where an override was specified */
     +	to_add->origin = current_config_scope();
     +
    -+	list_add_tail(&to_add->list, pos);
    ++	list_add_tail(&to_add->list, head);
     +}
     +
     +static void remove_hook(struct list_head *to_remove)
    @@ hook.c (new)
     +		const char *command = value;
     +		struct strbuf hookcmd_name = STRBUF_INIT;
     +
    -+		/* Check if a hookcmd with that name exists. */
    ++		/*
    ++		 * Check if a hookcmd with that name exists. If it doesn't,
    ++		 * 'git_config_get_value()' is documented not to touch &command,
    ++		 * so we don't need to do anything.
    ++		 */
     +		strbuf_addf(&hookcmd_name, "hookcmd.%s.command", command);
     +		git_config_get_value(hookcmd_name.buf, &command);
     +
    @@ hook.c (new)
     +
     +	strbuf_addf(&hook_key, "hook.%s.command", hookname->buf);
     +
    -+	git_config(hook_config_lookup, (void*)&cb_data);
    ++	git_config(hook_config_lookup, &cb_data);
     +
     +	strbuf_release(&hook_key);
     +	return hook_head;
    @@ hook.h (new)
     +#include "list.h"
     +#include "strbuf.h"
     +
    -+struct hook
    -+{
    ++struct hook {
     +	struct list_head list;
     +	/*
     +	 * Config file which holds the hook.*.command definition.
 4:  89f1adf34d !  4:  d8232a8254 hook: include hookdir hook in list
    @@ Commit message
         $GIT_DIR/hooks/$HOOKNAME (or $HOOKDIR/$HOOKNAME). Although hooks taken
         from the config are more featureful than hooks placed in the $HOOKDIR,
         those hooks should not stop working for users who already have them.
    -
    -    Legacy hooks should be run directly, not in shell. We know that they are
    -    a path to an executable, not a oneliner script - and running them
    -    directly takes care of path quoting concerns for us for free.
    +    Let's list them to the user, but instead of displaying a config scope
    +    (e.g. "global: blah") we can prefix them with "hookdir:".
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
     
      ## builtin/hook.c ##
     @@ builtin/hook.c: static int list(int argc, const char **argv, const char *prefix)
    - 	struct list_head *head, *pos;
    - 	struct hook *item;
    - 	struct strbuf hookname = STRBUF_INIT;
    -+	struct strbuf hookdir_annotation = STRBUF_INIT;
    - 
    - 	struct option list_options[] = {
    - 		OPT_END(),
    -@@ builtin/hook.c: static int list(int argc, const char **argv, const char *prefix)
      
      	list_for_each(pos, head) {
    - 		item = list_entry(pos, struct hook, list);
    + 		struct hook *item = list_entry(pos, struct hook, list);
     -		if (item)
    --			printf("%s: %s\n",
    --			       config_scope_name(item->origin),
    --			       item->command.buf);
    ++		item = list_entry(pos, struct hook, list);
     +		if (item) {
     +			/* Don't translate 'hookdir' - it matches the config */
    -+			printf("%s: %s%s\n",
    + 			printf("%s: %s\n",
    +-			       config_scope_name(item->origin),
     +			       (item->from_hookdir
     +				? "hookdir"
     +				: config_scope_name(item->origin)),
    -+			       item->command.buf,
    -+			       (item->from_hookdir
    -+				? hookdir_annotation.buf
    -+				: ""));
    + 			       item->command.buf);
     +		}
      	}
      
    @@ hook.c
      void free_hook(struct hook *ptr)
      {
     @@ hook.c: static void append_or_move_hook(struct list_head *head, const char *command)
    - 		to_add = xmalloc(sizeof(struct hook));
    + 		to_add = xmalloc(sizeof(*to_add));
      		strbuf_init(&to_add->command, 0);
      		strbuf_addstr(&to_add->command, command);
     +		to_add->from_hookdir = 0;
    @@ hook.c: static void append_or_move_hook(struct list_head *head, const char *comm
      
      	/* re-set the scope so we show where an override was specified */
     @@ hook.c: struct list_head* hook_list(const struct strbuf* hookname)
    - 	struct strbuf hook_key = STRBUF_INIT;
    - 	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
    - 	struct hook_config_cb cb_data = { &hook_key, hook_head };
    -+	const char *legacy_hook_path = NULL;
    - 
    - 	INIT_LIST_HEAD(hook_head);
      
    -@@ hook.c: struct list_head* hook_list(const struct strbuf* hookname)
    + 	git_config(hook_config_lookup, &cb_data);
      
    - 	git_config(hook_config_lookup, (void*)&cb_data);
    - 
    -+	if (have_git_dir())
    -+		legacy_hook_path = find_hook(hookname->buf);
    ++	if (have_git_dir()) {
    ++		const char *legacy_hook_path = find_hook(hookname->buf);
     +
    -+	/* Unconditionally add legacy hook, but annotate it. */
    -+	if (legacy_hook_path) {
    -+		struct hook *legacy_hook;
    ++		/* Unconditionally add legacy hook, but annotate it. */
    ++		if (legacy_hook_path) {
    ++			struct hook *legacy_hook;
     +
    -+		append_or_move_hook(hook_head, absolute_path(legacy_hook_path));
    -+		legacy_hook = list_entry(hook_head->prev, struct hook, list);
    -+		legacy_hook->from_hookdir = 1;
    ++			append_or_move_hook(hook_head,
    ++					    absolute_path(legacy_hook_path));
    ++			legacy_hook = list_entry(hook_head->prev, struct hook,
    ++						 list);
    ++			legacy_hook->from_hookdir = 1;
    ++		}
     +	}
     +
      	strbuf_release(&hook_key);
    @@ hook.c: struct list_head* hook_list(const struct strbuf* hookname)
      }
     
      ## hook.h ##
    -@@ hook.h: struct hook
    +@@ hook.h: struct hook {
      	enum config_scope origin;
      	/* The literal command to run. */
      	struct strbuf command;
    -+	int from_hookdir;
    ++	unsigned from_hookdir : 1;
      };
      
      /*
 5:  723edcd785 !  5:  96c0a4838f hook: respect hook.runHookDir
    @@ Metadata
     Author: Emily Shaffer <emilyshaffer@google.com>
     
      ## Commit message ##
    -    hook: respect hook.runHookDir
    +    hook: teach hook.runHookDir
     
    -    Include hooks specified in the hook directory in the list of hooks to
    -    run. These hooks do need to be treated differently from config-specified
    -    ones - they do not need to run in a shell, and later on may be disabled
    -    or warned about based on a config setting.
    -
    -    Because they are at least as local as the local config, we'll run them
    -    last - to keep the hook execution order from global to local.
    -
    -    Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    +    For now, just give a hint about how these hooks will be run in 'git hook
    +    list'. Later on, though, we will pay attention to this enum when running
    +    the hooks.
     
      ## Documentation/config/hook.txt ##
     @@ Documentation/config/hook.txt: hookcmd.<name>.command::
    @@ builtin/hook.c: static const char * const builtin_hook_usage[] = {
      static int list(int argc, const char **argv, const char *prefix)
      {
      	struct list_head *head, *pos;
    + 	struct strbuf hookname = STRBUF_INIT;
    ++	struct strbuf hookdir_annotation = STRBUF_INIT;
    + 
    + 	struct option list_options[] = {
    + 		OPT_END(),
     @@ builtin/hook.c: static int list(int argc, const char **argv, const char *prefix)
      		return 0;
      	}
    @@ builtin/hook.c: static int list(int argc, const char **argv, const char *prefix)
     +		case HOOKDIR_NO:
     +			strbuf_addstr(&hookdir_annotation, _(" (will not run)"));
     +			break;
    ++		case HOOKDIR_ERROR:
    ++			strbuf_addstr(&hookdir_annotation, _(" (will error and not run)"));
    ++			break;
     +		case HOOKDIR_INTERACTIVE:
     +			strbuf_addstr(&hookdir_annotation, _(" (will prompt)"));
     +			break;
     +		case HOOKDIR_WARN:
    -+		case HOOKDIR_UNKNOWN:
    -+			strbuf_addstr(&hookdir_annotation, _(" (will warn)"));
    ++			strbuf_addstr(&hookdir_annotation, _(" (will warn but run)"));
     +			break;
     +		case HOOKDIR_YES:
     +		/*
     +		 * The default behavior should agree with
    -+		 * hook.c:configured_hookdir_opt().
    ++		 * hook.c:configured_hookdir_opt(). HOOKDIR_UNKNOWN should just
    ++		 * do the default behavior.
     +		 */
    ++		case HOOKDIR_UNKNOWN:
     +		default:
     +			break;
     +	}
     +
      	list_for_each(pos, head) {
    + 		struct hook *item = list_entry(pos, struct hook, list);
      		item = list_entry(pos, struct hook, list);
      		if (item) {
    + 			/* Don't translate 'hookdir' - it matches the config */
    +-			printf("%s: %s\n",
    ++			printf("%s: %s%s\n",
    + 			       (item->from_hookdir
    + 				? "hookdir"
    + 				: config_scope_name(item->origin)),
    +-			       item->command.buf);
    ++			       item->command.buf,
    ++			       (item->from_hookdir
    ++				? hookdir_annotation.buf
    ++				: ""));
    + 		}
    + 	}
    + 
    + 	clear_hook_list(head);
    ++	strbuf_release(&hookdir_annotation);
    + 	strbuf_release(&hookname);
    + 
    + 	return 0;
     @@ builtin/hook.c: static int list(int argc, const char **argv, const char *prefix)
      
      int cmd_hook(int argc, const char **argv, const char *prefix)
    @@ builtin/hook.c: static int list(int argc, const char **argv, const char *prefix)
     +	if (run_hookdir)
     +		if (!strcmp(run_hookdir, "no"))
     +			should_run_hookdir = HOOKDIR_NO;
    ++		else if (!strcmp(run_hookdir, "error"))
    ++			should_run_hookdir = HOOKDIR_ERROR;
     +		else if (!strcmp(run_hookdir, "yes"))
     +			should_run_hookdir = HOOKDIR_YES;
     +		else if (!strcmp(run_hookdir, "warn"))
    @@ hook.c: static int hook_config_lookup(const char *key, const char *value, void *
     +	if (!strcmp(key, "no"))
     +		return HOOKDIR_NO;
     +
    ++	if (!strcmp(key, "error"))
    ++		return HOOKDIR_ERROR;
    ++
     +	if (!strcmp(key, "yes"))
     +		return HOOKDIR_YES;
     +
    @@ hook.c: static int hook_config_lookup(const char *key, const char *value, void *
      	struct strbuf hook_key = STRBUF_INIT;
     
      ## hook.h ##
    -@@ hook.h: struct hook
    +@@ hook.h: struct hook {
       */
      struct list_head* hook_list(const struct strbuf *hookname);
      
     +enum hookdir_opt
     +{
     +	HOOKDIR_NO,
    ++	HOOKDIR_ERROR,
     +	HOOKDIR_WARN,
     +	HOOKDIR_INTERACTIVE,
     +	HOOKDIR_YES,
    @@ t/t1360-config-based-hooks.sh: test_expect_success 'git hook list shows hooks fr
     +	test_i18ncmp expected actual
     +'
     +
    ++test_expect_success 'hook.runHookDir = error is respected by list' '
    ++	setup_hookdir &&
    ++
    ++	test_config hook.runHookDir "error" &&
    ++
    ++	cat >expected <<-EOF &&
    ++	hookdir: $(pwd)/.git/hooks/pre-commit (will error and not run)
    ++	EOF
    ++
    ++	git hook list pre-commit >actual &&
    ++	# the hookdir annotation is translated
    ++	test_i18ncmp expected actual
    ++'
    ++
     +test_expect_success 'hook.runHookDir = warn is respected by list' '
     +	setup_hookdir &&
     +
     +	test_config hook.runHookDir "warn" &&
     +
     +	cat >expected <<-EOF &&
    -+	hookdir: $(pwd)/.git/hooks/pre-commit (will warn)
    ++	hookdir: $(pwd)/.git/hooks/pre-commit (will warn but run)
     +	EOF
     +
     +	git hook list pre-commit >actual &&
    @@ t/t1360-config-based-hooks.sh: test_expect_success 'git hook list shows hooks fr
     +	# the hookdir annotation is translated
     +	test_i18ncmp expected actual
     +'
    ++
    ++test_expect_success 'hook.runHookDir is tolerant to unknown values' '
    ++	setup_hookdir &&
    ++
    ++	test_config hook.runHookDir "junk" &&
    ++
    ++	cat >expected <<-EOF &&
    ++	hookdir: $(pwd)/.git/hooks/pre-commit
    ++	EOF
    ++
    ++	git hook list pre-commit >actual &&
    ++	# the hookdir annotation is translated
    ++	test_i18ncmp expected actual
    ++'
     +
      test_done
 6:  567f6d9d00 !  6:  9068e11679 hook: implement hookcmd.<name>.skip
    @@ Commit message
         hook: implement hookcmd.<name>.skip
     
         If a user wants a specific repo to skip execution of a hook which is set
    -    at a global or system level, they can now do so by specifying 'skip' in
    -    their repo config:
    +    at a global or system level, they will be able to do so by specifying
    +    'skip' in their repo config:
     
         ~/.gitconfig
           [hook.pre-commit]
    @@ Commit message
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
     
    + ## Documentation/config/hook.txt ##
    +@@ Documentation/config/hook.txt: hookcmd.<name>.command::
    + 	as a command. This can be an executable on your device or a oneliner for
    + 	your shell. See linkgit:git-hook[1].
    + 
    ++hookcmd.<name>.skip::
    ++	Specify this boolean to remove a command from earlier in the execution
    ++	order. Useful if you want to make a single repo an exception to hook
    ++	configured at the system or global scope. If there is no hookcmd
    ++	specified for the command you want to skip, you can use the value of
    ++	`hook.<command>.command` as <name> as a shortcut. The "skip" setting
    ++	must be specified after the "hook.<command>.command" to have an effect.
    ++
    + hook.runHookDir::
    + 	Controls how hooks contained in your hookdir are executed. Can be any of
    + 	"yes", "warn", "interactive", or "no". Defaults to "yes". See
    +
    + ## Documentation/git-hook.txt ##
    +@@ Documentation/git-hook.txt: $ git hook list "prepare-commit-msg"
    + local: /bin/linter --c
    + ----
    + 
    ++If there is a command you wish to run in most cases but have one or two
    ++exceptional repos where it should be skipped, you can use specify
    ++`hookcmd.<name>.skip`, for example:
    ++
    ++System config
    ++----
    ++  [hook "pre-commit"]
    ++    command = check-for-secrets
    ++
    ++  [hookcmd "check-for-secrets"]
    ++    command = /bin/secret-checker --aggressive
    ++----
    ++
    ++Local config
    ++----
    ++  [hookcmd "check-for-secrets"]
    ++    skip = true
    ++  # This works for inlined hook commands, too:
    ++  [hookcmd "~/typocheck.sh"]
    ++    skip = true
    ++----
    ++
    ++After these configs are added, the hook list becomes:
    ++
    ++----
    ++$ git hook list "post-commit"
    ++global: /bin/linter --c
    ++local: python ~/run-test-suite.py
    ++
    ++$ git hook list "pre-commit"
    ++no commands configured for hook 'pre-commit'
    ++----
    ++
    + COMMANDS
    + --------
    + 
    +
      ## hook.c ##
     @@ hook.c: void free_hook(struct hook *ptr)
      	}
      }
      
     -static void append_or_move_hook(struct list_head *head, const char *command)
    -+static struct hook* find_hook_by_command(struct list_head *head, const char *command)
    ++static struct hook * find_hook_by_command(struct list_head *head, const char *command)
      {
      	struct list_head *pos = NULL, *tmp = NULL;
     -	struct hook *to_add = NULL;
    @@ hook.c: void free_hook(struct hook *ptr)
     -		    /* we'll simply move the hook to the end */
     -		    to_add = it;
     +		    found = it;
    + 		    break;
      		}
      	}
     +	return found;
    @@ hook.c: void free_hook(struct hook *ptr)
      
      	if (!to_add) {
      		/* adding a new hook, not moving an old one */
    -@@ hook.c: static void append_or_move_hook(struct list_head *head, const char *command)
    - 	/* re-set the scope so we show where an override was specified */
    - 	to_add->origin = current_config_scope();
    - 
    --	list_add_tail(&to_add->list, pos);
    -+	list_add_tail(&to_add->list, head);
    - }
    - 
    - static void remove_hook(struct list_head *to_remove)
     @@ hook.c: static int hook_config_lookup(const char *key, const char *value, void *cb_data)
      	if (!strcmp(key, hook_key)) {
      		const char *command = value;
    @@ hook.c: static int hook_config_lookup(const char *key, const char *value, void *
     +		strbuf_addf(&hookcmd_name, "hookcmd.%s.skip", command);
     +		git_config_get_bool(hookcmd_name.buf, &skip);
      
    - 		/* Check if a hookcmd with that name exists. */
    + 		/*
    + 		 * Check if a hookcmd with that name exists. If it doesn't,
    + 		 * 'git_config_get_value()' is documented not to touch &command,
    + 		 * so we don't need to do anything.
    + 		 */
     +		strbuf_reset(&hookcmd_name);
      		strbuf_addf(&hookcmd_name, "hookcmd.%s.command", command);
      		git_config_get_value(hookcmd_name.buf, &command);
    @@ t/t1360-config-based-hooks.sh: test_expect_success 'hook.runHookDir = warn is re
     +	test_i18ncmp expected actual
     +'
     +
    ++test_expect_success 'git hook list ignores skip referring to unused hookcmd' '
    ++	test_config hookcmd.abc.command "/path/abc" --add &&
    ++	test_config hookcmd.abc.skip "true" --add &&
    ++
    ++	cat >expected <<-EOF &&
    ++	no commands configured for hook '\''pre-commit'\''
    ++	EOF
    ++
    ++	git hook list pre-commit >actual &&
    ++	test_i18ncmp expected actual
    ++'
    ++
     +test_expect_success 'git hook list removes skipped inlined hook' '
     +	setup_hooks &&
     +	test_config hookcmd."$ROOT/path/ghi".skip "true" --add &&
 7:  a1c02b6758 !  7:  a2867ab8c0 parse-options: parse into strvec
    @@ Documentation/technical/api-parse-options.txt: There are some macros to easily d
      	Use of `--no-option` will clear the list of preceding values.
      
     +`OPT_STRVEC(short, long, &struct strvec, arg_str, description)`::
    -+	Introduce an option with a string argument.
    -+	The string argument is stored as an element in `strvec`.
    ++	Introduce an option with a string argument, meant to be specified
    ++	multiple times.
    ++	The string argument is stored as an element in `strvec`, and later
    ++	arguments are added to the same `strvec`.
     +	Use of `--no-option` will clear the list of preceding values.
     +
      `OPT_INTEGER(short, long, &int_var, description)`::
 8:  d865772ebc !  8:  8848eeddf2 hook: add 'run' subcommand
    @@ Commit message
         supported.
     
         Legacy hooks (those present in $GITDIR/hooks) are run at the end of the
    -    execution list. For now, there is no way to disable them.
    +    execution list. They can be disabled, or made to print warnings, or to
    +    prompt before running, with the 'hook.runHookDir' config.
     
         Users may wish to provide hook commands like 'git config
         hook.pre-commit.command "~/linter.sh --pre-commit"'. To enable this,
    @@ Documentation/git-hook.txt: in the order they should be run, and print the confi
     +run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] `<hook-name>`::
     +
     +Runs hooks configured for `<hook-name>`, in the same order displayed by `git
    -+hook list`. Hooks configured this way are run prepended with `sh -c`, so paths
    -+containing special characters or spaces should be wrapped in single quotes:
    -+`command = '/my/path with spaces/script.sh' some args`.
    ++hook list`. Hooks configured this way may be run prepended with `sh -c`, so
    ++paths containing special characters or spaces should be wrapped in single
    ++quotes: `command = '/my/path with spaces/script.sh' some args`.
     +
     +OPTIONS
     +-------
    @@ builtin/hook.c: static int list(int argc, const char **argv, const char *prefix)
     +static int run(int argc, const char **argv, const char *prefix)
     +{
     +	struct strbuf hookname = STRBUF_INIT;
    -+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
    ++	struct run_hooks_opt opt;
     +	int rc = 0;
     +
     +	struct option run_options[] = {
    @@ builtin/hook.c: static int list(int argc, const char **argv, const char *prefix)
     +		OPT_END(),
     +	};
     +
    -+	/*
    -+	 * While it makes sense to list hooks out-of-repo, it doesn't make sense
    -+	 * to execute them. Hooks usually want to look at repository artifacts.
    -+	 */
    -+	if (!have_git_dir())
    -+		usage_msg_opt(_("You must be in a Git repo to execute hooks."),
    -+			      builtin_hook_usage, run_options);
    ++	run_hooks_opt_init(&opt);
     +
     +	argc = parse_options(argc, argv, prefix, run_options,
     +			     builtin_hook_usage, 0);
    @@ hook.c: enum hookdir_opt configured_hookdir_opt(void)
     +
     +	switch (cfg)
     +	{
    ++		case HOOKDIR_ERROR:
    ++			fprintf(stderr, _("Skipping legacy hook at '%s'\n"),
    ++				path);
    ++			/* FALLTHROUGH */
     +		case HOOKDIR_NO:
     +			return 0;
    -+		case HOOKDIR_UNKNOWN:
    -+			fprintf(stderr,
    -+				_("Unrecognized value for 'hook.runHookDir'. "
    -+				  "Is there a typo? "));
    -+			/* FALLTHROUGH */
     +		case HOOKDIR_WARN:
     +			fprintf(stderr, _("Running legacy hook at '%s'\n"),
     +				path);
    @@ hook.c: enum hookdir_opt configured_hookdir_opt(void)
     +			} while (prompt.len); /* an empty reply means "Yes" */
     +			strbuf_release(&prompt);
     +			return 1;
    ++		/*
    ++		 * HOOKDIR_UNKNOWN should match the default behavior, but let's
    ++		 * give a heads up to the user.
    ++		 */
    ++		case HOOKDIR_UNKNOWN:
    ++			fprintf(stderr,
    ++				_("Unrecognized value for 'hook.runHookDir'. "
    ++				  "Is there a typo? "));
    ++			/* FALLTHROUGH */
     +		case HOOKDIR_YES:
     +		default:
     +			return 1;
    @@ hook.c: struct list_head* hook_list(const struct strbuf* hookname)
     +	strvec_clear(&o->args);
     +}
     +
    ++static void prepare_hook_cp(struct hook *hook, struct run_hooks_opt *options,
    ++			    struct child_process *cp)
    ++{
    ++	if (!hook)
    ++		return;
    ++
    ++	cp->no_stdin = 1;
    ++	cp->env = options->env.v;
    ++	cp->stdout_to_stderr = 1;
    ++	cp->trace2_hook_name = hook->command.buf;
    ++
    ++	/*
    ++	 * Commands from the config could be oneliners, but we know
    ++	 * for certain that hookdir commands are not.
    ++	 */
    ++	cp->use_shell = !hook->from_hookdir;
    ++
    ++	/* add command */
    ++	strvec_push(&cp->args, hook->command.buf);
    ++
    ++	/*
    ++	 * add passed-in argv, without expanding - let the user get back
    ++	 * exactly what they put in
    ++	 */
    ++	strvec_pushv(&cp->args, options->args.v);
    ++}
    ++
     +int run_hooks(const char *hookname, struct run_hooks_opt *options)
     +{
     +	struct strbuf hookname_str = STRBUF_INIT;
    @@ hook.c: struct list_head* hook_list(const struct strbuf* hookname)
     +		struct child_process hook_proc = CHILD_PROCESS_INIT;
     +		struct hook *hook = list_entry(pos, struct hook, list);
     +
    -+		hook_proc.env = options->env.v;
    -+		hook_proc.no_stdin = 1;
    -+		hook_proc.stdout_to_stderr = 1;
    -+		hook_proc.trace2_hook_name = hook->command.buf;
    -+		hook_proc.use_shell = 1;
    -+
    -+		if (hook->from_hookdir) {
    -+		    if (!should_include_hookdir(hook->command.buf, options->run_hookdir))
    ++		if (hook->from_hookdir &&
    ++		    !should_include_hookdir(hook->command.buf, options->run_hookdir))
     +			continue;
    -+		    /*
    -+		     * Commands from the config could be oneliners, but we know
    -+		     * for certain that hookdir commands are not.
    -+		     */
    -+		    hook_proc.use_shell = 0;
    -+		}
    -+
    -+		/* add command */
    -+		strvec_push(&hook_proc.args, hook->command.buf);
     +
    -+		/*
    -+		 * add passed-in argv, without expanding - let the user get back
    -+		 * exactly what they put in
    -+		 */
    -+		strvec_pushv(&hook_proc.args, options->args.v);
    ++		prepare_hook_cp(hook, options, &hook_proc);
     +
     +		rc |= run_command(&hook_proc);
     +	}
    @@ hook.h
      #include "strbuf.h"
     +#include "strvec.h"
      
    - struct hook
    - {
    + struct hook {
    + 	struct list_head list;
     @@ hook.h: enum hookdir_opt
       */
      enum hookdir_opt configured_hookdir_opt(void);
    @@ hook.h: enum hookdir_opt
     +	enum hookdir_opt run_hookdir;
     +};
     +
    -+#define RUN_HOOKS_OPT_INIT  {   		\
    -+	.env = STRVEC_INIT, 				\
    -+	.args = STRVEC_INIT, 			\
    -+	.run_hookdir = configured_hookdir_opt()	\
    -+}
    -+
     +void run_hooks_opt_init(struct run_hooks_opt *o);
     +void run_hooks_opt_clear(struct run_hooks_opt *o);
     +
    @@ t/t1360-config-based-hooks.sh: test_expect_success 'hook.runHookDir = no is resp
     +	test_must_be_empty actual
      '
      
    - test_expect_success 'hook.runHookDir = warn is respected by list' '
    + test_expect_success 'hook.runHookDir = error is respected by list' '
    +@@ t/t1360-config-based-hooks.sh: test_expect_success 'hook.runHookDir = error is respected by list' '
    + 
    + 	git hook list pre-commit >actual &&
    + 	# the hookdir annotation is translated
    ++	test_i18ncmp expected actual &&
    ++
    ++	cat >expected <<-EOF &&
    ++	Skipping legacy hook at '\''$(pwd)/.git/hooks/pre-commit'\''
    ++	EOF
    ++
    ++	git hook run pre-commit 2>actual &&
    + 	test_i18ncmp expected actual
    + '
    + 
     @@ t/t1360-config-based-hooks.sh: test_expect_success 'hook.runHookDir = warn is respected by list' '
      
      	git hook list pre-commit >actual &&
    @@ t/t1360-config-based-hooks.sh: test_expect_success 'hook.runHookDir = interactiv
     +	nongit test_must_fail git hook run pre-commit
      '
      
    - test_done
    + test_expect_success 'hook.runHookDir is tolerant to unknown values' '
 9:  53a655ed2c !  9:  452f7eea89 hook: replace find_hook() with hook_exists()
    @@ Metadata
     Author: Emily Shaffer <emilyshaffer@google.com>
     
      ## Commit message ##
    -    hook: replace find_hook() with hook_exists()
    +    hook: introduce hook_exists()
     
         Add a helper to easily determine whether any hooks exist for a given
         hook event.
    @@ Commit message
         hook; that check should include the config-based hooks as well. Optimize
         by checking the config directly. Since commands which execute hooks
         might want to take args to replace 'hook.runHookDir', let
    -    'hook_exists()' mirror the behavior of 'hook.runHookDir'.
    +    'hook_exists()' take a hookdir_opt to override that config.
     
    -    Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    +    In some cases, external callers today use find_hook() to discover the
    +    location of a hook and then run it manually with run-command.h (that is,
    +    not with run_hook_le()). Later, those cases will call hook.h:run_hook()
    +    directly instead.
     
    - ## builtin/bugreport.c ##
    -@@
    - #include "strbuf.h"
    - #include "help.h"
    - #include "compat/compiler.h"
    --#include "run-command.h"
    -+#include "hook.h"
    - 
    - 
    - static void get_system_info(struct strbuf *sys_info)
    -@@ builtin/bugreport.c: static void get_populated_hooks(struct strbuf *hook_info, int nongit)
    - 	}
    - 
    - 	for (i = 0; i < ARRAY_SIZE(hook); i++)
    --		if (find_hook(hook[i]))
    -+		if (hook_exists(hook[i], configured_hookdir_opt()))
    - 			strbuf_addf(hook_info, "%s\n", hook[i]);
    - }
    - 
    +    Once the entire codebase is using hook_exists() instead of find_hook(),
    +    find_hook() can be safely rolled into hook_exists() and removed from
    +    run-command.h.
    +
    +    Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
     
      ## hook.c ##
     @@ hook.c: void run_hooks_opt_init(struct run_hooks_opt *o)
    @@ hook.c: void run_hooks_opt_init(struct run_hooks_opt *o)
     +{
     +	const char *value = NULL; /* throwaway */
     +	struct strbuf hook_key = STRBUF_INIT;
    ++	int could_run_hookdir;
    ++
    ++	if (should_run_hookdir == HOOKDIR_USE_CONFIG)
    ++		should_run_hookdir = configured_hookdir_opt();
     +
    -+	int could_run_hookdir = (should_run_hookdir == HOOKDIR_INTERACTIVE ||
    ++	could_run_hookdir = (should_run_hookdir == HOOKDIR_INTERACTIVE ||
     +				should_run_hookdir == HOOKDIR_WARN ||
     +				should_run_hookdir == HOOKDIR_YES)
     +				&& !!find_hook(hookname);
    @@ hook.c: void run_hooks_opt_init(struct run_hooks_opt *o)
      	strvec_clear(&o->env);
     
      ## hook.h ##
    +@@ hook.h: struct list_head* hook_list(const struct strbuf *hookname);
    + 
    + enum hookdir_opt
    + {
    ++	HOOKDIR_USE_CONFIG,
    + 	HOOKDIR_NO,
    + 	HOOKDIR_ERROR,
    + 	HOOKDIR_WARN,
     @@ hook.h: struct run_hooks_opt
      void run_hooks_opt_init(struct run_hooks_opt *o);
      void run_hooks_opt_clear(struct run_hooks_opt *o);
10:  13abc6ce24 ! 10:  e76507b290 hook: support passing stdin to hooks
    @@ Documentation/git-hook.txt: in the order they should be run, and print the confi
     +run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] [--to-stdin=<path>] `<hook-name>`::
      
      Runs hooks configured for `<hook-name>`, in the same order displayed by `git
    - hook list`. Hooks configured this way are run prepended with `sh -c`, so paths
    + hook list`. Hooks configured this way may be run prepended with `sh -c`, so
     @@ Documentation/git-hook.txt: Specify arguments to pass to every hook that is run.
      +
      Specify environment variables to set for every hook that is run.
    @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix)
      
     
      ## hook.c ##
    -@@ hook.c: int run_hooks(const char *hookname, struct run_hooks_opt *options)
    - 		struct child_process hook_proc = CHILD_PROCESS_INIT;
    - 		struct hook *hook = list_entry(pos, struct hook, list);
    +@@ hook.c: void run_hooks_opt_init(struct run_hooks_opt *o)
    + {
    + 	strvec_init(&o->env);
    + 	strvec_init(&o->args);
    ++	o->path_to_stdin = NULL;
    + 	o->run_hookdir = configured_hookdir_opt();
    + }
    + 
    +@@ hook.c: static void prepare_hook_cp(struct hook *hook, struct run_hooks_opt *options,
    + 	if (!hook)
    + 		return;
      
    -+		/* reopen the file for stdin; run_command closes it. */
    -+		if (options->path_to_stdin)
    -+			hook_proc.in = xopen(options->path_to_stdin, O_RDONLY);
    -+		else
    -+			hook_proc.no_stdin = 1;
    +-	cp->no_stdin = 1;
    ++	/* reopen the file for stdin; run_command closes it. */
    ++	if (options->path_to_stdin)
    ++		cp->in = xopen(options->path_to_stdin, O_RDONLY);
    ++	else
    ++		cp->no_stdin = 1;
     +
    - 		hook_proc.env = options->env.v;
    --		hook_proc.no_stdin = 1;
    - 		hook_proc.stdout_to_stderr = 1;
    - 		hook_proc.trace2_hook_name = hook->command.buf;
    - 		hook_proc.use_shell = 1;
    + 	cp->env = options->env.v;
    + 	cp->stdout_to_stderr = 1;
    + 	cp->trace2_hook_name = hook->command.buf;
     
      ## hook.h ##
     @@ hook.h: struct run_hooks_opt
    @@ hook.h: struct run_hooks_opt
     +	const char *path_to_stdin;
      };
      
    - #define RUN_HOOKS_OPT_INIT  {   		\
    --	.env = STRVEC_INIT, 				\
    -+	.env = STRVEC_INIT, 			\
    - 	.args = STRVEC_INIT, 			\
    -+	.path_to_stdin = NULL,			\
    - 	.run_hookdir = configured_hookdir_opt()	\
    - }
    - 
    + void run_hooks_opt_init(struct run_hooks_opt *o);
     @@ hook.h: int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir);
      
      /*
    @@ hook.h: int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdi
      
     
      ## t/t1360-config-based-hooks.sh ##
    -@@ t/t1360-config-based-hooks.sh: test_expect_success 'out-of-repo runs excluded' '
    - 	nongit test_must_fail git hook run pre-commit
    +@@ t/t1360-config-based-hooks.sh: test_expect_success 'hook.runHookDir is tolerant to unknown values' '
    + 	test_i18ncmp expected actual
      '
      
     +test_expect_success 'stdin to multiple hooks' '
11:  0465a9ec94 ! 11:  5f41555e49 run-command: allow stdin for run_processes_parallel
    @@ run-command.c: static int pp_start_one(struct parallel_processes *pp)
      	if (i == pp->max_processes)
      		BUG("bookkeeping is hard");
      
    -+	/* disallow by default, but allow users to set up stdin if they wish */
    ++	/*
    ++	 * By default, do not inherit stdin from the parent process - otherwise,
    ++	 * all children would share stdin! Users may overwrite this to provide
    ++	 * something to the child's stdin by having their 'get_next_task'
    ++	 * callback assign 0 to .no_stdin and an appropriate integer to .in.
    ++	 */
     +	pp->children[i].process.no_stdin = 1;
     +
      	code = pp->get_next_task(&pp->children[i].process,
12:  83eb7805a4 ! 12:  a3bf826304 hook: allow parallel hook execution
    @@ Documentation/git-hook.txt: in the order they should be run, and print the confi
     +run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] [--to-stdin=<path>] [(-j|--jobs)<n>] `<hook-name>`::
      
      Runs hooks configured for `<hook-name>`, in the same order displayed by `git
    - hook list`. Hooks configured this way are run prepended with `sh -c`, so paths
    + hook list`. Hooks configured this way may be run prepended with `sh -c`, so
     @@ Documentation/git-hook.txt: Specify environment variables to set for every hook that is run.
      Specify a file which will be streamed into stdin for every hook that is run.
      Each hook will receive the entire file from beginning to EOF.
    @@ builtin/hook.c
      	NULL
      };
      
    -@@ builtin/hook.c: static int list(int argc, const char **argv, const char *prefix)
    - static int run(int argc, const char **argv, const char *prefix)
    - {
    - 	struct strbuf hookname = STRBUF_INIT;
    --	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
    -+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_ASYNC;
    - 	int rc = 0;
    - 
    - 	struct option run_options[] = {
     @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix)
      			   N_("argument to pass to hook")),
      		OPT_STRING(0, "to-stdin", &opt.path_to_stdin, N_("path"),
    @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix)
      		OPT_END(),
      	};
      
    +-	run_hooks_opt_init(&opt);
    ++	run_hooks_opt_init_async(&opt);
    + 
    + 	argc = parse_options(argc, argv, prefix, run_options,
    + 			     builtin_hook_usage, 0);
     
      ## hook.c ##
     @@ hook.c: enum hookdir_opt configured_hookdir_opt(void)
    @@ hook.c: enum hookdir_opt configured_hookdir_opt(void)
      static int should_include_hookdir(const char *path, enum hookdir_opt cfg)
      {
      	struct strbuf prompt = STRBUF_INIT;
    -@@ hook.c: void run_hooks_opt_init(struct run_hooks_opt *o)
    +@@ hook.c: struct list_head* hook_list(const struct strbuf* hookname)
    + 	return hook_head;
    + }
    + 
    +-void run_hooks_opt_init(struct run_hooks_opt *o)
    ++void run_hooks_opt_init_sync(struct run_hooks_opt *o)
    + {
      	strvec_init(&o->env);
      	strvec_init(&o->args);
    + 	o->path_to_stdin = NULL;
      	o->run_hookdir = configured_hookdir_opt();
    ++	o->jobs = 1;
    ++}
    ++
    ++void run_hooks_opt_init_async(struct run_hooks_opt *o)
    ++{
    ++	run_hooks_opt_init_sync(o);
     +	o->jobs = configured_hook_jobs();
      }
      
    @@ hook.c: void run_hooks_opt_clear(struct run_hooks_opt *o)
      	strvec_clear(&o->args);
      }
      
    -+
    +-static void prepare_hook_cp(struct hook *hook, struct run_hooks_opt *options,
    +-			    struct child_process *cp)
     +static int pick_next_hook(struct child_process *cp,
     +			  struct strbuf *out,
     +			  void *pp_cb,
     +			  void **pp_task_cb)
    -+{
    + {
     +	struct hook_cb_data *hook_cb = pp_cb;
    ++	struct hook *hook = hook_cb->run_me;
     +
    -+	struct hook *hook = list_entry(hook_cb->run_me, struct hook, list);
    -+
    -+	if (hook_cb->head == hook_cb->run_me)
    + 	if (!hook)
    +-		return;
     +		return 0;
    -+
    -+	cp->env = hook_cb->options->env.v;
    -+	cp->stdout_to_stderr = 1;
    -+	cp->trace2_hook_name = hook->command.buf;
    -+
    -+	/* reopen the file for stdin; run_command closes it. */
    + 
    + 	/* reopen the file for stdin; run_command closes it. */
    +-	if (options->path_to_stdin)
    +-		cp->in = xopen(options->path_to_stdin, O_RDONLY);
    +-	else
     +	if (hook_cb->options->path_to_stdin) {
     +		cp->no_stdin = 0;
     +		cp->in = xopen(hook_cb->options->path_to_stdin, O_RDONLY);
     +	} else {
    -+		cp->no_stdin = 1;
    + 		cp->no_stdin = 1;
     +	}
    -+
    -+	/*
    -+	 * Commands from the config could be oneliners, but we know
    -+	 * for certain that hookdir commands are not.
    -+	 */
    -+	if (hook->from_hookdir)
    -+		cp->use_shell = 0;
    -+	else
    -+		cp->use_shell = 1;
    -+
    -+	/* add command */
    -+	strvec_push(&cp->args, hook->command.buf);
    -+
    -+	/*
    -+	 * add passed-in argv, without expanding - let the user get back
    -+	 * exactly what they put in
    -+	 */
    + 
    +-	cp->env = options->env.v;
    ++	cp->env = hook_cb->options->env.v;
    + 	cp->stdout_to_stderr = 1;
    + 	cp->trace2_hook_name = hook->command.buf;
    + 
    +@@ hook.c: static void prepare_hook_cp(struct hook *hook, struct run_hooks_opt *options,
    + 	 * add passed-in argv, without expanding - let the user get back
    + 	 * exactly what they put in
    + 	 */
    +-	strvec_pushv(&cp->args, options->args.v);
     +	strvec_pushv(&cp->args, hook_cb->options->args.v);
     +
     +	/* Provide context for errors if necessary */
     +	*pp_task_cb = hook;
     +
     +	/* Get the next entry ready */
    -+	hook_cb->run_me = hook_cb->run_me->next;
    ++	if (hook_cb->run_me->list.next == hook_cb->head)
    ++		hook_cb->run_me = NULL;
    ++	else
    ++		hook_cb->run_me = list_entry(hook_cb->run_me->list.next,
    ++					     struct hook, list);
     +
     +	return 1;
     +}
    @@ hook.c: void run_hooks_opt_clear(struct run_hooks_opt *o)
     +	strbuf_addf(out, _("Couldn't start '%s', configured in '%s'\n"),
     +		    attempted->command.buf,
     +		    attempted->from_hookdir ? "hookdir"
    -+		    	: config_scope_name(attempted->origin));
    ++			: config_scope_name(attempted->origin));
     +
     +	/* NEEDSWORK: if halt_on_error is desired, do it here. */
     +	return 0;
    @@ hook.c: void run_hooks_opt_clear(struct run_hooks_opt *o)
     +
     +	/* NEEDSWORK: if halt_on_error is desired, do it here. */
     +	return 0;
    -+}
    -+
    + }
    + 
      int run_hooks(const char *hookname, struct run_hooks_opt *options)
      {
      	struct strbuf hookname_str = STRBUF_INIT;
    @@ hook.c: int run_hooks(const char *hookname, struct run_hooks_opt *options)
     -		struct child_process hook_proc = CHILD_PROCESS_INIT;
      		struct hook *hook = list_entry(pos, struct hook, list);
      
    --		/* reopen the file for stdin; run_command closes it. */
    --		if (options->path_to_stdin)
    --			hook_proc.in = xopen(options->path_to_stdin, O_RDONLY);
    --		else
    --			hook_proc.no_stdin = 1;
    --
    --		hook_proc.env = options->env.v;
    --		hook_proc.stdout_to_stderr = 1;
    --		hook_proc.trace2_hook_name = hook->command.buf;
    --		hook_proc.use_shell = 1;
    --
    --		if (hook->from_hookdir) {
    --		    if (!should_include_hookdir(hook->command.buf, options->run_hookdir))
    + 		if (hook->from_hookdir &&
    + 		    !should_include_hookdir(hook->command.buf, options->run_hookdir))
     -			continue;
    --		    /*
    --		     * Commands from the config could be oneliners, but we know
    --		     * for certain that hookdir commands are not.
    --		     */
    --		    hook_proc.use_shell = 0;
    --		}
    --
    --		/* add command */
    --		strvec_push(&hook_proc.args, hook->command.buf);
    -+		if (hook->from_hookdir &&
    -+		    !should_include_hookdir(hook->command.buf, options->run_hookdir))
     +			    list_del(pos);
     +	}
    ++
    ++	if (list_empty(to_run))
    ++		return 0;
      
    --		/*
    --		 * add passed-in argv, without expanding - let the user get back
    --		 * exactly what they put in
    --		 */
    --		strvec_pushv(&hook_proc.args, options->args.v);
    +-		prepare_hook_cp(hook, options, &hook_proc);
     +	cb_data.head = to_run;
    -+	cb_data.run_me = to_run->next;
    ++	cb_data.run_me = list_entry(to_run->next, struct hook, list);
      
     -		rc |= run_command(&hook_proc);
     -	}
    @@ hook.h: enum hookdir_opt
      	/* Environment vars to be set for each hook */
     @@ hook.h: struct run_hooks_opt
      
    + 	/*
    + 	 * How should the hookdir be handled?
    +-	 * Leave the RUN_HOOKS_OPT_INIT default in most cases; this only needs
    ++	 * Leave the run_hooks_opt_init_*() default in most cases; this only needs
    + 	 * to be overridden if the user can override it at the command line.
    + 	 */
    + 	enum hookdir_opt run_hookdir;
    + 
      	/* Path to file which should be piped to stdin for each hook */
      	const char *path_to_stdin;
     +
     +	/* Number of threads to parallelize across */
     +	int jobs;
    - };
    - 
    --#define RUN_HOOKS_OPT_INIT  {   		\
    ++};
    ++
     +/*
     + * Callback provided to feed_pipe_fn and consume_sideband_fn.
     + */
     +struct hook_cb_data {
     +	int rc;
     +	struct list_head *head;
    -+	struct list_head *run_me;
    ++	struct hook *run_me;
     +	struct run_hooks_opt *options;
    -+};
    -+
    -+#define RUN_HOOKS_OPT_INIT_SYNC  {   		\
    - 	.env = STRVEC_INIT, 			\
    - 	.args = STRVEC_INIT, 			\
    - 	.path_to_stdin = NULL,			\
    -+	.jobs = 1,				\
    - 	.run_hookdir = configured_hookdir_opt()	\
    - }
    + };
      
    -+#define RUN_HOOKS_OPT_INIT_ASYNC {		\
    -+	.env = STRVEC_INIT, 			\
    -+	.args = STRVEC_INIT, 			\
    -+	.path_to_stdin = NULL,			\
    -+	.jobs = configured_hook_jobs(),		\
    -+	.run_hookdir = configured_hookdir_opt()	\
    -+}
    -+
    -+
    - void run_hooks_opt_init(struct run_hooks_opt *o);
    +-void run_hooks_opt_init(struct run_hooks_opt *o);
    ++void run_hooks_opt_init_sync(struct run_hooks_opt *o);
    ++void run_hooks_opt_init_async(struct run_hooks_opt *o);
      void run_hooks_opt_clear(struct run_hooks_opt *o);
      
    + /*
13:  f84c879d5a <  -:  ---------- hook: allow specifying working directory for hooks
 -:  ---------- > 13:  0c4add98a4 hook: allow specifying working directory for hooks
14:  ac9cec6587 = 14:  1847c4c675 run-command: add stdin callback for parallelization
15:  71fca28ccf ! 15:  ab781c94d7 hook: provide stdin by string_list or callback
    @@ hook.c: static void append_or_move_hook(struct list_head *head, const char *comm
      	}
      
      	/* re-set the scope so we show where an override was specified */
    +@@ hook.c: void run_hooks_opt_init_sync(struct run_hooks_opt *o)
    + 	o->run_hookdir = configured_hookdir_opt();
    + 	o->jobs = 1;
    + 	o->dir = NULL;
    ++	o->feed_pipe = NULL;
    ++	o->feed_pipe_ctx = NULL;
    + }
    + 
    + void run_hooks_opt_init_async(struct run_hooks_opt *o)
     @@ hook.c: void run_hooks_opt_clear(struct run_hooks_opt *o)
    - {
    - 	strvec_clear(&o->env);
      	strvec_clear(&o->args);
    -+	string_list_clear(&o->str_stdin, 0);
      }
      
    - 
    -+static int pipe_from_string_list(struct strbuf *pipe, void *pp_cb, void *pp_task_cb)
    ++int pipe_from_string_list(struct strbuf *pipe, void *pp_cb, void *pp_task_cb)
     +{
     +	int *item_idx;
     +	struct hook *ctx = pp_task_cb;
    -+	struct string_list *to_pipe = &((struct hook_cb_data*)pp_cb)->options->str_stdin;
    ++	struct string_list *to_pipe = ((struct hook_cb_data*)pp_cb)->options->feed_pipe_ctx;
     +
     +	/* Bootstrap the state manager if necessary. */
     +	if (!ctx->feed_pipe_cb_data) {
    @@ hook.c: int run_hooks(const char *hookname, struct run_hooks_opt *options)
      	if (!options)
      		BUG("a struct run_hooks_opt must be provided to run_hooks");
      
    -+	if ((options->path_to_stdin && options->str_stdin.nr) ||
    -+	    (options->path_to_stdin && options->feed_pipe) ||
    -+	    (options->str_stdin.nr && options->feed_pipe))
    ++	if (options->path_to_stdin && options->feed_pipe)
     +		BUG("choose only one method to populate stdin");
    -+
    -+	if (options->str_stdin.nr)
    -+		options->feed_pipe = &pipe_from_string_list;
     +
      	strbuf_addstr(&hookname_str, hookname);
      
    @@ hook.h
      #include "strvec.h"
     +#include "run-command.h"
      
    - struct hook
    - {
    -@@ hook.h: struct hook
    + struct hook {
    + 	struct list_head list;
    +@@ hook.h: struct hook {
      	/* The literal command to run. */
      	struct strbuf command;
    - 	int from_hookdir;
    + 	unsigned from_hookdir : 1;
     +
     +	/*
     +	 * Use this to keep state for your feed_pipe_fn if you are using
    @@ hook.h: struct run_hooks_opt
      
      	/* Path to file which should be piped to stdin for each hook */
      	const char *path_to_stdin;
    -+	/* Pipe each string to stdin, separated by newlines */
    -+	struct string_list str_stdin;
     +	/*
     +	 * Callback and state pointer to ask for more content to pipe to stdin.
     +	 * Will be called repeatedly, for each hook. See
     +	 * hook.c:pipe_from_stdin() for an example. Keep per-hook state in
     +	 * hook.feed_pipe_cb_data (per process). Keep initialization context in
     +	 * feed_pipe_ctx (shared by all processes).
    ++	 *
    ++	 * See 'pipe_from_string_list()' for info about how to specify a
    ++	 * string_list as the stdin input instead of writing your own handler.
     +	 */
     +	feed_pipe_fn feed_pipe;
     +	void *feed_pipe_ctx;
    @@ hook.h: struct run_hooks_opt
     +
      };
      
    ++/*
    ++ * To specify a 'struct string_list', set 'run_hooks_opt.feed_pipe_ctx' to the
    ++ * string_list and set 'run_hooks_opt.feed_pipe' to 'pipe_from_string_list()'.
    ++ * This will pipe each string in the list to stdin, separated by newlines.  (Do
    ++ * not inject your own newlines.)
    ++ */
    ++int pipe_from_string_list(struct strbuf *pipe, void *pp_cb, void *pp_task_cb);
    ++
      /*
    -@@ hook.h: struct hook_cb_data {
    - 	.path_to_stdin = NULL,			\
    - 	.jobs = 1,				\
    - 	.dir = NULL,				\
    -+	.str_stdin = STRING_LIST_INIT_DUP,	\
    -+	.feed_pipe = NULL,			\
    -+	.feed_pipe_ctx = NULL,			\
    - 	.run_hookdir = configured_hookdir_opt()	\
    - }
    - 
    -@@ hook.h: struct hook_cb_data {
    - 	.path_to_stdin = NULL,			\
    - 	.jobs = configured_hook_jobs(),		\
    - 	.dir = NULL,				\
    -+	.str_stdin = STRING_LIST_INIT_DUP,	\
    -+	.feed_pipe = NULL,			\
    -+	.feed_pipe_ctx = NULL,			\
    - 	.run_hookdir = configured_hookdir_opt()	\
    - }
    - 
    +  * Callback provided to feed_pipe_fn and consume_sideband_fn.
    +  */
16:  98253fa8fd = 16:  c51bf46e8d run-command: allow capturing of collated output
17:  9505812b74 ! 17:  b90a4ee79b hooks: allow callers to capture output
    @@ Commit message
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
     
      ## hook.c ##
    +@@ hook.c: void run_hooks_opt_init_sync(struct run_hooks_opt *o)
    + 	o->dir = NULL;
    + 	o->feed_pipe = NULL;
    + 	o->feed_pipe_ctx = NULL;
    ++	o->consume_sideband = NULL;
    + }
    + 
    + void run_hooks_opt_init_async(struct run_hooks_opt *o)
     @@ hook.c: int run_hooks(const char *hookname, struct run_hooks_opt *options)
      				   pick_next_hook,
      				   notify_start_failure,
    @@ hook.h: struct run_hooks_opt
      	/* Number of threads to parallelize across */
      	int jobs;
      
    -@@ hook.h: struct hook_cb_data {
    - 	.str_stdin = STRING_LIST_INIT_DUP,	\
    - 	.feed_pipe = NULL,			\
    - 	.feed_pipe_ctx = NULL,			\
    -+	.consume_sideband = NULL,		\
    - 	.run_hookdir = configured_hookdir_opt()	\
    - }
    - 
    -@@ hook.h: struct hook_cb_data {
    - 	.str_stdin = STRING_LIST_INIT_DUP,	\
    - 	.feed_pipe = NULL,			\
    - 	.feed_pipe_ctx = NULL,			\
    -+	.consume_sideband = NULL,		\
    - 	.run_hookdir = configured_hookdir_opt()	\
    - }
    - 

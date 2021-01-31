Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCF7C433DB
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 03:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2052464E17
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 03:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhAaDK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 22:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhAaDK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 22:10:56 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A55EC061573
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 19:10:16 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id 70so10402018qkh.4
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 19:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=rvgfhv7d+bfOQKt+8aXwpn3JVxKtuI7tBiEOhhl/0Kw=;
        b=b2yp8l90XzzNKxQnb5C8nTk//DGxuVIw4q8GhfScyMBaTKNSl5dr9gcMa9w9MERFyT
         tRt/iS+Gylegv47Xw4FZfWqyHanf/1u5kTrMCUNTuAbxE8YWbo33jagdHy2jC20iAsR4
         +YyV4KgyM/JMXtxnOFBWzKY3sakMPldkOxpe+WJAOjoEGU9sbafCWzQTLjlg+aJwZlvs
         mkKO0B9Jb2FrGpIbLoUlBAB6z32bqSHUGUw66kGw9VAYnuxvXKOejD4bxQumXPKMJTE/
         vuMvmD3eKT1CbDYuY2MyDMxG+IFnhFKN2+qhLcjPFGu/c/eBsnltahTMtcHjTSl+tHMm
         ifPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rvgfhv7d+bfOQKt+8aXwpn3JVxKtuI7tBiEOhhl/0Kw=;
        b=gbb5UcFQuK8LTDyafR6uxewm305ukAaX1ux6Hl0hU4fpw2EAZo9vaO41pwex2qGT3i
         zetIuVjFU+7pOGIGoygH/oYw/MExXhplV9EUxZaGvfS+Br0uYSRf288rZq+HDLX2CGvT
         wG3puXqftMvNBZbn6NreOlOtnplIlVuh5jgiLMag8gpqLdztJxoSYJK8eRa8lfc0XhLN
         H1+xSmPhlMIsMs+pfZOyz1kdhDI5RjVo2MO8/qFLgAELFsNvlUjJyBs9xnYJ4p9tjsTg
         qZNdmBAj42e6uZ3HfqVp5+jwz/vmqSDJQBmp/WpJ0D7xsX/eLNhPrPUvVMi4tEVOgBNe
         6Xug==
X-Gm-Message-State: AOAM532zfFyIOw8fgrXH2s/wWYyqdp0/SpR83mzL6D8qXZ4yfXOXLbT/
        p/OslypdQKkKv4ptKcXVJKTfnBjJsvWYDlYD9pXC
X-Google-Smtp-Source: ABdhPJyrQ97MZIewGu3ZM2MmGEvX2lte9zyszzu+Kjy1YMRV9+i5kOCTPcuxQe16JdwQ5exjFdGdzbTVYEA6X3FYmH3D
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:e4cf:: with SMTP id
 g15mr10194787qvm.23.1612062614995; Sat, 30 Jan 2021 19:10:14 -0800 (PST)
Date:   Sat, 30 Jan 2021 19:10:11 -0800
In-Reply-To: <20201222000220.1491091-4-emilyshaffer@google.com>
Message-Id: <20210131031011.1016240-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201222000220.1491091-4-emilyshaffer@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: Re: [PATCH v7 03/17] hook: add list command
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Teach 'git hook list <hookname>', which checks the known configs in
> order to create an ordered list of hooks to run on a given hook event.
> 
> Multiple commands can be specified for a given hook by providing
> multiple "hook.<hookname>.command = <path-to-hook>" lines. Hooks will be
> run in config order. If more properties need to be set on a given hook
> in the future, commands can also be specified by providing
> "hook.<hookname>.command = <hookcmd-name>", as well as a "[hookcmd
> <hookcmd-name>]" subsection; at minimum, this subsection must contain a
> "hookcmd.<hookcmd-name>.command = <path-to-hook>" line.

I learned later that this isn't true - in patch 6, the commit message
and one of the tests therein describe being able to skip a previously
inline command by making a hookcmd section of the same name and just
specifying "skip = true" there (without any command).

Maybe just delete the "at minimum" part.

> +static int list(int argc, const char **argv, const char *prefix)
>  {
> -	struct option builtin_hook_options[] = {
> +	struct list_head *head, *pos;
> +	struct hook *item;

You asked for review on nits too so here's one: "item" should be
declared in the list_for_each block. (That also makes it easier to see
that we don't need to free it.)

> diff --git a/hook.c b/hook.c
> new file mode 100644
> index 0000000000..937dc768c8
> --- /dev/null
> +++ b/hook.c
> @@ -0,0 +1,115 @@
> +#include "cache.h"
> +
> +#include "hook.h"
> +#include "config.h"

Usually we put all the includes together without any intervening blank
lines.

> +static void append_or_move_hook(struct list_head *head, const char *command)
> +{
> +	struct list_head *pos = NULL, *tmp = NULL;
> +	struct hook *to_add = NULL;
> +
> +	/*
> +	 * remove the prior entry with this command; we'll replace it at the
> +	 * end.
> +	 */
> +	list_for_each_safe(pos, tmp, head) {
> +		struct hook *it = list_entry(pos, struct hook, list);
> +		if (!strcmp(it->command.buf, command)) {
> +		    list_del(pos);
> +		    /* we'll simply move the hook to the end */
> +		    to_add = it;

"break" here?

> +		}
> +	}
> +
> +	if (!to_add) {
> +		/* adding a new hook, not moving an old one */
> +		to_add = xmalloc(sizeof(struct hook));

Style is to write sizeof(*to_add), I think.

[snip]

> +struct hook_config_cb
> +{
> +	struct strbuf *hookname;

struct declarations have "{" not on a line on its own.

Also, "hookname" could just be a char *?
	
> +	struct list_head *list;
> +};
> +
> +static int hook_config_lookup(const char *key, const char *value, void *cb_data)
> +{
> +	struct hook_config_cb *data = cb_data;
> +	const char *hook_key = data->hookname->buf;
> +	struct list_head *head = data->list;
> +
> +	if (!strcmp(key, hook_key)) {
> +		const char *command = value;
> +		struct strbuf hookcmd_name = STRBUF_INIT;
> +
> +		/* Check if a hookcmd with that name exists. */
> +		strbuf_addf(&hookcmd_name, "hookcmd.%s.command", command);
> +		git_config_get_value(hookcmd_name.buf, &command);

So we don't really care whether git_config_get_value returns 0 or 1 as
long as it doesn't touch "command" if there is no such hookcmd. That
fits with how git_config_get_value() is documented, so that's great.
Perhaps better to document as:

  If a hookcmd.%s.command config exists, replace the command with the
  value of that config. (If not, do nothing - git_config_get_value() is
  documented to not overwrite the value argument in this case.)

> +
> +		if (!command) {
> +			strbuf_release(&hookcmd_name);
> +			BUG("git_config_get_value overwrote a string it shouldn't have");
> +		}
> +
> +		/*
> +		 * TODO: implement an option-getting callback, e.g.
> +		 *   get configs by pattern hookcmd.$value.*
> +		 *   for each key+value, do_callback(key, value, cb_data)
> +		 */
> +
> +		append_or_move_hook(head, command);
> +
> +		strbuf_release(&hookcmd_name);
> +	}
> +
> +	return 0;
> +}
> +
> +struct list_head* hook_list(const struct strbuf* hookname)

"const char *hookname" should suffice?

Also, search for "* " and replace with " *" where applicable (also in
the .h file).

> +{
> +	struct strbuf hook_key = STRBUF_INIT;
> +	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
> +	struct hook_config_cb cb_data = { &hook_key, hook_head };
> +
> +	INIT_LIST_HEAD(hook_head);
> +
> +	if (!hookname)
> +		return NULL;
> +
> +	strbuf_addf(&hook_key, "hook.%s.command", hookname->buf);
> +
> +	git_config(hook_config_lookup, (void*)&cb_data);

Do we need this void* cast?

> +
> +	strbuf_release(&hook_key);
> +	return hook_head;
> +}
> diff --git a/hook.h b/hook.h
> new file mode 100644
> index 0000000000..8ffc4f14b6
> --- /dev/null
> +++ b/hook.h
> @@ -0,0 +1,26 @@
> +#include "config.h"
> +#include "list.h"
> +#include "strbuf.h"
> +
> +struct hook
> +{
> +	struct list_head list;
> +	/*
> +	 * Config file which holds the hook.*.command definition.
> +	 * (This has nothing to do with the hookcmd.<name>.* configs.)
> +	 */
> +	enum config_scope origin;
> +	/* The literal command to run. */
> +	struct strbuf command;

"char *" would suffice?

The tests look fine.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C12C433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 21:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FF9664EE4
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 21:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbhBIVog (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 16:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbhBIVJB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 16:09:01 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E8BC0613D6
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 13:06:41 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d13so10502410plg.0
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 13:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JANNoqE1J0JnSfhr/RO41wHuKDup3z3LtSIN5awUd2U=;
        b=iUcRE3tPu01k/fqC97P7FBzi5EqezVR06UoioKlxBtPsStwr0fM95d80VDi2pfYI3U
         3aDtCGlbTG7O2Yh8Cezhzl8nUff787VlUUbwR9fPmr5o5V9Ndta4gZs8BVyEuABeeo1t
         St1cwQZSLK8rHx6y6Ao8NhA8+U4IXbwfIquZvM1bmXpl46GjuCL2QA4bbJWomV3hItnn
         QtSwmMIOFQOUZN8KXnEsNk30Yc02xErKPJyL2kr+MhKmpxV3/hNn/zICerCf+D6/0DBK
         6khh9XgKWo6kXNkXl5CFDTFepWwQeRf+171XWTO1SmqpQKs00ovd8irC0hLXSLbukkNa
         J83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JANNoqE1J0JnSfhr/RO41wHuKDup3z3LtSIN5awUd2U=;
        b=TSPY+WXXj1Et+BTRRcRgXSGapNfkgrDDBfq8UJ/qV5wOC7p7YMHzqlC+wHrZul7F8w
         bP+kjcYyfPEXAjMq3fdMaINltk8Ww6xnAGWuIlnDgzb5j7H0ceb5f8q0BJE5sTNV7od5
         v8SJ+J8WStzMGAjs9JNaP36nSgKhzLrtOLqxDPl3vbxBiLTmXhwglnpLirGAIgQ+PJUy
         DQlq+vuZcH1A6KZ6nAhfN+NSYVKV5UCAvv7fBSEySBHkaerILSXYq4MmsvYgD17SHSX9
         OxqZK1zTCWG0xXTtRfpiuMuac2tVIGXHgb9pxqaq2Z+vJ2tkNF+TwIcIg398fA7Taqvw
         tbFg==
X-Gm-Message-State: AOAM531wBN683exKxcnmsGwGQixhBhECxgljoBVouXSxQcBdUffZ3EHM
        G0dyst9rmKGn6XlDQhtcIvISfBNPC7+dUA==
X-Google-Smtp-Source: ABdhPJzR2DRfApbg8na0g5/CYOw4QbRrsYtnmxvupauu+cepAGnEwW3RdgB2oqSmCv+ofJxdP9Zi0A==
X-Received: by 2002:a17:90a:e16:: with SMTP id v22mr5854069pje.73.1612904800716;
        Tue, 09 Feb 2021 13:06:40 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:7413:906e:c6f8:81a1])
        by smtp.gmail.com with ESMTPSA id a15sm11393893pfg.159.2021.02.09.13.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 13:06:39 -0800 (PST)
Date:   Tue, 9 Feb 2021 13:06:35 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 03/17] hook: add list command
Message-ID: <YCL5W31A0ClF16ug@google.com>
References: <20201222000220.1491091-4-emilyshaffer@google.com>
 <20210131031011.1016240-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210131031011.1016240-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 30, 2021 at 07:10:11PM -0800, Jonathan Tan wrote:
> 
> > Teach 'git hook list <hookname>', which checks the known configs in
> > order to create an ordered list of hooks to run on a given hook event.
> > 
> > Multiple commands can be specified for a given hook by providing
> > multiple "hook.<hookname>.command = <path-to-hook>" lines. Hooks will be
> > run in config order. If more properties need to be set on a given hook
> > in the future, commands can also be specified by providing
> > "hook.<hookname>.command = <hookcmd-name>", as well as a "[hookcmd
> > <hookcmd-name>]" subsection; at minimum, this subsection must contain a
> > "hookcmd.<hookcmd-name>.command = <path-to-hook>" line.
> 
> I learned later that this isn't true - in patch 6, the commit message
> and one of the tests therein describe being able to skip a previously
> inline command by making a hookcmd section of the same name and just
> specifying "skip = true" there (without any command).
> 
> Maybe just delete the "at minimum" part.

Thanks, nice catch. I dropped "at minimum" and s/must/should/. Since I
received feedback during the dogfood internally that there's no
documentation on "hookcmd.<thing>.skip" whatsoever, I'll try to make
a more detailed overview of hookcmd acting as an alias in the
user-facing docs in that commit.

> 
> > +static int list(int argc, const char **argv, const char *prefix)
> >  {
> > -	struct option builtin_hook_options[] = {
> > +	struct list_head *head, *pos;
> > +	struct hook *item;
> 
> You asked for review on nits too so here's one: "item" should be
> declared in the list_for_each block. (That also makes it easier to see
> that we don't need to free it.)

Ok, done.

> 
> > diff --git a/hook.c b/hook.c
> > new file mode 100644
> > index 0000000000..937dc768c8
> > --- /dev/null
> > +++ b/hook.c
> > @@ -0,0 +1,115 @@
> > +#include "cache.h"
> > +
> > +#include "hook.h"
> > +#include "config.h"
> 
> Usually we put all the includes together without any intervening blank
> lines.

Done.

> 
> > +static void append_or_move_hook(struct list_head *head, const char *command)
> > +{
> > +	struct list_head *pos = NULL, *tmp = NULL;
> > +	struct hook *to_add = NULL;
> > +
> > +	/*
> > +	 * remove the prior entry with this command; we'll replace it at the
> > +	 * end.
> > +	 */
> > +	list_for_each_safe(pos, tmp, head) {
> > +		struct hook *it = list_entry(pos, struct hook, list);
> > +		if (!strcmp(it->command.buf, command)) {
> > +		    list_del(pos);
> > +		    /* we'll simply move the hook to the end */
> > +		    to_add = it;
> 
> "break" here?

I think it's safe to do so, but I think I left it out in case duplicates
do make it into the list somehow. But if they're always being inserted
via "append_or_move_hook()" that should not be an issue, so I'll add the
break.

In fact, fixing this exposed a bug. Later, I add using 'pos' instead of
'head':
  list_add_tail(&to_add->list, pos);
When I'm guaranteed to iterate to the end of the list, that works fine,
because in this implementation the last element of the list has "->next"
set back to "head". But when 'pos' isn't sure to be at the end of the
list, it breaks the list. Whoops.. :)


> 
> > +		}
> > +	}
> > +
> > +	if (!to_add) {
> > +		/* adding a new hook, not moving an old one */
> > +		to_add = xmalloc(sizeof(struct hook));
> 
> Style is to write sizeof(*to_add), I think.

Sure.

> 
> [snip]
> 
> > +struct hook_config_cb
> > +{
> > +	struct strbuf *hookname;
> 
> struct declarations have "{" not on a line on its own.

Sure, I can change it. Although, 'git grep -E "struct \w+$"' tells me
there are a few other offenders :) But the count (60ish minus
doc/relnotes references) is much lower than 'git grep -E "struct \w+
\{$"' (800+ matches) so I'm definitely doing it wrong :D

> 
> Also, "hookname" could just be a char *?

Hrmph. I think my C++ background is showing - to me, calling ".buf"
(which is cheap) a few times is a small price to pay to get length
info and so on for free. "hookname" can come from the user - "git
hook (list|run) repo-special-magic-hook" - so I worry about leaving it as a raw
char* with no size info associated. Am I being too paranoid?

> 	
> > +	struct list_head *list;
> > +};
> > +
> > +static int hook_config_lookup(const char *key, const char *value, void *cb_data)
> > +{
> > +	struct hook_config_cb *data = cb_data;
> > +	const char *hook_key = data->hookname->buf;
> > +	struct list_head *head = data->list;
> > +
> > +	if (!strcmp(key, hook_key)) {
> > +		const char *command = value;
> > +		struct strbuf hookcmd_name = STRBUF_INIT;
> > +
> > +		/* Check if a hookcmd with that name exists. */
> > +		strbuf_addf(&hookcmd_name, "hookcmd.%s.command", command);
> > +		git_config_get_value(hookcmd_name.buf, &command);
> 
> So we don't really care whether git_config_get_value returns 0 or 1 as
> long as it doesn't touch "command" if there is no such hookcmd. That
> fits with how git_config_get_value() is documented, so that's great.
> Perhaps better to document as:
> 
>   If a hookcmd.%s.command config exists, replace the command with the
>   value of that config. (If not, do nothing - git_config_get_value() is
>   documented to not overwrite the value argument in this case.)

OK. Thanks, done.

> 
> > +
> > +		if (!command) {
> > +			strbuf_release(&hookcmd_name);
> > +			BUG("git_config_get_value overwrote a string it shouldn't have");
> > +		}
> > +
> > +		/*
> > +		 * TODO: implement an option-getting callback, e.g.
> > +		 *   get configs by pattern hookcmd.$value.*
> > +		 *   for each key+value, do_callback(key, value, cb_data)
> > +		 */
> > +
> > +		append_or_move_hook(head, command);
> > +
> > +		strbuf_release(&hookcmd_name);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +struct list_head* hook_list(const struct strbuf* hookname)
> 
> "const char *hookname" should suffice?
> 
> Also, search for "* " and replace with " *" where applicable (also in
> the .h file).

See above.

> 
> > +{
> > +	struct strbuf hook_key = STRBUF_INIT;
> > +	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
> > +	struct hook_config_cb cb_data = { &hook_key, hook_head };
> > +
> > +	INIT_LIST_HEAD(hook_head);
> > +
> > +	if (!hookname)
> > +		return NULL;
> > +
> > +	strbuf_addf(&hook_key, "hook.%s.command", hookname->buf);
> > +
> > +	git_config(hook_config_lookup, (void*)&cb_data);
> 
> Do we need this void* cast?

Nope. Dropped, thanks.

> 
> > +
> > +	strbuf_release(&hook_key);
> > +	return hook_head;
> > +}
> > diff --git a/hook.h b/hook.h
> > new file mode 100644
> > index 0000000000..8ffc4f14b6
> > --- /dev/null
> > +++ b/hook.h
> > @@ -0,0 +1,26 @@
> > +#include "config.h"
> > +#include "list.h"
> > +#include "strbuf.h"
> > +
> > +struct hook
> > +{
> > +	struct list_head list;
> > +	/*
> > +	 * Config file which holds the hook.*.command definition.
> > +	 * (This has nothing to do with the hookcmd.<name>.* configs.)
> > +	 */
> > +	enum config_scope origin;
> > +	/* The literal command to run. */
> > +	struct strbuf command;
> 
> "char *" would suffice?

Since 'command' comes directly from user input and is executed, I'm
nervous about using a char* instead of a strbuf even more so than for
the hookname.

> 
> The tests look fine.

Thanks for the nitpicky review, it was great! :)

 - Emily

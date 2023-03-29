Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04101C74A5B
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 11:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjC2Ldu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 07:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjC2Ldr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 07:33:47 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA7640F2
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 04:33:40 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ek18so61871843edb.6
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 04:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680089618;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9B3uW54iWMCvNIUrmCiZdT2VAqbHRYGZO0J0Gcauy1k=;
        b=g/qLBX8A8dlSCk401pCqA+oeqXRNTJCuiB9ieoDVcgGWSM7MM2N0lSZwD8XXIWrEhz
         Qgo38OqbqWYY/LzEIHbW0QGA/7de1XKbgLAMFik+7usq9NWZelPZjQKNt1i/54ymIPAX
         O0YJeYNurRyNHzSPUh304UM89GCmiMKIdC5H8ymp87IJvbLGjpj/WjgNNJcgzp8z/RDk
         ff6i6NxLb/2rQLHGbRV3wBUc/qtX3lVmiFtdv3i5DqjB6gw7Wd0WQRt2NEVrYczuv6dQ
         G6fNvQQQm8IqhMjmd9IVjnyAdJHbU30LkvDq+4qxHRCApaJQ2E7ALO7LuZiYM+FOKL93
         wnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680089618;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9B3uW54iWMCvNIUrmCiZdT2VAqbHRYGZO0J0Gcauy1k=;
        b=dx5Z2RJ5F3ofzfYvyYZmo0qmhxmyHyoK2feh1PSSucAxrt0O39wdwCaF2SEDDQX7JX
         lvKhVd8qlY8CauU31jWs/9j3MgquBbjvV50UqWmbIZEfnlNjHs3EB4J1yVCwH8Wm5nv4
         7RmtQ0rUeiBU9M1FdN7YZAhY59qtPXo9c8ONJuEC2YO+I0SecTHgr0V93wo+nG6wDSNE
         WUAew5OSZcg/0U1YJMrR1ldTgZC9pTaJk5/DCNpjSutXECsLQo6VoxkWc810mT3YrX99
         Ken+kXvk1VmIMZeogStbqRr88o7dkDRuwglbnx4C5FUcVVW22p80ViHHNYwosv/a1emc
         qBew==
X-Gm-Message-State: AAQBX9cjfoDnx+eA51dPVxH4eSPcEpl+UyeHU6Dw762e7/Es4ZHvNx+J
        sqejnQVbkGNKVQtAZyLYTRQeE1y1Vuebtw==
X-Google-Smtp-Source: AKy350Zp7aaCXI4hpEVCRgXYDJB5IBOOBgpsXKjyxSmc2b8vGx8pftb97NZ8rkv6DrSvYhgHQYkksA==
X-Received: by 2002:a17:906:b303:b0:8b1:7fa:6588 with SMTP id n3-20020a170906b30300b008b107fa6588mr16989293ejz.12.1680089618491;
        Wed, 29 Mar 2023 04:33:38 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id la18-20020a170907781200b00914001c91fcsm16367472ejc.86.2023.03.29.04.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 04:33:38 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1phU3d-0058y2-1c;
        Wed, 29 Mar 2023 13:33:37 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3 3/8] config.c: create config_reader and the_reader
Date:   Wed, 29 Mar 2023 12:41:32 +0200
References: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
 <pull.1463.v3.git.git.1680025914.gitgitgadget@gmail.com>
 <72774fd08f3eb9ff1d449814637e584692ba2bfc.1680025914.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <72774fd08f3eb9ff1d449814637e584692ba2bfc.1680025914.git.gitgitgadget@gmail.com>
Message-ID: <230329.86sfdnvlke.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 28 2023, Glen Choo via GitGitGadget wrote:

> From: Glen Choo <chooglen@google.com>
>
> Create "struct config_reader" to hold the state of the config source
> currently being read. Then, create a static instance of it,
> "the_reader", and use "the_reader.source" to replace references to
> "cf_global" in public functions.
>
> This doesn't create much immediate benefit (since we're mostly replacing
> static variables with a bigger static variable), but it prepares us for
> a future where this state doesn't have to be global; "struct
> config_reader" (or a similar struct) could be provided by the caller, or
> constructed internally by a function like "do_config_from()".
>
> A more typical approach would be to put this struct on "the_repository",
> but that's a worse fit for this use case since config reading is not
> scoped to a repository. E.g. we can read config before the repository is
> known ("read_very_early_config()"), blatantly ignore the repo
> ("read_protected_config()"), or read only from a file
> ("git_config_from_file()"). This is especially evident in t5318 and
> t9210, where test-tool and scalar parse config but don't fully
> initialize "the_repository".

I don't mean to just rehash previous discussion
(i.e. https://lore.kernel.org/git/230307.86wn3szrzu.gmgdl@evledraar.gmail.com/
and downthread). I get that you think sticking this in a "struct
repository *" here isn't clean, and would prefer to not conflate the
two.

Fair enough.

But I think this paragraph still does a bad job of justifying this
direction with reference to existing code.

Why? Because from reading it you get the impression that with
read_very_early_config() and read_protected_config() "config reading is
not scoped to a repository", but "scoped to" is doing a *lot* of work
here.

At the start of read_very_early_config() we do:

	struct config_options opts = { 0 };
	[...]
	opts.ignore_repo = 1;
	opts.ignore_worktree = 1;

And then call config_with_options(), which does:

	struct config_include_data inc = CONFIG_INCLUDE_INIT;

And that struct has:

	struct git_config_source *config_source;

Which in turn has:

	/* The repository if blob is not NULL; leave blank for the_repository */
	struct repository *repo;
	const char *blob;

The read_protected_config() is then another thin wrapper for
config_with_options().

So, so far the reader might be genuinely confused, since we already have
a "repo" in scope why can't we use it for this cache? Even if just
reading the system config etc.

For *those* cases I think what I *think* you're going for is that while
we have a "struct repository" already, we don't want to use it for our
"cache", and instead have a file-scoped one.

Personally, I don't see how it's cleaner to always use a file-scope
rather than piggy-back on the global we almost always have (or provide a
fallback), but let's not get on that topic again :)

Now, the case that *is* special on the other hand is
git_config_from_file(), there we really don't have a "repository" at
all, as it never gets the "struct config_include_data inc", or a
"git_config_source".

But if we dig a bit into those cases there's 3x users of
git_config_from_file() outside of config.c itself:

 * setup.c, to read only repo's "config.worktree"
 * setup.c, to read only repo "config"
 * sequencer.c, to read "sequencer/opts"

For the former two, I think the only thing that's needed is something
like this, along with a corresponding change to
do_git_config_sequence():

	diff --git a/config.h b/config.h
	index 7606246531a..b8a3de4eb93 100644
	--- a/config.h
	+++ b/config.h
	@@ -85,7 +85,10 @@ typedef int (*config_parser_event_fn_t)(enum config_event_t type,
	 
	 struct config_options {
	        unsigned int respect_includes : 1;
	+       unsigned int ignore_system : 1;
	+       unsigned int ignore_global : 1;
	        unsigned int ignore_repo : 1;
	+       unsigned int ignore_local : 1;
	        unsigned int ignore_worktree : 1;
	        unsigned int ignore_cmdline : 1;
	        unsigned int system_gently : 1;

I.e. we actually *do* have a repo there, we just haven't bridged the gap
of "ignore most of its config" so we can use config_with_options()
there.

The sequencer.c case is trickier, but presumably for such isolated
reading we could have a lower-level function which would return the
equivalent of a "key_value_info" on errors or whatever.


Anyway, I'm fine with this direction for now, but given the above & my
previous RFC
https://lore.kernel.org/git/RFC-cover-0.5-00000000000-20230317T042408Z-avarab@gmail.com/
I can't help but think we're taking two steps forward & one step
backwards for some of this.

I.e. are we assuming no "repo", but per the above we really do have one,
but we just don't pass it because we don't have a "read only the
worktree config part", or whatever?

Ditto the line number relaying for builtin/config.c, which as my RFC
showed we have one or two API users that care, which we can just
convert...

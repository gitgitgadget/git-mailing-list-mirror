Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DACC433EF
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 10:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbiAXKLf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 05:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiAXKLe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 05:11:34 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2656C06173B
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 02:11:33 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id o12so19888155eju.13
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 02:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=rA7o+vRsVvxay5xzOxaImzoo/mMtAI8nRxIAil3+/SA=;
        b=GAyvhmunch7btsUPXZi6gPbT2cFtE3BovOVmXcIn6z8K9j5z3PzY/CRjcYdFlkj5Eb
         W+NodHHXmZF8lJ2kdz8jHf36FZEgulPfc+bd8KtH5wuh816DjRzgzjRHOf4eRUizTktl
         VajvT5ilb+jF6zgbkSrlQ94i9t7YjHmlArpD1C27AEQjlEr5PK+asz+2kx1o8P8Vj0TO
         Gd1U4dJqyZfqmLr+70IXnwxkO5odLthpVfFS5003xI/u22rrhYQEOdfxzWH5goRGmVmY
         A7Z/CjyudxJPmn2hipohKzoorJTlIIYj6ASk2LkCvwund08NzJIMq8/qrKeHsrIbEgfd
         X60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=rA7o+vRsVvxay5xzOxaImzoo/mMtAI8nRxIAil3+/SA=;
        b=QHeP78sAgvnEZerIv9mhfrwsTBh58f8xhyK23UbwFdqMr+VCv2Q5RUF5v4pbKmDzmw
         um0LQiUw4J6raHOU59NLZM49c0HvlRvtowhArZxOk+L+2yvg0CxCsgr9Ft0wM7sNeryq
         tlxrA26H07Ufq2AXLT2RGDVlZDS/1G4HKV+EgF2pBsit+/nsjPEU/X0QApfgVn8+JUDK
         ZiJzCZcbe+gJS73228DpF5j0x0JKouVROEOD+eCXAasfKfHeO1aRBSP38ucuX1l5J2dO
         Sn+/83XILRPVYlsDtRtn0zIHKRd7p4sGpQ2SevaqIkIG8jR2mY95DAGNmPsQPD7M1hgb
         vZcg==
X-Gm-Message-State: AOAM533beV3W8zbNWA4Y0XZFcSqo3ionxSFyLK/nFrFOqjl6W2HGxzj7
        E0lzK6kpNmgcfDdLuv8A0TCF3I0alXE=
X-Google-Smtp-Source: ABdhPJzU3cx9Nah7ufK5LbBonqU4si+68fO5HGbaYu5fnWp+y2pm98KhXvR02lVZxf6MAVoliKcf6w==
X-Received: by 2002:a17:907:6da5:: with SMTP id sb37mr12676832ejc.595.1643019092296;
        Mon, 24 Jan 2022 02:11:32 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bm13sm6312196edb.67.2022.01.24.02.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 02:11:31 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nBwJv-002QeN-6C;
        Mon, 24 Jan 2022 11:11:31 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 10/12] merge-tree: provide easy access to `ls-files -u`
 style info
Date:   Mon, 24 Jan 2022 11:06:48 +0100
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <050add3e4986c457cd467b36eb4fd1f215b7406d.1642888562.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <050add3e4986c457cd467b36eb4fd1f215b7406d.1642888562.git.gitgitgadget@gmail.com>
Message-ID: <220124.864k5tigto.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jan 22 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> Much like `git merge` updates the index with information of the form
>     (mode, oid, stage, name)
> provide this output for conflicted files for merge-tree as well.
> Provide an --exclude-oids-and-modes option for users to exclude the
> mode, oid, and stage and only get the list of conflicted filenames.
> [...]
> +--exclude-oids-and-modes::
> +	Instead of writing a list of (mode, oid, stage, path) tuples
> +	to output for conflicted files, just provide a list of
> +	filenames with conflicts.
> +
> [...]
> -This is a sequence of lines containing a filename on each line, quoted
> -as explained for the configuration variable `core.quotePath` (see
> -linkgit:git-config[1]).
> +This is a sequence of lines with the format
> +
> +	<mode> <object> <stage> <filename>
> +
> +The filename will be quoted as explained for the configuration
> +variable `core.quotePath` (see linkgit:git-config[1]).  However, if
> +the `--exclude-oids-and-modes` option is passed, the mode, object, and
> +stage will be omitted.
>  
>  Informational messages
>  ~~~~~~~~~~~~~~~~~~~~~~
>  
>  This always starts with a blank line to separate it from the previous
> -section, and then has free-form messages about the merge, such as:
> +sections, and then has free-form messages about the merge, such as:
>  
>    * "Auto-merging <file>"
>    * "CONFLICT (rename/delete): <oldfile> renamed...but deleted in..."
> @@ -113,6 +123,14 @@ plumbing commands since the possibility of merge conflicts give it a
>  much higher chance of the command not succeeding (and NEWTREE containing
>  a bunch of stuff other than just a toplevel tree).
>  
> +git-merge-tree was written to provide users with the same information
> +that they'd have access to if using `git merge`:
> +  * what would be written to the working tree (the <OID of toplevel tree>)
> +  * the higher order stages that would be written to the index (the
> +    <Conflicted file info>)
> +  * any messages that would have been printed to stdout (the <Informational
> +    messages>)
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index d8eeeb3f306..7aa7f9fd54a 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -395,6 +395,7 @@ struct merge_tree_options {
>  	int real;
>  	int trivial;
>  	int show_messages;
> +	int exclude_oids_and_modes;
>  };
>  
>  static int real_merge(struct merge_tree_options *o,
> @@ -461,7 +462,11 @@ static int real_merge(struct merge_tree_options *o,
>  		merge_get_conflicted_files(&result, &conflicted_files);
>  		for (i = 0; i < conflicted_files.nr; i++) {
>  			const char *name = conflicted_files.items[i].string;
> -			if (last && !strcmp(last, name))
> +			struct stage_info *c = conflicted_files.items[i].util;
> +			if (!o->exclude_oids_and_modes)
> +				printf("%06o %s %d\t",
> +				       c->mode, oid_to_hex(&c->oid), c->stage);
> +			else if (last && !strcmp(last, name))
>  				continue;
>  			write_name_quoted_relative(
>  				name, prefix, stdout, line_termination);
> @@ -495,6 +500,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>  			 N_("do a trivial merge only")),
>  		OPT_BOOL(0, "messages", &o.show_messages,
>  			 N_("also show informational/conflict messages")),
> +		OPT_BOOL_F(0, "exclude-oids-and-modes",
> +			   &o.exclude_oids_and_modes,
> +			   N_("list conflicted files without oids and modes"),
> +			   PARSE_OPT_NONEG),
>  		OPT_END()
>  	};

Perhaps this really is the last formatting information anyone will want,
but with a default of "<mode> <object> <stage> <filename>" being made
"<stage> <filename>" with --exclude-oids-and-modes perhaps we'll want
--exclude-all-except-filename etc. later.

It seems a lot simpler for new code to just support a --conflict-format
option, lifting some code from the in-flight
https://lore.kernel.org/git/db058bf670c5668fc5b95baf83667cc282cb739b.1641978175.git.dyroneteng@gmail.com/

I.e. that inner loop becomes a slightly more verbose strbuf_expand(),
but it's all easy boilerplate code.

Then we just feed "%(objectmode) %(objectname) %(objectstage)
%(filename)" into it by default, and allow the user to customize it.

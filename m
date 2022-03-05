Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EA7C433EF
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 14:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiCEPAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Mar 2022 10:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiCEPAG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Mar 2022 10:00:06 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0216A3ED3B
        for <git@vger.kernel.org>; Sat,  5 Mar 2022 06:59:16 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id p15so23181871ejc.7
        for <git@vger.kernel.org>; Sat, 05 Mar 2022 06:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=d7gZjF3950f3w1I0+4OnuKgn+85qeg8dRkNsDGuGeMI=;
        b=eKVUw/o3uU4qL4k+pb5QmVoDSpdurwf5eSgyR+j/KoH7Lj+OgudjFxPCkozjuQvCk0
         nSUHExdg2WCJ81DyPTTIDk0p3QTJan8Rzix/zz4IVkoL46+G4R+sy/X+We8IRBPiAypQ
         aaSq71F9JbKd0bsOuA+bhklU2UuOIRjzmdFXMcUhKHaUqHFsOCnQLRe6T2Q0LwtzHiA9
         duJFmd5OfXaFq/J4PgyPJNl4xSFRZEoOHbDFbRjIStCVVS9gKQ+SvzA0jKh12PUxNrB4
         ccGcOEdcI0tHRHOrBOlVTJeqFVd7yo4WNMUV0r7kuCfdcMb8PE8V/3HX+azjCmX1hSZi
         szgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=d7gZjF3950f3w1I0+4OnuKgn+85qeg8dRkNsDGuGeMI=;
        b=m2U+quXCSlcOH+QJ3waq8NgeAM6e6LcFSGRRDirRjf3ww2otA3sY5puqN2r65JsbVE
         v35jASjGbCyhuFqxOSZVCbF0STA07SYA63dD/hnCOd1SEC/E7/5Z0XXaRUD/bPVcQ+Yo
         78JOxXNcgsizHCY3mXgYpYvLOLHbyw8d91LUtzKYCIHcc3OE9HPdVFfJk3o+HCQ7VAf7
         C0CwCjhi07eEK5ltIDltNIFHX68pvnJyS/8gFN7nBGd3/wq66SBDkiUW6urNhVsleD9N
         j1AfqcN3ML6FLZtkjDJGoDo9yKnzWpv3145WVCTiqh3M1d0M3P2mdcgMntu9IOIlC829
         kK4g==
X-Gm-Message-State: AOAM530dBHIDj1iVEkYBhthBTb+brbKZxW94mPf3+AFhVrlv70cSmboJ
        rHVci1SESBzErTrTLHwOgGE6c/HiS+Epsg==
X-Google-Smtp-Source: ABdhPJxdGFw+04kYkP+9WwUHB3kUwzaQMloj/9YbNTLhOhubaE5ZR+rJbe1GMJ8uksGAzyvXc3ICBA==
X-Received: by 2002:a17:907:1ca4:b0:6da:86a4:1ec7 with SMTP id nb36-20020a1709071ca400b006da86a41ec7mr2962383ejc.556.1646492354447;
        Sat, 05 Mar 2022 06:59:14 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g13-20020a50bf4d000000b00410d407da2esm3639449edk.13.2022.03.05.06.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 06:59:13 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nQVsH-000YRF-4W;
        Sat, 05 Mar 2022 15:59:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        derrickstolee@github.com, gitster@pobox.com
Subject: Re: [PATCH v3 2/2] builtin/remote.c: show progress when renaming
 remote references
Date:   Sat, 05 Mar 2022 15:31:05 +0100
References: <70a0325ca8ab0492a9b0873ee3fba576c5ab90b9.1646173186.git.me@ttaylorr.com>
 <cover.1646346286.git.me@ttaylorr.com>
 <d5b0a4b71027619123b7284611692d3a9c128518.1646346287.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <d5b0a4b71027619123b7284611692d3a9c128518.1646346287.git.me@ttaylorr.com>
Message-ID: <220305.86pmn030ou.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 03 2022, Taylor Blau wrote:

> diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
> index 2bebc32566..cde9614e36 100644
> --- a/Documentation/git-remote.txt
> +++ b/Documentation/git-remote.txt
> @@ -11,7 +11,7 @@ SYNOPSIS
>  [verse]
>  'git remote' [-v | --verbose]
>  'git remote add' [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=(fetch|push)] <name> <URL>
> -'git remote rename' <old> <new>
> +'git remote rename' [--[no-]progress] <old> <new>
>  'git remote remove' <name>
>  'git remote set-head' <name> (-a | --auto | -d | --delete | <branch>)
>  'git remote set-branches' [--add] <name> <branch>...

Thanks, this looks much better.

But now that we don't piggy-back on --verbose (which as noted, would
have needed to be reworded if we still did) we should add a
--no-progress, --progress to the OPTIONS section, see e.g.:

    git grep '^--.*progress::' -- Documentation/

> @@ -571,6 +572,7 @@ struct rename_info {
>  	const char *old_name;
>  	const char *new_name;
>  	struct string_list *remote_branches;
> +	uint32_t symrefs_nr;
>  };

I didn't notice this in previous iterations, but why the uint32_t over
say a size_t?

The string_list is "unsigned int" (but we should really use size_t
there), but there's some code in refs.c that thinks about number of refs
as size_t already...

>  
>  static int read_remote_branches(const char *refname,
> @@ -587,10 +589,12 @@ static int read_remote_branches(const char *refname,
>  		item = string_list_append(rename->remote_branches, refname);
>  		symref = resolve_ref_unsafe(refname, RESOLVE_REF_READING,
>  					    NULL, &flag);
> -		if (symref && (flag & REF_ISSYMREF))
> +		if (symref && (flag & REF_ISSYMREF)) {
>  			item->util = xstrdup(symref);
> -		else
> +			rename->symrefs_nr++;
> +		} else {
>  			item->util = NULL;
> +		}
>  	}
>  	strbuf_release(&buf);

Just FWIW this could also be, if you prefer to skip the brace additions:
	
	@@ -588,9 +590,10 @@ static int read_remote_branches(const char *refname,
	 		symref = resolve_ref_unsafe(refname, RESOLVE_REF_READING,
	 					    NULL, &flag);
	 		if (symref && (flag & REF_ISSYMREF))
	-			item->util = xstrdup(symref);
	+			rename->symrefs_nr++;
	 		else
	-			item->util = NULL;
	+			symref = NULL;
	+		item->util = xstrdup_or_null(symref);
	 	}
	 	strbuf_release(&buf);

> @@ -682,7 +688,8 @@ static int mv(int argc, const char **argv)
>  		old_remote_context = STRBUF_INIT;
>  	struct string_list remote_branches = STRING_LIST_INIT_DUP;
>  	struct rename_info rename;
> -	int i, refspec_updated = 0;
> +	int i, refs_renamed_nr = 0, refspec_updated = 0;

Another type mixup nit, refs_renamed_nr should be "size_t" (as above,
it's looping over the "unsigned int" string_list, but we can just use
size_t for future-proofing...)

> +	struct progress *progress = NULL;
>  
>  	argc = parse_options(argc, argv, NULL, options,
>  			     builtin_remote_rename_usage, 0);
> @@ -693,6 +700,7 @@ static int mv(int argc, const char **argv)
>  	rename.old_name = argv[0];
>  	rename.new_name = argv[1];
>  	rename.remote_branches = &remote_branches;
> +	rename.symrefs_nr = 0;
>  
>  	oldremote = remote_get(rename.old_name);
>  	if (!remote_is_configured(oldremote, 1)) {
> @@ -767,6 +775,14 @@ static int mv(int argc, const char **argv)
>  	 * the new symrefs.
>  	 */
>  	for_each_ref(read_remote_branches, &rename);
> +	if (show_progress) {
> +		/*
> +		 * Count symrefs twice, since "renaming" them is done by
> +		 * deleting and recreating them in two separate passes.
> +		 */

I didn't look this over all that carefully before, but is the count that
we'll get in rename.symrefs_nr ever different than in
resolve_ref_unsafe() in read_remote_branches()? If not that's an issue
that pre-exists here, i.e. why do we need to find out twice for each ref
it's a symref?

And in any case the "total" fed to start_progress() will be wrong since
in the two later loops we "continue" if "item->util" is true....

> +		progress = start_progress(_("Renaming remote references"),
> +					  rename.remote_branches->nr + rename.symrefs_nr);
> +	}
>  	for (i = 0; i < remote_branches.nr; i++) {
>  		struct string_list_item *item = remote_branches.items + i;
>  		int flag = 0;
> @@ -776,6 +792,7 @@ static int mv(int argc, const char **argv)
>  			continue;
>  		if (delete_ref(NULL, item->string, NULL, REF_NO_DEREF))
>  			die(_("deleting '%s' failed"), item->string);
> +		display_progress(progress, ++refs_renamed_nr);

...I think it makes sense to display_progress() at the start of the
loop, otherwise we expose ourselves to the progress bar stalling if
we're just looping over a bunch of stuff where we "continue", and it's
easier to reason about.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B57FC433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 19:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 754F76108E
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 19:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbhJOTHO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 15:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbhJOTHN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 15:07:13 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A60C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 12:05:06 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y26so45818340lfa.11
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 12:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NHtuMSJq8w6Lg0Rw54cTcoPTCFhIERTc9HSHwUd9D5A=;
        b=F83JJQqQZcLMG/cv10QkLhpLOgALk3Jo/XJcCFve+WPI5y0dRGVGFWtx2yBqE9ppPN
         WjvMxZihCc2E/gxjyT79C4WPrKRVipKRrL5+PLU0pD2SXGmefGQqtG+nPJTrxQtI7CtT
         LvvtWoyIOGFhciwFLd5XuhoBb36cdsXQb/ZN+/x8pYJY4dLxOzAe94/WymOmx2nMjDk0
         UZei8JaBWWa4YjAwZDSDAGqTO0oKib6lPt85W9BpjsEsUiQ0R00xX0tBiWKo6+znQHQy
         vXMweAlLKRKK1PSWSHBeIlWhy5iZBsGqkZEiJXGh0H6/KB1ymvdvbWhm1XKCIU52ge6Z
         GIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=NHtuMSJq8w6Lg0Rw54cTcoPTCFhIERTc9HSHwUd9D5A=;
        b=ttm/v0ANDYgSlIOV0I/YDR/GCWE6mEfx4jmFsZMX6RvyiZ0ky4qQxkuyUzHjygMvOQ
         qMxOl8HZNF08eo/DvDLI9Mw3L3hvIYuWipBebMlYGO7jXIh69xgKflGTI7b7MbyREQfE
         5B7/pWa11fehF+XX59v36tybl+/uOpgm/GiCwY3VIugDkaIDUehPKYHBWDvF0O98CpV8
         LXP9xOEHDcrryVNxHRrImHjjSIvrn29vlOjM1kBuUd6WN90l97R02cMmOmBjjLDUxphp
         wFTrm6i737pf2aBq/i8DcSf3dl5YxPToXfyY+O2+4f83MBksj7xicW9SIDGovVR9m99C
         uYYg==
X-Gm-Message-State: AOAM531iJMkmBNtNoyXNHL6OMyK68urZoDHp8hYj91iPUF1gWxLZ5wdQ
        1kzXOHcbLlHa+hzaEBaMHnw=
X-Google-Smtp-Source: ABdhPJxSKyb6s/04kdGO/XC3Ij2WU6WYMegIyfeNG5hV851XLlca85oCWFH4DgZzg6yccwLKD+b4fw==
X-Received: by 2002:a2e:bd02:: with SMTP id n2mr15270521ljq.412.1634324704763;
        Fri, 15 Oct 2021 12:05:04 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h23sm645440ljl.35.2021.10.15.12.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 12:05:04 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] stash: implement '--staged' option for 'push' and
 'save'
References: <875yugcs3l.fsf@osv.gnss.ru> <87lf2zz59w.fsf@osv.gnss.ru>
        <87fst2gwia.fsf_-_@osv.gnss.ru> <xmqq5yty6uh1.fsf@gitster.g>
Date:   Fri, 15 Oct 2021 22:05:03 +0300
In-Reply-To: <xmqq5yty6uh1.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        15 Oct 2021 10:58:18 -0700")
Message-ID: <87pms6cdnk.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> @@ -205,6 +205,16 @@ to learn how to operate the `--patch` mode.
>>  The `--patch` option implies `--keep-index`.  You can use
>>  `--no-keep-index` to override this.
>>  
>> +-S::
>> +--staged::
>> +	This option is only valid for `push` and `save` commands.
>> ++
>> +Stash only the changes that are currently staged. This is similar to
>> +basic `git commit` except the state is committed to the stash instead
>> +of current branch.
>> ++
>> +The `--patch` option has priority over this one.
>> +
>>  --pathspec-from-file=<file>::
>>  	This option is only valid for `push` command.
>>  +
>> @@ -341,6 +351,24 @@ $ edit/build/test remaining parts
>>  $ git commit foo -m 'Remaining parts'
>>  ----------------------------------------------------------------
>>  
>> +Saving unrelated changes for future use::
>> +
>> +When you are in the middle of massive changes and you find some
>> +unrelated issue that you don't want to forget to fix, you can do the
>> +change(s), stage them, and use `git stash push --staged` to stash them
>> +out for future use. This is similar to committing the staged changes,
>> +only the commit ends-up being in the stash and not on the current branch.
>> ++
>> +----------------------------------------------------------------
>> +# ... hack hack hack ...
>> +$ git add --patch foo           # add unrelated changes to the index
>> +$ git stash push --staged       # save these changes to the stash
>> +# ... hack hack hack, finish curent changes ...
>> +$ git commit -m 'Massive'       # commit fully tested changes
>> +$ git switch fixup-branch       # switch to another branch
>> +$ git stash pop                 # to finish work on the saved changes
>> +----------------------------------------------------------------
>> +
>
> The last step would more like "to start working on top of the saved
> changes", I would think, as the user did not want to bother thinking
> about them earlier while working on the other theme.  Otherwise, the
> user would have done
>
>     git checkout -b fixup-branch
>     git add -p
>     git commit -m '[WIP] mostly done' -e
>     git checkout -
>
> to remember that the fixup is not quite but mostly done and what was
> done so far.

Yep, that's why I said: "to finish work on the saved changes" in the
comments. If it's not clear enough, I'm open for suggestions for
clarifications.

>
> But I'd agree that the new mode would fit in such a workflow.
>
>
>> +static int stash_staged(struct stash_info *info, const struct pathspec *ps,
>> +		       struct strbuf *out_patch, int quiet)
>> +{
>> +	int ret = 0;
>> +	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
>> +	struct index_state istate = { NULL };
>> +
>> + if (write_index_as_tree(&info->w_tree, &istate,
>> the_repository->index_file,
>> +				0, NULL)) {
>> +		ret = -1;
>> +		goto done;
>> +	}
>
> OK.  So what is currently in the index becomes the w-tree.
>
>> +	cp_diff_tree.git_cmd = 1;
>> +	strvec_pushl(&cp_diff_tree.args, "diff-tree", "-p", "-U1", "HEAD",
>> +		     oid_to_hex(&info->w_tree), "--", NULL);
>> +	if (pipe_command(&cp_diff_tree, NULL, 0, out_patch, 0, NULL, 0)) {
>> +		ret = -1;
>> +		goto done;
>> +	}
>> +
>> +	if (!out_patch->len) {
>> +		if (!quiet)
>> +			fprintf_ln(stderr, _("No changes selected"));
>> +		ret = 1;
>> +	}
>
> This seems to have been taken from the "stash_patch()" flow,

Yep, exactly. I'm not familiar enough with the code to easily write it
by myself, so it's basically a copy-paste of stash_patch() and getting
rid of all the unneeded stuff.

> but
> unlike the "stash -p" that goes interactive to let the user pick
> hunks, in which context "oh, no, you did not SELECT anything" makes
> perfect sense as an error message, this message would be confusing
> to users who weren't offered a chance to select.

It seems to me that it makes sense to leave this warning as is, in case
the user invoked "stash --staged" without anything staged. I'm OK to
change this if you have something better in mind.

>
>> +done:
>> +	discard_index(&istate);
>> +	return ret;
>> +}
>> +
>
> Also, as stash_staged() and stash_patch() are _so_ close, I suspect
> that we might want to make a common helper out of the original
> stash_patch() and make stash_patch() a thin wrapper around it in the
> step #1 of the series, and then add stash_staged() as a second
> caller to the common helper.  That might result in a cleaner end
> result.  And optionally the "do we really need to spawn diff-tree"
> optimization can be done on top after the dust settles [*].

I do see a few of opportunities to improve code quality of "git stash",
even before this patch, but that is was not an aim of this patch.

What I aimed for is to keep all the existing code as intact as possible
to minimize probability of unintended breakage.

[...]

>>  static int do_create_stash(const struct pathspec *ps, struct strbuf
>> *stash_msg_buf,
>> -			   int include_untracked, int patch_mode,
>> + int include_untracked, int patch_mode, int only_staged,
>
> Let's not keep adding a parameter to represent just a bit (or less).
> Can't we at least treat this as an auxiliary bit in the "patch_mode"
> flag?  The traditional patch_mode may be variant #1 while the one
> that does the same thing but skips the interactive hunk selection
> (i.e. only-staged) becomes the variant #2, or something?

I don't want to mix --patch and --staged, as I believe --patch, after
introduction of --staged, becomes almost useless. One can instead use
"git add --interactive" directly and then run "stash --staged" on the
result.

That said, to get rid of these function arguments bloating, the code
should better be rewritten to use structure to hold all the parameters,
but that's again not the material of this patch.

>
>> @@ -1321,6 +1353,16 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
>>  		} else if (ret > 0) {
>>  			goto done;
>>  		}
>> +	} else if (only_staged) {
>> +		ret = stash_staged(info, ps, patch, quiet);
>> +		if (ret < 0) {
>> +			if (!quiet)
>> +				fprintf_ln(stderr, _("Cannot save the current "
>> +						     "staged state"));
>> +			goto done;
>> +		} else if (ret > 0) {
>> +			goto done;
>> +		}
>
> ... which would reduce the need to add yet another else-if to this
> cascade.

These else-if cascades could *all* be reduced. The code does need actual
re-factoring, independently of this patch.

>
>> @@ -1379,7 +1421,7 @@ static int create_stash(int argc, const char **argv, const char *prefix)
>>  	if (!check_changes_tracked_files(&ps))
>>  		return 0;
>>  
>> -	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, &info,
>> +	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, 0, &info,
>>  			      NULL, 0);
>
> and no need to touch this hunk.

Yep, if they all were in parameters structure in the first place, it'd
be unneeded.

>
>> @@ -1389,7 +1431,7 @@ static int create_stash(int argc, const char
>> **argv, const char *prefix)
>>  }
>>  
>>  static int do_push_stash(const struct pathspec *ps, const char
>> *stash_msg, int quiet,
>> -			 int keep_index, int patch_mode, int include_untracked)
>> + int keep_index, int patch_mode, int include_untracked, int
>> only_staged)
>>  {
>
> nor this one.

Yep, but that's the generic problem with the code. Mixing "only_staged"
into "patch_mode" would only worsen the code.

>
> I think I can agree with the motivation now (thanks for the
> discussion); the code may want a bit more cleaning up.

I do thing the code of "git stash" needs cleanup. Independently of the
patch. If somebody gets time to cleanup the original code, I'll happily
adapt the patch to the changes.

Otherwise, maybe I'll find time later to refactor the resulting code of
the "git stash" myself, but I'd like the patch to get its place first.

If you insist, I can provide a follow-up patch that factors-out minor
bit of common code from --patch and --staged, but I really don't want to
mix "only_staged" flag into the "patch_mode" flag, sorry.

Thanks,
-- Sergey Organov

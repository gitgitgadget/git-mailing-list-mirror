Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C89C433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 20:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5BFC2087D
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 20:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGWZnZe8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHXUaZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgHXUaV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 16:30:21 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C332BC061574
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 13:30:20 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d19so5171606pgl.10
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 13:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=odz4Mdwlgj33vJPUpEsVUBKFxDUeeok9+ttuRATEHQM=;
        b=cGWZnZe8vUUbYtgj3PoHYK8bQAnXSruIxQZopYk7z9guqkVRddOYSF2OPsyjbxmktd
         vdvxPhHHvR5fNAPzZjYFCchLotHiJikxdz+kCru2HGE4snJYgdwsxZgU+Jud8jLjemyi
         sulYWgF3RuQqpfLQwhlCFWyAT5vPJ/uv3NcjAJTbUaq76SY5EEj9OI1TnBPCKcjlj90P
         syEgoqhF/2mDoJUhhxgBFYcW1G0j2zHW1oyBeBL2jgyU5YPGu3irceBO1/29fp19L3QZ
         OMwuT5Ikf9wjTPOu30wng111EZbinHyZuPqfLC8ID+SleT41uI7Y6JLX+LKkuDZrjEUy
         I6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=odz4Mdwlgj33vJPUpEsVUBKFxDUeeok9+ttuRATEHQM=;
        b=Q1/Lf6afEg2F/B06WkdpnwSgVT/KzCaHEfrHll1xHuAzMT7cBBLw9ly2yToDebdOpe
         CMWUoPHGJOUXeypNyqGiKDAT/vZ7QDpHs7J2iVgTpmfVk4lIoP91sOz6/svoiGSqzgsg
         X4lFh2Ta9o68AfwgdElel1Hml/qxlwA4aurpZHZqR8Y3gvbsadujn9ZXnLXxKLuXGnOW
         y9N4lJwJZdPrMDo07dsZd4gEOHu5jgG4ZXSLSRq/xTX7FwfBlUE+P1/W6yqG2LsRon9l
         toTPMxVBUHSMHAlivw7Rt2btUZPH9hc59uyTXzdjMNzmasElSL+zSAk2LEIVOx0MPlG5
         7VFw==
X-Gm-Message-State: AOAM530k5sFvQWZgWbo0bW87zw/7luP5N+wgI9y/uEbuS+YalFfUEJ57
        qVTFJRhfPmp+2Q2ur3p82q8=
X-Google-Smtp-Source: ABdhPJxl2OoOWxvozLSqJTaOBQC/HqdAD7he1sFDd6zJd/qfhYJD3OLyeNidJTFke8qsq2wrEmiYRw==
X-Received: by 2002:a63:ee12:: with SMTP id e18mr4324399pgi.1.1598301020202;
        Mon, 24 Aug 2020 13:30:20 -0700 (PDT)
Received: from lwitch-pc ([49.205.77.238])
        by smtp.gmail.com with ESMTPSA id w23sm10433625pgj.5.2020.08.24.13.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 13:30:19 -0700 (PDT)
Message-ID: <43337924c09119d43c74fdad3f00d4dab76edb51.camel@gmail.com>
Subject: Re: [GSoC][PATCH] submodule: port submodule subcommand 'add' from
 shell to C
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, liu.denton@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Stefan Beller <stefanbeller@gmail.com>
Date:   Tue, 25 Aug 2020 02:00:16 +0530
In-Reply-To: <xmqq8se36gev.fsf@gitster.c.googlers.com>
References: <20200824090359.403944-1-shouryashukla.oo@gmail.com>
         <xmqq8se36gev.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2020-08-24 at 11:35 -0700, Junio C Hamano wrote:
> Shourya Shukla <shouryashukla.oo@gmail.com> writes:
> 
> > 	if test -z "$force"
> > 	then
> > 		git ls-files --error-unmatch "$sm_path" > /dev/null 2>&1 &&
> > 		die "$(eval_gettext "'\$sm_path' already exists in the index")"
> > 	else
> > 		git ls-files -s "$sm_path" | sane_grep -v "^160000" > /dev/null 2>&1 &&
> > 		die "$(eval_gettext "'\$sm_path' already exists in the index and is not a submodule")"
> > 	fi
> 
> Hmph.  So,
> 
>  - if we are not being 'force'd, we see if there is anything in the
>    index for the path and error out, whether it is a gitlink or not.
> 

Right.

>  - if there is 'force' option, we see what the given path is in the
>    index, and if it is already a gitlink, then die.  That sort of
>    makes sense, as long as the remainder of the code deals with the
>    path that is not a submodule in a sensible way.
> 

With `force, I think it's the opposite of what you describe. That is:

    - if there is 'force' option, we see what the given path is in the
      index, and if it is **not** already a gitlink, then die. 

Note the `-v` passed to sane_grep.

> > This is what I have done in C:
> > 
> > 	if (!force) {
> > 		if (is_directory(path) && submodule_from_path(the_repository, &null_oid, path))
> > 			die(_("'%s' already exists in the index"), path);
> 
> The shell version would error out with anything in the index, so I'd
> expect that a faithful conversion would not call is_directory() nor
> submodule_from_path() at all---it would just look path up in the_index
> and complains if anything is found.  For example, the quoted part in
> the original above is what gives the error message when I do
> 
> 	$ git submodule add ./Makefile
> 	'Makefile' already exists in the index.
> 
> I think.  And the above code won't trigger the "already exists" at
> all because 'path' is not a directory.
> 
> > 	} else {
> > 		int err;
> > 		if (index_name_pos(&the_index, path, strlen(path)) >= 0 &&
> > 		    !is_submodule_populated_gently(path, &err))
> > 			die(_("'%s' already exists in the index and is not a "
> > 			      "submodule"), path);
> 
> Likewise.  The above does much more than the original.
> 
> The original was checking if the found cache entry has 160000 mode
> bit, so the second test would not be is_submodule_populated_gently()
> but more like !S_ISGITLINK(ce->ce_mode)
> 

Yeah, the C version does need a more proper check in both cases.


> Now it is a different question if the original is correct to begin
> with ;-).  
> 

By looking at commit message of 619acfc78c (submodule add: extend force
flag to add existing repos, 2016-10-06), I'm assuming it's correct.
There are chances I might be missing something, though.

Speaking of correctness, I'm surprised how the port passed the
following test t7400.63 despite the incorrect check.

-- 8< --
$ ./t7400-submodule-basic.sh
... snip ...
ok 62 - add submodules without specifying an explicit path
ok 63 - add should fail when path is used by a file
ok 64 - add should fail when path is used by an existing directory
... snip ...
-- >8 --

Most likely it passed because it slipped through the incorrect check
and failed later in the code[1]. That's not good, of course.

> > 	}
> > 
> > Is this part correct? I am not very sure about this. This particular
> > part is not covered in any test or test script, so, I do not have a
> > solid method of knowing the correctness of this segment.
> > Feedback and reviews are appreciated.


> +static int add_submodule(struct add_data *info)
> +{
> +	/* perhaps the path exists and is already a git repo, else clone it */
> +	if (is_directory(info->sm_path)) {
> +		char *sub_git_path = xstrfmt("%s/.git", info->sm_path);
> +		if (is_directory(sub_git_path) || file_exists(sub_git_path))
> +			printf(_("Adding existing repo at '%s' to the index\n"),
> +				 info->sm_path);
> +		else
> +			die(_("'%s' already exists and is not a valid git repo"),
> +			      info->sm_path);
> +		free(sub_git_path);
> +	} else {
> +		struct strvec clone_args = STRVEC_INIT;
> +		struct child_process cp = CHILD_PROCESS_INIT;
> +		char *submodule_git_dir = xstrfmt(".git/modules/%s", info->sm_name);
> +
> +		if (is_directory(submodule_git_dir)) {
> +			if (!info->force) {
> +				struct child_process cp_rem = CHILD_PROCESS_INIT;
> +				struct strbuf sb_rem = STRBUF_INIT;
> +				cp_rem.git_cmd = 1;
> +				fprintf(stderr, _("A git directory for '%s' is "
> +					"found locally with remote(s):\n"),
> +					info->sm_name);
> +				strvec_pushf(&cp_rem.env_array,
> +					     "GIT_DIR=%s", submodule_git_dir);
> +				strvec_push(&cp_rem.env_array, "GIT_WORK_TREE=.");
> +				strvec_pushl(&cp_rem.args, "remote", "-v", NULL);
> +				if (!capture_command(&cp_rem, &sb_rem, 0)) {
> +					modify_remote_v(&sb_rem);
> +				}
> +				error(_("If you want to reuse this local git "
> +				      "directory instead of cloning again from\n "
> +				      "  %s\n"
> +				      "use the '--force' option. If the local "
> +				      "git directory is not the correct repo\n"
> +				      "or you are unsure what this means choose "
> +				      "another name with the '--name' option."),
> +				      info->realrepo);
> +				return 1;
> +			} else {
> +				printf(_("Reactivating local git directory for "
> +					 "submodule '%s'."), info->sm_path);
> +			}
> +		}
> +		free(submodule_git_dir);

This part results in a difference in error message in shell and C 
versions.

-- 8< --
$ # Shell version
$ git submodule add ../subm1 sub
A git directory for 'sub' is found locally with remote(s):
  origin        /me/subm1
If you want to reuse this local git directory instead of cloning again from
  /me/subm1
use the '--force' option. If the local git directory is not the correct repo
or you are unsure what this means choose another name with the '--name' option.
$
$ # C version
$ git submodule add ../subm1 sub
A git directory for 'sub' is found locally with remote(s):
  origin        /me/subm1
error: If you want to reuse this local git directory instead of cloning again from
   /me/subm1
use the '--force' option. If the local git directory is not the correct repo
or you are unsure what this means choose another name with the '--name' option.
-- >8 --

Note how the third line is oddly prefixed by a `error` unlike the rest
of the lines. It would be nice if we could weed out that inconsistency.
We could probably use `advise()` for printing the last four lines and
`error()` for the lines above them.


Footnote
---
[1]: Looks like not checking for the error message when a command fails
     has it's own downsides x-(

--
Sivaraam



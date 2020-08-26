Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13CEC433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 09:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A436C20866
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 09:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJsFVjpk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgHZJ1p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgHZJ1o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 05:27:44 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D12AC061574
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 02:27:44 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w14so1549134ljj.4
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 02:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sViIa1NeRrQt3Swh7iiPSateNjlkuJgXkHBMluPVW/Q=;
        b=lJsFVjpkiNHpjJf7ve2dbz77fuIbNpRwhAx352v4+cJMezcgCE9OSBSfGl3j7FO+ID
         Pw+BWqJTCxPMSJPMJYCEQWrcvOQ7EeuhB+lh0IQVs2PVghskQE3xmbBraBzv2K0H/TAD
         QXmMMvCt/IlWQS9PdZPgn/OCReuhxj+TtObaRGJqtubji14rnQLvN9lnvvtrRUpMrYnp
         UzPa3t5dKVuZOyAR2JatZR/ICRh83vyKTVUsp7l35bfTkQG+kUYtcpntQpS7camuAVGL
         KoEBwHMn2IMuDEwHDVagNkagY5kIsTJhgSRqtInvAawpfMc5Gt5tT0UjOVIgvquJ//zO
         m70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sViIa1NeRrQt3Swh7iiPSateNjlkuJgXkHBMluPVW/Q=;
        b=RwB5F382am2mEc5A7tWNM0cTDE6Jgx8dBflLqA0VmIGY+vNDX5a0R9FY2vlW79e+p5
         fHZonBQF2v9wozyaEC4jWcdb4Bl5iA3YlL7ONdLTOzAx/hYTLh/6uVPIE2BQ+NPQL/gM
         AXTGRiWvDQmsqlrLxNcD9XZDbfd2gxjdvF5qJaWZm8moGLMmjCnIqaRVc04WgK9+vYiC
         SD5Nl6mSHGXpdBvsEVJln4FcrMKbmJekt2eGDN/l6LyZZITdJ2vB5hlI05IQeYoxO2qs
         43DwQJ+SNOIDfgWBJcElgg4fMxGQjNRBL1i1DdjCLNuAj4DfIE+xH5J9m5S4fFZQHuFY
         qVEw==
X-Gm-Message-State: AOAM533rzdt1WeqnJXdXFetdPEPS6t9xdwLlt+FHLkeCro5ccBJD+4Ja
        NIz8L5WNJ75HoDjj+T7vaAYLWPlGDnB4HX34x/4=
X-Google-Smtp-Source: ABdhPJxzW6E2Udj0REVbHhwClScmgZ5CvRv7hHMcnTj2jGooU9gJi6Sxl5VpEEce+dGZ04tNiKwfPIwCgzF+5RR386c=
X-Received: by 2002:a05:651c:221:: with SMTP id z1mr6415873ljn.52.1598434062499;
 Wed, 26 Aug 2020 02:27:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:109a:0:0:0:0:0 with HTTP; Wed, 26 Aug 2020 02:27:41
 -0700 (PDT)
In-Reply-To: <43337924c09119d43c74fdad3f00d4dab76edb51.camel@gmail.com>
References: <20200824090359.403944-1-shouryashukla.oo@gmail.com>
 <xmqq8se36gev.fsf@gitster.c.googlers.com> <43337924c09119d43c74fdad3f00d4dab76edb51.camel@gmail.com>
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
Date:   Wed, 26 Aug 2020 14:57:41 +0530
Message-ID: <CAP6+3T2FbjKc35QYiDmaezzKbkrxEOcBqzirm032_tTU2foZ=Q@mail.gmail.com>
Subject: Re: [GSoC][PATCH] submodule: port submodule subcommand 'add' from
 shell to C
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        christian.couder@gmail.com, johannes.schindelin@gmx.de,
        liu.denton@gmail.com, Prathamesh Chavan <pc44800@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/25/20, Kaartic Sivaraam <kaartic.sivaraam@gmail.com> wrote:
> On Mon, 2020-08-24 at 11:35 -0700, Junio C Hamano wrote:
>> Now it is a different question if the original is correct to begin
>> with ;-).
>>
>
> By looking at commit message of 619acfc78c (submodule add: extend force
> flag to add existing repos, 2016-10-06), I'm assuming it's correct.
> There are chances I might be missing something, though.
>
> Speaking of correctness, I'm surprised how the port passed the
> following test t7400.63 despite the incorrect check.
>
> -- 8< --
> $ ./t7400-submodule-basic.sh
> ... snip ...
> ok 62 - add submodules without specifying an explicit path
> ok 63 - add should fail when path is used by a file
> ok 64 - add should fail when path is used by an existing directory
> ... snip ...
> -- >8 --
>
> Most likely it passed because it slipped through the incorrect check
> and failed later in the code[1]. That's not good, of course.
>
>> > 	}
>> >
>> > Is this part correct? I am not very sure about this. This particular
>> > part is not covered in any test or test script, so, I do not have a
>> > solid method of knowing the correctness of this segment.
>> > Feedback and reviews are appreciated.
>
>
>> +static int add_submodule(struct add_data *info)
>> +{
>> +	/* perhaps the path exists and is already a git repo, else clone it */
>> +	if (is_directory(info->sm_path)) {
>> +		char *sub_git_path = xstrfmt("%s/.git", info->sm_path);
>> +		if (is_directory(sub_git_path) || file_exists(sub_git_path))
>> +			printf(_("Adding existing repo at '%s' to the index\n"),
>> +				 info->sm_path);
>> +		else
>> +			die(_("'%s' already exists and is not a valid git repo"),
>> +			      info->sm_path);
>> +		free(sub_git_path);
>> +	} else {
>> +		struct strvec clone_args = STRVEC_INIT;
>> +		struct child_process cp = CHILD_PROCESS_INIT;
>> +		char *submodule_git_dir = xstrfmt(".git/modules/%s", info->sm_name);
>> +
>> +		if (is_directory(submodule_git_dir)) {
>> +			if (!info->force) {
>> +				struct child_process cp_rem = CHILD_PROCESS_INIT;
>> +				struct strbuf sb_rem = STRBUF_INIT;
>> +				cp_rem.git_cmd = 1;
>> +				fprintf(stderr, _("A git directory for '%s' is "
>> +					"found locally with remote(s):\n"),
>> +					info->sm_name);
>> +				strvec_pushf(&cp_rem.env_array,
>> +					     "GIT_DIR=%s", submodule_git_dir);
>> +				strvec_push(&cp_rem.env_array, "GIT_WORK_TREE=.");
>> +				strvec_pushl(&cp_rem.args, "remote", "-v", NULL);
>> +				if (!capture_command(&cp_rem, &sb_rem, 0)) {
>> +					modify_remote_v(&sb_rem);
>> +				}
>> +				error(_("If you want to reuse this local git "
>> +				      "directory instead of cloning again from\n "
>> +				      "  %s\n"
>> +				      "use the '--force' option. If the local "
>> +				      "git directory is not the correct repo\n"
>> +				      "or you are unsure what this means choose "
>> +				      "another name with the '--name' option."),
>> +				      info->realrepo);
>> +				return 1;
>> +			} else {
>> +				printf(_("Reactivating local git directory for "
>> +					 "submodule '%s'."), info->sm_path);
>> +			}
>> +		}
>> +		free(submodule_git_dir);
>
> This part results in a difference in error message in shell and C
> versions.
>
> -- 8< --
> $ # Shell version
> $ git submodule add ../subm1 sub
> A git directory for 'sub' is found locally with remote(s):
>   origin        /me/subm1
> If you want to reuse this local git directory instead of cloning again from
>   /me/subm1
> use the '--force' option. If the local git directory is not the correct
> repo
> or you are unsure what this means choose another name with the '--name'
> option.
> $
> $ # C version
> $ git submodule add ../subm1 sub
> A git directory for 'sub' is found locally with remote(s):
>   origin        /me/subm1
> error: If you want to reuse this local git directory instead of cloning
> again from
>    /me/subm1
> use the '--force' option. If the local git directory is not the correct
> repo
> or you are unsure what this means choose another name with the '--name'
> option.
> -- >8 --
>
> Note how the third line is oddly prefixed by a `error` unlike the rest
> of the lines. It would be nice if we could weed out that inconsistency.
> We could probably use `advise()` for printing the last four lines and
> `error()` for the lines above them.

Understood. I will correct this part. BTW, you surely are talking
about error() on
the first 2 lines? I think fprintf(stderr, _()) is OK for them otherwise they
will be prefixed by 'error:' which will not be in line with the shell version.

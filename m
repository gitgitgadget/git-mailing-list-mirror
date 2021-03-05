Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC902C433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 17:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81D7464DEC
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 17:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCER6c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 12:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbhCER6X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 12:58:23 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C26C061574
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 09:58:22 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id u11so1763061plg.13
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 09:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CKoI1f7mwdsLk8WnA0k4md4bNcdbi+zBZaVuYcnAy0A=;
        b=qxx7NJi2fHEOAS/bNNTqHQ88Arc4r4D3RopPmiHWmqGULcZJ8GtsjHfrY1lCAJnS3a
         FDLhNLQMF04gUZ4vT0K88D8UL94B/wn/9Sbze5/ZtuYaOX89CQrQOrCLmcaw306MY4ma
         DVCSbffdf1GNy4h+7HTtuDbSH0JB8cl27Rl6GHIJzFLVmGNocSjQ7gtYjE0o3QldIz/c
         DY3CLo33gXcoOKXvu+NuqaK/WVaAjK/KYbYBiL2N/LrCUv5OGneYHGkHOvUh+moUq9pN
         CnKrXvc3lxRsffJ95C/AJ1hshhrTWiv1438iNuUHyiC303zoASv0qZZyyHF14I6LTWij
         F92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CKoI1f7mwdsLk8WnA0k4md4bNcdbi+zBZaVuYcnAy0A=;
        b=TFt+nJ8ANV/ReswqH25o3r10qyp2MTuGnj+pi+xBKLxjLFKShfdk6n3PNkenNbhxwJ
         l9o3mm8dgqJoGbHpi0lOibxRVdyWq2lYL923WqFgOWv2xk9VQIj/xoUZzvHDEKtZeXUR
         ywdk0oVlCZ1Udpv+YjRpUpubhTGVupCFwYUZoMDJYEMKltoHaPorxEmCPh16QYfHjsGM
         BqOpUSi+Qdpi09BeSHhrs1QrIi/nNStDHrqVUph1SljTxNTc4CTUl9IahBO672Iy1Zr/
         VvzK5D0Ymuk0vBdxotyW/RtDPNZfcaWk9I/g920kSWOX+tax0IG2aC5B0/a4/8AHaC/m
         oWSQ==
X-Gm-Message-State: AOAM530wqJmI2KDbKU34+MDKy4r1KJOjPzkFTH0Jn8opxd0MCGi9wgsz
        lIHemlFUGLBSq32AP0fW1Ho=
X-Google-Smtp-Source: ABdhPJxcV2nUxQqI/0mYOcCNRMyIEkJ49vhO3UZZEO0Ij/tbOCp01iSlFD1aFQpDKi23b4ILY0Zyrg==
X-Received: by 2002:a17:902:9a46:b029:e2:f97b:47da with SMTP id x6-20020a1709029a46b02900e2f97b47damr9396183plv.77.1614967102258;
        Fri, 05 Mar 2021 09:58:22 -0800 (PST)
Received: from konoha ([14.139.233.131])
        by smtp.gmail.com with ESMTPSA id s138sm3408814pfc.135.2021.03.05.09.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 09:58:21 -0800 (PST)
Date:   Fri, 5 Mar 2021 23:28:16 +0530
From:   Shourya Shukla <periperidip@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        levraiphilippeblain@gmail.com
Subject: Re: [PATCH v2 1/1] rm: stage submodule removal from '.gitmodules'
 when using '--cached'
Message-ID: <20210305175816.GA22075@konoha>
References: <20210218184931.83613-1-periperidip@gmail.com>
 <20210222172623.69313-1-periperidip@gmail.com>
 <20210222172623.69313-2-periperidip@gmail.com>
 <xmqqv9ak6iac.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv9ak6iac.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio!

Really really sorry for the late reply. I was busy in some personal
engagements and was travelling for the past 8-9 days.

On 22/02 10:58, Junio C Hamano wrote:
> Shourya Shukla <periperidip@gmail.com> writes:
> 
> > Currently, using 'git rm --cached <submodule>' removes the submodule
> > <submodule> from the index and leaves the submodule working tree
> > intact in the superproject working tree, but does not stage any
> > changes to the '.gitmodules' file, in contrast to 'git rm <submodule>',
> > which removes both the submodule and its configuration in '.gitmodules'
> > from the worktree and index.
> >
> > Fix this inconsistency by also staging the removal of the entry of the
> > submodule from the '.gitmodules' file, leaving the worktree copy intact,
> 
> The "also" above felt a bit puzzling, as we would be removing the
> entry only from the indexed copy without touching the working tree
> (by the way, I try to be precise in terminology between worktree and
> working tree, and please follow suit.  A working tree is what you
> have in a non-bare repository that let's you "less" "gcc" etc. on
> the files checked out.  A worktree refers to the mechanism that lets
> you have separate working tree by borrowing from a repository, or
> refers to an instance of a working tree plus .git file created by
> the mechanism.  You mean "working tree" in the above sentence), but
> it refers to "remove the submodules directory and also entry", so it
> is OK.

Sure. Will make it more precise and rather technically connect.

> And that is all for what is done to a submodule.
> 
> Makes sense so far.
> 
> > +		}
> > +		if (!index_only) {
> >  			if (!remove_path(path)) {
> >  				removed = 1;
> >  				continue;
> > @@ -396,9 +399,6 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
> >  			if (!removed)
> >  				die_errno("git rm: '%s'", path);
> >  		}
> > -		strbuf_release(&buf);
> > -		if (gitmodules_modified)
> > -			stage_updated_gitmodules(&the_index);
> 
> OK, because this should have been done where we called
> remove_path_from_gitmodules().
> 
> >  	}
> >  
> >  	if (write_locked_index(&the_index, &lock_file,
> > diff --git a/submodule.c b/submodule.c
> > index 9767ba9893..6ce8c8d0d8 100644
> > --- a/submodule.c
> > +++ b/submodule.c
> > @@ -131,7 +131,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
> >   * path is configured. Return 0 only if a .gitmodules file was found, a section
> >   * with the correct path=<path> setting was found and we could remove it.
> >   */
> > -int remove_path_from_gitmodules(const char *path)
> > +int remove_path_from_gitmodules(const char *path, int index_only)
> >  {
> >  	struct strbuf sect = STRBUF_INIT;
> >  	const struct submodule *submodule;
> > @@ -149,7 +149,8 @@ int remove_path_from_gitmodules(const char *path)
> >  	}
> >  	strbuf_addstr(&sect, "submodule.");
> >  	strbuf_addstr(&sect, submodule->name);
> > -	if (git_config_rename_section_in_file(GITMODULES_FILE, sect.buf, NULL) < 0) {
> > +	if (git_config_rename_section_in_file(index_only ? GITMODULES_INDEX :
> > +					      GITMODULES_FILE, sect.buf, NULL) < 0) {
> >  		/* Maybe the user already did that, don't error out here */
> >  		warning(_("Could not remove .gitmodules entry for %s"), path);
> >  		strbuf_release(&sect);
> 
> When !index_only, do we have any guarantee that .gitmodules in the
> working tree and .gitmodules in the index are in sync?  I somehow
> doubt it.  
> 
> I would have expected that the updated remove_path_from_gitmodules()
> would look more like:
> 
>  - only if !index_only, nuke the section for the submodule in
>    .gitmodules in the working tree.
> 
>  - nuke the section for the submodule in .gitmodules in the
>    index.
> 
> IOW, there would be two git_config_rename_section_in_file() calls to
> remove the section in !index_only case.
> 
> Doing so would also mean that you should not have the caller call
> stage_updated_gitmodules() at all, even in !index_only case.
> Imagine if the .gitmodules file in the working tree had local
> changes (e.g. registered a few more submodules, or updated the url
> field of a few submodules) that are not yet added to the index when
> "git rm" removed a submodule.  The user does not want them to be in
> the index yet and "git rm" should not add these unrelated local
> changes to the index.

Won't this be deviating from the current behaviour of 'git rm'?
Currently, the above case won't process and the user will be asked to
stage or undo the mods they made before moving forward. If I am not
mistaken, won't we deviate from the case if we do the above? As of now,
I tried this:

	if (!index_only) {
		if (git_config_rename_section_in_file(GITMODULES_FILE, sect.buf, NULL) < 0) {
			/* Maybe the user already did that, don't error out here */
			warning(_("Could not remove .gitmodules entry for %s"), path);
			strbuf_release(&sect);
			return -1;
		}
	}
	if (git_config_rename_section_in_file(GITMODULES_INDEX , sect.buf, NULL) < 0) {
		/* Maybe the user already did that, don't error out here */
		warning(_("Could not remove .gitmodules entry for %s"), path);
		strbuf_release(&sect);
		return -1;
	}

Everything else being unchanged. Therefore, we still have the
'stage_updated_gitmodules()' call. If we don't call this function then
won't we be NOT adding the updated '.gitmodules' to the staging area,
something which is done as of now?

Or am I mising something here?

Regards,
Shourya Shukla


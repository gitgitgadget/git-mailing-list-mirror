Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECC1C433E0
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 08:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1895E64F6A
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 08:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbhCSIF0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 04:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbhCSIFL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 04:05:11 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C05C06174A
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 01:05:10 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y5so5335252pfn.1
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 01:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=28uN0OmluQiU3yuaf5KFv1CUqEeCC/zpRHfMwloaHbo=;
        b=J0MRP0uWUCISj1CO3w1zUM7PJAIJvDky9McSaNEsY4qggP2R6xFzq/Rix37w/dYNq6
         1bF5IntawjFSm7g5N0xnOVU2VAQOu7lmYiI2DguP0aH6ce1cEmU5oli9ZviQ0+Cqyc8S
         fwDZdEs7suIRFYwMEfW0U3yhDiR15UfDwef4c+dzGgkb5JwwOA24fnYJ/9btjrIzw94w
         ALFvNKypEz1dpkblx0sUhicqEkJ08Lbeb/IEyx1U0UxpDVrLInJayKkffGVDYvW7UzBE
         8ncaLhfhI5mETAHpgrMV7m6TLRvM1ipEi62cqZ4NHSKY4vVG/itffgc7CIixS3nmKXD8
         lZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=28uN0OmluQiU3yuaf5KFv1CUqEeCC/zpRHfMwloaHbo=;
        b=USAyrX+v4zfWhUtNUd8g9d+d/ttZUSizWaYF25HirfTn/3ueKNlcIVuKjgXw/CWc2m
         AAN/vEPDu0ylqA9a8BnaeYgZeynRGNgJss0RhaY3bDwn8FrX5lnXvbNLdPnK8bEs0iLA
         38rddzikB0jt8S1OOpzZQlce4O7vEizkRKV/Y5/USr0r8LyhlZGZT0rkyCKnEIsZ9Z5t
         slNjn6nWsEApsVgPjLjZ9JrPULx5iH+UKTFcQToatnVBYT9YjVYiQC+9cbOgyh3EtJYe
         qoZB0b2otFGy3aOS3g6mFbd6CIjt/Ba/S95INzTubXJXrmuqnGLc+tMMbVcZt4dNs/gJ
         qXkw==
X-Gm-Message-State: AOAM533kuRM4z7p2FVJ5ehH3SP1byuZEw+vLifxlSAQgRxL/F4WV/X8O
        CyTd96sq9t4vhnROL7iJThg=
X-Google-Smtp-Source: ABdhPJxq6NvFIaTSZ6/Huak9g99WKLIhzoLNsH/CkZmP5YtAGnf4RqWLDON19p0AkS8lq2yY+V3gkg==
X-Received: by 2002:aa7:9433:0:b029:1ff:a321:2e34 with SMTP id y19-20020aa794330000b02901ffa3212e34mr7918740pfo.77.1616141110385;
        Fri, 19 Mar 2021 01:05:10 -0700 (PDT)
Received: from generichostname ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id k11sm4407604pjs.1.2021.03.19.01.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 01:05:09 -0700 (PDT)
Date:   Fri, 19 Mar 2021 01:05:07 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [RESEND PATCH 2/3] git-completion.bash: fix `git <args>... stash
 branch` bug
Message-ID: <YFRbM1st0yINtScF@generichostname>
References: <cover.1615855962.git.liu.denton@gmail.com>
 <cover.1616060793.git.liu.denton@gmail.com>
 <be727d0171b16e488a357a959176e60bf9210d40.1616060793.git.liu.denton@gmail.com>
 <xmqqsg4sryq9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsg4sryq9.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, Mar 18, 2021 at 01:30:38PM -0700, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > When completions are offered for `git stash branch<TAB>`, the user is
> > supposed to receive refs. This works in the case where the main git
> > command is called without arguments but if options are provided, such as
> > `git -C dir stash branch<TAB>`, then the `$cword -eq 3` provides
> > incorrect results.
> >
> > Count the words relative to the first instance of "stash" so that we
> > ignore arguments to the main git command.
> >
> > Unfortunately, this still does not work 100% correctly. For example, in
> > the case of something like `git -C stash stash branch<TAB>`, this will
> > incorrectly identify the first "stash" as the command. This seems to be
> > an edge-case that we can ignore, though, as other functions, such as
> > _git_worktree(), suffer from the same problem.
> 
> I am not familiar with how the completion support works, but doing
> this inside _git_stash() and still not being able to tell which
> "stash" on the command line is supposed to be the git subcommand
> smells quite fishy to me.  
> 
> How did the caller decide to invoke _git_stash helper function in
> the first place?
> 
> When it is given "git -C push --paginate stash branch<TAB>", it must
> have parsed the command line, past the options given to the "git"
> potty, to find "stash" on the command line that it is _git_stash and
> not _git_push that needs to be called, no?  If it were possible to
> propagate that information without losing it, then we do not have to
> recompute where the subcommand name is at all, do we?

Good observation. _git_stash() is called in the body of
__git_complete_command() which is called by __git_main(). There is
currently no mechanism by which to pass the index of the command over to
_git_*() completion functions.

That being said, passing in the index to all functions would definitely
be doable. I can work on a series in the future that passes in the index
of the command so that working with $cword is more robust but I'd prefer
if that were handled outside this series to keep it focused.

Thanks,
Denton

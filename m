Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF5BC433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 04:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D20E61158
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 04:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhDUEEQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 00:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhDUEEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 00:04:16 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8561C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 21:03:43 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id c17so27440027pfn.6
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 21:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IwEgi15ZQHtqIPGz4fVtBk+fPORXyX7Eqp8fVzeXDoI=;
        b=VxhFJzz8LgQioZfBb3MsU9kFfSkV59+EDow+7u/WATL44p3sFDm4lFbKmCptuafyNt
         frxNfRgZTD9PIdfFnEeSVvo17HIpkxSnjfeuRfDqlYz2du8Njf1znY+XqSsypasxafL7
         hU4b/4SYSb1WKf2I94nLAU7UNex5o+AfeJqc1m+9/IxuRj+JMrMrLH1hYsdZXYf6WJMn
         vRMeB4vj5YbHsZSUwFOmCsGP2l4cQiZeuO5ua3zabwrAC68letNFkG2zXFRQna+i8XFW
         uQr5AH0ViiU8pZ/9kdGjjuCQDlwzyhf3i5tfjxnvaJK3EX2+OsNaWEXjYTqjZ2aS9VA0
         cwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IwEgi15ZQHtqIPGz4fVtBk+fPORXyX7Eqp8fVzeXDoI=;
        b=QNp57gxWYqwzFItMYq89bLhywgGfARqoxXi2K+RhFbH5D0LJnjYTjzQ2EVR87hBgUX
         QCXoBTmPGiBsvctShHkPIm7o8sxpxSAevlHanub84rafyXKBb1oWyXe+lMCXclQHHfgm
         G67kxT43bsz7PXRoKQKeBvcq2LJcpZX4JLlqGXCp7To04PaFcuI+wV6aR1HFMvqLoeAm
         Ol5cfj+/3ulRNPGv39cZgNSVVvpoyfBpHwYggyZ+lXzaPDMR8obXTAibJDTtRXm9TED6
         dfLjrVsG7z7/hkBARbG8prZOS382k/AAjtH4lIJh7WJMiespxUc0hKdzoo5nKB0x2yUd
         0gzw==
X-Gm-Message-State: AOAM532mxjIGbzTpl4jgN5CSySuaSDUoPWP+qCmiKLZap4HtVZ6e18V1
        823Jo7NWBTFXSNENp0wyCEw=
X-Google-Smtp-Source: ABdhPJyuZ6XjoqQtDJj3pWjhZIRoq29KxrVarvY8P9EcF/qRyBSOUw+43bQqcVqI/8D0U9yYbQKvsA==
X-Received: by 2002:a63:f443:: with SMTP id p3mr20204362pgk.378.1618977823298;
        Tue, 20 Apr 2021 21:03:43 -0700 (PDT)
Received: from generichostname ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id m2sm438117pgv.87.2021.04.20.21.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 21:03:42 -0700 (PDT)
Date:   Tue, 20 Apr 2021 21:03:40 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] git-completion.bash: consolidate cases in
 _git_stash()
Message-ID: <YH+kHGLBLpPVW+88@generichostname>
References: <cover.1618910364.git.liu.denton@gmail.com>
 <4f8d015d54376af277883f57e8b4cf2c63ed8a03.1618910364.git.liu.denton@gmail.com>
 <877dkx44ma.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877dkx44ma.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

On Tue, Apr 20, 2021 at 12:44:45PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Apr 20 2021, Denton Liu wrote:
> 
> > The $subcommand case statement in _git_stash() is quite repetitive.
> > Consolidate the cases together into one catch-all case to reduce the
> > repetition.
> >
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> >  contrib/completion/git-completion.bash | 21 ++-------------------
> >  1 file changed, 2 insertions(+), 19 deletions(-)
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index 30c9a97616..7bce9a0112 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -3032,21 +3032,6 @@ _git_stash ()
> >  	fi
> >  
> >  	case "$subcommand,$cur" in
> > -	push,--*)
> > -		__gitcomp_builtin stash_push
> > -		;;
> > -	save,--*)
> > -		__gitcomp_builtin stash_save
> > -		;;
> > -	pop,--*)
> > -		__gitcomp_builtin stash_pop
> > -		;;
> > -	apply,--*)
> > -		__gitcomp_builtin stash_apply
> > -		;;
> > -	drop,--*)
> > -		__gitcomp_builtin stash_drop
> > -		;;
> >  	list,--*)
> >  		# NEEDSWORK: can we somehow unify this with the options in _git_log() and _git_show()
> >  		__gitcomp_builtin stash_list "$__git_log_common_options $__git_diff_common_options"
> > @@ -3054,8 +3039,8 @@ _git_stash ()
> >  	show,--*)
> >  		__gitcomp_builtin stash_show "$__git_diff_common_options"
> >  		;;
> > -	branch,--*)
> > -		__gitcomp_builtin stash_branch
> > +	*,--*)
> > +		__gitcomp_builtin "stash_$subcommand"
> >  		;;
> >  	branch,*)
> >  		if [ $cword -eq $((__git_cmd_idx+2)) ]; then
> > @@ -3069,8 +3054,6 @@ _git_stash ()
> >  		__gitcomp_nl "$(__git stash list \
> >  				| sed -n -e 's/:.*//p')"
> >  		;;
> > -	*)
> > -		;;
> >  	esac
> >  }
> 
> One might think that this introduces a logic error in "git stash
> doesnotexist" now dispatching to a non-existing "stash_doesnotexist" or
> something, bu tI see that earlier (omitted from context) in the function
> there's an exhaustive lit of push/save/pop etc. which guards against
> this, is is that correct?

Yep, that's exactly correct.

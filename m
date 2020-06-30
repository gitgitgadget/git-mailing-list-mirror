Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB355C433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 07:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E3DF207FF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 07:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDP+UdeM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbgF3HmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731019AbgF3HmH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 03:42:07 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C965CC061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 00:42:07 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h22so9131973pjf.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 00:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pslDSW1Pb3Lb6jwdTEG1XmsMyRWTh3iNo+o7a+HoI7E=;
        b=EDP+UdeMNwZYJhcjG91x89tPt+Qx/pofwncT1ssGw76cnaUWvNc274JcUqOp66dL0a
         v8Gcd7oSYT5AfPiM3DxFvRv+0FD7ZGFHlPisZ9boHKbd04Zey/IzJSgvVvf0Jo75H4Mg
         f2fnwaizhnxGP+sE6OLJ3EQlamNlbMKdRDQ8GCJeOLKExVKu9etv53NGxoMN4cIdLaut
         1Xbl/aot3Y7G2aK+ujX2xjetSPxW56sgIo5LZm3yyWTkacHfwKC0D4jCVQ2twjhSgvcA
         rOy6gW/QpxI/6Tt3sqBmsIL2aX986XTTJm9CYuYg5wR1gfFDG6hKcFNO7BQDaqF+kVbI
         EHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pslDSW1Pb3Lb6jwdTEG1XmsMyRWTh3iNo+o7a+HoI7E=;
        b=QZB5iGPI49XYK7VqMgR8OOD+R83u135fhHGIkFLkNCPJMpsm4GoGrh+sgUcNKVAZR+
         rpaOiXr8RW9imVGpK0hiG3hC0r0IU/HHSPVodIRNs4wa386iM5C6zXbMQNVLB4vxhk2M
         D6QCqyo0xpf9IWMthWdmbaPyhEqH/Qa9xd67Xl8/8kPMdhUb3pYQUP8IUfhTN3+dJsp6
         Ne+VJgme4ECFt09AvmroAbfSSUoQPvHI/OA9Iu9DlT/PJK5hpLsVI1Jltu90aK12JwIP
         V80wItOaE4GgH9VIYhyDtEkbdsv0GoFb4V+gewSkkrwA+U4eIaQAAaPSDFIy07KVVgdn
         r0Mg==
X-Gm-Message-State: AOAM533307eFXQqhkZI5a8LHoMNHMSGIPc6oblH+cSW8T9A0VI2Up4F3
        LfQ4zc/MmXSq++8OM4VzUjU=
X-Google-Smtp-Source: ABdhPJyABLB3bloyo8Rg80s4NsjrwxgsilsILwU0ivamA72AyWuK2/Rw6kHjy67WC3MKheK2hsu+SQ==
X-Received: by 2002:a17:902:8e82:: with SMTP id bg2mr17052513plb.198.1593502927237;
        Tue, 30 Jun 2020 00:42:07 -0700 (PDT)
Received: from gmail.com (108-81-23-119.lightspeed.irvnca.sbcglobal.net. [108.81.23.119])
        by smtp.gmail.com with ESMTPSA id 137sm1783000pgg.72.2020.06.30.00.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 00:42:06 -0700 (PDT)
Date:   Tue, 30 Jun 2020 00:42:04 -0700
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     sunlin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sunlin <sunlin7@yahoo.com>,
        "lin.sun" <lin.sun@zoom.us>
Subject: Re: [PATCH v3] Enable auto-merge for meld to follow the vim-diff
 beharior
Message-ID: <20200630074204.GA2144485@gmail.com>
References: <pull.781.v2.git.git.1591672753363.gitgitgadget@gmail.com>
 <pull.781.v3.git.git.1593414441313.gitgitgadget@gmail.com>
 <xmqqeepxfmdm.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeepxfmdm.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 29, 2020 at 05:06:13PM -0700, Junio C Hamano wrote:
> "sunlin via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >  mergetools/meld | 32 ++++++++++++++++++++++++++++++--
> >  1 file changed, 30 insertions(+), 2 deletions(-)
> >
> > diff --git a/mergetools/meld b/mergetools/meld
> > index 7a08470f88..91b65ff22c 100644
> > --- a/mergetools/meld
> > +++ b/mergetools/meld
> > @@ -7,13 +7,23 @@ merge_cmd () {
> >  	then
> >  		check_meld_for_output_version
> >  	fi
> > +	if test -z "${meld_has_auto_merge_option:+set}"
> > +	then
> > +		check_meld_for_auto_merge_version
> > +	fi
> 
> The detection part looks clumsy and inefficient.  More about it later.


Sorry for not noticing your reply here earlier.  I agree with everything
you wrote here, and rescind my earlier sign-off.  Combining as you
suggested below is best IMO as well.

> 
> > +	option_auto_merge=
> > +	if test "$meld_has_auto_merge_option" = true
> > +	then
> > +		option_auto_merge="--auto-merge"
> > +	fi
> >  
> >  	if test "$meld_has_output_option" = true
> >  	then
> > -		"$merge_tool_path" --output="$MERGED" \
> > +		"$merge_tool_path" $option_auto_merge --output="$MERGED" \
> >  			"$LOCAL" "$BASE" "$REMOTE"
> >  	else
> > -		"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
> > +		"$merge_tool_path" $option_auto_merge "$LOCAL" "$MERGED" "$REMOTE"
> >  	fi
> >  }
> 
> The part that chooses whether to pass --auto-merge or not and
> adjusts the command line options does look sensible.
> 
> I wonder if the same "hasAutoMerge" option can be used by those who
> do *not* want the new --auto-merge behaviour to opt out of this
> change.  Is there a reason why "meld" offers the --auto-merge as an
> optional behaviour (which tells, at least to me, that the default
> behaviour is not to auto-merge and makes me assume that the default
> must be chosen by some sound reasoning, hence some users would prefer
> not to use this new behaviour with good reasons)?
> 
> I guess what I am trying to get at is, if --auto-merge is an optional
> and non-default behaviour for "meld" users, perhaps it is not a good
> idea to change the behaviour on them only because the version of meld
> they run happens to support the --auto-merge as an optional behaviour.
> 
> IOW, wouldn't it make more sense, and certainly make it safer
> without surprises to existing users, if we made the logic to
> 
>     * If mergetool.meld.useAutoMerge is not set, do not pass
>       --auto-merge whether "meld" supports the option or not.
> 
>     * If mergetool.meld.useAutoMerge is 'true', always pass it
>       without checking.
> 
>     * If mergetool.meld.useAutoMerge is 'when-able' (or come up with
>       a better name if you want, perhaps 'auto'), check if "meld"
>       accepts "--auto-merge" and decide whether to pass it or not.
> 
> perhaps?


I like the idea of having it be auto/true/false, and perhaps "auto"
would be a sensible default if more users benefit from it than not.

Sunlin, do you have an opinion on what the default should be?



> > +# Check whether we should use 'meld --auto-merge ...'
> > +check_meld_for_auto_merge_version () {
> > +	meld_path="$(git config mergetool.meld.path)"

Small sug -- this command substitution doesn't need the enclosing
quotes.

	meld_path=$(git config mergetool.meld.path || echo meld)

should be sufficient.  Are we okay with `|| echo meld`?
If so, it would let us drop this line below.

> > +	meld_path="${meld_path:-meld}"


> > +
> > +	if meld_has_auto_merge_option=$(git config --bool mergetool.meld.hasAutoMerge)
> > +	then
> > +		: use configured value
> > +	elif "$meld_path" --help 2>&1 |
> > +		grep -e '--auto-merge' -e '\[OPTION\.\.\.\]' >/dev/null
> > +	then
> > +		: old ones mention --auto-merge and new ones just say OPTION...
> > +		meld_has_auto_merge_option=true
> > +	else
> > +		meld_has_auto_merge_option=false
> > +	fi
> > +}
> 
> When not configured, we end up running "meld --help" twice for two
> options, which is not great, don't you think?  I actually think the
> part that runs "meld --help" and parses its output should be split
> out of the helper function "check_meld_for_output_version" and
> called "check_meld_supported_options" or something, so that the
> logic to see if the --output and --auto-merge options should be
> passed can be made with at most one invocation of "meld --help".
> Which may involve *NOT* having two separate helper functions
> check_meld_for_*_version for the tested features.


I'm 100% on board with this suggestion.

> 
> Oh, also, check_meld_for_*_version is nonsensical as a name for
> these helper functions (it is not the fault of this patch---it is
> mimicking the existing practice, but that does not make the function
> name not nonsensical).  The helpers do not actually want to check a
> "version", they only want to see if a feature is supported.  So
> having "feature" in the name would be good, but "version" is not.


Ditto.
-- 
David

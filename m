Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4980C433FE
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 18:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351095AbiCOSkX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 14:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351100AbiCOSkW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 14:40:22 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B8E289AC
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 11:39:10 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id g19so343314pfc.9
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 11:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZCR9xRxQbcNj2Oy91AoSZylDBlVL0Z6O/FBokU+4USg=;
        b=Zj7O0JiJf91IAibP3MclwRmQeH4Au94DdP+dpPNjwQp0SYnQN5kocvR2nQOU4MiSma
         YFEGUIxi6YXYkjzfDq2O7G00UN9aLPWR3WzJl59SLjDnSSpziIQuEfmYxK4ILMR9Ke1g
         OiEkP7fPoE1r5dRpRJHs0Nt2azXdeBVFrWrhtLuCG59mczOhvD8JpQlewqopYQ4e4dcw
         oI5YwzZVIdXCP2o8avpI/AZmW4ddhp+XHTWVRwzW5gR46wNa2fUFD+wxBAbyHVzuE0ya
         JfewmZzjPDy78dDaqFG79MW7stnwpDkLuV7WmxtyME0I+tMx/3ZntoM/zOc/se1IDSiU
         +SmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZCR9xRxQbcNj2Oy91AoSZylDBlVL0Z6O/FBokU+4USg=;
        b=N1ywFpmtG/jZyDpZpx0IYvkr6mIee8fmxNl/KzlmlwzVdV8fRBYjkT6MmcFfrfkBlW
         /VAWlxa0ddTXPDkpLunKNtJRbRbGl9TjBfB28GVL/h9DMMP7PTzzXvzWShvVO7DR/TVA
         myHAkLEsP5mnVxarFSecT8+sW7oDYeIZhWn9gYcefjLUUuZIf6RSi0hY9hcjiFq3P336
         PzT3/RMXMsXNUJLGEwcAOlUJkarEzMeupslEkyzRwa1vbHDHUOaIGX/7MYMgiyqmELwx
         NXRvytUA6El2awFzKNDFQeW2UjNyDZ5Sb2NquyUTdS91N1Bpu2zXzZUDDDV/tjGa2e/p
         Rowg==
X-Gm-Message-State: AOAM533lD7d7p88Rq+2nPiPw2RnFcw6i5pu99ORrqSn/eZvr8c25ideG
        hIXx9X3+4d4oCTqZM+XzmV0o58/KZ1BzqQ==
X-Google-Smtp-Source: ABdhPJw0Q6+XdIwIvwWQNMBWwQ5dpR2RM93P/Zcd/5ZyTzmQDAJSEK91jG6bYsxpuhB+839IGDIUPQ==
X-Received: by 2002:a05:6a00:14c2:b0:4f7:aa97:b5e with SMTP id w2-20020a056a0014c200b004f7aa970b5emr17298259pfu.36.1647369548996;
        Tue, 15 Mar 2022 11:39:08 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:3c95:b7b0:13cc:7a5b])
        by smtp.gmail.com with ESMTPSA id t15-20020a63b70f000000b00381510608e9sm4943887pgf.14.2022.03.15.11.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 11:39:08 -0700 (PDT)
Date:   Tue, 15 Mar 2022 11:39:02 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v9 2/3] introduce submodule.hasSuperproject record
Message-ID: <YjDdRiRvvDtKZyq4@google.com>
References: <20220310004423.2627181-1-emilyshaffer@google.com>
 <20220310004423.2627181-3-emilyshaffer@google.com>
 <xmqqtuc6h83m.fsf@gitster.g>
 <kl6la6dxsczx.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqwnh1bgr4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwnh1bgr4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 10, 2022 at 02:10:55PM -0800, Junio C Hamano wrote:
> 
> Glen Choo <chooglen@google.com> writes:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> Emily Shaffer <emilyshaffer@google.com> writes:
> >>
> >>> @@ -2617,6 +2622,12 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
> >>>  
> >>>  	free(prefixed_path);
> >>>  
> >>> +	/*
> >>> +	 * This entry point is always called from a submodule, so this is a
> >>> +	 * good place to set a hint that this repo is a submodule.
> >>> +	 */
> >>> +	git_config_set("submodule.hasSuperproject", "true");
> >>> +
> >>>  	if (!oideq(&update_data.oid, &update_data.suboid) || update_data.force)
> >>>  		return do_run_update_procedure(&update_data);
> >>
> >> In Glen's update to rewrite "submodule update" in C, this part is
> >> replaced with a call to update_submodule2().  I am not sure what the
> >> current repository is at this point of the code with and without
> >> Glen's topic, but are we sure we are in a submodule we discovered?
> >
> > Rereading this, I realize you probably meant that this conflicts with
> > part1, not part2...
> >
> > At the end of part1, update_submodule2() is called from inside the
> > submodule (specifically from run_update_procedure()). So a good merge
> > conflict resolution would be to set the config _before_ calling
> > update_submodule2(). e.g.
> >
> > ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
> > diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> > index bef9ab22d4..f53808d995 100644
> > --- a/builtin/submodule--helper.c
> > +++ b/builtin/submodule--helper.c
> > @@ -2672,6 +2677,11 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
> >                                             &update_data.update_strategy);
> >
> >         free(prefixed_path);
> > +       /*
> > +        * This entry point is always called from a submodule, so this is a
> > +        * good place to set a hint that this repo is a submodule.
> > +        */
> > +       git_config_set("submodule.hasSuperproject", "true");
> >         return update_submodule2(&update_data);
> >  }
> 
> That matched my tentative resolution I made last night, but what do
> you think about this part of the test added by the patch?
> 
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 11cccbb333..ec2397fc69 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -1061,4 +1061,12 @@ test_expect_success 'submodule update --quiet passes quietness to fetch with a s
>  	)
>  '
>  
> +test_expect_success 'submodule update adds submodule.hasSuperproject to older repos' '
> +	(cd super &&
> +	 test_unconfig submodule.hasSuperproject &&
> +	 git submodule update &&
> +	 test_cmp_config -C submodule true --type=bool submodule.hasSuperproject
> +	)
> +'
> +
>  test_done
> 
> We go to "super", make sure that superproject does not have
> submodule.hasSuperproject set, run "git submodule update", and see
> if the configuration file in "submodule" subdirectory has the
> variable set.  It does not clear the variable from the submodule
> before starting, so the variable given to the submodule when it was
> cloned would be there, even if "git submodule update" failed to set
> it.
> 
> I am wondering if it should do something like the attached instead.
> 
> We
> 
>  * clear the variable from "super" and "super/submodule"
>    repositories;
> 
>  * run "git submodule update";
> 
>  * ensure that "git submodule update" did not touch "super/.git/config";

Yeah, this is a good idea, and indeed when I add this step the bug
pointed out downthread becomes clear. Thanks.

> 
>  * ensure that "git submodule update" added the variable to
>    "super/submodule/.git/config".
> 
> Clearing the variable from "super" is technically wrong because the
> repository is set up as a submodule of "recursivesuper" and if we
> had further tests, we should restore it in "super", but the point is
> that we are makng sure "git submodule update" sets the variable in
> the configuration file of the submodule, and not in the superproject's. 
> 
> With the conflict resolution above, this "corrected" test fails and
> shows that superproject's configuration file is updated after "git
> submodule update".
> 
> This series alone, without your topic, this "corrected" test fails,
> and that is where my "are we sure we are mucking with the
> configuration file in the submodule"? comes from.
> 
> diff --git c/t/t7406-submodule-update.sh w/t/t7406-submodule-update.sh
> index 000e055811..c9912bb242 100755
> --- c/t/t7406-submodule-update.sh
> +++ w/t/t7406-submodule-update.sh
> @@ -1083,4 +1083,16 @@ test_expect_success 'submodule update --filter sets partial clone settings' '
>  	test_cmp_config -C super-filter/submodule blob:none remote.origin.partialclonefilter
>  '
>  
> +test_expect_success 'submodule update adds submodule.hasSuperproject to older repos' '
> +	(cd super &&
> +	 test_unconfig submodule.hasSuperproject &&
> +	 test_unconfig -C submodule submodule.hasSuperproject &&
> +	 git submodule update &&
> +	 echo in super &&
> +	 test_cmp_config false --type=bool submodule.hasSuperproject &&
> +	 echo in submodule &&
> +	 test_cmp_config -C submodule true --type=bool submodule.hasSuperproject
> +	)
> +'
> +
>  test_done

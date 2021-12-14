Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C888AC433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 22:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhLNWQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 17:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbhLNWP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 17:15:56 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82F7C061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 14:15:56 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so18496283pjc.4
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 14:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BRNogODMnDfZ4/qZX+d4BbNVsRZjOPwcBrRGImyv0LA=;
        b=o3BuPfYFNSLEJr7JLO2bIC8zOLb5M2HxB8dfM6/RabqGg8MnPfmsUZgE7idhMbE/Fu
         J4wqcd6csv8ZNtgYtZL31wvp7WbcANduUJDFiu3B+IPLkXx/qwrbVjGd2hYKgCN8Z8SG
         AwDlNOOdltZjhjqzdWCO4wMqKbcoI/EjxCH3nF74dqT9ZXZSU/Ghdz/lCpTN7+/5M3+V
         Q8eCMfy+gVUOnlbMHrKSx3emKxO0UAE8Kc4Y9hIyn9A4ULaP3hnBepczNDseMr4WVRDX
         6swwO3XW6oEt2ezB7K0rzKYw9plvEBTTMGEzXujTqg6xQ4QxHg/LMTN+qatxqpMneE+h
         vs7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=BRNogODMnDfZ4/qZX+d4BbNVsRZjOPwcBrRGImyv0LA=;
        b=AKxvxBDURdHQDoLmIfvRXgAC4TSkiyzwDJY9lyCrDKiyrAMjD6C0v7Oh5Y6Wdi/fId
         EeUiwI9Kla2hdqOQEoI5Kdo2cE1Kz7ARZYYdwcQKy5piydhqiaz1GNAbBvnGNYdNnfnn
         hNUUNWgoO3yUiX6BUWNSIDpLDTht3SepvcsQR18+126n/ATePnIfkg8g0Pena6EzT9Nl
         2PT8Zjb/7O/6tCewK36xbHDr5AHIdPOkvbFGfb/tj3L3Ue3C2RLnuR7DUHxOxiC95kbo
         WWRP+Dp0oGUpQj5fekI6B1z2/t8kq15/9FgNqzrksq/ZzkT5x8C41VkS4U7MOpki2nhw
         oeyQ==
X-Gm-Message-State: AOAM531nChOGUjMG8wBoJQmUcbMt1Sguer31A0lDhGrts764gDaZFFId
        XUk66yRsPFCL3bchWdi2LuJnQg==
X-Google-Smtp-Source: ABdhPJwNSl7SP1Fpwhs6eSMfw3U9TAiG/c6K6iDd0WyDz5YqeDzVSBV9IeY4KyuX6d67ncVQ6Ej5Xw==
X-Received: by 2002:a17:902:d2d0:b0:148:a2e8:2764 with SMTP id n16-20020a170902d2d000b00148a2e82764mr1532526plc.107.1639520155976;
        Tue, 14 Dec 2021 14:15:55 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:b37:fbed:ef52:5dca])
        by smtp.gmail.com with ESMTPSA id z2sm94544pff.107.2021.12.14.14.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 14:15:55 -0800 (PST)
Date:   Tue, 14 Dec 2021 14:15:49 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, emilyshaffer@google.com
Subject: Re: [PATCH v5 2/2] branch: add flags and config to inherit tracking
Message-ID: <YbkXlTdGBemY5nRi@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, emilyshaffer@google.com
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1638859949.git.steadmon@google.com>
 <c7e4af9a365cc61e682c3c73045fb1ee4b79cfbf.1638859949.git.steadmon@google.com>
 <211207.86ilw0pydg.gmgdl@evledraar.gmail.com>
 <kl6lilw0aq76.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <kl6lilw0aq76.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.12.07 16:35, Glen Choo wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> >> @@ -10,7 +10,8 @@ enum branch_track {
> >>  	BRANCH_TRACK_REMOTE,
> >>  	BRANCH_TRACK_ALWAYS,
> >>  	BRANCH_TRACK_EXPLICIT,
> >> -	BRANCH_TRACK_OVERRIDE
> >> +	BRANCH_TRACK_OVERRIDE,
> >> +	BRANCH_TRACK_INHERIT
> >>  };
> >
> > So we've got 5 items in this enum...
> >
> >>  
> >>  extern enum branch_track git_branch_track;
> >> diff --git a/builtin/branch.c b/builtin/branch.c
> >> index b23b1d1752..ebde5023c3 100644
> >> --- a/builtin/branch.c
> >> +++ b/builtin/branch.c
> >> @@ -632,8 +632,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
> >>  		OPT__VERBOSE(&filter.verbose,
> >>  			N_("show hash and subject, give twice for upstream branch")),
> >>  		OPT__QUIET(&quiet, N_("suppress informational messages")),
> >> -		OPT_SET_INT('t', "track",  &track, N_("set up tracking mode (see git-pull(1))"),
> >> -			BRANCH_TRACK_EXPLICIT),
> >> +		OPT_CALLBACK_F('t', "track",  &track, "direct|inherit",
> >> +			N_("set branch tracking configuration"),
> >> +			PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
> >> +			parse_opt_tracking_mode),
> >>  		OPT_SET_INT_F(0, "set-upstream", &track, N_("do not use"),
> >>  			BRANCH_TRACK_OVERRIDE, PARSE_OPT_HIDDEN),
> >
> > But map --track, --track=direct --track=inherit to 3/5 of them. Will it
> > ever make sense to do the oher 2/5 (I really haven't checked)....
> 
> Reasonable question, but I believe the answer is no, it doesn't make
> sense to map all the values:
> 
> * BRANCH_TRACK_REMOTE is just a default value as far as I can tell (I
>   don't think this does anything?)
> * BRANCH_TRACK_ALWAYS behaves like BRANCH_TRACK_EXPLICIT but it's only
>   meant to be set from config files, see 9ed36cfa35 (branch: optionally
>   setup branch.*.merge from upstream local branches, 2008-02-19). We're
>   more lenient with _ALWAYS than with _EXPLICIT; e.g. we don't die()
>   when the upstream doesn't exist.
> 
> Even one of the other options doesn't really make that much sense...
> 
> * BRANCH_TRACK_OVERRIDE used to be used to implement --set-upstream, but
>   that's not necessary any more. Now it's used to make create_branch()
>   *not* create a branch sometimes, but that's going away if I get my
>   refactor of create_branch()
>   (https://lore.kernel.org/git/xmqq1r2pcnyw.fsf@gitster.g/T/#u) :)

Agreed, thank you for stating things better than I could have :)

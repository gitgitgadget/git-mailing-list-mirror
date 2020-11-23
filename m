Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1440C8300A
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 13:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E412076E
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 13:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoxT3XFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388590AbgKWNN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 08:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388563AbgKWNNl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 08:13:41 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB80C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 05:13:41 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id m6so18533386wrg.7
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 05:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=Ob+4RZb4B8BbbI1ehdfXisVXAY+h17GO/asrj2/DQgo=;
        b=CoxT3XFTFme3DCS6CREYk2CzMMa8LdT1sly9Ejehv1+DsOWj8EYhtDCuJtaiQ68rxG
         LPnLjHpkmshLZqb0vhKTp+IofAlChIqFiMWKwXTUpTmt5lKPRwmHwUywt8d2FIacZ9rc
         nwiuNWekbff2lEtEzwywkqTmt7d+NClJpH2FjhPF8GVG8c/pbHZLxKHZ4Qmd0PN+pLlC
         djkSjRDNblWOZi9etqhWVITchp4CGd360slwn87OeHKnfTXzTeySQoSfSRwN+pvizbQr
         aLUpG6arn60cRW91qLPoedH0bX/eJGM/XhyjEp7932UN7rLg9zC/xFrogbZUgFmcnOvS
         8MvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=Ob+4RZb4B8BbbI1ehdfXisVXAY+h17GO/asrj2/DQgo=;
        b=eq345RwvCwyHa4yCOKu9OD8Ou5QuTvp3H2hjokAfDT0FuT19K7TRhEy62ZLjtKDe7K
         TVktKxNhdoMe7qIKqpxzX2ik7fzEOjeQvUYOqMcdlW80kNiXwgHhwUohgmEdo+AxSJWg
         OiB6md5GYDC2i9+ouCW4f1RaO0y+/zjWHciD5VTYctnW69P2Wlam4W+ewxMWDShnkT5M
         anuwkyQyrkkSNtdGSAHShTGQkDNahh/OC2oCxO13EkqTVMbE0xU2cfPCqiQ4l16kL1s4
         QAEDomjip1ZSJolof3oC8+d+4tLK6KEbyk00Wgvg1TMFiupJ6kY52bhOdbWhy63O6R3b
         ovhg==
X-Gm-Message-State: AOAM530STAh4YqvhEidFl+oPSIoSXLvjK38Vmdp1gm5h7E/BmsSJ21oi
        JDZJh9EkbtFBQFU47n9FrSE=
X-Google-Smtp-Source: ABdhPJweoYqy6Uy5PsSvGvaLNtUe5aSsd0DEASHemSiiStEDuxnClSMov33w7YAXekYpkMbEl3vE1g==
X-Received: by 2002:adf:f783:: with SMTP id q3mr29628786wrp.88.1606137219845;
        Mon, 23 Nov 2020 05:13:39 -0800 (PST)
Received: from [192.168.1.66] ([46.98.123.94])
        by smtp.gmail.com with ESMTPSA id v64sm17100223wme.25.2020.11.23.05.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 05:13:39 -0800 (PST)
Date:   Mon, 23 Nov 2020 15:13:31 +0200
From:   serg.partizan@gmail.com
Subject: Re: [PATCH] git-gui: use gray selection background for inactive
 =?UTF-8?Q?text=0D=0A?= widgets
To:     Stefan Haller <stefan@haller-berlin.de>
Cc:     me@yadavpratyush.com, git@vger.kernel.org
Message-Id: <JE39KQ.T4FA61XF34XT3@gmail.com>
In-Reply-To: <20201123114805.48800-1-stefan@haller-berlin.de>
References: <DZJ7KQ.UXACXR9SWDQI3@gmail.com>
        <20201123114805.48800-1-stefan@haller-berlin.de>
X-Mailer: geary/3.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Mon, Nov 23, 2020 at 12:48, Stefan Haller <stefan@haller-berlin.de> 
wrote:
> On 22.11.20 18:16, serg.partizan@gmail.com wrote:
>>  I think calculating that gray color from current selection bg is 
>> too much work
>>  for just one color.
>> 
>>  We can just set inactiveSelectBackground to some neutral gray color 
>> like
>>  #707070 or #909090 which will work fine with both dark and light 
>> themes.
> 
> OK, fine with me. Here's a patch that does this (it sits on top of 
> yours). It
> almost works, except for one problem: on Mac, the inactive selection 
> background
> is white instead of lightgray, but only for the diff view; for the 
> commit editor
> it's correct. On Windows it's also correct for both views. I can't 
> figure out
> what's the difference on Mac; do you have an idea what could be wrong?
> 
I have no idea. Can confirm on linux it works as expected.
> --- 8< ---
> 
> This makes it easier to see at a glance which of the four main views 
> has the
> keyboard focus.
> ---
>  git-gui.sh     | 25 +++++++++++++++++++++----
>  lib/themed.tcl | 13 +++++++++----
>  2 files changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 867b8ce..a8c5cad 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -721,8 +721,8 @@ proc rmsel_tag {text} {
>  		-foreground [$text cget -foreground] \
>  		-borderwidth 0
>  	$text tag conf in_sel\
> -		-background $color::select_bg \
> -		-foreground $color::select_fg
> +		-background $color::inactive_select_bg \
> +		-foreground $color::inactive_select_fg
>  	bind $text <Motion> break
>  	return $text
>  }
> @@ -3325,8 +3325,25 @@ if {!$use_ttk} {
>  foreach i [list $ui_index $ui_workdir] {
>  	rmsel_tag $i
>  	$i tag conf in_diff \
> -		-background $color::select_bg \
> -		-foreground $color::select_fg
> +		-background $color::inactive_select_bg \
> +		-foreground $color::inactive_select_fg
> +
> +	if {$use_ttk} {

I think this check can be safely removed. This is all standard tk 
widgets, and select_bg/fg only changed if use_ttk is true.

> +		bind $i <FocusIn> {
> +			foreach tag [list in_diff in_sel] {
> +				%W tag conf $tag \
> +					-background $color::select_bg \
> +					-foreground $color::select_fg
> +			}
> +		}
> +		bind $i <FocusOut> {
> +			foreach tag [list in_diff in_sel] {

This two `foreach` can be combined into one?

> +				%W tag conf $tag \

And this `%W`, probably should be `$i`?

> +					-background $color::inactive_select_bg \
> +					-foreground $color::inactive_select_fg
> +			}
> +		}
> +	}

And maybe this new code should be grouped into function like 
"bind_tag_selection_handlers" to improve readability?

>  }
>  unset i
> 
> diff --git a/lib/themed.tcl b/lib/themed.tcl
> index eda5f8c..02b15f2 100644
> --- a/lib/themed.tcl
> +++ b/lib/themed.tcl
> @@ -6,8 +6,10 @@ namespace eval color {
>  	# Variable colors
>  	# Preffered way to set widget colors is using add_option.
>  	# In some cases, like with tags in_diff/in_sel, we use these colors.
> -	variable select_bg		lightgray
> -	variable select_fg		black
> +	variable select_bg				lightblue
> +	variable select_fg				black
> +	variable inactive_select_bg		lightgray
> +	variable inactive_select_fg		black
> 
>  	proc sync_with_theme {} {
>  		set base_bg		[ttk::style lookup . -background]
> @@ -16,6 +18,9 @@ namespace eval color {
>  		set text_fg		[ttk::style lookup Treeview -foreground]
>  		set select_bg	[ttk::style lookup Default -selectbackground]
>  		set select_fg	[ttk::style lookup Default -selectforeground]
> +		# We keep inactive_select_bg as the hard-coded light gray above, as
> +		# there doesn't seem to be a way to get it from the theme. Light 
> gray
> +		# should work well for light and dark themes.
> 
>  		set color::select_bg $select_bg
>  		set color::select_fg $select_fg
> @@ -36,8 +41,8 @@ namespace eval color {
>  		add_option *Text.Foreground $text_fg
>  		add_option *Text.selectBackground $select_bg
>  		add_option *Text.selectForeground $select_fg
> -		add_option *Text.inactiveSelectBackground $select_bg
> -		add_option *Text.inactiveSelectForeground $select_fg
> +		add_option *Text.inactiveSelectBackground 
> $color::inactive_select_bg
> +		add_option *Text.inactiveSelectForeground 
> $color::inactive_select_fg
>  	}
>  }
> 
> --
> 2.29.0.18.gf8c967e53c
> 



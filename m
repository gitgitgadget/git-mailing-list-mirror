Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2254FC7EE23
	for <git@archiver.kernel.org>; Tue,  9 May 2023 20:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbjEIUTe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 16:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjEIUTb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 16:19:31 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638F63ABF
        for <git@vger.kernel.org>; Tue,  9 May 2023 13:19:30 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-643a1656b79so4167627b3a.3
        for <git@vger.kernel.org>; Tue, 09 May 2023 13:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683663570; x=1686255570;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6eUEPIXGFh00Gwu9KY0qXjFG/9QsBFwGur83joEHtps=;
        b=U2iEDb6EMrHuZhhBtoQGlKXxalpKsSV4W3TSEAx88xTtzUrxrnPbWAmYr2QW7LQmLE
         +ll2o+juKWW7H3hRBvySNl3iwUqLc0Dwe94cNcEnFfjkK+xKpeFFZOmIQ8l1kad5ZZO9
         lv97/QAf15t5nVVA4F72mHftaOtN9BRCwC2WSnnFVIU5P3g6lN2cxyMYufcKf8PbOB5J
         3MjqSyUYbLrGMgBv9oxZtqKFWjEFnjMSJXYsDJmL5nKVL7gEcwRPRxfL9wZFp5uDKoKR
         OTZ1brkwBo+9vROybCYyEgITXyRsnA462XG9Il3QGTpLuZP6GsPQVcTJ0vaA/3vd7EaZ
         Hj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683663570; x=1686255570;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6eUEPIXGFh00Gwu9KY0qXjFG/9QsBFwGur83joEHtps=;
        b=bKEH2QkNn9JIG7dQQZC1sxTZ5K9QLOiI6AdmlK2AGThCyXxjzWGNGO6rSJiAf3XC3T
         B4XQPgR9KrwP2vHaop230S+aUWrvSMCqnhEqAZmZ5/MIkDp6tLRy8Hl7YmfZTbIordWQ
         e3zJj+plq5V5dR3vVspDMIm7voPAwwaLvLC7FHVfLsrgrt+6RGWSrLTG2zIPJUqOHqXT
         d/ax0VnTIsi5d6phVeETbHovyMlhkMz3D8E7yffpHe8l3+/eWDRP7HiqgsUgAziOvu1w
         VQS3/z4QC86CNUVLBg5+jtdO+5eO4V0fFry8qQK+KRsIfEFeRub25v3e8+3tuVtqpz8f
         B3zw==
X-Gm-Message-State: AC+VfDzdnbfdPwxdo9l10fORqqSZR4M44wOh8u5CfYX0SoajPRXXPjiv
        SAVghvwROL0wnR2p57813S8=
X-Google-Smtp-Source: ACHHUZ6wRJq7gJtwTH+YfryZWiCKJEUdM+9w6B7I0KyDVH/rEtn1yO1xL5CAzYcj+/gQqzUj6/9fkg==
X-Received: by 2002:a05:6a00:234c:b0:646:3c2:4d30 with SMTP id j12-20020a056a00234c00b0064603c24d30mr10436532pfj.30.1683663569694;
        Tue, 09 May 2023 13:19:29 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id n23-20020a62e517000000b0064398fe3451sm2092535pff.217.2023.05.09.13.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 13:19:29 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v4 5/8] fetch: introduce `display_format` enum
References: <cover.1681906948.git.ps@pks.im> <cover.1683636885.git.ps@pks.im>
        <80ac00b0c4b0fde61a3edf48d996e3a60327a54d.1683636885.git.ps@pks.im>
Date:   Tue, 09 May 2023 13:19:29 -0700
In-Reply-To: <80ac00b0c4b0fde61a3edf48d996e3a60327a54d.1683636885.git.ps@pks.im>
        (Patrick Steinhardt's message of "Tue, 9 May 2023 15:02:19 +0200")
Message-ID: <xmqq5y91xnou.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> We currently have two different display formats in git-fetch(1) with the
> "full" and "compact" formats. This is tracked with a boolean value that
> simply denotes whether the display format is supposed to be compacted
> or not. This works reasonably well while there are only two formats, but
> we're about to introduce another format that will make this a bit more
> awkward to use.
>
> Introduce a `enum display_format` that is more readily extensible.

Makes sense.

> +enum display_format {
> +	DISPLAY_FORMAT_UNKNOWN = 0,
> +	DISPLAY_FORMAT_FULL,
> +	DISPLAY_FORMAT_COMPACT,
> +};
>
>  struct display_state {
>  	struct strbuf buf;
>  
>  	int refcol_width;
> -	int compact_format;
> +	enum display_format format;

OK.  Preparatory conversion without adding anything new.

> @@ -809,31 +814,42 @@ static void display_state_init(struct display_state *display_state, struct ref *
>  
>  	git_config_get_string_tmp("fetch.output", &format);
>  	if (!strcasecmp(format, "full"))
> -		display_state->compact_format = 0;
> +		display_state->format = DISPLAY_FORMAT_FULL;
>  	else if (!strcasecmp(format, "compact"))
> -		display_state->compact_format = 1;
> +		display_state->format = DISPLAY_FORMAT_COMPACT;
>  	else
>  		die(_("invalid value for '%s': '%s'"),
>  		    "fetch.output", format);

Naturally.

> -	display_state->refcol_width = 10;
> -	for (rm = ref_map; rm; rm = rm->next) {
> -		int width;
> +	switch (display_state->format) {
> +	case DISPLAY_FORMAT_FULL:
> +	case DISPLAY_FORMAT_COMPACT: {
> +		struct ref *rm;
>  
> -		if (rm->status == REF_STATUS_REJECT_SHALLOW ||
> -		    !rm->peer_ref ||
> -		    !strcmp(rm->name, "HEAD"))
> -			continue;
> +		display_state->refcol_width = 10;
> +		for (rm = ref_map; rm; rm = rm->next) {
> +			int width;
>  
> -		width = refcol_width(rm, display_state->compact_format);
> +			if (rm->status == REF_STATUS_REJECT_SHALLOW ||
> +			    !rm->peer_ref ||
> +			    !strcmp(rm->name, "HEAD"))
> +				continue;
>  
> -		/*
> -		 * Not precise calculation for compact mode because '*' can
> -		 * appear on the left hand side of '->' and shrink the column
> -		 * back.
> -		 */
> -		if (display_state->refcol_width < width)
> -			display_state->refcol_width = width;
> +			width = refcol_width(rm, display_state->format == DISPLAY_FORMAT_COMPACT);
> +
> +			/*
> +			 * Not precise calculation for compact mode because '*' can
> +			 * appear on the left hand side of '->' and shrink the column
> +			 * back.
> +			 */
> +			if (display_state->refcol_width < width)
> +				display_state->refcol_width = width;
> +		}
> +
> +		break;
> +	}
> +	default:
> +		BUG("unexpected display format %d", display_state->format);
>  	}

Due to reindentation, the patch is noisier than what it does (which
should be "nothing, other than allowing another value in the .format
member").

It makes me wonder if it would make it easier to read to move the
bulk of this code to a helper function.  If we are to give a name to
what is being done in the above hunk, what would it be?  It computes
display->refcol_width in which all records would fit, but presumably
if we are to add more things to be shown per ref and align them in a
simlar way, we would compute widths for these other things there as
well.  Perhaps compute_display_alignment() or somesuch?


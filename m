Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6612C4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 23:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiKBX7d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 19:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiKBX7b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 19:59:31 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8762C2BC1
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 16:59:30 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z3so142690iof.3
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 16:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TvpCVLdWbUoKOO1HbP33KqeJq2dwCJRpu2B8poxCyQM=;
        b=10IGlh9m3AfaPIL29ZxvEH9ToeTU5vqkEgVXbQtPUCs69P5Qf9vnA2rD2SjjZ9iNlh
         esg2r2t6k1B0rcn77738UOptqOqJxpY3sgbyJpmzzstWikYCweXmM1Ptea6pPeb9fZoT
         ESpAtL5Omozg3W7vSFeS6w8yHOKInLqGa+d0zXxRqPxdqeZZX2L4GzPpU0VwGTqY0cP/
         8awGZvKz41x86xsJ7s/GFx4EPZHJ9D5/smNkXbdYHnc+EtdPcLm6swdbVqENI0wabWQU
         KdqqGbnYVNK7XyKvXv3E7jiRzXTPHP9uuuxOEoEXU6nCb3MmLBkmXKjdnQZCded87skS
         Yc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvpCVLdWbUoKOO1HbP33KqeJq2dwCJRpu2B8poxCyQM=;
        b=Eizm5LLD9rhLtFme8usZZ36sIy5KiiugRn192c2wcq9X/FgfySqYe1RqcAXiu8NJxV
         D2hp0MdgQmBBV5sPUDcDwzjswoXLHS5shIoGKlG4Wpf/4JZpFv/FLAemdW+TDlHjoszr
         LRgrDnMD30P8d8lQqmk51VtTXKmzwTFMUu7d+mGdtPywb8igJ86CEctxcdrbA6wyf+DP
         qzQ+vlHkisHEISv/zcVUaToH8hK5Hh9hwf6sM4t6gHQCK38DK7i3zLuHe3TtI9DS6jdx
         DUIOmM5EapenoJTOOdVxv+g0jNQTEcyaKtZ9tS+TgOBQ6MX2azd7QkQk04fbuDTQ+xuX
         6WlQ==
X-Gm-Message-State: ACrzQf0J8ziynZxM/WAVznWaJ3BwmEszfMWjML6QhlU4JctD6YR6hT53
        FpZUmhCSOqhNJHaEGqi3zuCvlCbSN+X8hVaH
X-Google-Smtp-Source: AMsMyM68pBC96Xp95MSxu0+clISfddre/5qd3xR8RDoRdP8L/9259MbKcS8MkpBB5RFV+3nbOWxtTQ==
X-Received: by 2002:a05:6638:40b:b0:375:55f7:f0ac with SMTP id q11-20020a056638040b00b0037555f7f0acmr14202598jap.249.1667433569856;
        Wed, 02 Nov 2022 16:59:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q16-20020a05663810d000b00363d6918540sm5256852jad.171.2022.11.02.16.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 16:59:29 -0700 (PDT)
Date:   Wed, 2 Nov 2022 19:59:27 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Rudy Rigot <rudy.rigot@gmail.com>
Subject: Re: [PATCH v2] status: long status advice adapted to recent
 capabilities
Message-ID: <Y2MEXyhh2cJ14ba9@nand.local>
References: <pull.1384.git.1665839050813.gitgitgadget@gmail.com>
 <pull.1384.v2.git.1667002005494.gitgitgadget@gmail.com>
 <8abc5272-4e01-e793-5155-ea116e9ad4fd@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8abc5272-4e01-e793-5155-ea116e9ad4fd@jeffhostetler.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2022 at 03:45:18PM -0400, Jeff Hostetler wrote:
> Let me suggest an alternative commit message.  We want to lead with a
> "command" -- as in: "make Git do this" or "teach Git to do this".  Then
> explain why.  Maybe something like:
>
> [...]

Excellent suggestions, thank you.

> > @@ -1870,13 +1884,25 @@ static void wt_longstatus_print(struct wt_status *s)
> >   		wt_longstatus_print_other(s, &s->untracked, _("Untracked files"), "add");
> >   		if (s->show_ignored_mode)
> >   			wt_longstatus_print_other(s, &s->ignored, _("Ignored files"), "add -f");
> > -		if (advice_enabled(ADVICE_STATUS_U_OPTION) && 2000 < s->untracked_in_ms) {
> > -			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
> > -			status_printf_ln(s, GIT_COLOR_NORMAL,
> > -					 _("It took %.2f seconds to enumerate untracked files. 'status -uno'\n"
> > -					   "may speed it up, but you have to be careful not to forget to add\n"
> > -					   "new files yourself (see 'git help status')."),
> > -					 s->untracked_in_ms / 1000.0);
> > +		if (uf_was_slow(s->untracked_in_ms)) {
> > +			if (advice_enabled(ADVICE_STATUS_U_OPTION)) {
> > +				status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
> > +				if (s->repo->settings.core_untracked_cache == UNTRACKED_CACHE_WRITE) {
> > +					status_printf_ln(s, GIT_COLOR_NORMAL,
> > +							_("It took %.2f seconds to enumerate untracked files,\n"
> > +							"but this is currently being cached, with fsmonitor %s."),
> > +							s->untracked_in_ms / 1000.0,
> > +							(fsm_mode > FSMONITOR_MODE_DISABLED) ? "ON" : "OFF");
> > +				} else {
> > +					status_printf_ln(s, GIT_COLOR_NORMAL,
> > +							_("It took %.2f seconds to enumerate untracked files."),
> > +							s->untracked_in_ms / 1000.0);
> > +				}
> > +				status_printf_ln(s, GIT_COLOR_NORMAL,
> > +						_("See https://git-scm.com/docs/git-status#_untracked_files_and_status_speed\n"
> > +						"for configuration options that may improve that time."));
> > +				status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
> > +			}
>
> I'm not sure I like the various mixture of messages here.  Maybe
> it would be better with a single simple message:
>
>     _("It took %.2f seconds to enumerate untracked files.\n"
>       "See 'git help status' for information on how to improve this.")
>
> This keeps all of the information in the documentation rather
> than having part of it here in the code.
>
> Also, we should refer to the documentation via `git help` rather
> than as a link to the website.

I agree with your suggestion of not linking out to git-scm.com here, but
I wonder if we could get by without mentioning 'git help' here, either.
Presumably looking up an unknown configuration variable with 'man
git-config' is easy enough.

Thanks,
Taylor

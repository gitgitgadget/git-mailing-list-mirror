Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D826C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 19:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F1C206D3
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 19:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npXC0/L7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfLITTA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:19:00 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41620 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfLITTA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 14:19:00 -0500
Received: by mail-pf1-f193.google.com with SMTP id s18so7708498pfd.8
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 11:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pb2ygBdzqn25M9/kpg9DOdtwnfPqwZ47aFNdoiuOsC0=;
        b=npXC0/L7Q7xoiC4hWPWXiDpHmjkO6EMl1lfcDLmrfQpSTu1Prumn2Gm8RxrunecNMI
         sMnHzzvpSnDkSYm3kt4IabJOeDlj/xLqJ6iP/Ig1uwSnoRXwRx3axsjgmRP2bLRf95i6
         cZ1f0HYfTJ4PLplI/Z+vAxn6Kx6DS1TlpEGNLoFBRTJN83dUSzKnRaeg40NKA01n1HM6
         Qvp1+LLixFzWbSPoYrNB27pdykF135QgMZCOHaHEjjdacyifYiL/vnSe0ieNNbIoJy8e
         2uAAWBI6wsfMaZXn+rHLY8pdUyUU4lNqmFdbmVCyLBWpMC6cVkkQopf8Sxi6sHrb59Dj
         QFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pb2ygBdzqn25M9/kpg9DOdtwnfPqwZ47aFNdoiuOsC0=;
        b=VdNoe321IfVcxYqzdRizbjf8Qm2a0O6wlpZDyMVKGIEFj7kqD7viQcKH5HCjUqhqwu
         eQRLdmBRJqDbp+KHNR7BwQAi6lKU/18LJr8EFTOZsm5DCD1GkFfSX8hT3hjsqejeiPrK
         ODz0zEbbfQnsgk4BNmTz4VjOcwLTqkFKU6Wpy3QrQngaBOl65duAiHKN5moNCakLMB1Z
         C42SYCoW1kDJX9abfH0+ODuPTk/HY67gqmufi9cUeIoYuwTu2nNSs7bZu4JiQrP7pJqG
         x5tz5CuIEv57AClKztxO8BsMjH6ihWAiQSX8IphQAXuubvMgD5aw1LBwGzIuTLwvq356
         cMuw==
X-Gm-Message-State: APjAAAVJzqhz16/cfk3yZDKcEtTgxl/MKMXFGpjwL0+JwsBslL+E3JdM
        9CW65knSaaqcyY1CE98hb/8=
X-Google-Smtp-Source: APXvYqzZOzv8kV74YoJ8qC/WKVWSnyUYoulRBYxz8Lg1K+y4AOgXe5eoAaROCinMSx+v+US4wnxJBA==
X-Received: by 2002:aa7:952a:: with SMTP id c10mr29924843pfp.77.1575919139329;
        Mon, 09 Dec 2019 11:18:59 -0800 (PST)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id t5sm160883pje.6.2019.12.09.11.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 11:18:58 -0800 (PST)
Date:   Mon, 9 Dec 2019 11:19:24 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Pavel Roskin <plroskin@gmail.com>
Subject: Re: [PATCH 3/5] notes: extract logic into set_display_notes()
Message-ID: <20191209191924.GA24159@generichostname>
References: <cover.1575896661.git.liu.denton@gmail.com>
 <62543250c4ea0e0327f974cb90b294c60b525982.1575896661.git.liu.denton@gmail.com>
 <CAPig+cToM+sHj-C5N_F2F+5B3LTPLVf39_-kCSih_WkuBOV+mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cToM+sHj-C5N_F2F+5B3LTPLVf39_-kCSih_WkuBOV+mA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, Dec 09, 2019 at 11:26:15AM -0500, Eric Sunshine wrote:
> On Mon, Dec 9, 2019 at 8:11 AM Denton Liu <liu.denton@gmail.com> wrote:
> > Instead of open coding the logic that tweaks the variables in
> > `struct display_notes_opt` within handle_revision_opt(), abstract away the
> > logic into set_display_notes() so that it can be reused.
> >
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> > diff --git a/notes.c b/notes.c
> > @@ -1045,6 +1045,30 @@ void init_display_notes(struct display_notes_opt *opt)
> > +int set_display_notes(struct display_notes_opt *opt, int show_notes, const char *opt_ref)
> > +{
> > +       if (show_notes) {
> > +               if (opt_ref) {
> > +                       struct strbuf buf = STRBUF_INIT;
> > +                       strbuf_addstr(&buf, opt_ref);
> > +                       expand_notes_ref(&buf);
> > +                       string_list_append(&opt->extra_notes_refs,
> > +                                          strbuf_detach(&buf, NULL));
> > +               } else {
> > +                       opt->use_default_notes = 1;
> > +               }
> > +       } else {
> > +               opt->use_default_notes = -1;
> > +               /* we have been strdup'ing ourselves, so trick
> > +                * string_list into free()ing strings */
> > +               opt->extra_notes_refs.strdup_strings = 1;
> > +               string_list_clear(&opt->extra_notes_refs, 0);
> > +               opt->extra_notes_refs.strdup_strings = 0;
> > +       }
> > +
> > +       return !!show_notes;
> > +}
> 
> When you find yourself creating a function in which the entire body is
> (effectively) a single giant 'if' statement and in which the 'then'
> and 'else' arms are chosen by an input argument to that function (and
> remaining input arguments are used only by one or the other branch),
> it is usually a good sign that you should really be creating two
> distinct functions. Doing so would reduce cognitive load of people
> reading and trying to understand the code (as well as reduce the
> indentation level). For instance, you might introduce these functions:
> 
>     void enable_display_notes(struct display_notes_opt *opt, const
> char *opt_ref);
>     void disable_display_notes(struct display_notes_opt *opt);

Makes sense. I'll probably split it off into disable_display_notes(),
enable_default_display_notes() and enable_ref_display_notes() since
there is no logic shared between when opt_ref is NULL and when it isn't.

> 
> > diff --git a/notes.h b/notes.h
> > @@ -265,6 +265,16 @@ struct display_notes_opt {
> > +/*
> > + * Set a display_notes_opt to a given state. 'show_notes' is a boolean
> > + * representing whether or not to show notes. 'opt_ref' points to a
> > + * string for the notes ref, or is NULL if the default notes should be
> > + * used.
> > + *
> > + * Return 'show_notes' normalized to 1 or 0.
> > + */
> > +int set_display_notes(struct display_notes_opt *opt, int show_notes, const char *opt_ref);
> 
> Please drop the meaningless return value. While I understand you did
> this as a convenience to make calling code a bit more concise, it
> nevertheless doesn't belong here since it conflates that convenience
> code with the true purpose of this function (which to enable or
> disable note display). Worse, it increases cognitive load on people
> trying to comprehend the code since it requires that they consult the
> documentation for set_display_notes() to understand what is going on.
> That is, this is far less obvious:
> 
>     revs->show_notes = set_display_notes(&revs->notes_opt, 1, optarg);
> 
> than this:
> 
>     revs->show_notes = 1;
>     enable_display_notes(&revs->notes_opt, optarg);
> 
> Alternately, if revs->show_notes and revs->notes_opt really ought
> always be set in lockstep, then maybe it makes more sense to have the
> "enable" and "disable" functions accept 'revs' directly in order to be
> able to adjust both revs->show_notes and revs_notes_opt together:
> 
>     void enable_display_notes(struct rev_info *revs, const char *opt_ref);
>     void disable_display_notes(struct rev_info *revs);

Hmm, the "lockstep" thing was what I was going for. That's why I ended
up using one monolithic function instead of several smaller ones. That
way, the caller can just blindly pass in values and then use the values
returned to set its own state (i.e. how 4/5 does it). Also, it would
ensure that future developers using this function won't forget to set
the corresponding show_notes variable to whatever value is appropriate.

The reason why we can't accept `revs` is because this series attempts to
stop depending on `revs` for the notes configuration entirely. That way,
we can call git_config() before repo_init_revisions() since we won't
need to have `revs` initialised.

I considered accepting an `int *` instead of using the return value to
make the intent more explicit but I didn't do that because the return
value seemed easier to deal with. Perhaps we could revive that idea
with:

     void enable_display_notes(struct display_notes_opt *opt,
	     int *show_notes, const char *opt_ref);
     void disable_display_notes(struct display_notes_opt *opt,
	     int *show_notes);

I'll brood over the alternatives for a little bit before sending a
reroll.

Thanks,

Denton

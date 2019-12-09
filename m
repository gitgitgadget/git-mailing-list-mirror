Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB126C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 08:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8552071E
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 08:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBM8ZENf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfLIIY4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 03:24:56 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:46386 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLIIY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 03:24:56 -0500
Received: by mail-pj1-f66.google.com with SMTP id z21so5530752pjq.13
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 00:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n9yEXbRgrugBSWgDCfxifH5Gu8TzNx5OmlMQNCmc0DY=;
        b=CBM8ZENfHI6hTKRUz0hwTpeNgy/4U2jpA7G/e0cvFHQdLYdwKmInHo230FuZ2w09A8
         J3gaU6jbadh/dEiUU/nx6dHiwnsMINgebb1V5LOw7+F7WFBbPvI2oHkC38w3eam+T/CN
         6n7qx2Xe/9u7HLEmZMLe49v7lFBV3HTczpP17QTz/J/BX+NT6fg6TLgev4vgPA6ThHpn
         SdLsPWEu7N3Qoo8YCydDIgiHL7du9DTC/ygm04umqYwIcBJ6wcX4rn9FSQxhlusApfwB
         FZuJC0OqZ49djsMHNVCMpFZ92T+WscqUEPGPpNJMMmZSit5vt+GWHrGO+svp7ZZlt2If
         uROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n9yEXbRgrugBSWgDCfxifH5Gu8TzNx5OmlMQNCmc0DY=;
        b=t0k4GFNNlFvH9L1Wo4kBzFW/Uu8hDiaxGQBynv0uE+z3Kh68dDS3dUlbcifGSgNbts
         Fos/Yb5Cr7CJewyLsfvIcIohD6b1q+qLeESnZ1CXndjWf8qaHYv/hpahBTENwJ/A9Wum
         gfjM8d8xbKz5oheED3lnu8vk/5YfuYGhZe1mfI87ubqnpe7kBc8lodKMrdq5oq4s83Lk
         RNFM4XL6/8zWx9eEirBdQ8SOGVCSLKlKQdERc0r+mqKEeVucRIkEn/XPEe5OMlerh0Sn
         5FMWImdCv3vTRfaHjU7NLrDAevIfmRChwCJaaMElrrlawr0341Q0ZcQTfeqJ/gumdwIu
         RJrQ==
X-Gm-Message-State: APjAAAURXXOXVMqzoN1M8Z580poeRfqlV8Jgn891AIHEX8/TV/K9ru9n
        eGghwVDiVqCiDIqgQEVisLA=
X-Google-Smtp-Source: APXvYqzVPbbciOavb93XKJQNG7ItaZvibRjU1cufsE986enBlONsc256AsrTNVYAaabDWqchX6gQ7Q==
X-Received: by 2002:a17:902:7484:: with SMTP id h4mr24419577pll.74.1575879894936;
        Mon, 09 Dec 2019 00:24:54 -0800 (PST)
Received: from generichostname ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id e20sm26092866pff.96.2019.12.09.00.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 00:24:53 -0800 (PST)
Date:   Mon, 9 Dec 2019 00:24:51 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Pavel Roskin <plroskin@gmail.com>
Subject: Re: [PATCH v4 2/2] format-patch: teach format.notes config option
Message-ID: <20191209082451.GA57882@generichostname>
References: <cover.1558048212.git.liu.denton@gmail.com>
 <7cb770e190f235accf50e4af3ec9a964f26358c5.1558048212.git.liu.denton@gmail.com>
 <CABPp-BF44+6gvZVNimKf-k7AWbOjw3OK-cJeFunNR96wvZGkcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BF44+6gvZVNimKf-k7AWbOjw3OK-cJeFunNR96wvZGkcw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Sat, Dec 07, 2019 at 11:48:59PM -0800, Elijah Newren wrote:
> > @@ -864,6 +866,22 @@ static int git_format_config(const char *var, const char *value, void *cb)
> >                         from = NULL;
> >                 return 0;
> >         }
> > +       if (!strcmp(var, "format.notes")) {
> > +               struct strbuf buf = STRBUF_INIT;
> > +               int b = git_parse_maybe_bool(value);
> > +               if (!b)
> > +                       return 0;
> > +               rev->show_notes = 1;
> > +               if (b < 0) {
> > +                       strbuf_addstr(&buf, value);
> > +                       expand_notes_ref(&buf);
> > +                       string_list_append(&rev->notes_opt.extra_notes_refs,
> > +                                       strbuf_detach(&buf, NULL));
> > +               } else {
> > +                       rev->notes_opt.use_default_notes = 1;
> > +               }
> > +               return 0;
> > +       }
> 
> What if someone has multiple format.notes entries in their config
> file, but the last entry is "false" -- shouldn't that disable notes?
> Also, what if they specify both "true" and e.g.
> "refs/notes/my-cool-notes"?  In that case, should it show
> refs/notes/my-cool-notes because that's obviously showing some notes
> so it satisfies true as well as the specific request about which note,
> or should it treat "true" the same as the-default-notes-ref and then
> add the two refs together and show them both?

I think I'll just copy the existing logic of --notes, --notes=<ref> and
--no-notes from revision.c to `format.notes = true`, 
`format.notes = <ref>` and `format.notes = false` respectively. IOW,
with `format.notes = true`, we'll unconditionally use the default notes,
with `format.notes = <ref>`, we'll append <ref> to the reflist and with
`format.notes = false`, we'll clear and unset the notes refs.

It seems like that logic has been around for almost a decade and I don't
think anyone's complained about it so I think it should be safe to
duplicate.

> 
> >
> >         return git_log_config(var, value, cb);
> >  }
> > @@ -1617,8 +1635,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
> >         extra_to.strdup_strings = 1;
> >         extra_cc.strdup_strings = 1;
> >         init_log_defaults();
> > -       git_config(git_format_config, NULL);
> >         repo_init_revisions(the_repository, &rev, prefix);
> > +       git_config(git_format_config, &rev);
> 
> Calling git_config() after repo_init_revisions() breaks things;
> generally git_config() should always be called first.  Here,
> git_format_config() can set up parameters used by
> repo_init_revisions(), and by reversing the order of the two you end
> up ignoring settings specified by the user (e.g. diff.context having a
> value of 5).  This came up due to the bug report at
> https://lore.kernel.org/git/xmqqa78d2qmk.fsf@gitster-ct.c.googlers.com/T/#mb6a09958ff10acde295b37a9136bc3791fd4a2c2
> (though fixing the issue there _also_ requires fixing git_am_config()
> to call git_diff_ui_config()).  To break the circular dependency here,
> we'd need to store the information that git_format_config() discovers
> in some data structure besides rev, and then after the
> repo_init_revisions() call has finished then update rev.

I see, I'll move the git_config() back up while I'm at it.

> 
> I was just going to do that, but then ran into the questions above
> about multiple format.notes entries in the config file, and am not as
> sure about what should be done about that stuff (and I don't want to
> try to translate the current behavior as-is while tweaking where the
> stuff is stored, both because I'm not sure of the right behavior and
> because I don't want future folks to blame the code to me when they
> hit bugs in this area), so I'm firing off this email instead.

Sounds good, I don't want my bugs blamed on anyone else either ;)

I'll try to get a patchset out soon and hopefully you'll be able to base
your work off of that.

Thanks,

Denton

> 
> So, um...help?
> 
> Thanks,
> Elijah

Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC64C2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 23:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47CAB2087E
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 23:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCI8D/0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgKFXKT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 18:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbgKFXKS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 18:10:18 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1D0C0613CF
        for <git@vger.kernel.org>; Fri,  6 Nov 2020 15:10:18 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id c80so3149644oib.2
        for <git@vger.kernel.org>; Fri, 06 Nov 2020 15:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OVzSvZkngt7O4S5wmJq3XytY9h0i++Xk7kOqSZZuwP0=;
        b=vCI8D/0OB5uG99OI8JsgCD8zCR8ql8nrZTz0E2+ZZkz/n0tqf7tjbPuS6VwY0Mrw2s
         IZBILCVmiK7WlP3vS4XE4OizZ/CdZKy2XOurpbu3uKzHEhHLBtCEowGhQtn909ovnaXX
         7TBnlI1YA0JTk7pDuYBofZIV6WYP2wFv2aYslT5k147fAh51NSr5KcH2Lj3segztGVFl
         w0svbdNEX9T83+YGwvmRdZdAei4Owo4EEuoPKXz4odoBJ8li3P/LXmK4FQ/80Er6fYdo
         SJWoV1bxvtDlCAhYz7Eg7+h1BGd4SZ06dTpZKas8PNY0lSzEYfkiDn34IhIbkvQo3HO9
         N6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OVzSvZkngt7O4S5wmJq3XytY9h0i++Xk7kOqSZZuwP0=;
        b=IsyemjAWM6+Rnmj74e+0qWGRk1IMEAa9wMV+BmCdCsTgQRR1y/S2lob8b9HJR7AzDn
         qnaPQ0ZLjmQgqYzmGHvljijdwoUjXuDv9oEjjO8LciRWW5LRf47zBhiA6LM0oFINQSXU
         Pu/DJaaac5YGyE2MiJd6Ipsb4YlrSW8wEFCx/xJy0boe1TLCLfVCp4Q2rv4yv9tGhSUK
         31V65yvgbsu3fpzTWy86GDq0luZUqqwFwfev0AeJxoeqlNAhVyMuzBdO7Viu7w34TEmR
         cOeDPOUi+pz34dRtpCk3R88TdDyntA0HAEBN4WyQ+do4WmPFPMphN4jvYnGR99iE/Toa
         vpAQ==
X-Gm-Message-State: AOAM531qArcQQZ4DFbV0Jn/rvckfyOG18duHo6AejHPtiPOL4uDbvqmP
        sXVBtNHGbbTbbZh5kUlCgPM4IXm0zTQ4B22YE8k=
X-Google-Smtp-Source: ABdhPJxOB8MGNqOpOjjqlgyhSnDiimz3DB9WIsAZgeIDddj4jQLIsnoFtCC0DMrD/RmKB0p4r/TAnuHYcvckGW9T4vA=
X-Received: by 2002:aca:3756:: with SMTP id e83mr2457692oia.31.1604704218154;
 Fri, 06 Nov 2020 15:10:18 -0800 (PST)
MIME-Version: 1.0
References: <20201102204344.342633-7-newren@gmail.com> <20201106221934.764672-1-jonathantanmy@google.com>
In-Reply-To: <20201106221934.764672-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 6 Nov 2020 15:10:07 -0800
Message-ID: <CABPp-BFkAu6oO5V0jRh=ExuPxBXma1F17zaq-zEaqMagc72Ccw@mail.gmail.com>
Subject: Re: [PATCH v2 06/20] merge-ort: implement a very basic collect_merge_info()
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 6, 2020 at 2:19 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > diff --git a/merge-ort.c b/merge-ort.c
> > index 537da9f6df..626eb9713e 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -77,13 +77,130 @@ static int err(struct merge_options *opt, const char *err, ...)
> >       return -1;
> >  }
> >
> > +static int collect_merge_info_callback(int n,
> > +                                    unsigned long mask,
> > +                                    unsigned long dirmask,
> > +                                    struct name_entry *names,
> > +                                    struct traverse_info *info)
> > +{
>
> [snip]
>
> > +     unsigned mbase_null = !(mask & 1);
> > +     unsigned side1_null = !(mask & 2);
> > +     unsigned side2_null = !(mask & 4);
>
> Should these be "int"?

Does the type matter, particularly since "boolean" isn't available?

> > +     /*
> > +      * A bunch of sanity checks verifying that traverse_trees() calls
> > +      * us the way I expect.  Could just remove these at some point,
> > +      * though maybe they are helpful to future code readers.
> > +      */
> > +     assert(mbase_null == is_null_oid(&names[0].oid));
> > +     assert(side1_null == is_null_oid(&names[1].oid));
> > +     assert(side2_null == is_null_oid(&names[2].oid));
> > +     assert(!mbase_null || !side1_null || !side2_null);
> > +     assert(mask > 0 && mask < 8);
>
> These were helpful to me.
>
> > +     /* Other invariant checks, mostly for documentation purposes. */
> > +     assert(mask == (dirmask | filemask));
>
> But not this - filemask was computed in this function, so I need not
> look elsewhere to see that this is correct.
>
> > +     /*
> > +      * TODO: record information about the path other than all zeros,
> > +      * so we can resolve later in process_entries.
> > +      */
> > +     ci = xcalloc(1, sizeof(struct conflict_info));
> > +     strmap_put(&opti->paths, fullpath, ci);
>
> OK - so each entry is a full-size conflict_info to store all relevant
> information. Presumably some of these will be converted later into what
> is effectively a struct merged_info (so, the extra struct conflict_info
> fields are unused but memory is still occupied).
>
> I do see that in patch 10, there is an optimization that directly
> allocates the smaller struct merged_info when it is known at this point
> that there is no conflict.

Yep.  :-)

> [snip rest of function]
>
> >  static int collect_merge_info(struct merge_options *opt,
> >                             struct tree *merge_base,
> >                             struct tree *side1,
> >                             struct tree *side2)
> >  {
> > -     /* TODO: Implement this using traverse_trees() */
> > -     die("Not yet implemented.");
> > +     int ret;
> > +     struct tree_desc t[3];
> > +     struct traverse_info info;
> > +     char *toplevel_dir_placeholder = "";
> > +
> > +     opt->priv->current_dir_name = toplevel_dir_placeholder;
> > +     setup_traverse_info(&info, toplevel_dir_placeholder);
>
> I thought that this was written like this (instead of inlining the 2
> double-quotes) to ensure that the string-equality-is-pointer-equality
> characteristic holds, but I see that that characteristic is for
> directory_name in struct merged_info, not current_dir_name in struct
> merge_options_internal. Any reason for not inlining ""?

You're really digging in; I love it.  From setup_path_info(), the
directory_name is set from the current_dir_name:
        path_info->merged.directory_name = current_dir_name;
(and if you follow where the current_dir_name parameter gets its value
from, you find that it came indirectly from
opt->priv->current_dir_name), so current_dir_name must meet all the
requirements on merge_info's directory_name field.

Perhaps there's still some kind of additional simplification possible
here, but directory rename detection is an area that has to take some
special care around this requirement.  I simplified the code a little
bit in this area as I was trying to break off a good first 20 patches
to submit, but even if we can simplify it more, the structure is just
going to come back later.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BCDC2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 22:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B20AB20789
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 22:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HgzmlrMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbgKIWJG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 17:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKIWJG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 17:09:06 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A66AC0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 14:09:06 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i184so10025111ybg.7
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 14:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=SM4c6aCM3ChivcVC2PDOr3ryhsZzNMPJHU2KYEGgTmQ=;
        b=HgzmlrMoHaEp2QDpO+SeYrntxar4sFUq5S/DaHuOJqIoLcl0JxCbRRo1Ov67bsN1Fi
         SfQNTfGloFXAehrE0S8iBNCQ8xgEY2oxB29ShP7FDotU2WN8nNJVj6rjOt3omSMv8xCX
         4+zPu1WdCEu9wDPKojwEMyWafp20QJvPWzSu6hZ6vgTBzql1/2uckHzHnbMvoFJ2/+PZ
         U/unmVN4JF4L/eQjRK3qJxwx+EarBn4qp6RrxKH8657w9JyI/anv7wKJvkkQ5je374Xw
         0bPdVqbZP75TrjR1cuMHho3hjbQTaO46XHVGm9MIUgr8EIiBG2NZ+7W0Ia0QS5TgxMGt
         nAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SM4c6aCM3ChivcVC2PDOr3ryhsZzNMPJHU2KYEGgTmQ=;
        b=SYP3S12jZWvSIqJD6lKgx4nzaHgrHdSC52KMCjiQWviA6s+YOAP9ANr/H6pC3c4ngp
         qO6wkIhp4J6CY6Yp4TX7rfASMmI9rX6NMEElnzQA5LtZHjamQPKaGeU6sXR6jhhczWRv
         Uvbs309uyRyZ2wqRHOSm5lZgd8LvAfi4GBakoQoY923sTWewMIBINKxccfvYEpcPBHgQ
         7onekR4d5Hv7kZpUxVI18RZZXvzgQrJGHhp1VNgNVhC12GNR3dzFMbin/fHgsLNlp1fO
         X3lHPd3xCpppm5wxjVBJKlIyqaqqKgCAgYjO/REDQrZpeiGQ+qp1aFQKJO5MRRdQ96rG
         TiPQ==
X-Gm-Message-State: AOAM530SVY7B84aV92CdvryYjcj1ia9BbiEl0J2VFfCsiB7gE5UsfKmM
        AK2gWM7liYWxHG74SdVPOj553OyPUe010ruG8Kzh
X-Google-Smtp-Source: ABdhPJzfOU9f00Wb4ZtDWq4me0Zt52nXSmjru3pGLjXLlkjWK+ob1wwNi5pQJ3Sl0teec2Xn2KeuB1UDswi3FqUaV3nF
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:642:: with SMTP id
 63mr22622715ybg.246.1604959745568; Mon, 09 Nov 2020 14:09:05 -0800 (PST)
Date:   Mon,  9 Nov 2020 14:09:03 -0800
In-Reply-To: <CABPp-BEyosjCpBr-8B19YXZV0mpn3oYAXoaaROKFNZQ+p4ZMnQ@mail.gmail.com>
Message-Id: <20201109220903.2536706-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BEyosjCpBr-8B19YXZV0mpn3oYAXoaaROKFNZQ+p4ZMnQ@mail.gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: Re: [PATCH v2 09/20] merge-ort: record stage and auxiliary info for
 every path
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > So these are placed in paths but not unmerged. I'm starting to wonder if
> > struct merge_options_internal should be called merge_options_state or
> > something, and each field having documentation about when they're used
> > (or better yet, have functions like collect_merge_info() return their
> > calculations in return values (which may be "out" parameters) instead of
> > in this struct).
> 
> Right, unmerged is only those paths that remain unmerged after all
> steps.  record_unmerged_index_entries() could simply walk over all
> entries in paths and pick out the ones that were unmerged, but
> process_entries() has to walk over all paths, determine whether they
> can be merged, and determine what to record for the resulting tree for
> each path.  So, having it stash away the unmerged stuff is a simple
> optimization.
> 
> Renaming to merge_options_state or even just merge_state would be fine
> -- but any renaming done here will also affect merge-recursive.[ch].
> See the definition of merge_options in merge-recursive.  (For history,
> merge-recursive.h stuffed state into merge_options, which risked funny
> misusage patterns and made the API unnecessarily complex...and made it
> suggest that alternative algorithms needed to have the same state.
> So, the state was moved to a merge_options_internal struct.  That's
> not to say we can't rename, but it does need to be done in
> merge-recursive as well.)

Ah, I see.

> As for having collect_merge_info() return their calculations in return
> values, would that just end with me returning a struct
> merge_options_internal?  Or did you want each return value added to
> the function signature?  Each return value in the function signature
> makes sense right now for this super-simplified initial 20 patches,
> but what about when this data structure gains all kind of
> rename-related state that is collected, updated, and passed between
> these areas?  I'd have a huge number of "out" and "in" fields to every
> function.  Eventually, merge_options_internal (or whatever it might be
> renamed to) expands to the following, where I have to first define an
> extra enum and two extra structs so that you know the definitions of
> new types that show up in merge_options_internal:

[snip enums and structs]

Good point. I should have realized that there would be much more to
track.

> > > +     result->string = fullpath;
> > > +     result->util = path_info;
> > > +}
> > > +
> > >  static int collect_merge_info_callback(int n,
> > >                                      unsigned long mask,
> > >                                      unsigned long dirmask,
> > > @@ -91,10 +136,12 @@ static int collect_merge_info_callback(int n,
> > >        */
> > >       struct merge_options *opt = info->data;
> > >       struct merge_options_internal *opti = opt->priv;
> > > -     struct conflict_info *ci;
> > > +     struct string_list_item pi;  /* Path Info */
> > > +     struct conflict_info *ci; /* pi.util when there's a conflict */
> >
> > Looking ahead to patch 10, this seems more like "pi.util unless we know
> > for sure that there's no conflict".
> 
> That's too long for the line to remain at 80 characters; it's 16
> characters over the limit.  ;-)

Well, you could move the description onto its own line :-)

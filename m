Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D30C2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 21:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942B7215A4
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 21:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R3WZE8Dn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgAaVuG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:50:06 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37548 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgAaVuG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 16:50:06 -0500
Received: by mail-qk1-f194.google.com with SMTP id 21so8131698qky.4
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 13:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aA10Na9PYyFnca0Wk0vKv+fCADysznQQf76NjDh2pEg=;
        b=R3WZE8Dn0k4ud0TW2PZEYyqKVWPVuYGANOmIenxpK6HleV1EoW66AQ9SBBM5B65cLa
         P/HLKx+cFZaByK1EthLKkH9HkzBB6TL5iUJuVsSNxhZCzEVAy6JhF2ksWABwpdJf1wpM
         7rFmNUKzFZdNCnJXgg/+9UqNRSrE2i3WkX7j483PP+RYt8f7p3tXZsaRRmkvAeZ5WEtt
         ZFFQyL9cPiMfwW4qDQQda4HRGF4WlWHClzqm1Ky3mkuO63iTOYxsNniZzEaFnokopimq
         fSe5+PnuQZxNh36OMYRk62eXfWYC4xeSBOu5JxMwjwPSvDifnfIm7Y4hdruKLHKYB1GR
         Pizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aA10Na9PYyFnca0Wk0vKv+fCADysznQQf76NjDh2pEg=;
        b=Z9yoVZipZyBlkvBkJB61MUS9iY+WN2LjsG7Lm2rEIPa3N0qaj4p+NEWbNEpPb+oHUI
         2nlA9jMkzACgSgP0KeMLpUyd36KZtbVxaiGpxAHVgS0/3lHDRjtz4esQYubMY+N7Kh8l
         LfccICdTJKK+7eg8Hyav3/EA6nteSZzP5O2dVdmOoGLB1xpJAG5Bsn4WKt3M2iWLlg1w
         9kGb+rtbs9ziwqRMev/yFgDMFSi4jLcJJ1Av+Rf9sfSy4CgLKe7PRvSVDNrugs3GxqVK
         W9QKZKx7dA3jtEf9klMDNMoYO/8VPUoX4LZWOZwvVyiSM4JTC/sSaWneQKUUVs+0wScH
         Fs4g==
X-Gm-Message-State: APjAAAWCNiAriV/W4SpcHKmi4u7FaHQDFqHUfN7zKhXeDQseeSMC/NCr
        W5Fr3nXxhHgQtTATto+P0E1TgARb0MqBWOgQBLHgCQ==
X-Google-Smtp-Source: APXvYqyuzX7CNeL6YFm72oVV+n4/UGH1m7fZ8PkBmWbLDrfglpvDzovQ3wFXCwhEYf3rCLIwlKNZyy1I7x8Suy9EMJM=
X-Received: by 2002:a37:6346:: with SMTP id x67mr13152555qkb.476.1580507404526;
 Fri, 31 Jan 2020 13:50:04 -0800 (PST)
MIME-Version: 1.0
References: <20200130225818.193825-1-masayasuzuki@google.com> <xmqqk1579xa4.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1579xa4.fsf@gitster-ct.c.googlers.com>
From:   Masaya Suzuki <masayasuzuki@google.com>
Date:   Fri, 31 Jan 2020 13:49:53 -0800
Message-ID: <CAJB1erXnNe0yGvL+wgU9RXAA6Vyx7T2dwM9NgCmUChOtL102NQ@mail.gmail.com>
Subject: Re: [PATCH] doc: describe Git bundle format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 31, 2020 at 12:38 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Masaya Suzuki <masayasuzuki@google.com> writes:
>
> > The bundle format was not documented. Describe the format with ABNF and
> > explain the meaning of each part.
>
> Thanks.
>
> >
> > Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
> > ---
> >  Documentation/technical/bundle-format.txt | 40 +++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >  create mode 100644 Documentation/technical/bundle-format.txt
> >
> > diff --git a/Documentation/technical/bundle-format.txt b/Documentation/technical/bundle-format.txt
> > new file mode 100644
> > index 0000000000..dbb80225b5
> > --- /dev/null
> > +++ b/Documentation/technical/bundle-format.txt
> > @@ -0,0 +1,40 @@
> > += Git bundle v2 format
> > +
> > +The Git bundle format is a format that represents both refs and Git objects.
> > +
> > +== Format
> > +
> > +We will use ABNF notation to define the Git bundle format. See
> > +protocol-common.txt for the details.
> > +
> > +----
> > +bundle    = signature references pack
> > +signature = "# v2 git bundle" LF
>
> Good.  "signature" is the name used by bundle.c::create_bundle() to
> call this part.
>
> > +references   = *(prerequisite / ref) LF
>
> This allows prereq and ref can come inter-mixed, but I think we show
> all prerequisites first before refs.

Based on bundle.c::parse_bundle_header(), I infer that this can be
mixed. If that's not intended, this can be changed to have
prerequisites first.

>
> > +prerequisite = "-" obj-id SP comment LF
> > +comment      = *CHAR
>
> Do readers know what CHAR consists of?  Anything other than NUL and
> LF?

RFC 5234 defines core rules
(https://tools.ietf.org/html/rfc5234#appendix-B.1), and these CHAR etc
are defined there. It should be OK to use these rules.

>
> > +ref          = obj-id SP refname LF
>
> OK.
>
> "prerequisite" and "ref" are both used in bundle.c::create_bundle(),
> so calling these parts with these names is consistent with the code.
> "head" is also a good name for the latter as "git bundle list-heads"
> is the way the end-users access them from outside.
>
> > +
> > +pack         = ... ; packfile
> > +----
> > +
> > +== Semantics
> > +
> > +A Git bundle consists of three parts.
> > +
> > +*   Prerequisites: Optional list of objects that are not included in the bundle
> > +    file. A bundle can reference these prerequisite objects (or it can reference
> > +    the objects reachable from the prerequisite objects). The bundle itself
> > +    might not contain those objects.
>
> While not incorrect per-se, the above misses the more important
> points (and defers the description to a later paragraph).  It is
> better to describe what it means to have prereqs upfront.
>
> > +*   References: Mapping of ref names to objects.
> > +*   Git objects: Commit, tree, blob, and tags. These are included in the pack
> > +    format.
> > +
>
> Match the name you used to descibe the parts in the earlier ABNF
> description, so that the correspondence is clear to the readers.
> You somehow used "references" to mean both prereqs and heads, but in
> the above you are describing only "heads" under the label of
> "references".

Yes. It should match with the ABNF definition above.

I usually use "heads" to mean "references under refs/heads/*" (not
sure if this is true for other people). Since a bundle can contain
tags etc., using "heads" here seems confusing. With prerequisites and
references split you mentioned above, I think I can make ABNF and this
semantics section consistent in terms of wording.

bundle = signature *prerequisite *ref LF pack
prerequisite = "-" obj-id SP comment LF
comment = *CHAR
reference = obj-id SP refname LF
pack = ... ; packfile

The terms ("prerequisite" and "reference") are consistent with
bundle.h::ref_list.

>
> Perhaps something like this?
>
>     * "Prerequisites" lists the objects that are NOT included in the
>       bundle and the receiver of the bundle MUST already have, in
>       order to use the data in the bundle.  The objects stored in
>       the bundle may refer to prerequiste objects and anything
>       reachable from them and/or expressed as a delta against
>       prerequisite objects.

I want to make sure the meaning of prerequisites.

1. Are they meant for a delta base? Or are they meant to represent a
partial/shallow state?

If these prerequisites are used as a delta base, the receiver of the
bundle MUST have them. If these prerequisites are the indicators of
the shallowness or the partialness of the repository, the pack data
would have complete data in terms of deltification (e.g. all objects
in the pack file can be undeltified with just the pack file), and the
bundle can be treated as a shallow-cloned/partially-cloned repository
snapshot.

From what I can see from bundle.c, I think it's an indicator of a
delta base, not an indicator of a shallow/partial state, but I want to
make sure.

2. Do they need to be commits? Or can they be any object type?

From what I can see, it seems that they should always be commits.

3. Does the receiver have to have all reachable objects from prerequisites?

My understanding is "Yes, the receiver must have all reachable objects
from prerequisites." This means that if a receiver has a
shallow-cloned repository, they might not be able to proceess a bundle
with prerequisites. The bundle's pack part can deltify against the
objects that exist beyond the shallow depth.

>
>     * "Heads" record the tips of the history graph, iow, what the
>       receiver of the bundle CAN "git fetch" from it.
>
>     * "Pack" is the pack data stream "git fetch" would send, if you
>       fetch from a repository that has the references recorded in
>       the "Heads" above into a repository that has references
>       pointing at the objects listed in "Prerequisites" above.

I'll adopt this in the next patch.

>
> > +If a bundle contains prerequisites, it means the bundle has a thin pack and the
> > +bundle alone is not enough for resolving all objects. When you read such
> > +bundles, you should have those missing objects beforehand.
>
> With the above rewrite, this paragraph is unneeded.
>
> > +In the bundle format, there can be a comment following a prerequisite obj-id.
> > +This is a comment and it has no specific meaning. When you write a bundle, you
> > +can put any string here. When you read a bundle, you can ignore this part.
>
> Is it "you can"?  At least the last one should be "readers of a
> bundle MUST ignore the comment", I think.

I'll change this to MUST.

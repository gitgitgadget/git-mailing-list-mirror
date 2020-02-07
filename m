Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A2BC2BA83
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 22:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A371B20720
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 22:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qXjimbsb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgBGWVu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 17:21:50 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38146 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgBGWVu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 17:21:50 -0500
Received: by mail-qk1-f193.google.com with SMTP id p10so535735qkk.5
        for <git@vger.kernel.org>; Fri, 07 Feb 2020 14:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dAnUd63oHXMCaJNfBamZgWKb7E/Tb76LALtPSXyUZKQ=;
        b=qXjimbsbyRLa/9AFudGxDB1ldn9dmWOp9Cl99fEHs15nZAox+THIsODjOaNFV69ZKc
         GlTfSPFIPil3B4mCBqoWrVItgE7FamItVu/wQDXWuWKl5uTUDKDCT9Y48o+VcnT+Os0t
         Qsz0R7SIl/VOnCduJwd2IvIO8AEali4g6CZuB15o7z2Wilc2J/hhKgslRVNfIqWLSifK
         RBQYHvNFsTB18VFQg6r63Vr0023cBFPEI79WB3V1pC932BWDECDj+5wAwGInevvVm9WZ
         4eBvDn0bUFTitdkqRrByYh2lK8Tme0tB21pjLy9omxuPdOz8RD5jtjf5n7LYEQ+NTQS+
         J6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dAnUd63oHXMCaJNfBamZgWKb7E/Tb76LALtPSXyUZKQ=;
        b=bUqapA0zVmtt8ER1MqQE5EHRuZZlpso3GA/PZ2qPzpFEoPQrTkplWlLThWKUo/y+ZX
         tevk3vMdrwGRejvwWTqvgf2BhtbiqLga0zAQGMsm0yjWRxfytYM9ZUSmJdWqNKyKGKTd
         mkz8XyPsk+xuVNjV5Q3wwVPgxVx4f4JIsyfnvTdW2s8O7EdxUufUV7J1hYs9OwoBDABd
         41OuUvkEKlfMfO7SFqfKSNC+6Ei0OzDKx5JNb5XiIntqSpJEVIYc/m0RMkck0+TxOR2g
         Q7w3F2qIUrV4Ghwy5IGzxeW4KQeiWa3MOwfwKyNtTNjc+ZAEzFSkxqF1cx8UkF23R7bG
         jtRg==
X-Gm-Message-State: APjAAAUSAZcmpBf49koRTAa+fHdQNTbKrk9uxCwFQvsBzJPkU+7Ykg2C
        aw+Z8FyCEPJ51CWfQ+zhWZldU0d5vYm6R+mjyjuyLA==
X-Google-Smtp-Source: APXvYqxMvtzH6+svbH9M5ItIHI2/1tuUNx/taNN/PS+tAc/O+LUddphxMKjO9oTKqtW9+KvUXzO5a42sX9LaMAFPcQs=
X-Received: by 2002:a37:4b48:: with SMTP id y69mr1141592qka.216.1581114109017;
 Fri, 07 Feb 2020 14:21:49 -0800 (PST)
MIME-Version: 1.0
References: <20200131221800.240352-1-masayasuzuki@google.com>
 <20200207204225.123764-1-masayasuzuki@google.com> <CAJB1erXMR_aCqVPsH6WQZdC7yybOBCUbwkJDv3LtU2f0ymNmbQ@mail.gmail.com>
 <xmqqlfpe2jx3.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlfpe2jx3.fsf@gitster-ct.c.googlers.com>
From:   Masaya Suzuki <masayasuzuki@google.com>
Date:   Fri, 7 Feb 2020 14:21:37 -0800
Message-ID: <CAJB1erVZ5E6FxtD8gJXXpzJjquvksLxpz+h1TzG52Yr9DFmDRQ@mail.gmail.com>
Subject: Re: [PATCH v3] doc: describe Git bundle format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 7, 2020 at 12:59 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Masaya Suzuki <masayasuzuki@google.com> writes:
>
> > On Fri, Feb 7, 2020 at 12:42 PM Masaya Suzuki <masayasuzuki@google.com> wrote:
> >> +=== Note on the shallow clone and a Git bundle
> >> +
> >> +Note that the prerequisites does not represent a shallow-clone boundary. The
> >
> > the prerequisites do not
>
> Grammo aside, I am not sure if that particular Note is beneficial to
> begin with.  I would imagine that you can get a bundle that holds
> all the objects in a shallow repository by specifying the range that
> match the shallow-clone boundary when you run "git bundle create"
> while disabling thin-pack generation.

Yes. The reason that I've been trying to check the semantics of the
prerequisites is that I DO recognize that this is possible
format-wise. I'm not sure if this Git implementation can create such
bundles, but format-wise such bundles can be created.

When writing a Git bundle parser in other implementations (like JGit),
it's not clear whether, as a library, I should support such use cases.
If such usage is supported in the format, then the semantics of the
prerequisites changes. Currently the prerequisites are defined as the
objects that are NOT included in the bundle, and the reader of the
bundle MUST already have, in order to use the data in the bundle. If
the format supports shallow-cloned repository, this will be defined as
the objects that are NOT included in the bundle. If the reader wants
to read this bundle as if it's a non-shallow clone, the reader of the
bundle MUST have the objects that are reachable from these
prerequisites. If the reader wants to read this bundle as if it's a
shallow clone, the reader MUST treat these as a shallow boundary.

Also, this change will put further restrictions on the pack. "Pack" is
the pack data stream "git fetch" would send. If the writer of a bundle
wants to write as a shallow-clone pack, the pack MUST NOT reference
objects outside of the shallow boundary from the pack file as a delta
base. The writer MAY reference the commit objects outside of the
shallow boundary as a parent.

The readers and the writers of bundles MUST communicate whether a
bundle represents a shallow clone repository in other means. The
bundle file does not have any indicator whether it's a shallow clone
bundle or not.

> The support of shallow-clone by Git may be incomplete and it may not
> be easy to form such a range, and "git bundle create" command may
> not have a knob to disable thin-pack generation, but that does not
> mean that the bundle *format* cannot be used to represent the
> shallow boundary.

As I wrote above, if this bundle format supports the shallow clone
state, the semantics will change and writers and readers have
different constraints on the packs. In order to do so, the readers and
the writers have to agree whether it's a shallow clone or not in other
mean since the bundle file doesn't have such indicators. I think it's
better to prohibit such use cases (or at least make it as unintended
usage), and then create a different bundle format version that
supports shallow clone boundary (so that the bundle file can be more
close to the frozen git-fetch response).

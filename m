Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23165C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 21:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9279620825
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 21:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRZlH61x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgKKVWG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 16:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKVWG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 16:22:06 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43342C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 13:22:06 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id u127so3832881oib.6
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 13:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fVzn+RsmKnXFYKfqd63X/CbkMpu8KQHbEZdUkW4xj0U=;
        b=qRZlH61x8PUZR1fizh+hBjMB8Z181/uPxp4e+kJcUiFg2OlfhQabtFJndoos/kssky
         9pkwiRkz1vixActMgr/SPssLUHuGJ8lG4kz6uv/xijnXasExer28zlZM5L9REr8xQRU2
         ZF7iYvB7dr2TocPCBh+nIFu1Jbi98qod7JpWPqRAY/uycNdmmdAGe/H5sLPlHsnXmgdE
         tLSIWrsxPuuQqXzhwkmeYzOAzn0I60GWaBeXCCBpoIomx9jKuF11OSZ+XYn8JMCH/jvI
         wlwev9rgw7mzGl4hYQgV8xnxfGu+r6B+I3O1zAU8Zl5YkOAsw8Rxf7uJIhbCgbiN1im9
         I4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fVzn+RsmKnXFYKfqd63X/CbkMpu8KQHbEZdUkW4xj0U=;
        b=YiYGgyQnezSIy2tOuvC8mRWS2vsPtvzWUfsanJFJ5MzgPEvzkaq9Gtz9lFFQHHPfaF
         2NtAzfnEruygInmmP7YqDY9JaIJs+US55NKInzEyTNS8iSpzUzvqKGz51G1P4zNUwfJv
         FFlvAkxmvDNMLBvyK1AhsjjvKIt5MQSBEydd6sCbibv4rw7j+jW7NgJOnUAgUqo7ZP33
         chTe7MBzgf7oLY0eF/IdVF+/l9i6nDU/vxQUwPjKKZis2TwISunFn7P9vaOWWYN4a/e7
         HEBH4pgbu5+O2doRtg3CKJeEjTe5QhLr1cpYy/a8AWWAb1ewABPHthFtHqa+iyICyIDL
         HEEg==
X-Gm-Message-State: AOAM533j0cByxQ8ZwI77GHpdv3FVauxbFVNv0PTmEXyeYUQuSIe/Ijx5
        jkNmubNmTBN19sng+QPlJZYyu/HuwONPlNdFM8E=
X-Google-Smtp-Source: ABdhPJxEX9WPVJmk9/jaQj51TvKucKzvWK0zZ0cqmOpVCP3nI4J/r7ulI7bTAl7bSPouHzPVVDOrb6H07U3/1Vs2zuQ=
X-Received: by 2002:aca:b4d7:: with SMTP id d206mr3609564oif.39.1605129725527;
 Wed, 11 Nov 2020 13:22:05 -0800 (PST)
MIME-Version: 1.0
References: <20201102204344.342633-15-newren@gmail.com> <20201111204707.3126694-1-jonathantanmy@google.com>
In-Reply-To: <20201111204707.3126694-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 11 Nov 2020 13:21:54 -0800
Message-ID: <CABPp-BF+wX4nRnVNJLFKqKhjop1nL948SyhYRs2Tx3rErDa8sw@mail.gmail.com>
Subject: Re: [PATCH v2 14/20] merge-ort: step 2 of tree writing -- function to
 create tree object
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 11, 2020 at 12:47 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > +static void write_tree(struct object_id *result_oid,
> > +                    struct string_list *versions,
> > +                    unsigned int offset)
> > +{
> > +     size_t maxlen = 0;
> > +     unsigned int nr = versions->nr - offset;
> > +     struct strbuf buf = STRBUF_INIT;
> > +     struct string_list relevant_entries = STRING_LIST_INIT_NODUP;
> > +     int i;
> > +
> > +     /*
> > +      * We want to sort the last (versions->nr-offset) entries in versions.
> > +      * Do so by abusing the string_list API a bit: make another string_list
> > +      * that contains just those entries and then sort them.
> > +      *
> > +      * We won't use relevant_entries again and will let it just pop off the
> > +      * stack, so there won't be allocation worries or anything.
> > +      */
> > +     relevant_entries.items = versions->items + offset;
> > +     relevant_entries.nr = versions->nr - offset;
> > +     string_list_sort(&relevant_entries);
> > +
> > +     /* Pre-allocate some space in buf */
> > +     for (i = 0; i < nr; i++) {
> > +             maxlen += strlen(versions->items[offset+i].string) + 34;
>
> Probably should include the_hash_algo->rawsz instead of hardcoding 34.

Ah, indeed.  And I should submit a patch for fast-import.c to update
it to not hardcode 34 either (though I'll submit the fast-import
change separate from this series).

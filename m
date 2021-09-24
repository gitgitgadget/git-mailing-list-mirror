Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE63C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39BFB60F24
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348106AbhIXSYY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345973AbhIXSYX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 14:24:23 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B91C061571
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 11:22:50 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id w10-20020ac87e8a000000b002a68361412bso35579479qtj.7
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 11:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0R1gRdMISnUt0JCrRiWenI7ox+5/Mr0K7w905+KY0bA=;
        b=Fa4GJYzVV4gT8kPcLN9Y6fAHQQHbQDPIFdieJPsmkI1cX1ObwYbquX/EZapTd13XL6
         6TTpb0osNVStwFnewfrhoKODjHL6McXWBbPin47nmMhHwBSDz37/qgT0r8fljgMdS6Oq
         mJANFJV/RRUIZVa/5zpmpRRXgXmorfLPO1Nq0C3W14qe7SYzyAgFsK8tziqIp5iMwprq
         4nPKfx8dz24BGear5c1T6z4didUlD0hpnD+xI8SgJ4Cc3YX7dtGWqGOswrzvPilxCLPV
         Rjxd3IDQpIUF55nKqf+EtPEQ+Q6Td9eJhdW6bKsqkyLn+gd9qoiNdLZWaAB44sSn+95T
         6oAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0R1gRdMISnUt0JCrRiWenI7ox+5/Mr0K7w905+KY0bA=;
        b=3WTKmOCUSG3cr71ieOejlzb5t+Vl5G4p5fUSAWJJ6q9CEuok635BpAeUfTBPlInut2
         svN6dBRe5ZzP1E7CksXeC3kab+upBnMHJ+f0dxF9b67Y4YBOl8orkmhZtAAP4ixhJTf2
         HHdY1puHgiwt3aHlsLJaA+e4w0zDUD6fsJZLsMT4p89eCdmf2CVva8bOm42wkokl4ch4
         ZkmcdTbsDUXO0yb/Ar11u6PChz7RxgataX/YSh6DEGxx6gR2WGKdk/Hao4oZHshZHp7o
         DieSHjqb4cIRsfaPOKW/2uVWpsqlMv4DZGIWSWz6bizBPopmYjnS6728CntA16hP01Do
         /Wvw==
X-Gm-Message-State: AOAM532i10Kfu/T5XaNKCwcLlvfJQnDulTqDZGnKHNdQE7hSzH7WQ5DY
        K+LckmfJTMSUnZR6E0C2oWJ7VyYIs3Cq4qPI/fb6
X-Google-Smtp-Source: ABdhPJycJQOSJeJp1fwRbqtx3xL3TGORj629SOQBBRdj2ElWhiUPTUexk+F4YxdB7F93YNBkYNBk7ZRUHIHhBj/no7zr
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:689:: with SMTP id
 r9mr11671141qvz.37.1632507769679; Fri, 24 Sep 2021 11:22:49 -0700 (PDT)
Date:   Fri, 24 Sep 2021 11:22:47 -0700
In-Reply-To: <eb24b308ecdbd7736fc63927130540abd0a668db.1631730270.git.me@ttaylorr.com>
Message-Id: <20210924182247.2922561-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <eb24b308ecdbd7736fc63927130540abd0a668db.1631730270.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: Re: [PATCH v2 8/8] builtin/repack.c: pass `--refs-snapshot` when
 writing bitmaps
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
        avarab@gmail.com, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +static void midx_snapshot_refs(struct tempfile *f)
> +{
> +	struct midx_snapshot_ref_data data;
> +	const struct string_list *preferred = bitmap_preferred_tips(the_repository);
> +
> +	data.f = f;
> +	oidset_init(&data.seen, 0);
> +
> +	if (!fdopen_tempfile(f, "w"))
> +		 die(_("could not open tempfile %s for writing"),
> +		     get_tempfile_path(f));
> +
> +	if (preferred) {
> +		struct string_list_item *item;
> +
> +		data.preferred = 1;
> +		for_each_string_list_item(item, preferred)
> +			for_each_ref_in(item->string, midx_snapshot_ref_one, &data);
> +		data.preferred = 0;
> +	}
> +
> +	for_each_ref(midx_snapshot_ref_one, &data);

One small thing here - I think "data.preferred = 0;" needs to be moved
to right above this for_each_ref line. As it is, if preferred is NULL,
data.preferred wouldn't be initialized.

Other than that (and the minor changes I've suggested in previous
patches), this series looks good to me.

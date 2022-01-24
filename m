Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB26C4332F
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 19:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348486AbiAXT7X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358007AbiAXTxl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 14:53:41 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA5FC0619C5
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:27:05 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id u24-20020a656718000000b0035e911d79edso2153708pgf.1
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SIEJz3Pspgp8KlTCUxEDh5L5nIapu4nwPa7yruEdvwc=;
        b=Ry/HYp1NEYoUaQXHO1BM/+nAUU+nHL7FAQsNv6lU//mu/8U9OBAOSzaaa2Zm/jhboS
         ApaALBslaVkFdb7ejhGGmFtIjPXLjNibXZ4QUN1hqsn6REvojhvFypUcpqJYTTEP6j9n
         KG136qXLlsKkx55Oe3189MapNKfN6ylFa7K5iTVHk/bNRNlPJBvNjb9tEiFhQNxbn188
         kOIyklmVbUIohpThRbD32yAnDOGQvJ0w0fmWeUjEdj/XfZqK03i8eELNim36rqu2But/
         Wl3YlNOnLP5/ZE/IL9wKelTQWep+XfhxIU95asXjPNxCbFqtEjOmd7mGv8dMKM2UjrKo
         lMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SIEJz3Pspgp8KlTCUxEDh5L5nIapu4nwPa7yruEdvwc=;
        b=29dlsZPjsJ8x25oUy4LhRSxRT4GeXVlvVGawSFU6firk3tGCyx1o6s4UYRFnD4/LWb
         i3DU/D6PrrAMzqvgZTVgMgrW84bK24P2K8FUSe5k+My1K5ykKPzLZca/iD6a4qILd/Gp
         bLZ5pSV6LyUutg1cIKJP5wzdRX6RwbGa97fKlU19VDGHjZMRe5cVFqzAt0XUmkBY5jEM
         jNitpe0BpfxCPThm18HBPyXXjE1iJU3A/d6enM4nbB6QPJz/BUaTv3BeD1JfsY4mMvZR
         luY8H6RlcT1b3IkN8UkhTh2Zn2qcJW/aGS4XXDgahB038eXehlRYWmJ6yTaGLeYJYBHQ
         ng7Q==
X-Gm-Message-State: AOAM530Pnddqve+HTobQY5W3GFx5qBfqAinR2Xga+QIs7rrixJ6ggqs3
        JTOdqnmju4D/Ks4LW9FoUuhDEbDaay/tDlLQsmSx
X-Google-Smtp-Source: ABdhPJwcfnaliGu8yYjOB9IcThDPLl5wFQsXk/Rd2V3jbG/fC0vKyk4XFcLNkhETFWQflH6khvjb9T8zTluiEk/xvuGL
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:4ac6:: with SMTP id
 mh6mr3409477pjb.23.1643052424592; Mon, 24 Jan 2022 11:27:04 -0800 (PST)
Date:   Mon, 24 Jan 2022 11:27:01 -0800
In-Reply-To: <55aa69de12c5f82a66836e829f915363cc73b421.1641320129.git.me@ttaylorr.com>
Message-Id: <20220124192702.2452750-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <55aa69de12c5f82a66836e829f915363cc73b421.1641320129.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: Re: [PATCH v3 8/9] midx: read `RIDX` chunk when present
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> When a MIDX contains the new `RIDX` chunk, ensure that the reverse index
> is read from it instead of the on-disk .rev file. Since we need to
> encode the object order in the MIDX itself for correctness reasons,
> there is no point in storing the same data again outside of the MIDX.
> 
> So, this patch stops writing separate .rev files, and reads it out of
> the MIDX itself. This is possible to do with relatively little new code,
> since the format of the RIDX chunk is identical to the data in the .rev
> file. In other words, we can implement this by pointing the
> `revindex_data` field at the reverse index chunk of the MIDX instead of
> the .rev file without any other changes.

Ah, that's great.

> Note that we have two knobs that are adjusted for the new tests:
> GIT_TEST_MIDX_WRITE_REV and GIT_TEST_MIDX_READ_RIDX. The former controls
> whether the MIDX .rev is written at all, and the latter controls whether
> we read the MIDX's RIDX chunk.
> 
> Both are necessary to ensure that the test added at the beginning of
> this series continues to work. This is because we always need to write
> the RIDX chunk in the MIDX in order to change its checksum, but we want
> to make sure reading the existing .rev file still works (since the RIDX
> chunk takes precedence by default).

Could we disable the beginning-of-this-series test when the MIDX .rev is
not written instead? Then, we can test what the user would actually
experience (no reverse index in .midx, reverse index in .rev) instead of
simulating it by skipping over the reverse index section in .midx.

If we can't do that, then I would agree that the approach in this patch
seems like the best approach.

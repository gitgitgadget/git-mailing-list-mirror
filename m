Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99081C433EF
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 20:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiDLUTI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 16:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbiDLUTA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 16:19:00 -0400
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CE2BD2D8
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 13:16:34 -0700 (PDT)
Received: by mail-pl1-f202.google.com with SMTP id z5-20020a170902ccc500b0015716eaec65so5977450ple.14
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 13:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=4aBIKyoL+SSj83TvWhcgDx/3LJUatTIVizOAgravpLY=;
        b=oFsORFETMHJ5G42ai/koCcq2DyVPnMyuEV3oyTnWkX05Auk5QSNE5RaStwv+cd/Dsp
         cu/e01IJzrPUVmz5JqWwTcTIq7C/I2bZIUWTkcSSwD366nz+zC0bSgn/cfg1C4L1oEMw
         o7oWHOgIpKy9boj8CXgHdMmLLLfZnKNfyDhP8QK0nmQ0pQRnulpPHi+WaBH7kkGtfpOI
         iJ+0hMqsWdoBgdybidLCMSx8sjtbcySyeM8m2UtO9fl6F03/OycSQrx0Eifmiid6otBE
         chCXmHkJ0fnWXOxaZn73VPxD5kqsl3AOr3xm4X/eS0ilAxWgFAljQhZ+zccpWmiYUr0C
         Tl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=4aBIKyoL+SSj83TvWhcgDx/3LJUatTIVizOAgravpLY=;
        b=icVKpnWomUnCJzxZ0nswYqhHxHowJlDtWb3985Pq+xpTOEX6eM+D+dZw3mGALC0Vhu
         xR/yIj0V0x9Nh6rb9L06wqxwGbHHE2XpV0TdfQhnf7S9ez2lawTf5uDVRZMp+TZMSyxA
         wawAuWCh6Vo69ruXBc5L/U43tL75z8+E3j1fPMg5QqAD8IgKoP4fRrLlzdkh2CkqJpU3
         n7FSggPlhTL1zrgfVjRC29+ewYqpYipCqB8w6axcVNWCsyKsiTdfiX+hBI62ljjenFvF
         u9E0S9CtoirY7w0L1RE52tnwtK/+PU/qNGOSZ5pSOTPnHzLEn/b/VlXDje2QVSi3jwKn
         rpTA==
X-Gm-Message-State: AOAM533b9I3qYj1Nu77YgqfWenGP9RVQv3BFp5/93k2jxmFNvyysKIIT
        eDoM6zJShy2kLXie+fGKOdOx5/14J5U4Yk01umQQ
X-Google-Smtp-Source: ABdhPJz5uge8maApVY4zaYOKis4PNmwRK4a7toI4L2qQ7kRCxESAvkuuwzfd9X1OKiO9ZBIEcHM6VyqRO8WwxTtdZmJA
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:3083:0:b0:505:f7ac:c4a6 with
 SMTP id w125-20020a623083000000b00505f7acc4a6mr5573710pfw.66.1649794478903;
 Tue, 12 Apr 2022 13:14:38 -0700 (PDT)
Date:   Tue, 12 Apr 2022 13:14:34 -0700
In-Reply-To: <20220407215352.3491567-5-sandals@crustytoothpaste.net>
Message-Id: <20220412201435.803424-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: Re: [PATCH v4 4/4] builtin/stash: provide a way to import stashes
 from a ref
From:   Jonathan Tan <jonathantanmy@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:
> Now that we have a way to export stashes to a ref, let's provide a way
> +	/*
> +	 * Now, walk each entry, adding it to the stash as a normal stash
> +	 * commit.
> +	 */
> +	for (i = items.nr - 1; i >= 0; i--) {
> +		unsigned long bufsize;
> +		const char *p;
> +		const struct object_id *oid = items.oid + i;
> +
> +		this = lookup_commit_reference(the_repository, oid);
> +		buffer = get_commit_buffer(this, &bufsize);
> +		if (!buffer) {
> +			res = -1;
> +			error(_("cannot read commit buffer for %s"), oid_to_hex(oid));
> +			goto out;
> +		}
> +
> +		p = memmem(buffer, bufsize, "\n\n", 2);
> +		if (!p) {
> +			res = -1;
> +			error(_("cannot parse commit %s"), oid_to_hex(oid));
> +			goto out;
> +		}
> +
> +		p += 2;
> +		msg = xmemdupz(p, bufsize - (p - buffer));
> +		unuse_commit_buffer(this, buffer);
> +		buffer = NULL;
> +
> +		if (do_store_stash(oid, msg, 1)) {

This seems like you're using the commit message as the reflog message -
is this necessary? For what it's worth, all tests still pass if I
replace "msg" with "NULL".

Other than that, everything looks good to me.

It might be worth adding tests that check that the exported stashes are
in the expected format (to ensure that we can read stashes exported from
another Git version) but I don't think that has to block the submission
of this patch set.

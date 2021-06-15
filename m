Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF768C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 18:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D40FC6128B
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 18:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhFOSwW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 14:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhFOSwU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 14:52:20 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D00C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 11:50:15 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id p7so28672644lfg.4
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 11:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WKPv0RmrQiA14h5BFpznkjlzm9hgMu4mdKOhFX45IIk=;
        b=nK6BoKCHtoKmzNqWZ/cKNitDyNW1ygdwqZsDfvmH+ZSEOHyW24EJskQUysNWDZsTSz
         L4USMWnuSq0k6U7iLm8YTcDchP6FaKJ2o7P+zJk/8BonjTe5VyOAj0DoJYMNgUjduwNX
         f1cF08pKkeaqBY25iFShYrnXIJNjSjGbZjaRmMPGIEdJxRIP3cEHcZeKN0vnTRmbWfyu
         U9qxS8mGCVYQUmRSgaLBY1L7wZFQdcApivCXNxABZJzttACLtdJ+f9DSTIF/2Q03URos
         +pZXbdypzGD8DfsXboWR01GDchEWEogociQrrQvaybMJOL4iczou2aoRv91JS6iYIf5M
         usEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=WKPv0RmrQiA14h5BFpznkjlzm9hgMu4mdKOhFX45IIk=;
        b=T6TDNqIUw3L4hb4La03GbCoMPBX8Ru5JiI3ZfFJGQ5EcI//DLEyC+9PO9mgpJls0VD
         EIC0PRO/ejm9EAXgqVV0tmMb0MIu0uiGOeokl57/PEnm6oEnCBXgewFh/a7XK+Qz7qfY
         bFrK4pvHwcwFVv2QXfxTnDYVINcGBiKBIeWytdyODcAoNIklBvq+U8TW7WAXO/xHPTq7
         tGUd/lV5XttFJM8WVhND9+0oazdmS31n+p2W3xPLpA2SzkEOZStCcxsiPPUYGmItx9+T
         9UfpUjaecO5e+kDs/MOsQG4yaUffoS/bgwvDC9jHFO5LCELeQludEoxmr6k9u4aV9+h1
         kzkA==
X-Gm-Message-State: AOAM532PqIA6hfS91CUrsmN85dEH3nWDlp31fc4XCnBmQcAsYZ7JSUNu
        BjOH79R2UyiCx68dXGhCHbGLR5SiAxk=
X-Google-Smtp-Source: ABdhPJxdgrgHAC0Vw882unvOZCb/CymOOH+hw+r0SrsGs/OBJU0xF9SiOjYGP/aBu8XRuHFbqtrAjA==
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr586338lfm.13.1623783013494;
        Tue, 15 Jun 2021 11:50:13 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t12sm2247558ljk.116.2021.06.15.11.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 11:50:12 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] xdiff: implement a zealous diff3, or "zdiff3"
References: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
        <b7561a67c192d4bdede47fee5b7b1cb30c44b785.1623734171.git.gitgitgadget@gmail.com>
        <60c8758c80e13_e633208f7@natae.notmuch>
        <CABPp-BHjXf88MQYX8Fd3WGw2WfbMKAdAD-MEViiB7oTtQbfTyw@mail.gmail.com>
Date:   Tue, 15 Jun 2021 21:50:12 +0300
In-Reply-To: <CABPp-BHjXf88MQYX8Fd3WGw2WfbMKAdAD-MEViiB7oTtQbfTyw@mail.gmail.com>
        (Elijah Newren's message of "Tue, 15 Jun 2021 11:12:35 -0700")
Message-ID: <8735tj2c9n.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Jun 15, 2021 at 2:40 AM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>>
>> Elijah Newren via GitGitGadget wrote:
>> > From: Elijah Newren <newren@gmail.com>
>> >
>> > "zdiff3" is identical to ordinary diff3 except that it allows compaction
>> > of common lines on the two sides of history at the beginning or end of
>> > the conflict hunk.
>>
>> That was not the main reason behind zdiff3.
>>
>> The whole point of zdiff3 was to have something closer to the "merge"
>> style, even if not technically correct.
>>
>> Your proposal is better than diff3 in that respect, but worse than Uwe's
>> zdiff3.
>>
>> If you have this:
>>
>>   l  b  r
>>   =  =  =
>>   A  A  A
>>
>>   B     b
>>   C     C
>>   D     D
>>   E     E
>>   F     F
>>   I     i
>>
>> merge will output this:
>>
>>   A
>>
>>   <<<<<<< l
>>   B
>>   =======
>>   b
>>   >>>>>>> r
>>   C
>>   D
>>   E
>>   F
>>   <<<<<<< l
>>   I
>>   =======
>>   i
>>   >>>>>>> r
>>
>> This is simple, and useful.
>>
>> diff3 will output this:
>>
>>   A
>>   <<<<<<< l
>>
>>   B
>>   C
>>   D
>>   E
>>   F
>>   I
>>   ||||||| b
>>   =======
>>
>>   b
>>   C
>>   D
>>   E
>>   F
>>   i
>>   >>>>>>> r
>>
>> Not very friendly.

For me it's friendly enough. One key-press in Emacs and I get:

--- upper/xx.txt
+++ lower/xx.txt
@@ -1,7 +1,7 @@
 
-B
+b
 C
 D
 E
 F
-I
+i

In a separate window, that is roughly what you've get in the "merge"
output in the first place, but even more compact.

My point is that once Git provides enough context, a good interactive
tool will do the rest just fine, beneficial to the end-user.

-- Sergey Organov

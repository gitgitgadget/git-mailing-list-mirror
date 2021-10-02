Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A700C433EF
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 09:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39BE26136A
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 09:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhJBJ00 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 05:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbhJBJ00 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 05:26:26 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE9CC061570
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 02:24:40 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id bd28so43553963edb.9
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 02:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=e7nWoX47PWSUGOYND2bG7JiqYrpRtEkdXZEemLIzPUc=;
        b=eoRx+ZV2hmPnHfu0w49Z8W3OXnXf66aw0QpxAqLE+2Pn5+V+6sBGezXgFKTsd5YPku
         AFYTWDiFvw2sJ09tOZevoSzm/YjYhHCxzKU04srakX5kzRRj5SoH/naVSGzLApJZRCD6
         qrBBlmSjUtPND6ipwyTjvemWkrc52OIALIc3j4CYnNMqEX81f8UzLE7bGqIO93UAgRr0
         wXW0bUbhdAmWMumzPJ1RGvoSBlIJbZo/Uciq/KefLvNPHblPFoe0Iqu+PjA8s4Xga0ya
         wMdt35LOlrJEzMdz8FlJS58CdfJ1lfsez6WTfNSGDW16oFiiFpQNeJ6rK3Tnacn4EaQ5
         +4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=e7nWoX47PWSUGOYND2bG7JiqYrpRtEkdXZEemLIzPUc=;
        b=TTBSjX8Axk61bmF41K1Qe085GS2YqQqjmVe03dNDaxJjgNZXgF3QS5scCOsAAaEOXq
         8zxiH3KR5+Znvv6c0NlMIJqSl1JKMWe0skoHmWyY1BGMJspmw3uP8Z41idgmM7eqbGO6
         5OsPWeLv0uU86+XwFMRsZc7Vwf6MT9wJlLmpn0isFtrMOsSIq5P5j+LTixqr0JkkY6iy
         tT6GgIDXDldk00TY1Cmw+i3RIVbQ9zKWkjo/oTJZwbAMJc6ik5bIiLPZ8RyhOoqPNXoF
         8FlMfzzLaew8Nc/7W49lTBT7coVMKEZ5z9jgy8JabJqQLXhzDFYSp8Vi/B2GhQmiDSGN
         pTMQ==
X-Gm-Message-State: AOAM533/9YQyPgs/02ZoZgpstT4epUL/F2PoFTi3TfiFFD8toIO0zX2r
        n6fe2IxZWed1WKo4ho6Yoikv7OJez25E/g==
X-Google-Smtp-Source: ABdhPJyw+PHvFj3OreRmOBc9R06fj08qzGVB+jbSHaDvaFFdeae46m88H/wHGRX1amcUyMmFAcWwUA==
X-Received: by 2002:a05:6402:348c:: with SMTP id v12mr2800440edc.323.1633166679184;
        Sat, 02 Oct 2021 02:24:39 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bj10sm3915397ejb.17.2021.10.02.02.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 02:24:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v3 00/19] Adds reftable library code from
 https://github.com/hanwen/reftable.
Date:   Sat, 02 Oct 2021 11:20:29 +0200
References: <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
 <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
 <xmqqtui4k1j5.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqtui4k1j5.fsf@gitster.g>
Message-ID: <875yufpynd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 28 2021, Junio C Hamano wrote:

> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> The reftable format is described in Documentation/technical/reftable.txt.
>>
>> This is a fully reentrant implementation of reading and writing the reftable
>> file format, and should be suitable for embedding in libgit2 too. It does
>> not hook the code up to git to function as a ref storage backend yet.
>
> Elsewhere you solicited comments on the "RFC - add LICENSE" step.
>
> As long as the copyright holders of this library are happy with BSD,
> I do not see a problem with your plan in which the project borrows
> this code under the license and then owns it, giving access to
> others under the same license.
>
> If somebody sees problems with it, please raise your hands ;-)

No objection, but as noted in previous discussions about it I think we
should have some clarity about what it means for contributors. I.e. that
when they're contributing to reftable/ it's BSD license, but for the
rest of the codebase it's GPLv2.

I've just submitted a series to address that more generally:
https://lore.kernel.org/git/cover-0.5-00000000000-20211002T091212Z-avarab@gmail.com/

I think with that clarification of what these in-tree subdirectory
"COPYING" files mean the only thing left is for the "RFC" label to be
dropped here.

From what I as not-a-lawyer think I know about how licenses work the
concept that we can have BSD licensed content in-tree that can be
extracted and legally used by anyone outside of it seems rather dubious.

I.e. if I author a cross-tree where "reftable/" uses some updated API,
isn't the result a derived work and now GPLv2 and not "cleanly" BSD
licensed? But that's a separate question, and ultimately a worry for any
out-of-tree users. So I don't really care. I also believe that we've had
that situation before with (I think) libgit2 taking snapshots of our
"xdiff", so maybe it's already deemed to be a complete non-issue.

All I'd like is for contributors to git.git not to be confused, which I
think with my series above won't be the case.

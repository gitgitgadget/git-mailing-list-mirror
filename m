Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959F6C2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 17:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243944AbiAZRvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 12:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243935AbiAZRva (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 12:51:30 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F17C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 09:51:30 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id s5so286869ejx.2
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 09:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=zjJuhmUcpn1FM3ZXSuk2oyywHIEb498XKkFkd2ZHQn4=;
        b=qcI5CzTSyVd0QX5rJTkKjNTYVwIheKIQEgwACgARU4hC+gopJcb2Mmci9cSITqfppr
         O42xsAmL6KJc+7Qpd38MyaToqqUBnyi6S5XGkaMyL7Q+mxOLNwpfwAj835LoII+W0f8e
         w1+PAlY4W5WShJUpels1kAgVrmLRx70rOH78WoY9peeWb0gVraWfOh2U5G/NdL4pBGXh
         H328vMwqtszaNAbL9taArs83r3t1BhFPUgk9splRUwHXDkIkO8hIagXiazKYEW7Tybo7
         efUUwO2ArDlPAVwfSaj3WGqKm/7NWEkrUa2ce9xdpdnVq7Zu5AXrzOqs1etM7In6ub82
         qgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=zjJuhmUcpn1FM3ZXSuk2oyywHIEb498XKkFkd2ZHQn4=;
        b=T3pyIBRKVcqwSWY7A6MwikKnhaDyLCH9B2GHHYXz4lQKKU5xxm3syo/beHme+T/44a
         iBB+4axCozwJDQ7Ao7yP3KmwwDt0qAMheLkO/ovTQ0arSNsch++kvLQfue8zo4YAGE8R
         sD/h4Eq2pC1saDbTAbEnTrX+WZFNZGES6+2gcnqMvIBCuQPkyfF9URkZbKmnSWkztD2H
         BupV3g9c15eI0zq/j/AszpcLCpZ/PU74KUA6ZvyCTpGF6FHTEd9bdmkeTgcYwizeSEAH
         Ytn5zgG781kom+ObAF3Z76FkUVjtI+r7ZfNmOjS1xOlLPrnauFiNpMXKB/BedNfPbwJL
         zSZg==
X-Gm-Message-State: AOAM530O05MRgPRRm+jCSlyDunZ67+W2GnZx32+Lvjn6Iz+rDYnne/WL
        UOQXTpKnpqhVg6h7CPhqajM=
X-Google-Smtp-Source: ABdhPJxGl4YyCy8JSl+/h6O/tYd7dpGzIJ3S/9ychhuSV8cqOHagF8luhz89/1RB2L1sHvYGmmINcg==
X-Received: by 2002:a17:907:6d05:: with SMTP id sa5mr10154673ejc.200.1643219488469;
        Wed, 26 Jan 2022 09:51:28 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hg12sm7639089ejc.66.2022.01.26.09.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:51:27 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nCmS6-003CHO-O0;
        Wed, 26 Jan 2022 18:51:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 0/9] midx: prevent bitmap corruption when permuting
 pack order
Date:   Wed, 26 Jan 2022 18:50:27 +0100
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1643150456.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <cover.1643150456.git.me@ttaylorr.com>
Message-ID: <220126.86czkee675.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 25 2022, Taylor Blau wrote:

> Here is a(n even) small(er) reroll of my series which fixes a serious problem
> with MIDX bitmaps by which they can become corrupt when permuting their pack
> order.
>
> The only change is to revert back to using finalize_object_file(), since it
> behaves consistently with other parts of the code that touch $GIT_DIR/objects.
> This is safe to do given the other change described in that patch. The
> description has been updated slightly to reflect.
>
> A minor tweak to the tests is done towards the end of the series. But otherwise
> this is unchanged from v3.
>
> It is prepared on the tip of master (which is 89bece5c8c at the time of
> writing).

I gave this some light reading earlier, and left a few nit-y comments
along the way. This isn't my area of expertise, but without giving it
much of a deep look this all looked good to me.

I don't see a reason not to carry this forward, with or without
addressing any of the nits I brought up.

Thanks for working on this.

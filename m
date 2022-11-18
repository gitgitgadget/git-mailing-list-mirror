Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3373C43217
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 00:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiKSAEC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 19:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237478AbiKSACS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 19:02:18 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA50C1F51
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 15:30:06 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id x16so3267084ilm.5
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 15:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mm5AapP8/BJ/t1Zz2CE9aeaZzHvngbCd2ZV3pqsYquA=;
        b=oNhm9u99+l0Nh99227SfygMctqjqKpv2yQBVzbWQgMnyQWsEEv4eORtIQkwpmL+AQ/
         9N9qMQoeE0R3FuKBXkH+OaBCwXbVIHcuWoAp7EAMrP1wLb8hIWlcIxfe5qpqUkXpJn5+
         vkIcxwpl/mNthXEgGKan4LPXOr8/zdtRVu0H6SruXiLVVMPCTJ7GQQfU2nOKUUjv1Q5t
         4pZTLswJuGxIlrbAX0bbEAzJhVhzFQY33urk8dHbpikqEBdf9wFrF5ET79PdK/2fnIwu
         1wWjv8PoFsd6F4ZU1ULhQsDXHG8TYnI0Ti5dyTW5rgD/Z1Cy8OtctzTQtj3DRHVckFmW
         WPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mm5AapP8/BJ/t1Zz2CE9aeaZzHvngbCd2ZV3pqsYquA=;
        b=b8jZ7Cfld9ZyrgFCvsF24C8fNxjaxtPEkoygblMLmO9C2rYx0zMMfe5Bb8EBbodZ2/
         6uFbUBpOPzrL3Mf6mWp8Y3HUMpLnbDIgOdNZ15Lb1OIlaWy1TV343Dke1Zo6YbEraUkE
         UnHcJIz7LgOsy3Sb8m1oJk6p6vyKaBqfEC5G899hI7yuVzoUwvT1HaEfbrHk8K0HHLd8
         BRkI8F6i5BTE2hrrKCZ9I69Lzhzd3xxsZNGp2xIseeEDRIooeVFkXh8LEc6koulfen5b
         2saJjclPWMYdY9YdXuQxXH16bWA9+PCW2cFmKFiIZ0rkAEDD0zFum9jM6AK+b/t3S7jl
         sQWA==
X-Gm-Message-State: ANoB5plwbfjPy42SpR7EWjwDGb6/e4qySsCVpWVnYDKGvT7OVuOa9mMd
        jKtuUdZ5IV+id5ASeBitZdWgVA==
X-Google-Smtp-Source: AA0mqf59GYcdUVZCQNE1aPGts2g/H9aY99rznBQAfqi++PU4XVV4uCNVs6KTYhWgJi6VeB/8svb5Wg==
X-Received: by 2002:a05:6e02:4cd:b0:302:9269:f3d2 with SMTP id f13-20020a056e0204cd00b003029269f3d2mr4116599ils.87.1668814205557;
        Fri, 18 Nov 2022 15:30:05 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a67-20020a029449000000b00375081fbc7fsm1684245jai.166.2022.11.18.15.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 15:30:04 -0800 (PST)
Date:   Fri, 18 Nov 2022 18:30:02 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v9 00/12] merge-index: prepare to rewrite merge drivers
 in C
Message-ID: <Y3gVekgT7jLibjWo@nand.local>
References: <20220809185429.20098-1-alban.gruin@gmail.com>
 <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 18, 2022 at 12:18:17PM +0100, Ævar Arnfjörð Bjarmason wrote:
> This is a prep series for a re-roll of Alban Gruin's series to rewrite
> various merge drivers from *.sh to *.c, and being able to call those
> in-process.

Thanks for resurrecting this topic. I couldn't quite tell what this was
supposed to be based on from your cover letter, but digging around your
repo, the best I could come up with was:

    $ git log --oneline --first-parent --merges master.
    00c0dd7b8a Merge branch 'ab/various-leak-fixes' into ab/merge-index-prep
    dc39d4bbb4 Merge branch 'pw/rebase-no-reflog-action' into ab/merge-index-prep

when queuing, which seemed to do the trick.

If that wasn't what you had intended, let me know. The series does not
apply as-is on top of 'master' (which is at eea7033409 (The twelfth
batch, 2022-11-14), at the time of writing).

Thanks,
Taylor

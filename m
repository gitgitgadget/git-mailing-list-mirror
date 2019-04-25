Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E86341F453
	for <e@80x24.org>; Thu, 25 Apr 2019 17:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfDYRwg (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 13:52:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35320 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDYRwg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 13:52:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id f7so633607wrs.2
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 10:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dJdZYE2ifGRbQUnW4YFBX8liTRlTu6EfLzhfHtEAu3M=;
        b=tSJJDQvctj28yy2zPcXHiDPDweboqDitOkeoeluJZ1gG/G6HTx+LxwN3Ee+CG2Q/1T
         H9BTd8AS0at5lwKJRMsp6mk5YRJkicXlBFrQVfvNnKPvT28C7QA3QAmvA+Y49V0bvg7A
         3Ty4ECh/BwdBOTLJiUf7HupjlQcSa27AOK5acztD029f7TtatkkHyB6ZbcyJVRYGGCop
         UDxZ8MmD2Ae2FhzrpkN21JX+awwCBesLEiyVIEupMTSD1zTym2ZsDTg628vHAHKGwahc
         OwNbaG4looUUmpD1FloU4JRVGXmzU6K+pmhHVwb/yrQcgJUq5szK/6dSnKoP8dQadU6c
         hQuQ==
X-Gm-Message-State: APjAAAXC2YvHbjdnuvA8uxm/1sfmyFyrZ0zlWSxEeXTRiTduz5tgmqIU
        x0XfC24qaHET8+P6PdVcuV/lI1tgfCBShpGOKmU=
X-Google-Smtp-Source: APXvYqxMbiGlGKNWT+gHE9gkumjUCv5Fhbi1l7rjrT/6aQcbOhqTfQyCTprMmzQ4q51jQVEFnv6LQgKs1kXENFZPhwQ=
X-Received: by 2002:a5d:5282:: with SMTP id c2mr16463222wrv.88.1556214754652;
 Thu, 25 Apr 2019 10:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190425155118.7918-1-newren@gmail.com> <20190425155118.7918-2-newren@gmail.com>
In-Reply-To: <20190425155118.7918-2-newren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 25 Apr 2019 13:52:23 -0400
Message-ID: <CAPig+cR2kOmKMmSu4hP6gJp_S6t9QQCnMtKjTp6QEw+JwQxG=w@mail.gmail.com>
Subject: Re: [PATCH 1/5] t9350: fix encoding test to actually test reencoding
To:     Elijah Newren <newren@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 25, 2019 at 11:51 AM Elijah Newren <newren@gmail.com> wrote:
> This test used an author with non-ascii characters in the name, but
> no special commit message.  It then grep'ed for those non-ascii
> characters, but those are guaranteed to exist regardless of the
> reencoding process since the reencoding only affects the commit message,
> not the author or committer names.  As such, the test would work even if
> the re-encoding process simply stripped the commit message entirely.
> Modify the test to actually check that the reencoding in utf-8 worked.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> @@ -94,22 +94,22 @@ test_expect_success 'fast-export --show-original-ids | git fast-import' '
> +test_expect_success 'iso-8859-7' '
> +       test_when_finished "git config --unset i18n.commitencoding" &&
> +       git config i18n.commitencoding iso-8859-7 &&

Aren't these two lines are pretty much equivalent to this single line?

    test_config i18n.commitencoding iso-8859-7 &&

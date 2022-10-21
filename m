Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8C1C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 18:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJUSYW convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 21 Oct 2022 14:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiJUSYV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 14:24:21 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6D82764E3
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 11:24:19 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id q11so2063262ilj.10
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 11:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tkQs1heeSSYFFjMFAjI1GjSY4UdbfyyzvxrcDUZbnk=;
        b=hWO7nZx/X81Ky6lXxqmyBCnnFzSzLeuZClQTAZlCdW04rBDiYP4QwpFpyUlxALkSFB
         msdYv5mB2RBhbRoWgcEDfESDA1XnehWLEY41YS5xW1L+sm5fgZ/BHicGviFKpe6egH9l
         Ic/illu/q6eRzgYTi+EvAYztMgXu5ZqzoZ1ykXOIOe0Qv0P8+zU0UhAyeK92saCplPgb
         2j1perPuJ/7Zbj4VZN/1IujKX83Qrkvt00Hn0HcKTSd2tO2p+z4exW/3NVt95IU8hVb8
         Z4GdfVOwkDyUDBdSDkHpGzcW2qdSdVKrlsfe4dx8KXOwXE6BAm0mONfrrQPfQhE1/BUu
         6Ovw==
X-Gm-Message-State: ACrzQf2eznx8QEi+cAWGtKTCq3DPCzlg/PbYpYxF16/YEPILM0wKIgtC
        11VwrFfqi2kfrz/LjN4cd9O/YwtgwwbHeT0HsfbfeYjhGOk=
X-Google-Smtp-Source: AMsMyM5E0TjICU5nkcOLOCXDO4DKsD6oIwhlOOcY2aIY21AuWDTDdYSLR6wvEBHkS938+fmeZXMJuqG5p9wxOgQDx0s=
X-Received: by 2002:a05:6e02:2141:b0:2fa:c219:6158 with SMTP id
 d1-20020a056e02214100b002fac2196158mr13541567ilv.48.1666376658271; Fri, 21
 Oct 2022 11:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
 <86a842d50345f6d4d0b16c78d565474be6f8068a.1666365220.git.gitgitgadget@gmail.com>
 <221021.86mt9pdtcw.gmgdl@evledraar.gmail.com>
In-Reply-To: <221021.86mt9pdtcw.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 21 Oct 2022 14:24:07 -0400
Message-ID: <CAPig+cRszqyrPFHSaB92_kiQ60huXw2rWZbCh+JsGKetnChJUQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] subtree: fix split after annotated tag was squashed merged
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Luke Shumaker <lukeshu@datawire.io>,
        Thomas Koutcher <thomas.koutcher@online.fr>,
        James Limbouris <james@digitalmatter.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 12:48 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Fri, Oct 21 2022, Philippe Blain via GitGitGadget wrote:
> > +# Usage: find_existing_splits DIR REV [REPOSITORY]
> >  find_existing_splits () {
> > +     assert test $# = 2 -o $# = 3
>
> This "test" syntax is considered unportable, I'm too lazy to dig up the
> reference, but we've removed it in the past. Maybe it's OK with
> git-subtree.sh", but anyway, it's esay enough to change...

You may be referring to POSIX[1] long considering -o/-a to be
obsolescent, and GNU warning[2] against them for a couple decades or
more.

[1]: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html#tag_20_128_16
[2]: https://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.70/html_node/Limitations-of-Builtins.html

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C70C19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 06:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbiHCGoc convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 3 Aug 2022 02:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237315AbiHCGo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 02:44:29 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C740C39BB8
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 23:44:27 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id i62so25193282yba.5
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 23:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=M/ZBA4rJxQAVNJRiZTZn6wLKYegVnUd+bMGhQ4i4MqY=;
        b=cHe+uJrFj0uJ4WyCGcCqlHuBW4vuefZtkZ0vpYGzqA1TQ4nDRQ1IQvYKwTrrctzKK6
         8ymEh7gn0iQ5m1iTfDRkkqheKFnIKbH5JVZJ+Wa2jacemnfslrDfHGf5na+WNtbfAh1/
         UHaiu0IAKI1VVnomyiKO0lCb20xrNKiQLaNk8tGOzpXFtQ79c+GexKcLBVJ6HmPmrlLv
         GJY64oKPcYYTiGDzqDqgKKo2gX0sKgXBwGAoN7QEfNb11GoAJOR0eYajjImZJDTMGSyu
         F16aCPgeCDKMitc5BltV/ISQf+9NQlJYaFkNK1Z1CVnV473lMp0tjUuZagCLxfMLONla
         m+yw==
X-Gm-Message-State: ACgBeo3MouVOa6hKbuwr4h9UxO313dsWE9nQjCS+pResqFr5ZR8iwaDf
        zoyYLGGMxocdAm+Xc9lu3UxoOhNMOzdEpgW0wko=
X-Google-Smtp-Source: AA6agR6EOGepHrEwVh2IdsDjAizHxItRiuxVPikhmTbR/PGb8516HKCzgvfXYHAuepITsh7QJL9duNgsFOLELr+jFz0=
X-Received: by 2002:a25:d288:0:b0:671:7532:68ec with SMTP id
 j130-20020a25d288000000b00671753268ecmr18757974ybg.419.1659509066982; Tue, 02
 Aug 2022 23:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com> <b5eb110958baa80b72a345b3c850f1dfceabf076.1659122979.git.gitgitgadget@gmail.com>
 <220803.86y1w5g7r0.gmgdl@evledraar.gmail.com>
In-Reply-To: <220803.86y1w5g7r0.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 3 Aug 2022 02:44:16 -0400
Message-ID: <CAPig+cTUTXuBov4m0xvxehVFbbPjVPrAHAFfPWO5Yv4C9imyaQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] t4207: test coloring of grafted decorations
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Victoria Dye <vdye@github.com>,
        Josh Steadmon <steadmon@google.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 3, 2022 at 2:32 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Fri, Jul 29 2022, Derrick Stolee via GitGitGadget wrote:
> > +     sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" |
>
> {10,10} in a regex is just {10}, no?

I'm more than a little surprised that this regex repeat-count notation
works on macOS `sed` which, in the BSD tradition, is rather feature
poor. Testing it, though, I find that it does work, even on my
relatively old version of macOS. However, I'd still worry about other
BSD `sed`s in the wild.

Instead of using the repeat-count notation, we could model this after
the way `OID_REGEX` is defined in t/test-lib.sh which, through
automation, defines a highly portable regex. Alternatively, just use
"$_x05$_x05", also from test-lib.sh, to define a regex matcher for ten
hex digits.

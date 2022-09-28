Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628AEC04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 23:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiI1XwB convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 28 Sep 2022 19:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiI1Xv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 19:51:59 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CDB106A25
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 16:51:58 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-351cee25568so63821507b3.1
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 16:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UtYAEpc+lu9U6MV2iaEaLheIFu6h2z5f0vKK+clfVmM=;
        b=OXpemsOxPMqIMQdGixH703BbDFSI0EgeSTTA/D1BdjzH4P1fHFEVE/7ojjOsC4oW+J
         O6Rpvl/Tkn7KpiJBBosu72qQq6v+nJgVg0YiJyxADoUywAXTnOsufx0JlLkA6jDU1uHL
         NeILguozHhMAkxClhQCAe3kovmrpfqYpXvSDpr+TLl2rT4UavwITvoLbGarTSuQemCLs
         lps8SrcX0hx7tkKP7WUjp4+ejsSUblZFsCwkJcSjqyVRYUZG8YIuz1DY1hGpzSPfecmb
         LNppiNfLHe8ou8gfRErV82DdT8HIgVrQfhQKnBmVCFEORwindVvbVVM+qL0J09phwGIL
         rkhQ==
X-Gm-Message-State: ACrzQf0XznH0EzsBX4IJR9ydB/p+lGeNESiohQ12mjaAf5YFcVLXkGRE
        +t7QyPhuHyNJfUT1m7OnbsssJ1V2rzUgavjOsUQ=
X-Google-Smtp-Source: AMsMyM5j8LK1dKBTX3M0lliyLJ972qMuEaltPPMEbH60Q2Y6DX1+1ZKwl3a2Nw6UdVZskF+dO38Cn8H0EucioWXHN3o=
X-Received: by 2002:a0d:e244:0:b0:351:ce09:1b13 with SMTP id
 l65-20020a0de244000000b00351ce091b13mr481472ywe.332.1664409117405; Wed, 28
 Sep 2022 16:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
 <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <patch-v2-08.35-4c68003904f-20220928T082458Z-avarab@gmail.com>
In-Reply-To: <patch-v2-08.35-4c68003904f-20220928T082458Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 28 Sep 2022 19:51:46 -0400
Message-ID: <CAPig+cRyyGnUa8sjy63=AMdqZ6vF_7nXnUwbAFvvjYYNDCB=FA@mail.gmail.com>
Subject: Re: [PATCH v2 08/35] built-ins: consistently add "\n" between "usage"
 and options
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 28, 2022 at 4:42 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Change commands in the "diff" family and "rev-list" to separate the
> usage information and option listing with an empty line.
>
> In the case of "git diff -h" we did this already (but let's use a
> consistent "\n" pattern there), for the rest these are now consistent
> with how the parse_options() API would emit usage.
>
> As we'll see in a subsequent commit this also helps to make the "git
> <cmd> -h" output more easily machine-readable, as we can assume that
> the usage usage information is separated from the options by an empty

s/usage usage/usage/

> line.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  "git diff-files [-q] [-0 | -1 | -2 | -3 | -c | --cc] [<common-diff-options>] [<path>...]"
> +"\n"
>  COMMON_DIFF_OPTIONS_HELP;
>
>  "git diff-tree [--stdin] [-m] [-c | --cc] [-s] [-v] [--pretty] [-t] [-r] [--root] "
>  "[<common-diff-options>] <tree-ish> [<tree-ish>] [<path>...]\n"
> +"\n"
>  "  -r            diff recursively\n"

The patch itself was a confusing read until I realized that
COMMON_DIFF_OPTIONS_HELP embeds its own "\n" as the first character.

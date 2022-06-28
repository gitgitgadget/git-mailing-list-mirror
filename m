Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D5CC43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 12:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344919AbiF1MgJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 08:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiF1MgI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 08:36:08 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C68F2ED77
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 05:36:08 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x20so5340695plx.6
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 05:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=45G9xIJlGI1uQo99Erv3dvrOnn83axxTMVf6hhEbJQU=;
        b=MhJotHIk555AZJinoM9M9Qn+r1GztQNOPbUdU1ndclk1Zie67dnibJv1rFCf1X3xDI
         mEwEFW9pVciQrjAwcIvwoy7stJXAkwNWUU98xATQH+1G9BEnt5f9t7sf6aFGOBA52lIy
         iyKjPUOBVA3nyIukSbj2NjXUDRvPmqzxUrkdOkzXdpT3dQWOV/6vh4TbrNSOl4sziz1a
         GfmjKpotnTezCrX/OwzhJjXKROKwbzv0gIw0AnFW/NOTtBxv0C1io9pU8dYyGixKvuxu
         5OUGMp4jLPUxtNZfyBBnFxnhsa6h55vlToslxyOlsAnYbYQySa7NLgkGmWffncKsSYEG
         wmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=45G9xIJlGI1uQo99Erv3dvrOnn83axxTMVf6hhEbJQU=;
        b=A7dwKXL1uCNN1ddXQeimfSaOJMuNk0kGZ8AmHP1CRVxBPZieh1gHFVcXEgbHXA1NEh
         MHFNIbhxEiQnvBfjXR7YWN3VQX3tsUFyLVVAjhYwbJbGFPtcxsX5z8ONrZ921F5HQYqY
         Z3SZ0O5OvPVdWHihZ/Mon5J4UojfWKxlYgXsBlqoS1muTvFWhreftVlI877KPYi/s4X1
         Hx5/paACjJeF31cqP645heogfLlKYPXJffROIgR0DxK+Ocovr6DxjB+V/PMT1c/J1zd6
         nmIbKbvHXQjqv2LlVDCfrBfk7o/kJJTCegnNB6w4MYH8Hnjn+0UKbmB69Fg2LR/xnM39
         AI9w==
X-Gm-Message-State: AJIora/4jz60ogUHHZHL31Ps9nmu6r0WdQX2fYr2eSJK9GKdIccFduN/
        FgdGOLmyTmiTVAXOc23GPu8ewzcHx5r9D8hV+fo=
X-Google-Smtp-Source: AGRyM1sHlvxwBw5M2SZzlIJmsCPFKhC7yOi2K+FeXbEZOVhYRIkZ6Qyn6gs4iGfEO4Zcl2STgbZoZjYKGy0hZKOrRwA=
X-Received: by 2002:a17:90b:3505:b0:1ec:db5d:794b with SMTP id
 ls5-20020a17090b350500b001ecdb5d794bmr22528144pjb.24.1656419767215; Tue, 28
 Jun 2022 05:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAChcVumN66OxOjag9gPqgLq7gQrgdaEkZAJabusE-gGC7LLVyw@mail.gmail.com>
 <220628.86bkudf19g.gmgdl@evledraar.gmail.com>
In-Reply-To: <220628.86bkudf19g.gmgdl@evledraar.gmail.com>
From:   Pavel Rappo <pavel.rappo@gmail.com>
Date:   Tue, 28 Jun 2022 13:35:55 +0100
Message-ID: <CAChcVu=w8mxFtXHukZkf-VswchH_sRppCm=0XZbwh=9-Y4P8cg@mail.gmail.com>
Subject: Re: How to reduce pickaxe times for a particular repo?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 28, 2022 at 12:58 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

<snip>

> But eventually you'll simply run into the regex engine being slow

Since I know very little about git internals, I was under a naive
impression that a significant, if not comparable to that of regex,
portion of pickaxe's time is spent on computing diffs between
revisions. So I assumed that there was a way to pre-compute those
diffs.

<snip>

>  2. Stick that into Lucene with trigram indexing, e.g. ElasticSearch
>     might make this easy.

<snip>

> For someone familiar with the tools involved that should be about a day
> to get to a rough hacky solution, it's mostly gluing existing OTS
> software together.

<snip>

I'll see what I can do with external systems. You see, I initially
came from a similar repository exposed through OpenGrok. But I think
that something was wrong with the index or query syntax because I
couldn't find the things that I knew were there. I was able to secure
a git repo that was close to that of OpenGrok as I found pickaxe to be
robust albeit slow alternative for my searches.

Thanks for the suggestion.

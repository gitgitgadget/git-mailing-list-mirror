Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DDBC11F67
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 01:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDEF861D8B
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 01:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbhF3CAk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 22:00:40 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:37439 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbhF3CAj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 22:00:39 -0400
Received: by mail-ej1-f49.google.com with SMTP id i20so997879ejw.4
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 18:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7yRgjZXtVb7VU62OCoHo/UUSUKKSPQK7ZBHqbgpLe3c=;
        b=VX4XSSBQT3lbIxXYEJPaWBBInmqWadjXwjOyKIRMy6bj+xXGNVWVe85dpSD7K9CBma
         ck6bJexv+i47dyE/AV8GRj2bRyHdvauk6kUFv0ktnfP/BJwmwkaoMlUkUioP2l7M5p0Q
         I0Iy/cJy0AilJGiB97ovNmks8IQGlvPzK7SkPx5L2AtvlHvRcyWNu2On64JpziisICeW
         Qebzb1MPwv1G3ZW4NVWAmJ5qHMI64OdZqE+aR/yaiHFtmxXtOC7lai1BVhvHq5jDszaS
         p83DPib3e7oCtnJT3DVOGVoWsmS3KMD1CB0PsUv2vehFvxseyIccwl5p8IG7A3RGa0JI
         Y0Jg==
X-Gm-Message-State: AOAM531Jf4voD6ZigPWQ14ixoa/xaR4i/EbAe3vDEQOUguwga2puduqR
        wuVKPVW9yBveMgeoRNIKkEBxR7J1fW4I5vnLJ2Azx/cS
X-Google-Smtp-Source: ABdhPJwWNX5Yso8JQxmIuAd1qsKhMy1OSF7urWlHnL6uYdUbC2QDMwqlDlTvqDuC/VH3oKEs6sDM5iBzArnbTw9a2X0=
X-Received: by 2002:a17:907:a064:: with SMTP id ia4mr33075905ejc.482.1625018289877;
 Tue, 29 Jun 2021 18:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210615172038.28917-1-congdanhqx@gmail.com> <cover.1624974969.git.congdanhqx@gmail.com>
 <49104273b8b801fc61811347120c5f4c42a3700b.1624974969.git.congdanhqx@gmail.com>
 <CAPig+cSKOzebGRyoytUGORhq56P0rijYrKO6uu7q7fWnzwiQkw@mail.gmail.com> <xmqqk0mcuw0e.fsf@gitster.g>
In-Reply-To: <xmqqk0mcuw0e.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 29 Jun 2021 21:57:58 -0400
Message-ID: <CAPig+cRu9Sh7gKi37Hj9nj+A0zZvmrrJgaVZepsD0Y-618tmvw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] t6400: preserve git ls-files exit status code
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 29, 2021 at 6:49 PM Junio C Hamano <gitster@pobox.com> wrote:
> I wonder if it is worth adding a single copy that forces the callers
> to spell out the command name in test-lib.sh and make the above into
> something like
>
>         test_output_wc_l = 5 ls-files -s
>
> or even
>
>         test_output_wc_l = 5 git ls-files -s
>
> That way, it is easier to see what command is being run (yes, I know
> you have _ls_files_ in the middle of the name of the custom helper,
> but the thing is that "-s" and "_ls_files_" in the middle of the
> helper are so far apart that it is not immediately obvious what the
> argument "-s" is about), and by not having two identical copies, we
> have less risk of them drifting apart.
>
> Hmm?

I may be misunderstanding your suggestion, but isn't the proposed
test_output_wc_l() function the same as what Danh had originally
implemented several re-rolls back (though he named it
test_line_count_cmd())?

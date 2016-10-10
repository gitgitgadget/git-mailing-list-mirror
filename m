Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9953020989
	for <e@80x24.org>; Mon, 10 Oct 2016 17:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753013AbcJJRDZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:03:25 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34321 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752769AbcJJRDY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:03:24 -0400
Received: by mail-qk0-f176.google.com with SMTP id f128so99024253qkb.1
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 10:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5jCCdq0frdbmCfHQ6804gnQ4C9j9ZfQ5K1br8FdzOk4=;
        b=OrlwSbFKlIyzagWfW0IzDKWFLHhuAZIAHoJ7Smk49s7odWc78xq/yXAVU0jgWSlSut
         VxIgWRoTZY6NvYvGEIo6UQHLRc4+uccmzKGE09zJcg6w3OtEIWmg+PIIpPHHUM1PQn4f
         NmPMRsZUptot1JmA7q/F58ARvNR1wBYG2JhAOd4OTaq8F+OGp/2vqJt3JLtNS6fsAjoz
         tLVsZ9ixuNZ1Z8JNqGLt4S5XEUIfoFmoHIdmYUMZRS4wFtDEtF5cx8lz76t3cC+m+7Vo
         MAKzjTrMIMbwKbFxPwriGDAgtTGToVnz5sxzVMDypY6lTmBgarRvceJmIfU7UnaPe/ZV
         rFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5jCCdq0frdbmCfHQ6804gnQ4C9j9ZfQ5K1br8FdzOk4=;
        b=G0HMgF31Br9xRQEZhKhG7GcTMlBU85UcRx8faXzw2ZQvm+0kQ42vj6LxO6Y7/fjs4v
         Y203f2tc4KHfcjpSkxdv/KpQXjd4lByNqhfFcfNstAPtUg+vv0AOtQVmmvDaUy1ndTSJ
         zMQOS2hbhE5lXDf39amw1saM4Ic0Z20IiCmpmBTfH0ITOk+rA1M4/JiKNesctEJrFJ6s
         8NDoLhnP6ALxziV4o59Ou+FohjYVvWrHIk+xHstoK7C98xBvMRhHvwoaEB8tuzuBTJc+
         ihxRXLH1Cun4ylNopx0e1AvnxPUfb99dCiZR1eYhT9pQn/zqBvLf2a8xzgpdAPYKWsN4
         c4xw==
X-Gm-Message-State: AA6/9RnMrMqD4xbsMC1v34KbPT7fPazIqlhtoP/VS1EL8jHyVsjAvdBAml1nSimZPYRTdULMUFqS6I9tSjeUxz2c
X-Received: by 10.55.129.1 with SMTP id c1mr31063058qkd.53.1476119003101; Mon,
 10 Oct 2016 10:03:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Mon, 10 Oct 2016 10:03:22 -0700 (PDT)
In-Reply-To: <e9f58e04-a534-6794-feac-f6a47ca8bb65@web.de>
References: <20161007235857.20382-1-sbeller@google.com> <e9f58e04-a534-6794-feac-f6a47ca8bb65@web.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 10 Oct 2016 10:03:22 -0700
Message-ID: <CAGZ79kZ3n8iNqLrNA0WOMEs7zLTMHmLxc-WAo_fgj1uLQtwv5g@mail.gmail.com>
Subject: Re: [PATCH] remote.c: free previous results when looking for a ref match
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 8, 2016 at 6:38 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:

>
> Again, this check is not necessary.  If I read the code correctly the
> pointer could be uninitialized at that point, though, causing free(3) to
> crash.

yep, this patch is bogus.

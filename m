Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B44681F45F
	for <e@80x24.org>; Thu,  9 May 2019 18:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfEISEf convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 9 May 2019 14:04:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36418 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfEISEf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 14:04:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id o4so4303340wra.3
        for <git@vger.kernel.org>; Thu, 09 May 2019 11:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bQ+gL+4oicLodTXtkX1txMPcIHfBqb4quK3iEzfQQJM=;
        b=mPl2MPJo4MFoDn5fasnESs7Thg6dt5SFEk3VQlAthy6MeZcFzeP5tv8dL0r7Gsdte6
         3TPvysVzjVlh8etfZRNKRIMWs7DFQPjOTIfZOa84aLZgq6BVh366p/SGPUvb4EmNgBpV
         3bOSzZGnSaptsKAz63bka/unVR4fJSkz3+0NqaJNu/X7Owzfa9QGbtrghZHWHQx7eZqh
         uhby6Wwz3x0z9EROhgSbvreqtKtze6+t2ZNYazZl9S/mbxq12X8YtYSEaxuCcwvf59JP
         wONUdin7Dq7cp2bqjEo1xOnBMlBufCXmyC4lEhMDZwEuzElh9TfSRCUPsUUiiXSwKxj/
         NZ7w==
X-Gm-Message-State: APjAAAV9CXKpZrL7xfHlJ1SM6jYYMMi69x4wb92lN7IV1VdtVMJ5ITY1
        RRdDKbtgmTGX9EhU/A99EeE81sStwcf3TM+Bh4hWIIVN
X-Google-Smtp-Source: APXvYqxiE+QTGLYByu3BFL8XUvQKO+Lg6suPz1fZSWjelZUoGxY2iiDYfUUj6I/Nl2c7UmU8nIyN1+J9mNUiylZhsTI=
X-Received: by 2002:a5d:4206:: with SMTP id n6mr4443775wrq.58.1557425074102;
 Thu, 09 May 2019 11:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190508105607.178244-1-gitster@pobox.com> <20190509114830.29647-4-avarab@gmail.com>
In-Reply-To: <20190509114830.29647-4-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 9 May 2019 14:04:23 -0400
Message-ID: <CAPig+cTJFTkJ7N+ksrN-nHeLzNmCbDpVgLRBJZtMjTsKSE_ijA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] send-email: do defaults -> config -> getopt in
 that order
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Brian M Carlson <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 9, 2019 at 7:48 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Change the git-send-email command-line argument parsing and config
> reading code to parse those two in the right order. I.e. first we set
> our hardcoded defaults, then we read our config, and finally we read
> the command-line, with later sets overriding earlier sets.
>
> This fixes a bug introduced in e67a228cd8 ("send-email: automatically
> determine transfer-encoding", 2018-07-08). That change broke the broke

s/broke the broke/broke/

> the reading of sendmail.transferencoding because it wasn't careful to
> update our fragile code dealing with doing this in the previous
> "defaults -> getopt -> config" order..

s/\.\.$/./

> But as we can see from the history for this file doing it this way was
> never what we actually wanted, it just something we grew organically

s/it/it's/

> as of 5483c71d7a ("git-send-email: make options easier to configure.",
> 2007-06-27) and have been dealing with the fallout since, e.g. in
> 463b0ea22b ("send-email: Fix %config_path_settings handling",
> 2011-10-14).
>
> As can be seen in this change the only place where we actually want to
> do something clever is with the to/cc/bcc variables, where setting
> them on the command-line (or using --no-{to,cc,bcc}) should clear out
> values we grab from the config.
>
> All the rest are things where the command-line should simply override
> the config values, and by reading the config first the config code
> doesn't need all this "let's not set it was on the command-line"

ECANTPARSE "let's not set it was on the command-line"

> special-casing, as [1] shows we'd otherwise need to care about the
> difference between whether something was a default or present in
> config to fix the bug in e67a228cd8.
>
> 1. https://public-inbox.org/git/20190508105607.178244-2-gitster@pobox.com/
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

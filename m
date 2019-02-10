Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54DBA1F453
	for <e@80x24.org>; Sun, 10 Feb 2019 02:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfBJCH6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 21:07:58 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42022 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfBJCH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 21:07:58 -0500
Received: by mail-qk1-f195.google.com with SMTP id y140so4472096qkb.9
        for <git@vger.kernel.org>; Sat, 09 Feb 2019 18:07:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ruDsYWWtkB2Q2cHsOLcO1YivEf1VGPerNrb5LZ4GBwk=;
        b=Mebs7o89PFQzNtRm0RCLFUZUY9bD+tFnaTFZSukeZ8N7KTI7MdiDCWhx6/nKXO5bRh
         DaI/LZKJ4tFFBUQjir0IdiOuipmYrStfpcUHyvKX1pgw0j6LnuaNqQRAkko0bjxlRVDg
         pe2VihlHW160zOPJFRCxStqL+pr8DYDa2R01qrZORlwrFQPIVtAU4n9ZL0qNlLa/FvjE
         Px1BWS/CKqJHaEFYY67DIzNVhZOvSAXxqkYo+tWRi+ydhlawBb5hxl1/gde87C2Vm6CX
         i8u6TKeFABIQd5J1MwbhWD6/o8c1VNZyh4jShgXp+PkjJDc032xFYS8ehL2DFu0YJdUP
         sKDQ==
X-Gm-Message-State: AHQUAuavsiT4HaN4xG68wHHg3iZL2WfsO95W773LgThz1cQgzwKkxKgd
        ZPluba43KPAQI24WEV7IkDl6w65/ziymm2nHDixg2Q==
X-Google-Smtp-Source: AHgI3IaLZ3EhnsT1z4vyeoLsah5o/+eV5L3t5nvE5gRClnc0NlXY0qjcVzfFixou/wGt+Bt1uPQEel4/DmYRQEWTRFU=
X-Received: by 2002:a37:a4c2:: with SMTP id n185mr8205949qke.152.1549764477120;
 Sat, 09 Feb 2019 18:07:57 -0800 (PST)
MIME-Version: 1.0
References: <20190209185930.5256-1-randall.s.becker@rogers.com> <20190209185930.5256-3-randall.s.becker@rogers.com>
In-Reply-To: <20190209185930.5256-3-randall.s.becker@rogers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 9 Feb 2019 21:07:47 -0500
Message-ID: <CAPig+cTMoYMmnHVuay_4RGr_FN-HWC1tN4TPDsNM4vKCH3GzXw@mail.gmail.com>
Subject: Re: [Patch v1 2/3] t5318: replace use of /dev/zero with generate_zero_bytes
To:     randall.s.becker@rogers.com
Cc:     Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 9, 2019 at 2:00 PM <randall.s.becker@rogers.com> wrote:
> This change removes the dependency on /dev/zero with generate_zero_bytes
> appending NUL values to blocks generating wrong signatures for test cases.

This commit message says what the patch does but not _why_. At
minimum, it should explain that /dev/zero is not available on all
platforms, therefore, not portable, and (perhaps) cite NonStop as an
example.

> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> @@ -383,7 +383,7 @@ corrupt_graph_and_verify() {
> -       dd if=/dev/zero of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=$(($orig_size - $zero_pos)) &&
> +       generate_zero_bytes $(($orig_size - $zero_pos)) >> "$objdir/info/commit-graph" &&

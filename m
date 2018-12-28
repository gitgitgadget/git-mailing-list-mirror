Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 267571F597
	for <e@80x24.org>; Fri, 28 Dec 2018 19:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbeL1TnD (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 14:43:03 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42774 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729815AbeL1TnD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 14:43:03 -0500
Received: by mail-qk1-f196.google.com with SMTP id 68so13057660qke.9
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 11:43:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Asc1tkpa5Uax0lfvLLKXr80h7dZEr8AcK0b0r/QTHfY=;
        b=p2lQEPt2Yy25dwWJ2eHvnAN1ZBR/S1BP1DG89Hqi0JgXwp0F7zeVcspMVt8wb2KRuS
         UrRTNVO45u4irJX6KJ8/SLanACwWTfu12ec22vZ+DWOGzS2XtS7MdqbAXB1eU28ZNItH
         DSm/8fx4p/6awWK443Eo62pt0xKmzYmRhSdPCCaQNmS6+WQwRbx95qg3R19CugV3bu07
         2ayS/zTz1j17M35/V+4mtibcWD639tQ8RzjA1acrD8N6EzEgiWzD819T9T3TrQJK6z4c
         mHJKkN66q2KXHhGrKtd5O+Izm2CW1sVMT3jp8PLaPmXNiRBNhDACBBw/YnDICjCUxKTB
         x4JQ==
X-Gm-Message-State: AJcUukcZgdws9cNegb77S62WeeeIMsMhsx5UCPKwM/VLkLmMvmO0/wDe
        LJ20Z4ORdilkxnhkOIkLFA9+sHjk0PeXz2dhaF0=
X-Google-Smtp-Source: ALg8bN7stEoKplRT6U3yvy+vVIw6UIH4uzha1Zrt+iwETGwbkeY45dONayC3wvDuPpjI4JUyJk6kYWtSuhrlprNNLEo=
X-Received: by 2002:a37:5e42:: with SMTP id s63mr25155777qkb.220.1546026181457;
 Fri, 28 Dec 2018 11:43:01 -0800 (PST)
MIME-Version: 1.0
References: <20181227223856.18768-1-randall.s.becker@rogers.com>
In-Reply-To: <20181227223856.18768-1-randall.s.becker@rogers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 28 Dec 2018 14:42:50 -0500
Message-ID: <CAPig+cTjn4je8dOANs-xHhU_NYRw-Twm22HSnSLNXTkDB-qRYw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] config.mak.uname: support for modern HPE NonStop config.
To:     randall.s.becker@rogers.com
Cc:     Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 27, 2018 at 5:39 PM <randall.s.becker@rogers.com> wrote:
> A number of configuration options are not automatically detected by
> configure mechanisms, including the location of Perl and Python.
>
> There was a problem at a specific set of operating system versions
> that caused getopt to have compile errors. Account for this by
> providing emulation defines for those versions.

This version of the patch looks much better and addresses my comments
on previous attempts. One note below...

> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
> diff --git a/config.mak.uname b/config.mak.uname
> @@ -441,26 +441,45 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
> +       # The current /usr/coreutils/rm at lowest support level does not work
> +       # with the git test structure. Long paths cause nftw as in
> +       # 'trash directory...' cause rm to terminate prematurely without fully
> +       # removing the directory at OS releases J06.21 and L17.02.
> +       # Default to the older rm until those two releases are deprecated.
> +       RM = /bin/rm -f

Thanks, this comment does a much better job of explaining the actual
problem and selling the solution.

There is a slight grammatical problem:

    Long paths _cause_ ... _cause_ rm to terminate...

which might deserve fixing.

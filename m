Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2C8C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 22:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiLOWMk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 17:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiLOWMj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 17:12:39 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0438A2648C
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 14:12:36 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id t18so522041pfq.13
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 14:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=dCT4hzpzn/u7u7+TltRRcCtRep146Q2UYUv6fqN5XPSH6UMB2hwZJjW63EfTkyCl5p
         8RxYJJCPgHOT7vHqE9syIS1iP0J4X+CPCy7l6QNH45YYfZ5QL+kr55/643yFYodD7uyV
         cWIfuAC1VbEHTa84ujnRnbn5ZS5s43eVjQ2PmVYs5EEWUP+tP3H6nFCa2pzbmsQMM6mR
         aahE10E0pC++4TVEkD8tzD9D5uI+mTNOE0SlwRtW1BScM3EyWiZmyRij6qB9wc/JX8TI
         cludOiOUoF2qTU/b+oYK6QnwgCZdhRZ0Qz5nujCnSC6n0zzRptIFjQXoP/n5bfeI9fy7
         jKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=XwrrWNOy2PXGRl2zYsD2Hr1zDMYzuymlJabPJy0uArqrwJN5jv5NkGG9bTDVCSUpc4
         PV1J2a+tX9mzNfs/K6UEepZT4sdOybzuKNjLCyg8MgdXVz+FiOQJDUvq7gYy+Ku3gGd+
         TXHU663avONjfydi1b01aXUAAfkwNTeTEZkVXlwBmOShxsfjR2bfg2KoubTS0DT5noxZ
         SHhb2ZDXgWMx1BIvAYkAX9Oo+aZha+pYax/b14hhZtmg4J8rb2C4bDe+jM9wY6JpLFCX
         32TmLAn0rVBIkKshsC7p5DTfO63vfA5xhXRjwMTEmTuPIQxsug8OuElIYXI34KIBkVFt
         PdGw==
X-Gm-Message-State: ANoB5pkER15FsjB2lVlrQ8pWXg9WBeINlcDs5t6ObM2J2RmKVVdY0wJq
        2teVoyZfnQ3dvZC9lzB++Xg=
X-Google-Smtp-Source: AA0mqf7V1t7tFVddDKTpLOIIdabgWFBOJTCS52j9mS5pA2hIjIlKVprd0Z6WaRRtFDndnu9E+kog1w==
X-Received: by 2002:a05:6a00:328a:b0:577:9182:19a7 with SMTP id ck10-20020a056a00328a00b00577918219a7mr35133534pfb.29.1671142356093;
        Thu, 15 Dec 2022 14:12:36 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a22-20020aa795b6000000b0056c3a0dc65fsm94300pfk.71.2022.12.15.14.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 14:12:35 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Taylor Blau <me@ttaylorr.com>, Robert Coup <robert@coup.net.nz>
Subject: Re: [PATCH v4 0/9] Get rid of "git --super-prefix"
References: <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com>
        <cover-v4-0.9-00000000000-20221215T083502Z-avarab@gmail.com>
Date:   Fri, 16 Dec 2022 07:12:35 +0900
In-Reply-To: <cover-v4-0.9-00000000000-20221215T083502Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 15 Dec
 2022 10:32:41
        +0100")
Message-ID: <xmqqcz8ks4do.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


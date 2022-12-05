Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAA5C4332F
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 01:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiLEBIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Dec 2022 20:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiLEBIr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2022 20:08:47 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C93DF66
        for <git@vger.kernel.org>; Sun,  4 Dec 2022 17:08:46 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 82so9184424pgc.0
        for <git@vger.kernel.org>; Sun, 04 Dec 2022 17:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hph8G05TICAFCIF6fY3M9Tz3aJWo0YlfqduUY4UYHb0=;
        b=JdZTOANKkzuGvpeml3Emh0AVUZNHXY+453OZ1NX0pVsJPgCBZCfv+E4A5LtvsefAgL
         ibjqYuAlOwWPnT4TFblR9Kf0t/D/nAgPijNFkmxRzHimQ0me4Dd8QvYUb8H8dXXZ7WQX
         YRHwBrQNua8rs7+WvqWScurBFmFCr9d2zov/U8W23xmYdL9uBaPTCP+2M1Q1/+vKD9BR
         Ln/eaMnUDBwWsrMT+eNV2usO1yuyLJ4uQ0PsvS3+5yJgsUmkJpLqKXI7dNeLWrt0YG5r
         rxGtMFLdOEmWwWfGNGHMbRXXjU32P7XL94GApwO34JlIFf9dBr3k9SW4u9Bysjw0yn/w
         Vq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hph8G05TICAFCIF6fY3M9Tz3aJWo0YlfqduUY4UYHb0=;
        b=BnypD/kqKi8Dr/MrGlwxnCWjCLuz/JaZwKSPSWtXUPzZlOHNpjRhzxrBeCT5O1iM/Q
         ktjwQn3KnU0Fwh1td1+/yMweBHnKUv/nqszXgn8PZBGAK7F3DkfIFD+RHr7O7n52b6Y3
         +OHvrk0p/nHJzqr9ROcLkncpRkOwIxYg+tAi8Y0YdlFJBvwFQ7J6mIlE1XPWq0f8kIvu
         BV/4A9N9Cj4PlXgqrYo5Ay70509KEQijxw3lyCkU2tKCZJ9YeSsG4+6KJrDjARvw/wO2
         hRb9Wh+YmCJeXpfHUkDJKJFRORTpnGxCKTLZdcr4ZqeoICagM0fO9WVEkfsEh/4A0jeS
         fB0w==
X-Gm-Message-State: ANoB5pnSbCyQLxW/vT8LyYQHlKki7sFjC+SY5xXto/MHM+YDqn3ATBZH
        I7UvoVaJz1YFk7cqFIgXnpI=
X-Google-Smtp-Source: AA0mqf6kVESGVh+V/3iSmMNjtWxn3XSF/M5lEn0N6dNIh73RQBpCbldKse1yYoQ95L2pas77o/dsJQ==
X-Received: by 2002:a63:5fcc:0:b0:478:c025:c18a with SMTP id t195-20020a635fcc000000b00478c025c18amr1759733pgb.123.1670202525745;
        Sun, 04 Dec 2022 17:08:45 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u126-20020a627984000000b00575caf80d08sm8642931pfc.31.2022.12.04.17.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 17:08:45 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/1] t3920: support CR-eating grep
References: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
        <cbe88abc-c1fb-cb50-6057-47ff27f7a12d@web.de>
Date:   Mon, 05 Dec 2022 10:08:44 +0900
In-Reply-To: <cbe88abc-c1fb-cb50-6057-47ff27f7a12d@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 2 Dec 2022 17:51:13 +0100")
Message-ID: <xmqqo7sisllv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

>  	grep 'Subject' .crlf-orig-$branch.txt | tr '\n' ' ' | sed 's/[ ]*$//' | tr -d '\n' >.crlf-subject-$branch.txt &&
> -	{ grep 'Body' .crlf-message-$branch.txt >.crlf-body-$branch.txt || true; } &&
> +	grep 'Body' .crlf-orig-$branch.txt | append_cr >.crlf-body-$branch.txt &&

Doesn't append_cr unconditionally adds CR at the end?  Do we need to
touch this test again when "grep" gets fixed on the platform?

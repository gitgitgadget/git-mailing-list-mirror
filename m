Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02FCA1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 18:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965002AbeAXSvV (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 13:51:21 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34119 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964989AbeAXSvU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 13:51:20 -0500
Received: by mail-pg0-f68.google.com with SMTP id r19so3332117pgn.1
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 10:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JVrL6mguKiV7G7Zzt3yImVyUqTjKOICDNcGIm+3VBNs=;
        b=rTnCG93fk9wuYtjb8IFxXFy7AYRFAe70cRSPd2HtBvHRT6w9Dx5uqvVBIUuvMgB1OT
         k+Ch1olVs73mK1VpAgsrRZsJYIO0hMhj44MJCBz88mGt/tEVjb2N7e9A8EZKHoQv+dLR
         txy6jJXLQAhjMmOOuBntpSM4nKCxKyO8bDuktGuUFMK3eoY46NV1PEykq7L4DqCQYIfE
         7rGBsbgNAHUCdIoVCUXq2wDjRNgXazPJkIgOofUVQ2OkgXPPKmzotBMX7sRbfcnaImye
         svy32zdtP5oBmJUkfBIjvM87Im3DexOSdISjbf2qbTWoYI1CE/zuElQm3qgXRqO2Tzv6
         eLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JVrL6mguKiV7G7Zzt3yImVyUqTjKOICDNcGIm+3VBNs=;
        b=CiuxcCB+GbR/AYgRw9U6fM2wthA1cCTO1zl/1QnPjN5fASK/ds9Hxia8KfeW8LWV3+
         dLFkJdfrq4e3rh1sp30cTWQpLYKrAqn6eOtX2jWBz1iPsh4MD6wZxg+AMtAIYAy6F4jS
         wbuHLa2DXp/CJPaAaQ6pAre5mNvcXfKNwe/MoiLVz0dKTDoGVha2M+XdnMKnWuaMH48W
         SipjCoGkxAQLEFqykJbtZQarV7YwByoV/p8IDl7iwVmCJTV6Rt/1HUu9IcH1ftXEM9GI
         aCC/eGxVUUAHDmH5MzPbj0d878CbAQ/Pf1miQYPGTf61G3lIwXegly1qBIemiGAIyfTp
         TYng==
X-Gm-Message-State: AKwxytepVXRNevzcntPJPAGgvXCQxDty4oBD6zqBCVfnaBCuN8yqExwW
        4tP9Avw7BUvN/2m6PeMEUIA=
X-Google-Smtp-Source: AH8x225P1W+MPw2sIL2CLAm19+gtTBhhLBEKw9fTIaEAUPUyf1/Pau+W03VkJ/Ed7WO2cb05Ki97Ow==
X-Received: by 10.99.180.67 with SMTP id n3mr10630135pgu.169.1516819879581;
        Wed, 24 Jan 2018 10:51:19 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:69e6:5f42:e334:a0e2])
        by smtp.gmail.com with ESMTPSA id j4sm12204471pfe.53.2018.01.24.10.51.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Jan 2018 10:51:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 3/8] sequencer: fast-forward merge commits, if possible
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
        <9878bd57cc82daf08309943305460c1e8a050518.1516225925.git.johannes.schindelin@gmx.de>
        <7e6906c9-d642-ee8d-82fd-29ee6c60e308@talktalk.net>
        <xmqqr2qggzie.fsf@gitster.mtv.corp.google.com>
        <f1c5e283-d9c9-700d-0484-ec9c6bf76068@talktalk.net>
Date:   Wed, 24 Jan 2018 10:51:17 -0800
In-Reply-To: <f1c5e283-d9c9-700d-0484-ec9c6bf76068@talktalk.net> (Phillip
        Wood's message of "Wed, 24 Jan 2018 10:32:43 +0000")
Message-ID: <xmqqlggndra2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> I agree that the merge should be recreated, but I was thinking of
> something slightly different. Currently the sequencer uses
> opts->allow_ff to control whether a new commit with the same contents
> should be created even if the existing one could be reused.

Ahh, OK.  I misunderstood what you meant.  Yes, what you said makes
sense to me.

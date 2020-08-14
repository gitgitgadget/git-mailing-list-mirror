Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B186C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 02:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA77220838
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 02:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vcm/ekvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgHNCdW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 22:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgHNCdW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 22:33:22 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1DAC061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 19:33:22 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id v22so6014819qtq.8
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 19:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+vk6btUCd6tSTvgi30RRTdLT9Slxv3c6r+r3PCUgaJY=;
        b=Vcm/ekvWr6KJU5i41KAS0d5bu6jJRmav9U4HZJp0EXY9mUVSWqHxf6KbCD7v6TcfhA
         RTK+XCTos0k6C85XTVvPIlIwF7IDMHS5lDwJmmf4dIjvttT4PaPDRKg02nFfbIVAJTID
         aqCS1pZBU4o+HffJMHyyFFyaa9qvgH8+qLPfUCxeo40XT/SE6zM0ZmZuEFE5oCdSCTET
         SDNjZAE/NWboPitoJqrCqAPIsh/ezCCt5bDyFrG0i4aAvTdP3JdabBGCPqBn4pxaU7tN
         H89N/H5uGqIiHRo5G6uxlQNyDzaWm2P4jMM13yen9XEk+DpY1j1rGXQGzvNBgZuG94Qx
         yizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+vk6btUCd6tSTvgi30RRTdLT9Slxv3c6r+r3PCUgaJY=;
        b=i5JIqEJaMk7sIrrB/V0y04phbrzxLV0Sqvv5clE+4fKw0vKNz1kWBHyhGML74Envtv
         ELnOUhy18ydAkGGfPD//CaSSPKIJibhKN1uywCW1BhSTiZMbsvCaFyihRxg6OG3BZ96u
         MPtZt7soWrUgnc9RxItzsKjkJ5PiinhwH1kMOpF7WHyLweSX7kexZtzz/Iu1m1w1mO6v
         Qnm1Ad52+kzw8Tqgh5Q6LUEIjq/6wGo8oZHad+X3DjOj4ZHcJKDI37BupxOdRzsNR3/8
         LzrMfP0dcLg7d4Tl0/9vsaNryiBzvLVxo662wqz5KbGUfA8/1W1e0fal1MaoJeYhZseD
         Y75A==
X-Gm-Message-State: AOAM5331RaVBBznUMd2I4Qn8O5QrL4x/5RfxXigIUiNZxNr3djDk2IqO
        tUSQVYdDPgtaWUyJSGOa83o=
X-Google-Smtp-Source: ABdhPJwKZVaSdU+Iu+OZTKAlktrKG96yCFAH9zYzy+8m77azN14lLDJOZ7CDReGtss21tW/HwVmBeA==
X-Received: by 2002:ac8:23ad:: with SMTP id q42mr269578qtq.9.1597372401447;
        Thu, 13 Aug 2020 19:33:21 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7dfc:cd76:faf5:aaad? ([2600:1700:e72:80a0:7dfc:cd76:faf5:aaad])
        by smtp.gmail.com with ESMTPSA id s30sm8922490qtc.87.2020.08.13.19.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 19:33:20 -0700 (PDT)
Subject: Re: [PATCH 0/2] Documentation updates for SHA-256
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
References: <20200813224901.2652387-1-sandals@crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <da077fb0-14bb-b84f-c526-d759ebc9f5eb@gmail.com>
Date:   Thu, 13 Aug 2020 22:33:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200813224901.2652387-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/13/2020 6:48 PM, brian m. carlson wrote:
> As was pointed out recently, some of our documentation doesn't properly
> reflect the new support for SHA-256.

Just to bring up some subtlety in Martin's message [1], there is some
valid concern that the existing file formats are not correctly versioned
"in a vacuum." When they are in a repository that has SHA-256 set as its
hash algorithm, Git interprets these file formats correctly, but if a
*.pack file (and its *.idx) happened to be copied into the pack directory
of a Git repository still in SHA-1 mode, then Git would get confused and
probably fail miserably.

Is that really a concern? Maybe, but also Git will never move data like
that. The main thing is to focus on compatibility of the .git directory
as a whole (and the protocol, as we move into inter-operability mode).

[1] https://lore.kernel.org/git/CAN0heSptiJL9d86ZeNPMUaZeTA68juwTyf3K-uWR=K-vt=1Hrg@mail.gmail.com/

>  This series updates the pack and
> index documentation to reflect that these formats can handle SHA-256,
> and updates the transition plan to reflect what we've implemented and
> what the next steps are.

These patches are good to help clarify these formats in the new world.

Thanks,
-Stolee

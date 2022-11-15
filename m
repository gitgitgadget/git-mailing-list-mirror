Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B546C433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 18:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiKOSyu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 13:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiKOSys (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 13:54:48 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7951A3A0
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 10:54:47 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id 7so7869018ilg.11
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 10:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aDAP/oWXRDEAKq5efRizgdK37KB8J1eleEHKr+dKBnI=;
        b=TC6kc0jGNTTxuHOIy61XoxU8GKRWJJhhCga4mNI2wkTPNeL3LytDdqFRP9cRpFoZM5
         h0LZLdw2zrjvwfmeABH4sphfyGLeb7aTyhp8VYHUx6pxR8ou/gB49Q4/RhOTXevKWPhs
         cuoFuQBBSJxkh5br1YwvHyvtwWnYIwIBRyndXacnD24N95yyDz4X5qEAweJLtsRhH2nK
         ZzGTMyKis+3tZPNNQJ+BxlnBpaVHvm9W5f222F1wJJGAqrjrooTqy6NNN1NNBnXasZWs
         ULCknepC9lBPcPn8jTw2JXgq5/KkJPsFc7qXNlafbJ2+R8vH+RPEHoubJwy5KHRYxa7I
         V3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDAP/oWXRDEAKq5efRizgdK37KB8J1eleEHKr+dKBnI=;
        b=gSTUZrMmsNAPUCIx2xuy+ftwsvJ784rUcLc8MWg1QJ5Vw3Sz/yWPrJOaNyIwUWL/3H
         fvgR+yJyBwmcEmeks6FMC0tBAqKebW8qFNDXdD62VRdB8fQeLIsuJnom/jT5o+thn0uq
         gcDdqP3xajcJqD1Yf1hLiV5v+/pehrvRsH8/fFInx4hc0IRyj12yMuBz7jT5C8q28VFe
         vwXKmaoXUYDAQfEBrv/fuS/c9YyFo/Rx0ELQ3XI5V2inL4NcEaCPl6VcCQsiKRVrVSli
         XXSgqx57Rj0sIqDFoZ+tHECyg1OnXLzM8c82UtWbhvA1L+c6OAd6oTSxJe7Gec1HVTyV
         turg==
X-Gm-Message-State: ANoB5pmOkj5/DV9lBDU3OHCBxDVG8efvjtWdpY4feZ0xRJkug5g53sLv
        8UqrMQmMYw/ySFBrGSVqYWJ19g==
X-Google-Smtp-Source: AA0mqf5stkri77TF1T6sUoG3da+F5HpFYvKK89GFYPFMWeM2At7HbpTBJ5w44fF8Q8f76jHtZVXc8A==
X-Received: by 2002:a05:6e02:1c42:b0:300:cee5:b8c8 with SMTP id d2-20020a056e021c4200b00300cee5b8c8mr9159538ilg.201.1668538487283;
        Tue, 15 Nov 2022 10:54:47 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g20-20020a0566380bd400b003758f787affsm4819361jad.112.2022.11.15.10.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 10:54:46 -0800 (PST)
Date:   Tue, 15 Nov 2022 13:54:45 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     ronan@rjp.ie
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2] maintenance --unregister: fix uninit'd data use &
 -Wdeclaration-after-statement
Message-ID: <Y3PgdXp30kLA15E+@nand.local>
References: <Y3PN4K1ULrvGCEEE@nand.local>
 <patch-v2-1.1-f37e99c9d59-20221115T160240Z-avarab@gmail.com>
 <patch-1.1-54d405f15f1-20221115T080212Z-avarab@gmail.com>
 <1ab6aa0e8178c88689f26b8df9ec75cb@rjp.ie>
 <d66fad29eb4c80fd1e9db4cfe5077085@rjp.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d66fad29eb4c80fd1e9db4cfe5077085@rjp.ie>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2022 at 06:00:45PM +0000, ronan@rjp.ie wrote:
> November 15, 2022 10:35 AM, "Taylor Blau" <me@ttaylorr.com> wrote:
>
> > It was human error on my part. Please let me know if the result in
> > 'next' now is OK to you.
>
> Had a look and I'm just wondering if we're sure it's alright to clear
> the configset before using the list we found in it. Doesn't that list
> point into the configset?

It does. I should not have trusted the incoming patch so blindly. See:

    https://lore.kernel.org/git/2cbead254b77cb02d219bca8f628dc4362c045b0.1668538355.git.me@ttaylorr.com/

for a fixup on top.

Thanks,
Taylor

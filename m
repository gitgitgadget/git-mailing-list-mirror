Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23B5C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 22:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238690AbiCIWdP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 17:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbiCIWdO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 17:33:14 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2741121511
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 14:32:14 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id b9so1143569ila.8
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 14:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=T1AeVSNKZ/14JJkkjA9ZC6AmwE9X6itODGdALFcMpio=;
        b=cwEVzfOdETWd9BoeZUM05fkCclwPf+ADIyMLh2dzBM2efRba4RKQlJ1NQxn1XBGG7/
         Qpp9rhb/IyYJfQ2GSpS/TTXahhWB+rwCExBLlir82oQZJ3PUGK9RyHsZMaMSFfGcFpnC
         okyp8tQpoJCZw9jaRv7u6ie2SpZ8mOnsL5jQKDaiz+k9gpfA1RinjfmUg6BMME5ZZS5z
         KvvEiaEI3B4dHnt/ZmYBkPDVzC6EXHQttgkUqMZ/Fddz3azj8DxW7t6lYWHm3ksIO5ED
         jvZvpNiH9QdF5DQfaC+eWgspoqMawqdFt/5RR89Xo4EZ+7hMcoTCW3nAhSk3JUyjy98R
         rIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=T1AeVSNKZ/14JJkkjA9ZC6AmwE9X6itODGdALFcMpio=;
        b=yAr0OPSFPYHJW8jyrUHmJsZR7BP5JafZJLld+BJxZe13uwKEa3yzwTTwIpvESKcGjN
         zEnG9XF9FqzxNmCDauk2RiqWvhWiMhhub1VK8XkM+HHWOAuYN9792YLZV4/iRj1iEJdC
         8tgcUyzlelN24wb+aQkn/VKLEt7DG4WyO+o0bfNopve6ErpTqQy/pqYsJpvDcA+j+Ro/
         sYKJxzPGDTZd5K6yIY+C78zQ0Is0PXISe3RdcylHV4n64e0QGaf4i2T01+dB8NqqTjlK
         G6jxYgn2NIQwmnYhPsRyajQxS1m3oaq9bbNWLnYnd5dg8zpGkABFamROODRHsBP4h0Sw
         dQbg==
X-Gm-Message-State: AOAM530ltjmBA9Obvc1/Rk+WlQokBdgiJhNVAxUVLiRmxtidv5RvBJT3
        0+w0IhVCW10OnqlIUuEDYqbsnR9vjP/DakuZ
X-Google-Smtp-Source: ABdhPJz6pDfSV+kZyLasUvIdO5pc0yLOaCbnMLLUVpp36QYFyHICAROvZDl+ZPhpRXZGHVyJgzM02A==
X-Received: by 2002:a05:6e02:216a:b0:2c5:eefa:2bf1 with SMTP id s10-20020a056e02216a00b002c5eefa2bf1mr1276458ilv.236.1646865134103;
        Wed, 09 Mar 2022 14:32:14 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j9-20020a056e02154900b002c5f02e6eddsm1822852ilu.76.2022.03.09.14.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 14:32:13 -0800 (PST)
Date:   Wed, 9 Mar 2022 17:32:12 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] block-sha1: remove use of assembly
Message-ID: <Yikq7POhuxeN1UPQ@nand.local>
References: <20220307232552.2799122-1-sandals@crustytoothpaste.net>
 <20220308022240.2809483-1-sandals@crustytoothpaste.net>
 <220308.864k48y35f.gmgdl@evledraar.gmail.com>
 <Yikl2eGbc8sPsy5G@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yikl2eGbc8sPsy5G@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 09, 2022 at 10:10:33PM +0000, brian m. carlson wrote:
> On 2022-03-08 at 13:38:06, Ævar Arnfjörð Bjarmason wrote:
> >
> > On Tue, Mar 08 2022, brian m. carlson wrote:
> >
> > I think the $subject of the patch needs updating. It's not removing all
> > the assemply from the file, after this patch we still have the
> > ARM-specific assembly.
> >
> > I don't have a box to test that on, but I wonder if that also triggers
> > the pedantic mode?
> >
> > Perhaps:
> >
> >     block-sha1: remove superfluous i386 and x86-64 assembly
>
> I suspect it has the same problem.  My inclination is to just remove it,
> because my guess is that the compiler has gotten smarter between 2009
> and now.

Almost certainly. I don't have a machine to test it on, either, but I
would be shocked if `make BLK_SHA=YesPlease DEVELOPER=1` worked on
master today on an arm machine.

> I honestly intend to just remove this code in a future version because
> everyone not using SHA1DC has a security problem and we shouldn't offer
> insecure options.
>
> However, I think for now, I'm just going to reroll this with the new
> title and then I can remove it in a future version unless somebody with
> an ARM system can relatively quickly tell me whether it's necessary.

I wonder if a good stop-gap for arm systems might be to do something
like:

--- 8< ---

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 1bb6e7c069..7402d02875 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -57,7 +57,7 @@
 #if defined(__i386__) || defined(__x86_64__)
   #define setW(x, val) (*(volatile unsigned int *)&W(x) = (val))
 #elif defined(__GNUC__) && defined(__arm__)
-  #define setW(x, val) do { W(x) = (val); __asm__("":::"memory"); } while (0)
+  #define setW(x, val) do { W(x) = (val); __extension__ __asm__("":::"memory"); } while (0)
 #else
   #define setW(x, val) (W(x) = (val))
 #endif

--- >8 ---

in the meantime in a separate patch. There it seems like the memory
barrier is useful for machines with fewer than 25-ish registers. Though
obviously moot if your ultimate goal is to get rid of the block sha1
code.

But in the meantime, a stop-gap patch may be useful. If you use that
diff, feel free to forge my Signed-off-by.

Thanks,
Taylor

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5224AC433FE
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 01:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiKPBHX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 20:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiKPBHW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 20:07:22 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFBC20F48
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 17:07:21 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id y6so12121454iof.9
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 17:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p6iAj6hh8PTuJ+0LmnizGEr6ccqVLcfzwbBK9RRKNpQ=;
        b=LWQKWg76f+c20peO4EpA5tiR0/7uVvZm6pfkOXQKnWCMTbfDPsiq4NTr92fjGWMWFE
         9sYClORlT6vtFr+rlrpHgkXSX0pgOPQWnjXC0mqC1ZjLMObSRG6E9enER7zFswdOqWG8
         JrEPPGDMyFv4Qr4f5Zl8fXxM+k2gxMiVIJ1bXgBaaikVdK27UP6+fH9bqPCTE9NGE4pC
         C5NZSPojyjR9DRkwnhx4n8l17mMObWZeYxvVGhzpB/E82Zs24GyqkE/ASFHqNdPROVUL
         bIAe3InFL/1VxDyMy4vwFpeXkN73TF+is8dh33i6ceEmX8D0K1CWUqbiX28FheFpYFxw
         SOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p6iAj6hh8PTuJ+0LmnizGEr6ccqVLcfzwbBK9RRKNpQ=;
        b=Pq9jaeiL/aS2T5gvDLdLqjkUvBNHyR1fA1oTKBAmHh3ocZwCzTNX8EeX0KSwhiwHEt
         0y9I8JmG84XIcQbxkgiLAWwU26ccvnxJQshGT8dREwd1yjtRnzbj5D4NIw+AGt5VoHNp
         VXjQDH5DqClK3/2clq62gKDyK03ghsZGxBLXcWQLR6CGM2gf9NSwO9IVDrlomhBWuz9G
         Z0ygt3eNk6EO56E4tDw2ogHiIG3MZe+EVoJIYPKmXG2XgGGz/kPiYmwsA31kDGT9ay1i
         ale/X88eOiiyZIdgEugom7rqLdOy0PghsE+jPgmK0kGaHyp6lF1MtiOM2GhEDu1TtN6e
         y7Hw==
X-Gm-Message-State: ANoB5plVMz6U3Vrfk+gk4xgsXVhYgmA7gPehsndDwVikkBUi7j1/RRtS
        NnUmC6UZTZsyIbplmbaFcqg+2lwXu4/PGA==
X-Google-Smtp-Source: AA0mqf5r5iEwR7iQBoCnWCRXFvSzhyvqEjSmwVuz8Yq+tcPmgVo3KeyOWf6Wv/IA2v2Aw3TaGB4WQw==
X-Received: by 2002:a05:6638:4415:b0:363:8849:44f7 with SMTP id bp21-20020a056638441500b00363884944f7mr9187267jab.24.1668560840513;
        Tue, 15 Nov 2022 17:07:20 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q19-20020a056e02097300b0030014a5556bsm5691850ilt.69.2022.11.15.17.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 17:07:19 -0800 (PST)
Date:   Tue, 15 Nov 2022 20:07:17 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] t7610: use "file:///dev/null", not "/dev/null", fixes
 MinGW
Message-ID: <Y3Q3xQeaXGPemcWv@nand.local>
References: <Y3PrjMLcEGfoHifZ@nand.local>
 <patch-1.1-21a9cb49299-20221115T233516Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-21a9cb49299-20221115T233516Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 16, 2022 at 12:40:14AM +0100, Ævar Arnfjörð Bjarmason wrote:
> On MinGW the "/dev/null" is translated to "nul" on command-lines, even
> though as in this case it'll never end up referring to an actual file.
>
> So on Windows the fix for the previous "example.com" timeout issue in
> 8354cf752ec (t7610: fix flaky timeout issue, don't clone from
> example.com, 2022-11-05) would yield:
>
>   fatal: repo URL: 'nul' must be absolute or begin with ./|../
>
> Let's evade this yet again by prefixing this with "file://", which
> makes this pass in the Windows CI.

Thanks very much. I just picked this up on top of my 'ab/t7610-timeout'
branch and pushed it out to ttaylorr/git to double-check your results
against CI. (Not that I don't trust you, of course, but I'm feeling like
I should be extra-cautious ;-)).

Assuming that all looks good, then I'll push out a new version of 'next'
and dependent branches to the usual spots so that we can get 'next' back
to green.

Thanks for working on this so quickly.

Thanks,
Taylor

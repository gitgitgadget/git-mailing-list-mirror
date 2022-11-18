Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C867AC433FE
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 23:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbiKRXT3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 18:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbiKRXTH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 18:19:07 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7837197EEE
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 15:04:47 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id h206so4934145iof.10
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 15:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mv6jRob2PvrW4AMivbj95YTmctJA41fksQ+3wcDaVt4=;
        b=C4FhjLUh5gqqMNXOWK8NX/qUCxjQDiLTqIB9HnuKOf4duRObWit5dRer6qPYIFdxnb
         FKnBj9aIkx50FbSPdZ+HBdxC4n18SM5DnoMglX9FE1E7V8x1pxf5yh+RrH+8rbEh85e+
         dZ1MacWVm2ve8IzQvWIA+lSj/AErWqnT36cGwBLSswJP987Ns7VwO7YtPz6qy1xaGZcc
         AIFl/rtVsgcdZi6lnyZ3A3ueLxOwNMkM7Z8j/RImP6OsFI4jE3ORPG6Q+O5p79SrueFF
         L11Tx4gQ2V7S5nw0Q9GBSgJIgbV+jivsE6XNmFHtnp5JLgRRGdcTjjiEd1/upaLPAjQM
         2hLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mv6jRob2PvrW4AMivbj95YTmctJA41fksQ+3wcDaVt4=;
        b=uHctw04oQFz+rtDce2xTh2/jb90w07Gi03d4kjvNZcy4gvymCCmM+TBklwIn/2neOF
         IKYMQUa22nCfWlLQYY+ByXt93DBo96kZg176/tJfltW9ZnEgLWHgSaxLuj3jwxGl200t
         xQ2B7wEGPx1T3xGDRJZOnfSVUJ13Vz2DXTnaBvEGBaycwoPkBdUc+S1v+oXv3mmMbFJY
         owebtztCRGbqXf4p2KzCDv7HVUa0UgLQJQlPOeT88ZURxsdifdnGuNFRXo0a6CPvi03y
         ZAS0S6ZQfQzi4pQt7PMdkO4tRy3mkinl/ITSnK0yFQ2Kzq8JSPWvfETvv5b4UhULKzgK
         Q0Mw==
X-Gm-Message-State: ANoB5pmHqN902nbgTj4tpcokpQYOgQhteSt3cIdHdynsXB0Gf0J8Jh3S
        XTG9adtwgAPV6QKVWGguC3tKQQ==
X-Google-Smtp-Source: AA0mqf6ucjl+RvocOyZKuyxvKgSNbb1SzTnGcDPUQdqpQHvCkazUtRNguSYvYUWJTKTF+Yd6BlFl6Q==
X-Received: by 2002:a05:6638:603:b0:375:9ff6:3c8a with SMTP id g3-20020a056638060300b003759ff63c8amr4085645jar.306.1668812686857;
        Fri, 18 Nov 2022 15:04:46 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p70-20020a022949000000b00374fe4f0bc3sm1644344jap.158.2022.11.18.15.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 15:04:46 -0800 (PST)
Date:   Fri, 18 Nov 2022 18:04:45 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/12] builtin/*: remove or amend
 "USE_THE_INDEX_COMPATIBILITY_MACROS"
Message-ID: <Y3gPjQubrF+/v4Vd@nand.local>
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
 <patch-12.12-b69cf6d7600-20221118T112205Z-avarab@gmail.com>
 <Y3fSJwm7qoVmvPA8@nand.local>
 <221118.86mt8of3hi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221118.86mt8of3hi.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 18, 2022 at 08:27:25PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
> On Fri, Nov 18 2022, Taylor Blau wrote:
>
> > On Fri, Nov 18, 2022 at 12:31:06PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> Follow-up the preceding commit and change
> >> "USE_THE_INDEX_COMPATIBILITY_MACROS" to the more narrow
> >> "USE_THE_INDEX_VARIABLE" in cases where we still use "the_index".
> >>
> >> Then remove "USE_THE_INDEX_VARIABLE" entirely in the few cases where
> >> we don't require any compatibility macros or variables anymore.
> >
> > Could this get squashed into the previous commit? IOW, is there any
> > reason to keep them separate?
>
> I figured it would be easier to review if I split out the changes that
> are coccinelle-created v.s. the ones I made manually.
>
> But I don't have a preference at all, whatever you think is easier.

I think the 11-patch structure makes most sense to me (basically what
you have, with the last couple squashed together).

Thanks,
Taylor

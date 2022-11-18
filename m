Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3677FC4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 18:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242462AbiKRSlI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 13:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbiKRSlH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 13:41:07 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8671E701
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 10:41:05 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id i5so2923580ilc.12
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 10:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sQ5v//42AMmlDzMAM3AS2oLki1S27h0MAjqueVskU6Y=;
        b=kQr5FIkcJ1PTi2zzj6YnrztYr/aWGhYThgAsyvI0hw3AeyfOLfevK05+NBdU0c+mlr
         dQcnhB1jZL2rrzf6C8slqg9FjhF3Cc8eDscQsnQMTdr39cBxyAIXm2PF8Na11F0F4Q8K
         XWbfTTInKw+p6hwieIlAyQJrDWXhZTF7l3fozxqZHY5MhOiubdlZd2NVszmuRBsJQUg6
         8FPlk9W1hdkNEeyfUXiav/613OotPQfOfiA1wmzehns0FXTxq0SFJWgrtorY6f4ju4Nv
         cF+r/nq9xZuP8ISFFQ6tdStgiB4ttIbAXyT5z9IfipuFYoXKQMB5mmUdmMSrWbpRCx+Z
         CR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sQ5v//42AMmlDzMAM3AS2oLki1S27h0MAjqueVskU6Y=;
        b=nQjPZsyv4lPi/IhZZzUQfS2KKw0imGZjb7DjMpu4IAc2+8FIM/kM2loJvNXJHqaNPk
         oP0sD4bHYZVC0MQqmPjZx2iIZRfD6JDgGruq4y5CkqLWA7/Jz+4ZRzcsDg6RmoU5PdKX
         9m1trNPRHiB0p34eo7hZxDg2i2xss7YVBTdlbXezLYsk9J3nCu5zakJO/UgGvyAjnTVx
         5ACX7RHsROQvibk3noQO7WNYUXK4ZLogeqrRm9R2m3gwpHqD1aAmPBK2HSuRBCRGCj0P
         6RZNyav0sxEzsd75QmkGmnFUBRVEBDNoykfZhPok5HW+V+O2DjK0kVXQt//kZt0UYFus
         xBkA==
X-Gm-Message-State: ANoB5pkbBkS5/3M/IKqxvkit7lZ/H6ddtVdCGbvYvJoATQnVUX1GOoUe
        Tm0XxTrS29IpBX9IHkKkK0Wx6aaTK1kwvg==
X-Google-Smtp-Source: AA0mqf58qHJ08ZSDSVmRVZwXTAvZr1PS97zlZ6sMAr8YEYZv3djfDnP9v2Yj+Lbco2GcySVHoOWcHw==
X-Received: by 2002:a05:6e02:2218:b0:2f9:d6cf:6b71 with SMTP id j24-20020a056e02221800b002f9d6cf6b71mr3578931ilf.215.1668796865324;
        Fri, 18 Nov 2022 10:41:05 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n20-20020a056602341400b006c0cb1e1ea8sm1583915ioz.12.2022.11.18.10.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 10:41:04 -0800 (PST)
Date:   Fri, 18 Nov 2022 13:41:03 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/12] {builtin/*,repository}.c: add & use
 "USE_THE_INDEX_VARIABLE"
Message-ID: <Y3fRv4sQFCJ/qIic@nand.local>
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
 <patch-09.12-5b69cfa17ad-20221118T112205Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-09.12-5b69cfa17ad-20221118T112205Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 18, 2022 at 12:31:03PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Split up the "USE_THE_INDEX_COMPATIBILITY_MACROS" into that setting
> and a more narrow "USE_THE_INDEX_VARIABLE". In the case of these
> built-ins we only need "the_index" variable, but not the compatibility
> wrapper for functions we're not using.

OK. So the old "#define USE_THE_INDEX_COMPATIBILITY_MACROS" used to give
you the "the_index" extern, as well as all of the helper macros.

But now, USE_THE_INDEX_VARIABLE gives you just "the_index", and
USE_THE_INDEX_COMPATIBILITY_MACROS gives you that as well as the helper
macros, but you only get the latter if USE_THE_INDEX_VARIABLE is unset.

Makes sense.

Thanks,
Taylor

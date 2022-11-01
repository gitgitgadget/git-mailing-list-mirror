Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087D5FA3747
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 01:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiKABLv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 21:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiKABLq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 21:11:46 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED15AD2F1
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:11:44 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id n191so11194853iod.13
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tBxK0I7YfTXN+rq5R6Hm/zWZFwMq/Gf7orN/uAjHsJo=;
        b=1DWrbkZDwzLumNde7GU8BmtUlsv7GKpOyHd+WMs4r80rHbWH57lvO02HWE/XWby1o9
         YEYGf2RIkPuwfTpwXfXHbJ7RaZJ7Byh8JPPbZxBvDM693mEqyTlcMmawgd5nPx1V34hf
         BX36Qh/fMN29ErWvmUuK/gcs3MGKps7S3z6ncZxToO5b8sOZZznKZ69TSRI3awe6PftZ
         pIXc34iNNs9qp/gR5bjMugg2/l90GjEcOo5MVsSTfMoYwT0GPdYYXU+9gmUtwNM0TtUk
         gbi6o1TxaTmY8ZhjrWvVRboBQgnMspr8ldi37fClW/cKxzb4L+V0LX3T+fvFK5ha+T3u
         BoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tBxK0I7YfTXN+rq5R6Hm/zWZFwMq/Gf7orN/uAjHsJo=;
        b=4E2ife0hT1ZsC2kAKdl7kELD7tTWyRWEcgKUB9P19bb+6DkSLNZfY+ld3CK5vdhbMy
         C7CHLlXA/TBF4kBWr3bxOcl/KlbULTVtThu9bPXo6ZpfbtFavnU0aYBjEHtzqITpYLdr
         Qsl4GB2Xod76meo/1oLSlyLHCHpEPERs5ZJ7SwvVr3tRriVWhSlBPBzjsdTxGtY1fA/+
         2XSb74iDK0nRYi7EQ/2omgbeF0oX+rqQ9LyQXog87+T0G9eI9I+vMZROssRpEYD9zIYr
         E3DzZg5XNnfDDTyx+hNsDkjGcEp/tOCsfZoDN3AEEAy7o2fzsCfUcr+dBsI8gU2Y4ssL
         iYUA==
X-Gm-Message-State: ACrzQf2+i7Bg4QQ5fEn1U9xIUZsYMBktsX1Sn5oXd/psTBLMB42p8nYr
        h91cYmesGJStuz+uETOZX+ptPG6VY515Y+3j
X-Google-Smtp-Source: AMsMyM4l741a7qwpCPVdWeAxSb015hfo2jMKInTxUDZ3xoKlymXk4SJf2p+IXifw0AfN7gPdL7b7eQ==
X-Received: by 2002:a02:a682:0:b0:34c:14fc:b490 with SMTP id j2-20020a02a682000000b0034c14fcb490mr10074830jam.196.1667265104305;
        Mon, 31 Oct 2022 18:11:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h10-20020a02c72a000000b003752948ea69sm3378195jao.64.2022.10.31.18.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 18:11:44 -0700 (PDT)
Date:   Mon, 31 Oct 2022 21:11:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] test-lib-functions: drop redundant diagnostic print
Message-ID: <Y2ByT8sUTvp1S9EA@nand.local>
References: <20221031180048.5766-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221031180048.5766-1-martin.agren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 07:00:48PM +0100, Martin Ågren wrote:
> ---
>  t/test-lib-functions.sh | 4 ----
>  1 file changed, 4 deletions(-)

Good catch. Thanks, will queue.

Thanks,
Taylor

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FA3C61DA4
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 21:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjCMVLV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 17:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCMVLS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 17:11:18 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91458867D0
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 14:10:51 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id k17so5592773iob.1
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 14:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1678741851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+jsskCaLqrpLSPq8U7W9GGM4d23Rw5nAgihJVSXb63Q=;
        b=iYaSQNpmu9H4/8iIGfCxrcwg4Ch8lE+umbvFjMqtrM/9gOqiRKA7osr3LxH1ngsA3t
         htarmdstPTp0WP0XUlEzr4XO2vgkqf1aUd3wNIqKrKpK4gOQZVWPMW/yqRULGqLXaqbg
         9aa0unBXyH9fGNmqeKMUJnTaalzByZh+mX0Q4hN0VBBItgPjEDo9Py8QvMYqbxF9li0S
         B1cJhby2i2xd4EvaczTc+sE9sMtmZJVB+bsSB9OZtz1MmXMMO2CGS8wVe25QJPSaxcdI
         4aUBZyvdTiLX8Qj43O5q1RPcFTUTkjM7sFSdwEk0Sn2ZQmgcVN0VTv5UOE4HqjdAJLyU
         Zi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678741851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jsskCaLqrpLSPq8U7W9GGM4d23Rw5nAgihJVSXb63Q=;
        b=ysoGzqjIep57z+yyZ62sEj/8Fh4dOQyXrMLSv6H5602VBbet/kvATxuRnUBHsELvBF
         zOG87EzwMxcidqTLISAjq6O7PQvTPJxemu2ugZsXfHeJqIEdLACy+kOKWHmTig+Bm31L
         x+4B1ofFGjkdOeEwyM9O+jLPWFxDQEqUjz9oenDI4V/06QUKPozErGxMNxS+Rxpt7DHu
         T+X0THLJmrJ1S8GMqQQBmTM+Wa6W7bmCdXpWuNDjw+Vn5JcjlO3XdXg5GquTPABg5EQg
         U94AjXFn6jl6ZwZHCXNKOL+knzGFzqDzVKLdViAvRcQyCZ0+ZP2xHPEV/ay+RH/AaRXL
         D01w==
X-Gm-Message-State: AO0yUKXOUSCadrPGR6NSYRTBVbWa657Jykz5gI27wz+x/vfJiefM3f7T
        ifsc4O9Oswlkc5fI/K/I8pbbog==
X-Google-Smtp-Source: AK7set9YnvDAMMeTi6su2kIKmgyq8gl9NYwU1QsVJeWwdFAS9qDOv8FVhwI/uln7IuYJWyzMrH2rxQ==
X-Received: by 2002:a6b:fb15:0:b0:74c:ecb3:bc1f with SMTP id h21-20020a6bfb15000000b0074cecb3bc1fmr19608811iog.4.1678741850738;
        Mon, 13 Mar 2023 14:10:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b4-20020a5ea704000000b0074e7960e70dsm224565iod.51.2023.03.13.14.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 14:10:50 -0700 (PDT)
Date:   Mon, 13 Mar 2023 17:10:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/8] for-each-ref: add --stdin option
Message-ID: <ZA+RWc+eejXyPfO4@nand.local>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
 <a1d9e0f6ff6660c9264673be18bc24956f74eb9c.1678468864.git.gitgitgadget@gmail.com>
 <6badb697-aa74-cc2f-ba43-0bbf54b10973@dunelm.org.uk>
 <cd61cd39-ba84-49ae-4b36-92c7be043740@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd61cd39-ba84-49ae-4b36-92c7be043740@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 13, 2023 at 09:33:29AM -0400, Derrick Stolee wrote:
> Thanks, Philip. I like your version a lot and will use
> it in the next version.

Ditto. Thanks, both.

Thanks,
Taylor

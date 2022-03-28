Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5437EC433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 19:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343791AbiC1Tzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 15:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbiC1Tzf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 15:55:35 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E65338BB
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 12:53:41 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so524065pjm.0
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 12:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=fMYdzMsiP+1Bk/6iYa/q2eV0R1ymjfwVHmlSQ19fX/M=;
        b=EvmI8hCML6qIESBger26GHXS+XGlilq45vezFYZXshLgz3URC6xFuMnUtjcqWy7cQl
         VKNVDJ0biT9EcAv/9RZFsmBnNJX57KgCsD8+nVsqPub9WgssW+MklWfjb2wUdQaM6+77
         qU5ied+OL1jktdwP5vvDs82+66/lt/MAZhi2BxUjDzWLYA5pFYyarwIScaHC6yJ5mHBf
         FPpIVvet9owI18i0XPaOWeDTi8gczzFaY9Zt1sEUx6xLtvDLVT9/zlBUxxQSsIB9juNs
         VZHz4u5Yw0NS8szOKBSB6Lf1TmSWysYoQSr0ybJQ65a6uiuPxALPkzvSK0VRxUbQHLNg
         FqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=fMYdzMsiP+1Bk/6iYa/q2eV0R1ymjfwVHmlSQ19fX/M=;
        b=WJ04QhzlOWmEKZ5CsOammLfB+msXHLFCy+Au12wT5kD0cBNiA2So8uEikQHU4zwhIg
         rB+OaWr5R3v9CAjmA5jzBLvXUwlpmkxKDc/5V0UZx6EqYrq+g7QAkt8T3ibZRtp/w93E
         N42mElTFMok/bJHNfzsXUWK+oGDQVKv+OPPtYc5BTI1itupdmU8gI5tp6iNgT8m/cT3w
         /n5xCat5aZlW09glMqIPhjGBN+HzZM3iY3zwtLRonr2S0uOdniy1Ab+DobhWbFpxA3i0
         4NJlh8Jb5neoUupcTM7VdWzt6fKSZS4MzNmUo7VfOd9fX7ZCdZrMClLcqLlLhZzI3xKR
         R23Q==
X-Gm-Message-State: AOAM533zw1rUq+WDk3I2qxloqZ4PzmXqFLR6h8/Iu1S4kcamT+eo5cwm
        v/y1+luvMyRB6J2UyRgp9I7Z2g==
X-Google-Smtp-Source: ABdhPJwjLjh3IkCnvumeXc9IBbxZpuXH5xkI57nWrZ1E2OI1Kdh4Z6y0r7S1Yak0WLHLu45cRjMTVw==
X-Received: by 2002:a17:90a:5d93:b0:1bc:4f9c:8eed with SMTP id t19-20020a17090a5d9300b001bc4f9c8eedmr782253pji.180.1648497220544;
        Mon, 28 Mar 2022 12:53:40 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:11a8:5d81:f67f:aef9])
        by smtp.gmail.com with ESMTPSA id o1-20020a637e41000000b003804d0e2c9esm13626330pgn.35.2022.03.28.12.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 12:53:40 -0700 (PDT)
Date:   Mon, 28 Mar 2022 12:53:33 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        lessleydennington@gmail.com, gitster@pobox.com, vdye@github.com
Subject: Re: [RFC PATCH] repo-settings: set defaults even when not in a repo
Message-ID: <YkISPUe4NKvzwrjj@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        lessleydennington@gmail.com, gitster@pobox.com, vdye@github.com
References: <1b27e0b115f858a422e0a2891688227be8f3db01.1648055915.git.steadmon@google.com>
 <471ca70d-0da1-8c4f-16bc-3019706931bd@github.com>
 <Yjt6mLIfw0V3aVTO@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjt6mLIfw0V3aVTO@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.03.23 15:52, Taylor Blau wrote:
> I tried to sketch all of this out, which seems to work. Let me know what
> you think:

BTW, is it OK if I include your Signed-off-by on this when I send my V2?

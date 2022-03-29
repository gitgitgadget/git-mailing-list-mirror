Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307E8C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 01:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiC2BYP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 21:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiC2BYO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 21:24:14 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74852C117
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 18:22:32 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id gh15so13296085qvb.8
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 18:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kgtObJB+Zt8SY/4d+dlJEovnscgqx6LSIEa70Ry+rFc=;
        b=KQGR2CLf57l9P53D73MlMZ68H9z3Gens02Y0A3gZ91So6Mef+2vbUHd6sZsdBfq+P+
         rqoDx8MTCqj/tDpJOWsbZ/p3AMudv3Eld+E6ZFixoeo6FFIc6jY6EpX6XJxZCJqq/fvZ
         WjWB63s1Y/W1chDiR9lEK4ZtAohRAniL2npqaXdUDyl26jySS49Qg+L2UuqR+Q4hXZ6E
         wWM50xXVPA001pE6rzt+gDEsMTekefwPF2blGHmKFbOt/jjJQHoUooSW2ooxsnCJhxoA
         xHbXB4CHWRm4hiRoRcQO+i2d7gnnC5jvcJn9Kw7V27bDAE/Twc8mQ5sITYVU96O+aaSv
         ga/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kgtObJB+Zt8SY/4d+dlJEovnscgqx6LSIEa70Ry+rFc=;
        b=oB7q+c8qri2Pra7CZLosZK4hbu3rBh4aXG2vVTsEYkXS3MiJBIBS3LJWBy04mIhESv
         6Ns8eLCWD1GNGWp0MZgu5uGOFSzFn/azJRsmmfkuV84wYNgk4xyZE7eg9TdCgkyxHL2Z
         2nvcYYnmfBRiceuuclJSRTeDeAloJ1e8jwD+JYkO2EkSVS17ps1oOjdw1l4DVSe1LHyG
         lvpwUqBvPZgz5ueCsckCL5hw2mqguu62KxZMa5ComSvgvYdACHZbBZVVoxRBg/y3nAF7
         05I+XaChzJcaUB/eT7LKMQ/k3mP+CAW331mAscQm2fEho4OUdlxv3xVBTM/2HSNpnjsL
         3QQw==
X-Gm-Message-State: AOAM53073v7NNRH67/9lDXQyNRAEWjE6jfC4I41oxWf8vAwTpNnN84hG
        7aDj/Y2AXiwnOufzhpeh4yNexA==
X-Google-Smtp-Source: ABdhPJwm6NeELtALGaSdK1nIAusMJv6PMBdTV1H4ZDrjOgZesvXbQsFNIjkDKNMsZpk4a6Bz+pAhZA==
X-Received: by 2002:a05:6214:2528:b0:441:402c:178d with SMTP id gg8-20020a056214252800b00441402c178dmr24074591qvb.59.1648516951626;
        Mon, 28 Mar 2022 18:22:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m14-20020a05622a054e00b002e2072cffe6sm13273983qtx.5.2022.03.28.18.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 18:22:31 -0700 (PDT)
Date:   Mon, 28 Mar 2022 21:22:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Josh Steadmon <steadmon@google.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        lessleydennington@gmail.com, gitster@pobox.com, vdye@github.com
Subject: Re: [RFC PATCH] repo-settings: set defaults even when not in a repo
Message-ID: <YkJfVnVSaO0IRJe9@nand.local>
References: <1b27e0b115f858a422e0a2891688227be8f3db01.1648055915.git.steadmon@google.com>
 <471ca70d-0da1-8c4f-16bc-3019706931bd@github.com>
 <Yjt6mLIfw0V3aVTO@nand.local>
 <YkISPUe4NKvzwrjj@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YkISPUe4NKvzwrjj@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 28, 2022 at 12:53:33PM -0700, Josh Steadmon wrote:
> On 2022.03.23 15:52, Taylor Blau wrote:
> > I tried to sketch all of this out, which seems to work. Let me know what
> > you think:
>
> BTW, is it OK if I include your Signed-off-by on this when I send my V2?

Yes, absolutely. Thanks for asking; it's fine to include my
Signed-off-by on any patches / diffs that I send to the mailing list.

Thanks,
Taylor

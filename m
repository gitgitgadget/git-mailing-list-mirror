Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC25FC433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 00:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245655AbiFHA2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445250AbiFGXD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 19:03:26 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3691D2AD5
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 13:21:25 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id l1so13130737qvh.1
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 13:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ISxWg12wO2fAoMd/OHmB/QnxeYjsEJX2cAx/COTZcpQ=;
        b=vQJ/GqFSpek14XAxmpjWPNroSZCbYVZhvJEl4o4QRFCd7YSArExQcjsIVuAAbPL3lp
         054k4ssDxRfmdCmqCD7X/EVG7F3i9Kx/pmmPkqd5EtOrD3aZnY5eedamWFnq3hMssAMz
         Zzk63IpY6R9M5CU8whlPTEaK3xMVMdpV35AapHNqUzMofytKhYuE+TEIG99UqwAkJAnS
         3lXH7sg8bXWcxWZyx87IO6F+1/fqq1QpM+6+koJfV5kvmWQsvXDJFjMGA7cAEiKc4IrB
         6XcOTsFwvSWy4+qBMwFJWJQWfEDtDLj0+S1cNcYxxLe5Q+OY9oaE1AVl/B9gsr2HBTfO
         0nbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ISxWg12wO2fAoMd/OHmB/QnxeYjsEJX2cAx/COTZcpQ=;
        b=LiQtsikF8yeyKqtSIUAKblCsF7as4whR6CY5aVS2GkKYu9VJ5E9GIukvpUsUj92DqK
         duef8BxUp5kNRQ9OLEIvvCtgRKE5DdI+jLcZ+R3x+gjzOh+rhqgX3nk83ntCXdJjNwPC
         OMg65N2IiGr71tM3hU1pZppJJI2eJgXdNB9k4MAbfeJ3rejlHz7F2B5kjGAO57dQvZNO
         kHv8xQWK6ZHeMM0xiRl6uTH3m6tHmlxnTcI0lW1QxxSh8kbBoDHnpkl+NrmN/5IoWXpp
         T2dFV7dGlv3AYkimuJL/qR0D8IdraLwYo/WZto5S2DzqqqZs7mtButNHyCRus9s7iF69
         5Pwg==
X-Gm-Message-State: AOAM532RHAU5oLkp4et+BgPXa66elgGagdPDlmnYlcuLAzOcnlpRkzyd
        1CCiBFq23I64l7iJojksWiYeziixkvbKXJH2
X-Google-Smtp-Source: ABdhPJz24HE9/g98MwfqkfHeik4ow7alXAl0DhoVI3MxqeyMlw6imC9YHhf3sZSjyqHxoqDniHDznQ==
X-Received: by 2002:ad4:5d66:0:b0:464:4a42:5d77 with SMTP id fn6-20020ad45d66000000b004644a425d77mr38142418qvb.15.1654633284358;
        Tue, 07 Jun 2022 13:21:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h22-20020ac87456000000b00304de7561a8sm9009045qtr.27.2022.06.07.13.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 13:21:23 -0700 (PDT)
Date:   Tue, 7 Jun 2022 16:21:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Vicent Marti <tanoku@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v2 1/3] bitmap-format.txt: feed the file to asciidoc to
 generate html
Message-ID: <Yp+zQvbo/e7XDsDf@nand.local>
References: <pull.1246.git.1654177966.gitgitgadget@gmail.com>
 <pull.1246.v2.git.1654623814.gitgitgadget@gmail.com>
 <a1b9bd9af90df88b7ce14de60a9626d2a1f2d3e8.1654623814.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1b9bd9af90df88b7ce14de60a9626d2a1f2d3e8.1654623814.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 07, 2022 at 05:43:32PM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>
> Documentation/Makefile does not include bitmap-format.txt to generate
> a html page using asciidoc.
>
> Teach Documentation/Makefile to also generate a html page for
> Documentation/technical/bitmap-format.txt file.

I am glad to see us finally getting around to this ;). I proposed this
back in:

    https://lore.kernel.org/git/b0bb2e8051f19ec47140fda6500e092e37c6bea8.1624314293.git.me@ttaylorr.com/

but I dropped it from later versions of that series, due in large part
to some of the formatting issues that your series here fixes.

Thanks,
Taylor

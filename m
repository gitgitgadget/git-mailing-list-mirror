Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB498C43217
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 00:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiKBApf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 20:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiKBAp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 20:45:29 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C7D1F2C6
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 17:45:28 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id n191so13800946iod.13
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 17:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SuhUFuN5Cpo8lev0RVdfH6T+SAotW6j+Z54QHeHWOw0=;
        b=GcEdAfqPtZs+ngf0vAc2Liuan5FRtOibB9iU86rkuYeMPp9Bp2v9BIu8n9YV5HigjC
         mNBqeUm5BUcMM1wyaUSeaZ3mz9KLs4UdJOEzmpikgOq/18yZRtG2lM/1ddwTwRUGQQhf
         7OtZAxsWuYed5ysQk6BV9Uns0Uh8GU+XOr74bAqWc3yDmYfGDQsBSeQmZux6dbzt1MkG
         I7SQ1O5xy9C54Bsnv8KvRf5PgJw4kQd2IRtgB2GEV2nvxZhcjl03hHliQcHJrT1tEiDv
         YCPJbu4wxQOV2HUVvXSd3rgOiWSLyfyfn7fvRv4bSz9px7t9XoPjWI2iX8xee1AJLC/E
         z46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SuhUFuN5Cpo8lev0RVdfH6T+SAotW6j+Z54QHeHWOw0=;
        b=t2FKedupG3rMgElYD7l5EMr4iG69TxTQ6dq3BgjmYvKbdgFGgwvJ5zUfW7Ilt44gwH
         7nRAh+O3xOq4Dq8Zna+q6XrqNmT15Q/xHo9Nf4AREGfFa0auBI6H6yDgLzfZPKOLKTXr
         PvYE21vDq9oxsPDPJ40wc+k2swFoN0GhoHoghHhFM9WO2JqfNw9d+opLKRA+Hig10tK9
         LxWmU0I+QCoc5aNHTRmZ4JnmT6Tyv2eI8i/b7x8mYHUpMZqMfYv+Z1sK2AUoZYMmyqU4
         Ov3UXfIEnrQnDL4t2ooGr+ZlqBOoAH2LRrW1aqsPBXs23C+8wrw2rqeWizSbmcQCeix1
         YBsw==
X-Gm-Message-State: ACrzQf1o6qNP14Wssa87ZQ/04wEEArAbK48UXlgwW/cnkrj3nT8n3bbq
        Q5myfRnOSLFXxn1yFNGN/vcOqQ==
X-Google-Smtp-Source: AMsMyM7t31KU7Bgmv0W9NaCjgwsKZnECUci06I6cpYtbgPI8Jp6VUNnBatzipJCnE8t+q1JFxu5qog==
X-Received: by 2002:a6b:c6:0:b0:6c5:7b3f:4fef with SMTP id 189-20020a6b00c6000000b006c57b3f4fefmr14088998ioa.165.1667349927542;
        Tue, 01 Nov 2022 17:45:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d124-20020a026282000000b003640dc54d5asm4437659jac.14.2022.11.01.17.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 17:45:26 -0700 (PDT)
Date:   Tue, 1 Nov 2022 20:45:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Subject: Re: [PATCH v2 1/1] pretty-formats: add hard truncation, without
 ellipsis, options
Message-ID: <Y2G9pc/apyekUfcM@nand.local>
References: <20221030185614.3842-1-philipoakley@iee.email>
 <20221101225724.2165-1-philipoakley@iee.email>
 <20221101225724.2165-2-philipoakley@iee.email>
 <95cf6a8c-2f51-a79f-2270-82f0c3e1cea7@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95cf6a8c-2f51-a79f-2270-82f0c3e1cea7@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2022 at 11:05:50PM +0000, Philip Oakley wrote:
> On 01/11/2022 22:57, Philip Oakley wrote:
> > Instead of replacing with "..", replace with the empty string "",
> > having adjusted the padding length calculation.
> >
> > Needswork:
> > There are no tests for these pretty formats, before or after
> > this change.
> >
> > Signed-off-by: Philip Oakley <philipoakley@iee.email>
> Doh. Too busy doing code and text fixup!'s  to notice the commit message
> needed  a tweak.
>
> It's late already so that'll be tomorrow.

It happens. I'll take the new version in the meantime, and await a
reroll from you when you have a chance.

Thanks,
Taylor

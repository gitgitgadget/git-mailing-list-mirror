Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1424FC6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 20:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCTUfQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 16:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjCTUfN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 16:35:13 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DE0125A4
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 13:35:11 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id w4so7174542ilv.0
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 13:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1679344510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4W1VhVgTcvoOb3Mvisfs55eaYidk33wzONrUvi3FBT4=;
        b=8F71IDqwyiDv8kBpiXoiHHYyIrmAIPPsnAgabGsQFehNR03WoBR5YrBx93NMlvt/CK
         891xyvGCG2qXLjvvVpNmxeDXQokdGZ4H0Q61Dmeqi001dQHyyKr0I5THu0ucNYzgOGRi
         9gMDfjogUk9Ilh2ZPckfYUtvk1EBY21xU/PowTNcF/Bef3jfdPG0xsW3GJz2+jzouk5J
         5dGuqRlXSbAFIBCLu3S+OopEHSXl/vMnAHCewXebrn4GIpwj69YjYsC6KLeO4H+jOI4F
         pdAvd9LPO74O9qwSD5dewBWfUHmCuJMuRKBMzCK7cly/RyuUtPvLgAX7wlFK44ixqTk4
         MZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679344510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4W1VhVgTcvoOb3Mvisfs55eaYidk33wzONrUvi3FBT4=;
        b=jBetpMr3rElTD1bdn+FLGjGvdl1/8moQfJMG68hfKjInVhRgv/mroVk1bkTn02J9vE
         AFZ3Liec84MvqwYkrc/La7MzdbkHxLtyEDeO1+MaD9F2znbODB1Q6qYBhl5wcDNt1/wq
         SMWs0xcZQm5xa3PyPvaoivynoUsFGvLofgl8k6Mlt2j/ZZvn9K13HWCSOzbyQRuMMaZH
         /B43rBakIyEmxEHE0yxl0bYq0vhxVvYGbRAwJkAXo2QAkEbR745LPc2H/yQjjLlkCv9j
         kotCBDFf3yXFpkNrbJFu8N514lKvnYtBUKI5DVulB+annIHYPBQWZQPPjjRIx6tmBniH
         lglA==
X-Gm-Message-State: AO0yUKXfu4s1pjsNGbbFQVEm8q2fYg97mQjMn4WP66JsKTRRf73QRB+I
        GO/TpZmdrO8Fq2utsNcvVOsLQSCuEoi7R3sBeMNeVA==
X-Google-Smtp-Source: AK7set+s+/QyABWXiO9noSJMuMCBr7jCIwzFLvw1bF6jXkraTIpux1/d0bHmA/cC919T7FBjfsrdxw==
X-Received: by 2002:a92:2909:0:b0:317:97ab:e5d1 with SMTP id l9-20020a922909000000b0031797abe5d1mr587393ilg.12.1679344510515;
        Mon, 20 Mar 2023 13:35:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j10-20020a056638148a00b003eb1eee43a7sm3446030jak.112.2023.03.20.13.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 13:35:10 -0700 (PDT)
Date:   Mon, 20 Mar 2023 16:35:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org,
        Paul Eggert <eggert@cs.ucla.edu>
Subject: Re: [PATCH 2/2] git-compat-util: use gettimeofday for current time
Message-ID: <ZBjDfT15489G1o3Q@nand.local>
References: <20230319064353.686226-1-eggert@cs.ucla.edu>
 <20230319064353.686226-3-eggert@cs.ucla.edu>
 <20230319193449.M629601@dcvr>
 <xmqqh6ufo01u.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh6ufo01u.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2023 at 09:33:01AM -0700, Junio C Hamano wrote:
> Yeah, this is interesting.

Definitely so. You learn something new every day ;-).

> I however wonder if we should follow our usual pattern of implementing
> git_time() with the identical function signature as what we replace
> (i.e. system's time()), and #undef/#define the symbol we replace with
> git_time, though.  Wouldn't it make [1/2] a lot smaller and
> future-proof?

Yeah, I agree here, too. It was my first thought when I started reading
Paul's patches here. I think that your approach is sound and I would be
happy to see you queue it.

Thanks,
Taylor

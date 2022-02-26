Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4BEC433F5
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 17:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbiBZRdW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 12:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiBZRdV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 12:33:21 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA362E9
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 09:32:46 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id r7so10255888iot.3
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 09:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LhGBfEkCRIJuRFFg7IrM4uC6oi93bf17nR07xpC8qS8=;
        b=EgVWVLJXLjScYWzvhB/Yto/aQxs8ea9jM6jO8OUI5yvQFmZpqFwWHYmppOrlB1j+rh
         2XtxFQAaB67EYQoh9OBi0eWU51e/TLLWU0LlV21+Yo5H3snc2nbP3XJ2BYl5hVOLt+oK
         7vPXHhCBUgz0Ljwmkw4eIju+5KpJ/Ui3isnOqj1pQHVesrieM037Xrp646q9h7mGjRkg
         8ohBvlrzGHELX7wXcLgpRREaFL/cXRqsk1JZTf169M+41MoGR6slJu+4HQSkzu81dOtB
         txrxY7xf4Z3pYbBF2SSQspSQ7Ck0GOaGtYi7/1XLMGIxxuyCI0MXXqV9/eFSe8JsMZ04
         uzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LhGBfEkCRIJuRFFg7IrM4uC6oi93bf17nR07xpC8qS8=;
        b=Xzphj7Z47FIInDVuPUwTLlX2SyQe8DfEQqJk/k79pWGX9HkrIOJTP1luRg2W7nlWef
         zd6TFhhQ8Qhas4lXzaAqwukds06i2Y0YiWH1jadGWKbLK45MhvM7XL7TQxemL5oguk8E
         5q8Pi7pn1I27TUe2m49kJxa2Vv5aBd6/qKb+Bi+k55jVxgku88UHOUxHKyXRqLcTBFZ8
         jezzDxR+0PZG4s2022AadJUvmQczM6VD8VfytzhYR5gxNWrLBEaGOoNjNakyhITpNS7w
         MJTK8wtCu64ksLmKoPsm2JOUAeoEfNUBg5g8iAfQ/YZKwR1vovLHmRf62JBFtaYwiV0E
         9zuw==
X-Gm-Message-State: AOAM533vm6Jmr8hK7dk0GtKJIv5uVdZJi4a1kzpZ8YJVVd2PX6oxrsAw
        QLIdFJeeD7rM5FRv9mOlRQXypQ==
X-Google-Smtp-Source: ABdhPJxsp34HWI+GZJj5r9reyDUI+g0vaZJSlwi9Ub5jvsdiaTtMdaVcN9L7OUkMKl5vBttcoHDzOg==
X-Received: by 2002:a05:6638:24f:b0:307:4e3e:696d with SMTP id w15-20020a056638024f00b003074e3e696dmr10100808jaq.90.1645896765451;
        Sat, 26 Feb 2022 09:32:45 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e21-20020a5d9255000000b0064160848e5dsm3183102iol.52.2022.02.26.09.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 09:32:45 -0800 (PST)
Date:   Sat, 26 Feb 2022 12:32:43 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Shubham Mishra <shivam828787@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] t0030-t0050: avoid pipes with Git on LHS
Message-ID: <YhpkO8ThwaHK3LIF@nand.local>
References: <20220224054720.23996-1-shivam828787@gmail.com>
 <20220224054720.23996-3-shivam828787@gmail.com>
 <220224.86o82wab31.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220224.86o82wab31.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 24, 2022 at 09:59:45AM +0100, Ævar Arnfjörð Bjarmason wrote:
> You're modifying some tests here that are using some old coding style,
> so maybe it's better to adjust it while we're at it?
>
> Also I think this would be a lot nicer with test_stdout_line_count and a
> helper to deal with that pritnf, e.g.:

Thanks, Ævar for the quality review. I have nothing to add here.

Thanks,
Taylor

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0E0C6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 18:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD79F60454
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 18:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhGVRcj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 13:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhGVRcj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 13:32:39 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301F2C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 11:13:14 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id p3so6211853ilg.8
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 11:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Gd4P/Hd4Qamd+0bi9Wnrgp/RUQ6tqY6fYcgUnTqCrB4=;
        b=hgtbE2eoLyi4FEovBsyuFZ/vUcmulE+IcJN+a9IhB0CM4j9npqQil9MTqjRJZNryhc
         lWvjoAXQMqRzIwtAII0rzXi1mQ1c4T89jjDkN3Gm6qJu4m2+ZThAGNkojq0Ip8d5jeA2
         UAsoXhP6KYX7iDKabW8BM4i1hFgUwD+I6RK0f0bcqZg2T5qs9Z5DsVG9RtRZ6iqm4zOt
         04iJgilE5fmkpcBVvBMXCCbRxPCBNBdNojoWSMwG0KnaxcccA0QMiHKlP8r28UA5/DMW
         hj5xnMCLMiEwXAPsU+Wv3w6EAqHiQya/zSb4Gl1bZRPXIap/yzQKxxe107a5SXA1nj0Z
         TBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Gd4P/Hd4Qamd+0bi9Wnrgp/RUQ6tqY6fYcgUnTqCrB4=;
        b=G9gP+/UT976O1CTNhyVsGhii4nbU+Hv51G/MpwybEXjqWMUoxLqxBlhkufinDTEj6B
         AJqAiRt8DCNGmIPHWGRvGaHr4lr2+sjjc+50abiIKlnqqBwz9qNGmIWtOJvkWooBaQv9
         TzB1PrOpcOe/wGqvNvO+W7EETmIZeluTM93nLyGrNQT1VJ6zblS0RIK+0ZIXBBGPpRA5
         VogECi7DliZvDadB++ubEZiFDXNFFqWcpm8YIljkPDJeIcz3KiQLh3/W6aXnB2fmXLQy
         1HECUX2ceP4IeUE7uVQT396kvpoRv7z4hshnYWKmQaiuMcsyU4S3WrwriLaktsVSQkpC
         eXMQ==
X-Gm-Message-State: AOAM530yySnvIzOvMDZQdgNlxlWL/LRIGrPfejJ4O01wUX5lvLPmWfbj
        WeaaoqFRiJT9c+n/dYNO5BmejA==
X-Google-Smtp-Source: ABdhPJyuY8TCsC9DrQjmaRh5fXLXEtrXZMwa1smb8Xi5U6I/Atk+1p1qvnzfZBrO/FNlgZZplltcyg==
X-Received: by 2002:a92:d84f:: with SMTP id h15mr754442ilq.12.1626977593588;
        Thu, 22 Jul 2021 11:13:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k4sm16559892ior.55.2021.07.22.11.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 11:13:13 -0700 (PDT)
Date:   Thu, 22 Jul 2021 14:13:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 2/2] bundle tests: use test_cmp instead of grep
Message-ID: <YPm1ODTi2wX103My@nand.local>
References: <cover-0.2-00000000000-20210720T115052Z-avarab@gmail.com>
 <patch-2.2-062f34abf1a-20210720T115052Z-avarab@gmail.com>
 <YPcE24InpY4evFyE@nand.local>
 <87fsw7ussi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fsw7ussi.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 22, 2021 at 01:53:54AM +0200, Ævar Arnfjörð Bjarmason wrote:
> > Or, if you wanted to go further, you could do something like:
> >
> >     cat >expect <<-EOF
> >     $(test_have_prereq SHA1 || echo "@object-format=sha256")
> >     -$(git log --pretty=format:"%H %s" -1 HEAD^)
> >     $(git rev-parse HEAD) HEAD
> >     EOF
> >
> > which is arguably a little tighter (although I find the
> > echo-in-a-heredoc thing to be kind of ugly).
>
> This one won't work because you'll have an empty line at the start under
> SHA-1.

Ah, you're totally right: good catch. I think it's avoidable by smashing
the first two lines into one. If the subshell prints nothing, then the
first line will start with "-$(git log ...)", otherwise, if it does
print something, then the echo will print a newline to separate it from
the "-$(git log ...) output which will go on the second line.

But that is definitely uglier than my first suggestion, so I'm glad that
you didn't try and make what I wrote above work :).

Thanks,
Taylor

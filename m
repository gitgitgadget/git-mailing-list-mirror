Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133B3C77B75
	for <git@archiver.kernel.org>; Sat, 20 May 2023 00:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjETAhI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 May 2023 20:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjETAhH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2023 20:37:07 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E605124
        for <git@vger.kernel.org>; Fri, 19 May 2023 17:37:06 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d2c865e4eso1392814b3a.0
        for <git@vger.kernel.org>; Fri, 19 May 2023 17:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684543026; x=1687135026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=olPSuZTbsPb0W9faHxUCmK4lOhu7+c3lUUUuzJMqk9o=;
        b=Tf3nREgJq+pUD70zc6fU7UA/tvMw7fPrR6skcvavd5vu06SGCe4/hqhP5MDgY6k2gK
         EU225h0XDLYXAqP7YVMRnYGH6NQSoK9eL4MvNvcZBD+90/cI/i63B5tgr8lYVUUmWOfn
         a6iKPRU0gG4ZTnZXWMrVukvvxEItwgAIYRhn2h8A4IKkxwFdMbXIYY0IuXP/40f10JCh
         6no8hlOIQbi00n9kCDbJ4+X6cXzITFjSRlrT7c+K2nPzZ2wUs1HDJA+bwV0kGEmITz3e
         n1CBCJJnWk44SyPHEMPSTwz2Zd3Knqc4OaNWL5j/x4gOgZbv5z0VjugWkKaHxEnkV/mO
         pprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684543026; x=1687135026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olPSuZTbsPb0W9faHxUCmK4lOhu7+c3lUUUuzJMqk9o=;
        b=fRjkAiHNvPUCLdv6m5NYBy2PR2UPakkf9FCw/dVBSZ7jROEanGGrQ3uz5X1GieI94x
         cVn/AQNxq+mN3ta4707de0/gSzUQEfUfUG+cDlYfRRHHk/SEzHH300Sv2iUseP9NWUeu
         3/H1FgeiZ0dP/YlaMdK2XjnBnBhcePTAwhmUAElONjxlz0fH8gNlKer0GU/wATh+SHWs
         fwi3r4Pskp5i8Tb7JSBJQA/VWWOabAjEbOWG7pXbDUtnyJeqNyjymlj1pAyWmgVZK+18
         wJN+3i4jdGLBlZWtCk9mDjWH2yUbYjyLnQ5e9UThGIUtlpCK4f39dmyT0y6eg2RivJcr
         ttiw==
X-Gm-Message-State: AC+VfDwtSHyg6cDnsngH0CfrdfOqcguzqhjgcAgztan59/JwHVAoTPj2
        d0MuzzG5tySihiuayu2Ynks=
X-Google-Smtp-Source: ACHHUZ7oYf77nLCZ4nAvdzqBEoMg866ct60nNGeRqQMAyrZt/IT17Dy/eOksU7eO20hBRuZORpneHw==
X-Received: by 2002:a17:903:1d1:b0:1ac:8837:de9 with SMTP id e17-20020a17090301d100b001ac88370de9mr4733947plh.3.1684543025948;
        Fri, 19 May 2023 17:37:05 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local (192-184-219-167.fiber.dynamic.sonic.net. [192.184.219.167])
        by smtp.gmail.com with ESMTPSA id t9-20020a63eb09000000b00502e7115cbdsm298977pgh.51.2023.05.19.17.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 17:37:05 -0700 (PDT)
Date:   Fri, 19 May 2023 17:37:04 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     M Hickford <mirth.hickford@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Which macOS versions does Git support?
Message-ID: <k3dnos4h7i4sjxzotiqwhz47wc2qvuzpii4wgysgt6ywoi6dx3@2ggmoesxlqsi>
References: <CAGJzqsnS3SnoW__aPQ+13s+-b3a+makCjWxR=z6mjgBBnuKjLg@mail.gmail.com>
 <20230519090917.GB3515410@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519090917.GB3515410@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 19, 2023 at 05:09:17AM -0400, Jeff King wrote:
> 
> I'd guess that anything older than 2009 is probably not worth worrying
> about.

FWIW Mac OS X 10.5 (Leopard) was last updated in 2009 and also happens to
be the last one that can run in PowerPC, so sadly there is a non zero
number of users for it (MacPorts uses a minimum of 10.4 for that reason)

Carlo

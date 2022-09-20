Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08B1C6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 20:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiITUL5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 16:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiITULz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 16:11:55 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABC072856
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:11:54 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z13so5456754edb.13
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=7tIOao6zwDa37OQo1F1PEyqu+RlWQE5beUvWAc4xzSw=;
        b=ksxTuOpcwLokaFPgqgrdNviJUuULO0U3e4Bv75n3Nvr6Mjm8T4j7+Hz1vfoeAqRxP4
         Kk+Pq2Qm7dyz9hbe+OxPFkiLH1e31YDb3Gj92B+tWOfSCT+r9Qva2FdSYW8jcODhsLbG
         YmMxKghvfRVinTlJUiK6TwxHH+QaFxtkqICxFV/l/looXBjCrwivhJWhRPBFk2i0sl3K
         2P3ao3/GQ+p59UeLr3KYvcM5mr6r2dyI+/FoD3hc7NZOLf4M9gS+Xv4dQOkaS8/EWm9M
         C4Qx/OsHlz0dXTYeoih+ER8TMQ5yZgMRkV8eh38c3YVfERiTtpFQzHyx3agi7YzTNy8n
         x0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7tIOao6zwDa37OQo1F1PEyqu+RlWQE5beUvWAc4xzSw=;
        b=Jz4o4E2LSrHbnOpc3HFnC03WORaS4C0UMYLUkBPp6RufUqepf0LY1KobB7u57cMhhl
         hA8WdpCoi9XQi0NcaW6+sH8viVqIkLSass4UJd9isX+gxHZ69A8rF2ltsZDKjtK0++kS
         C6nNqiKg9UlU+YfB5Px7KjOG3NMx4N4DVgEvk5Job+asIFmzmXuNrqU+ld+uCqVeEBew
         o92re53cnVsFVCIlE2zXrnmZ2mzty2rY4Y1PKgyLqJ07Eln6Z6Fjchz/3vSsbK+rWBnk
         rmed6iDL6E5u+aRE7oNREYzaoQXhJscs7ksplIXA7nXD2SzWnJSIhupv+zKGkRlYnQQh
         o9tg==
X-Gm-Message-State: ACrzQf30Kc0rFN/wN5Zwy5KF5OFaHAOggSKC38arGsiQi1eJKs0dkQyz
        LRFyoAGMu1SUT+fs8xyFbG0=
X-Google-Smtp-Source: AMsMyM4ZAcReGTFtqDPv06FMdUgE7mSD6PFBrIj0RJhpHlF9TNcroJE3BjKC2GG1P0s88kAjKYYpgA==
X-Received: by 2002:a05:6402:180d:b0:453:bd1d:421c with SMTP id g13-20020a056402180d00b00453bd1d421cmr13872048edy.311.1663704713050;
        Tue, 20 Sep 2022 13:11:53 -0700 (PDT)
Received: from localhost (78-131-17-3.pool.digikabel.hu. [78.131.17.3])
        by smtp.gmail.com with ESMTPSA id t22-20020a056402021600b00443d657d8a4sm396109edv.61.2022.09.20.13.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 13:11:52 -0700 (PDT)
Date:   Tue, 20 Sep 2022 22:11:50 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] t/Makefile: remove 'test-results' on 'make clean'
Message-ID: <20220920201150.GB1704@szeder.dev>
References: <patch-v3-07.15-c7ea6dc013b-20220727T230800Z-avarab@gmail.com>
 <20220920105407.4700-1-szeder.dev@gmail.com>
 <YyoZsjf3FSxLuuKY@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YyoZsjf3FSxLuuKY@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2022 at 03:51:14PM -0400, Jeff King wrote:
> On Tue, Sep 20, 2022 at 12:54:07PM +0200, SZEDER Gábor wrote:
> 
> > The 't/test-results' directory and its contents are by-products of the
> > test process, so 'make clean' should remove them, but, alas, this has
> > been broken since ee65b194d (t/Makefile: don't remove test-results in
> > "clean-except-prove-cache", 2022-07-28).
> 
> I don't have that commit.

Uh-oh.  Me neither :)

> I assume you mean fee65b194d, and what you
> have here was a version before it hit 'next'.

Looking at the reflog, it seems that while rewording the commit
message I inadvertently deleted the first character of the SHA1.

> > Add that missing cleanup command to 't/Makefile', and all sub-Makefiles
> > touched by ee65b194d as well.
> 
> Ditto here.
> 
> >  contrib/scalar/t/Makefile  | 1 +
> >  contrib/subtree/t/Makefile | 1 +
> >  t/Makefile                 | 1 +
> 
> That patch itself looks sensible to me.
> 
> -Peff

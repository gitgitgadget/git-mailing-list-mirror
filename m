Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F5C71F62D
	for <e@80x24.org>; Mon,  9 Jul 2018 04:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750789AbeGIEFn (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 00:05:43 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:35878 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbeGIEFm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 00:05:42 -0400
Received: by mail-yb0-f194.google.com with SMTP id s1-v6so6686612ybk.3
        for <git@vger.kernel.org>; Sun, 08 Jul 2018 21:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fUgIWqPH9lRALX95Y5GttoldC3wAdZ0kpQuVaFbj+Qw=;
        b=tRcvu4FdBTBoumQ7Eb/XrfLAjXbW3WiKHfvyVTR/8juyhw3E5S4TFNz7i1g/jSIh9D
         4tdQOPO5IwgO+qzyGPvzWM1xPsl/6xqJGkn55gZmcA4QprT6pQpCaRWx8DvZSS1EwB+i
         xTEsyA0hIEAAyF4opI9wlC/CDAzJ1moZaDChFqQtVksfdbI7mVkiJFa7Un79cPA13eCX
         Qc262qgJx082rp9YGj7eGZn05EarPJ5cv+o8wzhnNSWlKqOGog1BHwfkWb9rGNfIObpB
         nTM3N77n+IFieb2el/vhUmLV4UFD3ZPdERPnLHW73YeYpr3gwyxphWLCoNfcijrVmYlK
         n6eA==
X-Gm-Message-State: APt69E2Q5FaEwqsND8RERucBorwjKm5R/drh9w+r52fsl9UEap0dSxQA
        QVTuskigykP9+o/aG+5qj2+44ZRx2eDgw1xgXy0=
X-Google-Smtp-Source: AAOMgpdU0JK9VT5Qoi+/hb/EaeIfGlz8BzefNc18XVZbap9zh6lOR27MxQ0V6NhIoQCd1aLsvh8AvgANc3wJ0rSEbcs=
X-Received: by 2002:a5b:601:: with SMTP id d1-v6mr9916671ybq.295.1531109141562;
 Sun, 08 Jul 2018 21:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
 <20180708233638.520172-2-sandals@crustytoothpaste.net> <CA+P7+xq900ikNR3uBEo28rjrTh5iYJm-R8jcAjhq-7G2jh3iVA@mail.gmail.com>
In-Reply-To: <CA+P7+xq900ikNR3uBEo28rjrTh5iYJm-R8jcAjhq-7G2jh3iVA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 9 Jul 2018 00:05:30 -0400
Message-ID: <CAPig+cRznUKdriPhHMt5ocb_pXbByY5a40A8ZOiqF=_0hm7avw@mail.gmail.com>
Subject: Re: [PATCH 01/17] cache: update object ID functions for the_hash_algo
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 8, 2018 at 10:38 PM Jacob Keller <jacob.keller@gmail.com> wrote:
> On Sun, Jul 8, 2018 at 4:39 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >  static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
> >  {
> > -       return hashcmp(oid1->hash, oid2->hash);
> > +       return memcmp(oid1->hash, oid2->hash, the_hash_algo->rawsz);
> >  }
>
> Just curious, what's the reasoning for not using the hashcmp anymore?

hashcmp() is specific to SHA-1 (for instance, it hardocdes
GIT_SHA1_RAWSZ). oidcmp() is meant as the hash-agnostic replacement
for hashcmp(), so it doesn't make sense to continue implementing
oidcmp() in terms of hashcmp() (the latter of which will eventually be
retired, presumably).

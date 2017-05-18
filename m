Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAEFA201A7
	for <e@80x24.org>; Thu, 18 May 2017 00:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754589AbdERARW (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 20:17:22 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:32986 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754460AbdERARU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 20:17:20 -0400
Received: by mail-pg0-f46.google.com with SMTP id u187so14332561pgb.0
        for <git@vger.kernel.org>; Wed, 17 May 2017 17:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VSLcbqfJu8qpXVFuwAeHwm2B3nEkP87ijYE9gWBzKKc=;
        b=RyCkvA8HgNtri+PNTH0EQzIsPz0HwBtMe6x2iecKAL7jvBjGN7rucyI1GC82+ln8zH
         ZU0G9YQGPIDg9iHGqoQNYNHol8im7kHEHgMZLA7ToW43iSP3moPoRXJf9uUAbme+ocvV
         YYaJGoAWX3DMPDs1d/FZsqJ4ICXJSs4sNehAOJNM/OjaEDXoLHFZs6QM77zB+yMT1naK
         9J5vN0wDGhtNIzEQ42snMcU9K/Yu15axNQPlPp6O3IHKLPsFc3LeEnHTTlAGL2pWXHqZ
         tLiWVY6WumM0Ui/xhhTjO6tgC64O1SVaaz1p7xZShrwqfoZ7iCUVkMWSsOcXmIsGRQ2p
         a/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VSLcbqfJu8qpXVFuwAeHwm2B3nEkP87ijYE9gWBzKKc=;
        b=ihcKqddlaRhVgPfI/+CJhUfjgeIGCu+W+so7Dqap1zkh9crDIN/kUhUaKs0VbsBAC4
         Z2WOQuTc5Xk37bCardhtKNEK7dXj68WY6nkkHzoZ0EQ9s7Lvv+RdwoNAETSfQP0VaFJd
         UXsI09ILNkWtptf2S+LE/1PN+M9C9ZvOSaKU0NXTLYtl1MKj7Cqj/Ka3HIUEoeqATq89
         MNGFBsw/uqnjevU6N1GXkh60WOqJnlFzB8JcsXvLnwBhpMEuYvEiRJ8VyHbVWF8EVz98
         J01QOlrddMWOUn2qmJZ0e45UGnf6rK0PTOPaoRkMSmWfIqUo2RCasNnBsKUUpEpirYUB
         yo+w==
X-Gm-Message-State: AODbwcDt69pGwifplEfGBabYMG6fAh3txyylU5Xh/UegDA9zhjvr/yJT
        A5O4sbsQPu3Rz4nE
X-Received: by 10.99.163.67 with SMTP id v3mr1383917pgn.210.1495066639480;
        Wed, 17 May 2017 17:17:19 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:1838:1185:c4dc:8c8d])
        by smtp.gmail.com with ESMTPSA id x18sm6124367pfe.13.2017.05.17.17.17.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 17 May 2017 17:17:18 -0700 (PDT)
Date:   Wed, 17 May 2017 17:17:17 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 10/23] files_ref_store: put the packed files lock
 directly in this struct
Message-ID: <20170518001717.GF185461@google.com>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <dd7637060bac1a27e03563edc82649812dcf897c.1495014840.git.mhagger@alum.mit.edu>
 <20170517131753.rditx62clmkrdmeq@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170517131753.rditx62clmkrdmeq@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/17, Jeff King wrote:
> On Wed, May 17, 2017 at 02:05:33PM +0200, Michael Haggerty wrote:
> 
> > Instead of using a global `lock_file` instance for the main
> > "packed-refs" file and using a pointer in `files_ref_store` to keep
> > track of whether it is locked, embed the `lock_file` instance directly
> > in the `files_ref_store` struct and use the new
> > `is_lock_file_locked()` function to keep track of whether it is
> > locked. This keeps related data together and makes the main reference
> > store less of a special case.
> 
> This made me wonder how we handle the locking for ref_stores besides the
> main one (e.g., for submodules). The lockfile structs have to remain
> valid for the length of the program. Previously those stores could have
> xcalloc()'d a lockfile and just leaked it. Now they'll need to xcalloc()
> and leak their whole structs.

Wait, why would this be the case?  I would assume that you would
allocate a ref_store (including a lockfile for it) and then once you are
done with the ref_store, you free it (and unlock and free the lockfile).
I'm definitely not versed in ref handling code though so I may be
missing something.

> 
> I suspect the answer is "we don't ever lock anything except the main ref
> store because that is the only one we write to", so it doesn't matter
> anyway.

Really? I can envision a case in the future where we'd want to update
a ref, or create a ref inside a submodule.

-- 
Brandon Williams

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCE042027C
	for <e@80x24.org>; Thu,  1 Jun 2017 09:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751767AbdFAJez (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 05:34:55 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:36219 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbdFAJee (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 05:34:34 -0400
Received: by mail-it0-f49.google.com with SMTP id m47so31871540iti.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 02:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OKPlPLW7Fe6N2b+OyPoCtqHI/hphVF4aeDMd1RtsD60=;
        b=nr/ySSLRqXmY969BXx26qhlPPSZNJ524Mut6m3KZBN9o0zWeoe8mSWHkThJDyKGSTq
         z4m3IE3cbQmXEewGIwnomidjyfF5Zo+OV1BcZIYY+D6E/2VDR0OVid4NotW2nkr8P3VQ
         8HRyCGUcAE6NXjqbq2QdizC4gebjG5g79g6twz/qPTp/0US1pJJ1fpO29I+DjVkeldhf
         8zz45Li8lkQ1q96ulG6L9VhCRJe+m/0+NTtObFD2UXQiaO/zZ9bKNKpDUChyyZ+jJAuh
         1fceEg9IT6XfJzF3b/ML8bTrKSyfA9UV5Z6K66hYNiPWznTUWmAQbU59Dx4sGH4Uku4E
         TOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OKPlPLW7Fe6N2b+OyPoCtqHI/hphVF4aeDMd1RtsD60=;
        b=IVZlXIvqN9tYfk8dQqRTNIUNgjc7ZcXNXa0OAt6gPqpZqxe7Flm3ZljfvOxmjmZHtK
         p3KIW73RRsqfrbja3N/82V41xoicwLhNcWxVDiUnGU4xNnYNEbn/IPrW5cEPQRfIhrIe
         1SwdC7oT4thQ37cNK2jtz++AH1Hb5NOXAD+VqhOK+A/wZmvUktyWcpnOrdFWHb4OZGoA
         8hQpjuFn3dLldA9ik2X/kSQKnrbHkYhSxygGXKM+/aamLPJK2jPQPXiV5vzjF/0s+q/s
         oBPNU4wgQrYWKJDSQZDyImppsU2z1N5d4M3QLu8rOAMenST33Os66/nrWMO+7Yqpo5F2
         GPfg==
X-Gm-Message-State: AODbwcDk74JEfjDkUW4p5d+VpcmBCoIam/1S6oTvTuImaPCjT3kx50GE
        TvRQzhM9NIVtGQ==
X-Received: by 10.36.80.7 with SMTP id m7mr1764937itb.73.1496309668943;
        Thu, 01 Jun 2017 02:34:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9c1c:dca9:c6e3:133e])
        by smtp.gmail.com with ESMTPSA id l10sm12413946itl.4.2017.06.01.02.34.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 02:34:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Schwab <schwab@suse.de>
Cc:     git@vger.kernel.org, Marc Stevens <marc@marc-stevens.nl>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Unaligned accesses in sha1dc
References: <mvm4lw0un5n.fsf@suse.de>
        <xmqqk24w5asf.fsf@gitster.mtv.corp.google.com>
        <mvmvaogt6eo.fsf@suse.de>
Date:   Thu, 01 Jun 2017 18:34:27 +0900
In-Reply-To: <mvmvaogt6eo.fsf@suse.de> (Andreas Schwab's message of "Thu, 01
        Jun 2017 11:15:59 +0200")
Message-ID: <xmqqfufk59wc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Schwab <schwab@suse.de> writes:

> This is git 2.13.0.

Thanks.  It is a known issue with a known fix cooking in 'next' to
be merged down to 'master' and 'maint' not in a too distant future.
An extra testing to ensure that the "fix" actually works before it
is merged down to a maintenance release is very much appreciated.

    $ git fetch git://git.kernel.org/pub/scm/git/git.git/ next
    $ git checkout v2.13.0^0
    $ git merge a0103914

should show what the proposed v2.13.x would look like wrt to this
issue.

Thanks.

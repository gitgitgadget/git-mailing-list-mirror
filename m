Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FAF920286
	for <e@80x24.org>; Wed, 13 Sep 2017 19:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbdIMTSv (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 15:18:51 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:45489 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751961AbdIMTSn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 15:18:43 -0400
Received: by mail-pg0-f53.google.com with SMTP id 188so2132561pgb.2
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 12:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bKh9RQRpOZguT7Te8hjSILVJo7K/c3XpVHxN3znhxgE=;
        b=C+Gn8zxhxOoPhSk/PBgUaTkpiH3qxXCxPNlH/Q7dLKy24Om+1MZnmu62U0Au38JJR4
         Q2OUWLw4ZQXPPGHFOOWCaWBGOMDxzgJYnbPwTbxJBn/yxByXIA323MlQ0CKpGrPPEjGC
         PWbk8f612rTj3MJ4vjYZHYT8b2oANy3QFCUQC5fod1nUHdfR73T+IPBalvIOydZ2/+J1
         SpH1SNkR9eg5IVVNl3Qounhjv0MfjKzylufPN3bymeYzpEquy435a3lecojoxBQQ5iEQ
         smluXpk5/3WoK3d/AYS6/qqepALwV9zIWXeMj6DF7gHS5811WISkfjPWD87BKhKfWSsc
         PuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bKh9RQRpOZguT7Te8hjSILVJo7K/c3XpVHxN3znhxgE=;
        b=FmmoZm9oAGnmwny5ZMpfT9JKOPRlqjob3fuK7loOW5e4c0dLYupqVyI3aLFISYN85q
         WRA//mie1zRjg/DkMlBN0ti3H8C7O+Exw6duzCm0EwBBBw4pmklhkvjMoJeqlUE3pVKD
         nNDqkfGskNMu8dPGcM3nKeZyNBDSj94YXzkE8hgCvHN2ghiJHaq5fXiTlVSUz1peVai7
         I32Rsj7UpKj7DJaT58KvPEesmupztVH/ZgRpfuHUq111e+JZTjdnRZbZ8favt1zEBjQT
         5ldiEJoBqguYh1hFqkNhPy7FRRkFbA+6uFmuHq/IGXEqj6VPkegYyhuwfx+xopTJPXUe
         FlGA==
X-Gm-Message-State: AHPjjUg8RXjnlW0nxAmacDlnv1V92hh1CJa2cpv6+aI7jfvVJf1BeKfo
        yG10PRQY1fOHkQ==
X-Google-Smtp-Source: ADKCNb4aaAjXRdD2VrCAvzKiCjDRGn2wWp9MStJcU/w+lQQAxzgywiuMUz+FMKT4DBexHnY3hfgEDw==
X-Received: by 10.98.214.131 with SMTP id a3mr19155296pfl.115.1505330322650;
        Wed, 13 Sep 2017 12:18:42 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:d132:98b:3ff1:a635])
        by smtp.gmail.com with ESMTPSA id p10sm27377549pfd.152.2017.09.13.12.18.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 12:18:42 -0700 (PDT)
Date:   Wed, 13 Sep 2017 12:18:40 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] config: avoid "write_in_full(fd, buf, len) < len"
 pattern
Message-ID: <20170913191840.GG27425@aiede.mtv.corp.google.com>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
 <20170913171104.yu7ags4aq2zdwz6r@sigill.intra.peff.net>
 <20170913181515.p7u2ouine3ysblqc@sigill.intra.peff.net>
 <20170913182431.GE27425@aiede.mtv.corp.google.com>
 <20170913185848.5ht44spbakzkrsu6@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913185848.5ht44spbakzkrsu6@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Wed, Sep 13, 2017 at 11:24:31AM -0700, Jonathan Nieder wrote:

>> Compilers' signed/unsigned comparison warning can be noisy, but I'm
>> starting to feel it's worth the suppression noise to turn it on when
>> DEVELOPER=1 anyway.  What do you think?  Is there a way to turn it on
>> selectively for certain functions on the LHS (like read() and write()
>> style functions)?
>
> Obviously we couldn't turn them on for -Werror at this point. Let me see
> how bad "-Wsign-compare -Wno-error=sign-compare" is.
>
>   $ make 2>&1 | grep -c warning:
>   1391
>
> Ouch. I'm afraid that's probably not going to be very helpful. Even if I
> were introducing a new problem, I'm not likely to see it amidst the mass
> of existing complaints.

Yup.

Something like http://coccinelle.lip6.fr/rules/find_unsigned.html (but
not that one precisely, since it's not smart enough to follow typedefs
like size_t!) can do this for specific functions.  Then "make
coccicheck" would report new problematic usages.  Let me know if this
seems worth pursuing, and I'll send a patch based on the spatch I used
to review your patch 8.

Using coccinelle for this is a kind of oversized hammer.  I wonder if
e.g. sparse would be able to do a better job.

> AFAIK there's no way to turn it on for specific functions, but I'm far
> from a gcc-warning guru. Even if you could, though, the error may be far
> from the function (e.g., if we store the result in an ssize_t and then
> compare that with a size_t).

If we have a check that catches the obvious cases then I'm already
pretty happy.

Though checking ssize_t vs size_t comparisons in general might also
not be a bad idea, since it would be narrower than the general
-Wsign-compare check.

Thanks,
Jonathan

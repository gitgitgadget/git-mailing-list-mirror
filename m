Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1312BC83001
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 03:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4F2420709
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 03:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="nwjqie+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgD3Dna (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 23:43:30 -0400
Received: from mx1.riseup.net ([198.252.153.129]:57570 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgD3Dn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 23:43:29 -0400
Received: from capuchin.riseup.net (unknown [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 49CLns2jqszFdgj;
        Wed, 29 Apr 2020 20:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1588218209; bh=dMtv+FUrSiBruNF0hfCTk/VDpUqSP84q28qeoUtJoUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nwjqie+UzDlUnGsJg0kSQuMcQ7seULcwoPLvjrzi7bMWITIsWHuzARUogzTqxCBC+
         UBc0AkteVWZFKbe6BfdsCLrUkKon8mFNB4s1prr3qSMknSjBro15M+e/1yXeBHJV6t
         OMUZgwSlD5rz90aLecRpW7kSigrdTfdbcqBxLnm8=
X-Riseup-User-ID: C8CDA91405CEB3D8C2403F9A9BC29AFF81F9295A82086859C12B6016F858CFD0
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 49CLnq3cRVz8vMp;
        Wed, 29 Apr 2020 20:43:27 -0700 (PDT)
Date:   Thu, 30 Apr 2020 11:43:23 +0800
From:   Ivan Tham <pickfire@riseup.net>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] branch: add '-' to delete previous branch
Message-ID: <20200430034323.wwsxzru7pcw2xsju@arch>
References: <20200429130133.520981-1-pickfire@riseup.net>
 <877dxyo1k8.fsf@osv.gnss.ru>
 <20200429190013.GG83442@syl.local>
 <87v9likr5a.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <87v9likr5a.fsf@osv.gnss.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 10:50:41PM +0300, Sergey Organov wrote:
>Taylor Blau <me@ttaylorr.com> writes:
>
>> In my opinion, it is fairly clear that 'git branch -D -' means "delete
>> the last branch", and not "delete a list of branches from stdin.
>
>Honestly, I'd never guess it'd "delete the last branch". No way.
>
>"-" standing by itself in a command means stdin, stdout, or otherwise a
>typo. Using it for any other meaning is a blasphemy. Sure, nobody will
>die because of this, but it's /extremely/ confusing!
>
>BTW, what about mistyping:
>
>$ git branch -d - f my_branch
>
>for
>
>$ git branch -d -f my_branch
>
>or some such?

I already knew `git checkout -` and `git switch -` exists and have been
using them quite frequently as my workflow, but when I wanted to go back
to my original branch and delete the branch, I tried `git branch -D -`
quite a few times and I am surprised it does not work as expected.

Yes, that typo would have deleted a branch but it could be restored from
reflog at the very least.

>No, it still doesn't look like a good idea to use isolated '-' as
>suggested by the patch.
>
>OTOH, for otherwise unusual @{-1}, @{-}, or @- I'd immediately realize I
>must consult the manual, so these would be fine with me.

But yes, I didn't know @{-1} or @{-} or @- exists before I was sending
this patch, I only know I can use - which is very simple.

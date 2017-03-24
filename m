Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEB931FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 17:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933200AbdCXRxQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 13:53:16 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36463 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933123AbdCXRxO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 13:53:14 -0400
Received: by mail-pg0-f67.google.com with SMTP id 81so1707257pgh.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 10:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F691CH6a6kPJaJAZjO9AxImiGqtCX616kTY7NCvvhHc=;
        b=DBDklvPE/jb9HjYcHTyjvQZtUs0n6MScj2jBo/wPl4m73UvxiEMzTPWrQI2yvyPfy6
         wkXUdcGlkY6KyMqGtFJHgqULzVh6Qsj8Ff9UeWNlFPhphAx6409Mc7o9ObdVFTaLbxrJ
         CoKoL6+eIFKT//+VDluZ0RT5LwRpMMlEOb4mwsJagub2tAR59us7FNkQfHNldkv7qOAj
         XOCcFHMyBYRIrEcAkYYtjpcUBXRjAS5zmdrrrKUPJMhxYzkDS9MWLPwJqX6Sqw+RkjMx
         c0HEuxodMeekm0Ixas1vLFhg3Mrj95hWPjdBgWQ2akBCK9ghohJ+1ma3PZKMU6xpIm49
         /UsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F691CH6a6kPJaJAZjO9AxImiGqtCX616kTY7NCvvhHc=;
        b=FRRcyrWAcxjz1XuZUSLKX+lN1DSNhzcNt7dmP+bJumNl45INlVlrN6RPSROdxUug2t
         otVOnRNBD/5HF+cvMZ5akcEgok00JWEKG1E1VQkjeNeC1C8MFQ1kFd4zHVOOcmHkOM7m
         apemYdl90hgDoYE7VWoEfVQ6N5IEHd2xMo+mfK6SECWg9hORjCNUaBPupvEOYL9s12d2
         igMtrVHOqDARO2x94GsFc3vXM5ieNHsOdj4BGJyuwF5xcDx//IgcFnMlLtc8rLvZEoCT
         +n4D5jGr8W7dCM1sgtt+aF4NJn39i+UOMAWRsqQV7yiaSOqlFW/9T5Gos4IvTCCoxKoF
         jjaw==
X-Gm-Message-State: AFeK/H3adDOjkWAEWtqOr5XYgGsHCJwKgQcEO/k9TxgiaDEkZMxn9yE1N+YIglVJZSUzuQ==
X-Received: by 10.84.196.164 with SMTP id l33mr12595053pld.0.1490377993056;
        Fri, 24 Mar 2017 10:53:13 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:8597:ae41:db75:6a97])
        by smtp.gmail.com with ESMTPSA id n24sm5158147pgc.43.2017.03.24.10.53.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 10:53:12 -0700 (PDT)
Date:   Fri, 24 Mar 2017 10:53:10 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] read-cache: call verify_hdr() in a background thread
Message-ID: <20170324175310.GC31294@aiede.mtv.corp.google.com>
References: <1490362071-46932-1-git-send-email-git@jeffhostetler.com>
 <1490362071-46932-2-git-send-email-git@jeffhostetler.com>
 <20170324163540.GB31294@aiede.mtv.corp.google.com>
 <23685f59-138f-51c8-61f4-6f46d153ff89@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23685f59-138f-51c8-61f4-6f46d153ff89@jeffhostetler.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler wrote:
> On 3/24/2017 12:35 PM, Jonathan Nieder wrote:

>> What happens if there is an error before the code reaches the end of
>> the function?  I think there needs to be a verify_hdr_finish call in
>> the 'unmap:' cleanup section.
>
> But the "unmap" section calls die().  Do need to join first ??
> (It's OK if we do, just asking.)

Good point.  Now I wonder why the 'unmap:' section exists at all.

	$ git log -Sunmap: read-cache.c 
	commit e83c5163316f89bfbde7d9ab23ca2e25604af290
	Author: Linus Torvalds <torvalds@ppc970.osdl.org>
	Date:   Thu Apr 7 15:13:13 2005 -0700

	    Initial revision of "git", the information manager from hell

So the unmap: section has been there since day one.  At that point
it used 'return error(...)', so it made more sense.  Where did the
die() come from, then?

	commit 5d1a5c02e8ac1c16688ea4a44512245f25a49f8a
	Author: Linus Torvalds <torvalds@osdl.org>
	Date:   Sat Oct 1 13:24:27 2005 -0700

	    [PATCH] Better error reporting for "git status"

I think it should be safe to eliminate the 'unmap' section altogether
and that that change just forgot to, but in any case it's orthogonal
to your patch.

Thanks and sorry for the confusion,
Jonathan

Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED305C32771
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 21:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B882F2081E
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 21:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHApYf/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgAOVXi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:23:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44205 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgAOVXi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 16:23:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so17147724wrm.11
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 13:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=by6e+KVQVENv4RrZeULt8QjoQMDvi9Eu1FV7+jaqzCs=;
        b=GHApYf/WzbRpdbPuWWKLAezFHfjVNnUMS3slGR9xl/eGGBh05DmI6N4qVkv/ug1BDl
         RlBLqq3ztwcXVZr2GfBCd32RNSG2Phb4EiTTlJrGXK/tj9cZAg5kqALlDbwtNhC0DKdV
         I4z2CQCjRK6TXrUHc+xmlnHVjcDlulVU3bUcxxUtfe9buUCsKyOW/y4tsUQ59LG00uGc
         CTaMcbxPt7hXs2CQheDsrAkvlWSF1Hr7nrwWs1afWc3eNeA+8PPHDJQPzx40Fbn6pcUH
         vXIWmXCV77KnuQc6wT3XmcO04VuINvM/nLJ0OJOg2V8scdc2FyusSoSVhZ2IrgCIMrh9
         Z1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=by6e+KVQVENv4RrZeULt8QjoQMDvi9Eu1FV7+jaqzCs=;
        b=EGRrUe6gymZmB0allO2qXdhvYurL1jrPkBJWFXYi6L0ooS4yCoi5AB3YRqEAypjTc2
         Tq30aMoRGCV8rVawmp4oWSucbx2fsQmUbWxx0kofuPJcZBizyog7DiWJHCJCbarr4Uyz
         g3eLnktshouaDi68op5BgJhcvt0YUF/LK36LQJWvDSQWVLoN8vTIMtPbp7F+PiT0L4w6
         RjJGg3ceg+1P872BLVGIArhe9ff9FReBFJ69mHs3dkhDsn0ol1Ib4E1gYrZoWDsbS3ex
         08Yn2PTNXY7orVIhryA/7oXgO77eHk5MEOB9CmSQuaG8ikyFve7BceIwlCVE4zFP7Y0C
         90GQ==
X-Gm-Message-State: APjAAAUaOvQJrZDsJXnkVk5zviRoRE6GQUeAQODl+QoT/vh12ETpI0V9
        e/X6CCOIXkpmpVDMzXAFCNF1iG7mvrc=
X-Google-Smtp-Source: APXvYqw9YNKm7Tc3TBQa9plnenMCkLndWvtsOQCvyXsZj1sqqcFWL6iFVouw75GweO4XtolVOANlaA==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr35317070wru.382.1579123416159;
        Wed, 15 Jan 2020 13:23:36 -0800 (PST)
Received: from [10.1.31.85] (dw872367114.amsterdam-tc.dataweb.net. [87.236.7.114])
        by smtp.gmail.com with ESMTPSA id c15sm26043928wrt.1.2020.01.15.13.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jan 2020 13:23:35 -0800 (PST)
Subject: Rebasing evil merges with --rebase-merges
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <f2fe7437-8a48-3315-4d3f-8d51fe4bb8f1@gmail.com>
 <089637d7-b4b6-f6ba-cce1-29e22ce47521@gmail.com>
 <xmqqeew4l6qf.fsf@gitster-ct.c.googlers.com>
 <xmqq5zhgkwxx.fsf@gitster-ct.c.googlers.com>
 <xmqqy2ubjkeo.fsf@gitster-ct.c.googlers.com>
 <xmqqpnfnj9p3.fsf_-_@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.2001151458100.46@tvgsbejvaqbjf.bet>
 <xmqqftggk2oi.fsf@gitster-ct.c.googlers.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <9355c545-08a5-ef63-f7bf-65201d50acc8@gmail.com>
Date:   Wed, 15 Jan 2020 22:23:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqftggk2oi.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/01/2020 19:14, Junio C Hamano wrote:
> 
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > Having said that, if you ever find yourself wanting Just One Feature 
> > in `--rebase-merges` that would make it worthwhile for you to think 
> > about switching your patch-based workflow to a `rebase -ir`-based 
> > one, please let me know, and I will try my best to accommodate.
> 
> Another thing I noticed was that we may want to attempt to recreate
> an evil merge and then stop to ask confirmation.  The "rebase -ri" I
> did to sanity-check my revert for example failed to bring in the
> change made in the existing evil merge when trying to recreate the
> merge of the dl/merge-autostash topic into master..pu chain and
> silently created a fails-to-build-from-the-source tree instead.

FYI (and anyone interested), it`s something we actually brought up 
some two years ago, at the time of introducing `--rebase-merges` 
(known as `--recreate-merges` back at the time), see[1].

It ended being a lengthy and heated discussion (inside a few 
different topics as well, like original RFC[2] and it`s v2 update[3]), 
myself being guilty for dropping out eventually and not following it 
through, though, life taking me in another direction at the moment... 
but I still find this functionality to be very useful, not to say 
essential, even, for reliable complex merge _rebasing_ (meaning 
keeping "evil merge" changes, too), and not just merge _recreating_ 
(loosing "evil merge" changes, and worse - doing it silently, as you 
experienced yourself now as well).

p.s. Bringing that one up again, it can`t go without saying a huge 
thanks to Dscho for taking it this far in the meantime anyway <3

Regards, Buga

[1]: https://lore.kernel.org/git/bc9f82fb-fd18-ee45-36a4-921a1381b32e@gmail.com/
[2]: https://lore.kernel.org/git/87y3jtqdyg.fsf@javad.com/
[3]: https://lore.kernel.org/git/87r2oxe3o1.fsf@javad.com/

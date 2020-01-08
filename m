Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2008AC282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 19:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C6420678
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 19:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nwCrYv9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbgAHTij (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 14:38:39 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37863 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbgAHTii (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 14:38:38 -0500
Received: by mail-pl1-f194.google.com with SMTP id c23so1532712plz.4
        for <git@vger.kernel.org>; Wed, 08 Jan 2020 11:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kf7JGgPvMIXJZZ5Mr6KL/Nlu1bBM6ICD7LG4HsOZUlE=;
        b=nwCrYv9rDhDbjBwtDpJLQbpkEMWnF8IbXCwA60GQ33dJmMZnaEjNgMalgKS4U9MWSw
         QX5nxfT1nUL+8pZNdT4hVQjQmFCKh8R6RkPH2E23XnGEsGePzmCIQSzZbC4YpEN++Ftq
         /rWqpCHNHXO4V48S10gnYe2DUOw8ugAQh2h4j9Kh5IcvLb6nNMU0/3FhcWd5YYXKfgaO
         MURlihOHqshOUnbW8gisCDBDcLwFLFGLQD2EXcOk4Pl+j7N6FZjvc8aQiyZAdeh9N4m4
         MQP3oCEHN6XCiDKeKnGdBgZfpMsd9r0SpnMSt9wx9ip3Y+5F62dYfnbn5ELgdPFUGFNw
         MRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kf7JGgPvMIXJZZ5Mr6KL/Nlu1bBM6ICD7LG4HsOZUlE=;
        b=nkQ95RgkVdsBcjnT0mz2F0N8cPNNm1GkRWhqBIIkSPqtlrCjAfHMRZYvBQzdFHBY9u
         yE30TsdklhwCVGDwDHEWSx0FC+IwdaxXNSRwf4JajvgcPakDDH1iz9JQUK/r4DeEqQLb
         y9/8NRHuT7foAtd8LQ75AI/c+t4BjZJGQHCCe/dfifJa5rWlojpD/juQqG29ioGVoJXM
         7GKbtDM5dg+VZTsSc/PEv4480TrF80+FHYOY226NQdudfwGe+gq94VVI0sEKHvRFBBpM
         djldZVEGoJvw47iXPGHyq6keRVWXf99d1O8Z6/erBXvbMVvCnn9iCDWoCdvotlHX6AEG
         g6Tw==
X-Gm-Message-State: APjAAAXDEZeFM9g0S5VZBrihWzZQEBbdNWWZCKmk2mkOKu5ZdmM+8TZA
        FuXAdFRM4SYg8CDyQ/I7EYqy1YS+ERA=
X-Google-Smtp-Source: APXvYqz0RUCMtjGGlAbTaHOBRnZ+/4Z0D3OPlfPp6W1UcukT0jGLhTofZqs4N4OjM8iLAviveRhKfQ==
X-Received: by 2002:a17:90a:9d8a:: with SMTP id k10mr237390pjp.91.1578512317977;
        Wed, 08 Jan 2020 11:38:37 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id c19sm4816739pfc.144.2020.01.08.11.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 11:38:37 -0800 (PST)
Date:   Wed, 8 Jan 2020 11:38:33 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [RFC PATCH] unpack-trees: watch for out-of-range index position
Message-ID: <20200108193833.GD181522@google.com>
References: <20200108023127.219429-1-emilyshaffer@google.com>
 <20200108071525.GB1675456@coredump.intra.peff.net>
 <xmqqeew93lfn.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeew93lfn.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 08, 2020 at 09:30:36AM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Jan 07, 2020 at 06:31:27PM -0800, Emily Shaffer wrote:
> >
> >> This issue came in via a bugreport from a user who had done some nasty
> >> things like deleting various files in .git/ (and then couldn't remember
> >> how they had done it). The concern was primarily that a segfault is ugly
> >> and scary, and possibly dangerous; I didn't see much problem with
> >> checking for index-out-of-range if the result is a fatal error
> >> regardless.
> >>
> >> [...]
> >>  	if (pos >= 0)
> >>  		BUG("This is a directory and should not exist in index");
> >>  	pos = -pos - 1;
> >> -	if (!starts_with(o->src_index->cache[pos]->name, name.buf) ||
> >> +	if (pos >= o->src_index->cache_nr ||
> >> +	    !starts_with(o->src_index->cache[pos]->name, name.buf) ||
> >>  	    (pos > 0 && starts_with(o->src_index->cache[pos-1]->name, name.buf)))
> >> -		BUG("pos must point at the first entry in this directory");
> >> +		BUG("pos %d doesn't point to the first entry of %s in index",
> >> +		    pos, name.buf);
> >
> > The new condition you added looks correct to me. I suspect this BUG()
> > should not be a BUG() at all, though. It's not necessarily a logic error
> > inside Git, but as you showed it could indicate corrupt data we read
> > from disk. The true is probably same of the "pos >= 0" condition checked
> > above.
> 
> It does not sound like a BUG to me, either, but the new condition
> does look correct to me, too.  We can turn it into die() later if
> somebody truly cares ;-)
> 
> Thanks, both.  Will queue.

Thanks much for the quick turnaround. If I hear more noise I'll give it
a try with die() or error code instead, but for now I'll move on to the
next bug on my list. :)

 - Emily

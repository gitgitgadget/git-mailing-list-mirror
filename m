Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670DEC433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EE6120671
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOSXi0ql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgERRg5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 13:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgERRg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 13:36:57 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9939C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 10:36:55 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id p12so8755153qtn.13
        for <git@vger.kernel.org>; Mon, 18 May 2020 10:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bd9q4w3sXHDGWYZAw6sz8XwP4sS2UTZIze4pMYftm9U=;
        b=fOSXi0qlGE8KxSLPfxEKmhug+S8QT2URBhe0sJbrO3onir2rkQLu/I3aWm2Dwx2OXE
         P2F78elsBBDTJu2ZpsLdJtNSGdTyY3tyjesnOcfgQr+w6rN5vaU9wnIHy+MAm8iIuLP4
         Dp1zfaYtf39ArMWqpn3r4FLStkOBtEAJjLeHHEy0/iJDcSbaj0BNrp3g5DTmd5CRCVzC
         QTQexWDG67AbS1SsNYbXprTt44df3s4SiAKfvbvaw4CquxPTZfIPANJbiux7HWn3NaL9
         5t4ynGMEmN9wcAuM5FddUOr1rIiF1NZHc9WIZuLbk1MBpN6HuhyZ6XxCwFKMRIAj3xkl
         ffEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bd9q4w3sXHDGWYZAw6sz8XwP4sS2UTZIze4pMYftm9U=;
        b=SrMMun5D8HL7F+xpC1xyZ87e6mKrMRw/ebM7u25xkRXOcbYxPA8dJ6ONMmhC+V9zNW
         jiVKWnN0P+hIlGrgwhQuU4QaGcKpbddggMdni52ZyWsnQFbZHLVW57Jkq6xelVzYPiU0
         OzxM+0N+hPNZKchAml0W5ScTCUHIk93WU6fIhIK1Qc5K56Z8D+sig/q1EJ3W2ubQKQx6
         nZkJq/fWqgdkOUb4OWO7nFyIHtsEh2MefZ/bW8AyyxJEnXxmSUQp7NjP9rN3UyJNfozh
         Caj8x8l+kK9AN8aEf4jg932DY86qjuUsywNAyTwpC/JlnP6yTqKXSw+lYWWPt6CmlCa9
         mRoA==
X-Gm-Message-State: AOAM530SP7DrBwgn5u1etjGaKzXVtZOGkc6KG2oMcjxjpZcqB2A1UrAe
        vWm+YKHZCKer3KDIWFIf1VU=
X-Google-Smtp-Source: ABdhPJwhoczLdulZH49BC3NocsWITbo8HJ1Qwiu/w8sBLsGqaU1hI9EDOP+HgumPpbRH9tHYYlBsbA==
X-Received: by 2002:ac8:2f50:: with SMTP id k16mr18107862qta.392.1589823414956;
        Mon, 18 May 2020 10:36:54 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id e26sm8595208qka.85.2020.05.18.10.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 10:36:54 -0700 (PDT)
Date:   Mon, 18 May 2020 13:36:52 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/7] remote-curl: fix deadlocks when remote server
 disconnects
Message-ID: <20200518173652.GB2462058@generichostname>
References: <cover.1589393036.git.liu.denton@gmail.com>
 <cover.1589816718.git.liu.denton@gmail.com>
 <20200518165056.GD42240@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518165056.GD42240@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, May 18, 2020 at 12:50:56PM -0400, Jeff King wrote:
> On Mon, May 18, 2020 at 11:47:17AM -0400, Denton Liu wrote:
> 
> > Changes since v1:
> > 
> > * Remove fallthrough in switch in favour of just extracting the common
> >   call out of the switch in patch 3
> > 
> > * Add more detail in function comment and use `const char linelen[4]` in
> >   patch 4
> > 
> > * Implement most of Peff's suggestions[0] in patch 5
> > 
> > * Only operate on stateless_connect() in patch 5
> > 
> > * Add tests in patch 5
> > 
> > * Drop "remote-curl: ensure last packet is a flush" in favour of
> >   "stateless-connect: send response end packet"
> 
> Overall this looks pretty cleanly done. I left a few minor comments
> throughout, but the real question is whether we prefer the "0002" packet
> in the last one, or if we instead insist that the response end in a
> flush.

Thanks for the prompt review!

> At first glance, the "0002" seems like it's more flexible, because we're
> making fewer assumptions about what's being transferred over the
> stateless-connect channel. But in reality it still has to be pktlines
> (because we're checking them for incomplete or invalid packets already).
> So all it really buys us is that the server response doesn't have to end
> with a flush packet.
> 
> So I dunno. The "0002" solution is slightly more flexible, but I'm not
> sure it helps in practice. And it does eat up one of our two remaining
> special packet markers.

Yeah, I was worried about consuming a special packet. One alternative
that I considered but is kind of gross is sending something like
"0028gitremote-helper: response complete\n" instead of "0002". Then,
instead of "0002" checks, we can check for that special string instead.
I don't _think_ that stateless-connect currently allows for completely
arbitrary data but I might be mistaken.

> There is another solution, which would allow arbitrary data over
> stateless-connect: adding an extra level of pktline framing between the
> helper and the parent process. But that's rather ugly (inner pktlines
> may be split across outer ones, so you have to do a bunch of buffer
> reassembly). I think that's actually how v0 http works, IIRC.
> IMHO it probably isn't worth pursuing. That extra layer wrecks the
> elegance to the v2 stateless-connect approach, and we really do expect
> only pktlines to go over it.

This was the original approach that I was working on but I found it to
be much too invasive for my liking. (Also, I never actually managed to
get it working ;) ) I think I gave up when I realised I had to insert
reframing logic into index-pack and unpack-objects.

> So I think either of your solutions (enforcing a final flush, or the
> 0002 packet) is preferable. I'm on the fence between them.

I'm mostly on the fence too. One advantage of 0002, however, is that a
malicious server can't end a request with 0002 as that's explicitly
prevented. If a malicious server closes a connection after sending a
0000, I think that they could cause a deadlock to happen if there are
multiple flush packets expected in a response. You mentioned in a
sibling email that this currently doesn't happen wrt stateless-connect
although I'm not sure if in the future, this is something that might
change. I dunno.

> -Peff

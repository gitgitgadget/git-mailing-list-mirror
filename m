Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79FE51FC44
	for <e@80x24.org>; Tue,  9 May 2017 00:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752367AbdEIAoy (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 20:44:54 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33072 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbdEIAox (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 20:44:53 -0400
Received: by mail-pf0-f196.google.com with SMTP id b23so11703779pfc.0
        for <git@vger.kernel.org>; Mon, 08 May 2017 17:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=R1iqEAQWeN63pd137cTHKM5M/IXRL8lvb1Up9OIRRiQ=;
        b=q9QelcHOgMFf54h/QF4rZ4+vc0uVPRjg8Ucieiv0zG7eD7zF1EKq4dNGKLBzAY9Z28
         y3s+/rLAx4lvUCYBDawzwx59XysVSlBmKJyX1kRlEo5ShubNkT4V9QpA8cduYc97qpBZ
         lmSp76WZ4UOAmi66Y07RCNzE1phhBco2FKDHXDGswMYQMA2fPkTYxjyPvlu3qugQfYxW
         Ry7Y01SqWZRCRX04xwyCfJnBPa41ORb1KWOewRMUrhuTIUVATnnBm+hPhcClA5ympPWG
         EW1VoA1UPR63vkLXClPyzwsis4wkHZufSMlBQJMJVJOQQV8UfBt/7m+tElSQzanD20sX
         /5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=R1iqEAQWeN63pd137cTHKM5M/IXRL8lvb1Up9OIRRiQ=;
        b=q+ox9ywh9R0khxRMY7A4g6agfnU9Y4CLRoWf9wryLD4gILY6GhkWHHj30p034GMwg+
         aBzEijqvMb0lfzo1n9zdWGWKROOBkagTpGrOmkdAjd3EiFovZgt9Hg/Ej9heDlYjOgXs
         fytRMXUV8yDIZq7fZGBirLX9QMkj6Sfr7F7/8/WXDyUMdiB0ULtRsddE4jQkQhU/kz/s
         hbqwjssoEoVW0CBDw60XDSScJWtDh37zzC+VPCvbOOZYjgq1KfTvcdJlu2ktj/qutLar
         99TdxIvDK+T0WlSYRvDYHi/NcrNmCIRwZNzuRShTveTOkhVu7TvmPNWIPI/hAI/TDKyL
         RDYw==
X-Gm-Message-State: AN3rC/5EBtynoLCAtcXiVmP44+DK2rw4qKrb08RHEAQLHVy4Odq0M/wT
        eLgiD2faZOEPkg==
X-Received: by 10.98.101.5 with SMTP id z5mr34127744pfb.96.1494290692399;
        Mon, 08 May 2017 17:44:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id z22sm27189448pfg.117.2017.05.08.17.44.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 17:44:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pack-objects: disable pack reuse for object-selection options
References: <20170502084326.65eisqmr4th5cbf7@sigill.intra.peff.net>
        <xmqq4lww9cas.fsf@gitster.mtv.corp.google.com>
        <20170508073143.lu73w5b54lvstty2@sigill.intra.peff.net>
Date:   Tue, 09 May 2017 09:44:50 +0900
In-Reply-To: <20170508073143.lu73w5b54lvstty2@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 8 May 2017 03:31:43 -0400")
Message-ID: <xmqqd1bi7ta5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, May 08, 2017 at 01:56:27PM +0900, Junio C Hamano wrote:
>
>> Surely, even if we need to exclude some objects from an existing
>> packfile due to these selection options, we should be able to reuse
>> the non-excluded part, no?  The end result may involve having to
>> pick and reuse more and smaller slices from existing packfiles,
>> which may be much less efficient, but it is no immediately obvious
>> to me if it leads to "need to disable".  I would understand it if it
>> were "it becomes much less efficient and we are better off not using
>> the bitmap code at all", though.
>
> Yes, it's this last bit. The main win of the packfile reuse code is that
> it builds on the bitmaps to avoid doing as much per-object work as
> possible. So the objects don't even get added to the list of "struct
> object_entry", and we never consider them for the "should they be in the
> result" checks beyond the have/want computation done by the bitmaps.
>
> We could add those checks in, but what's the point? The idea of the
> reuse code is to be a fast path for serving vanilla clones. Searching
> through all of the packfiles for a .keep entry is the antithesis of
> that.

Ah, OK, and now I understand why you called this a "bug" (which is
older and do not need to be addressed as part of 2.13) in the
original message.  The new tests check requests that ought to
produce an empty packfile as the result actually do, but with the
current code, the reuse code does not work with --local and friends
and ends up including what was requested to be excluded.

Thanks.

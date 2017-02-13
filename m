Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 795BC1FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 20:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753281AbdBMUiz (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 15:38:55 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34967 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752203AbdBMUiy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 15:38:54 -0500
Received: by mail-ot0-f193.google.com with SMTP id 65so13454705otq.2
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 12:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ORcdVpD4sT3EaVNs4c5jRNAusaPZd3PqQURD6RXaB6A=;
        b=dVlkWEagdIoccybYsj+hQOGb9RbnGa5xU2VCtq5qq8J74JXHo3E2M2Z43l0VtxVhDK
         TMTYEz/WtUyR1wHD0ImfGv/uEgN02urKbWwcW8vnpdUURJTtX4Wa8WI2mSeaob3id/1k
         tQP0D84gTWrtIN4GVphYur5gpuMoYdHgw+Pxw2r4KW6hpNzstXevBZ/B4fi2ajjl3rBH
         +n6Gea0ESXK28+6mTFBGz3ZB6ZmWbEh7B1fgympF+oqufRXiZnWqke3R3iVL4vK5YFWR
         WhPw2dtzr9eBQ4+OEsM8zHo6N0xiixWM8iYGbYY0PRe76Dujlrd2DbMYiYtmiKHODFA1
         4YFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ORcdVpD4sT3EaVNs4c5jRNAusaPZd3PqQURD6RXaB6A=;
        b=MjUTQLx9QNfWx49DEWwi4dhhCL/N1BX1FeoBqtNvANHEGz5DVS4pYSGI97Cqx7HnCK
         M34Nk0xTHWIllhDXOrhhQ0w23RR2v7fIQFzvNDTtDPLdY1pUC3v6IT1ZKK6atwNxYp55
         8Ilw4HS8DUqDsnsHFBb5buUMSeOfGfKLflzyhWCLy6SNdN5I0CEIwZAuQvHRDU9XP0EH
         j7OItQvPy1wF0q3OoyHe1UZqZ9SRejcyJQ2Wf5VqNKmCOHbTMPIdR1UparwvwekLfMjE
         vPqSw0FuQJIrFhTDGXOuFrPZhjbInLB8zA7CtBv53Xklw0YGfKAVKP3tDbtAnYsS9IOd
         9grg==
X-Gm-Message-State: AMke39mAE32c3oEofo21mC2EPObYFrJCCFzaAeXjJWrBl49bqsQ9+9JbQmwdrlvI0DnHFA==
X-Received: by 10.98.133.11 with SMTP id u11mr28015263pfd.132.1487018328505;
        Mon, 13 Feb 2017 12:38:48 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d0e0:42a7:601f:5154])
        by smtp.gmail.com with ESMTPSA id x10sm16265914pfi.117.2017.02.13.12.38.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 12:38:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] clean: use warning_errno() when appropriate
References: <20170213092702.10462-1-pclouds@gmail.com>
        <xmqqwpcudjoh.fsf@gitster.mtv.corp.google.com>
        <20170213191433.muwhz7zem64p3rxr@sigill.intra.peff.net>
Date:   Mon, 13 Feb 2017 12:38:47 -0800
In-Reply-To: <20170213191433.muwhz7zem64p3rxr@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 13 Feb 2017 14:14:33 -0500")
Message-ID: <xmqqk28tddwo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I wonder if xmalloc() should be the one doing the saved_errno trick.
> After all, it has only two outcomes: we successfully allocated the
> memory, or we called die().

I would be lying if I said I did not considered it when I wrote the
message you are responding to, but I rejected it because that would
be optimizing for a wrong case, in that most callers of xmalloc()
and friends do not do so in the error codepath, and we would be
penalizing them by doing the saved_errno dance unconditionally.


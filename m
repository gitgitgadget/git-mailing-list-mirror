Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50A2F201A4
	for <e@80x24.org>; Mon, 15 May 2017 01:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbdEOB0N (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 21:26:13 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36564 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbdEOB0M (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 21:26:12 -0400
Received: by mail-pf0-f193.google.com with SMTP id n23so12702606pfb.3
        for <git@vger.kernel.org>; Sun, 14 May 2017 18:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Pu6VT+wHyL3ohcF+OLyfAaA0noVPmBgKI5I4744ugNk=;
        b=TwuO/QWjXtcaYRHfk9rRRI1k+sYczGyi2CQ0ukvu6m9IA0C/YniTDRlroJDthjQd2+
         HzVEKseSbjVSXoxLRsWMIiD9UC/vG4VYMDEvzJ5r1BprYrzo/MhVJz46Qm3b779cNaNJ
         BRxuFvln5KZUUjIG2iRmfeiKZwwUBpYqIGiUpIhKwdBfUe0nuw7Vz1g87DZA563nv957
         AmlCZ+En3mjcW95BmUxTV16BDdfuXm2mvmiW9KEs0s8q3cjFhKTIrrfKBZrZhsg5VjWj
         VlLZ/pqDy0P4ktsyUee5I4LGxxrY27i6jaWXv43PsaDa+G64CJ5iOiNIcuzZ8opYMvQy
         zlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Pu6VT+wHyL3ohcF+OLyfAaA0noVPmBgKI5I4744ugNk=;
        b=WZvFgEecVsITQzDSOaUhyWpIXb6kzFY8vCRmtxYrdbvBBrl+8Y2xIlb4ejH3nHbI/m
         pYaiuVF/c1XypEU/sSZlS+CWXHyI70kBhMa/jpN72xGxVsMDxLgHJUFS51yXKV7RoFgL
         Z2QHbHKMDMnew1QLLBH78EG9QjsUglTgvwTBeHig5lcKB28njKENZDTNW9JUJdGZU70Y
         /CaKSmGM4xR6psOw/oLrAJ5VhOND+XAep0epYS2feJ7tZoXENTQxYP+O+DRy2+WEcKOC
         rz9Jc+fDoSP4vt2o9t57KsN8lyFF6CneRpIKLC2Bu7c5Kcz+y2ZaJbY+Ro5YYkodNr0p
         +6Yw==
X-Gm-Message-State: AODbwcA/1GQFg4cKDuxIvuy9DPU3q1SCZHMifzhD5IGObZS96JwF3vE9
        Law83sUfdj2QJw==
X-Received: by 10.84.137.3 with SMTP id 3mr5026872plm.68.1494811572186;
        Sun, 14 May 2017 18:26:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b170:f9ed:5f25:7ab5])
        by smtp.gmail.com with ESMTPSA id e64sm17644983pfl.49.2017.05.14.18.26.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 14 May 2017 18:26:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        jrnieder@gmail.com
Subject: Re: [PATCH v6] fetch-pack: always allow fetching of literal SHA1s
References: <20170509182042.28389-1-jonathantanmy@google.com>
        <20170512204648.10611-1-jonathantanmy@google.com>
        <20170513083615.dyfnmug35ghhy7ba@sigill.intra.peff.net>
Date:   Mon, 15 May 2017 10:26:10 +0900
In-Reply-To: <20170513083615.dyfnmug35ghhy7ba@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 13 May 2017 04:36:15 -0400")
Message-ID: <xmqqwp9iykp9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, May 12, 2017 at 01:46:48PM -0700, Jonathan Tan wrote:
>
>> Change from v5: used "ensure_tip_oids_initialized" function instead.
>> This removes some of the muddiness (e.g. with newlist being modified
>> after the function).
>
> I don't think it really improves the muddiness. You are still calling
> the ensure function each time through the loop with a potentially
> modified list, but it doesn't actually look at the list after the first
> time. So the muddy part is still there.
>
> I think rather than changing the code, you'd do better with a comment
> like:
>
>   /*
>    * Note that this only looks at the ref lists the first time
>    * it's called. This works out in filter_refs() because even
>    * though it may add to "newlist" between calls, the additions
>    * will always be for oids that are already in the set.
>    */
>
> At which point the original all-in-one function is probably fine (as it
> avoids the "return 1 just to join the &&-chain" bit).

Yes.  I agree that the in-code comment is the best approach to the
"muddy combination of 'grabbing it for the first time' and 'the
thing that is grabbed mutates in the loop'" confusion.


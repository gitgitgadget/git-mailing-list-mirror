Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 737B920401
	for <e@80x24.org>; Sat, 24 Jun 2017 18:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754959AbdFXSlm (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 14:41:42 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35984 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754814AbdFXSll (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 14:41:41 -0400
Received: by mail-pf0-f193.google.com with SMTP id z6so3494557pfk.3
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 11:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cjDx7bn6TdwoZibOxZJcJio7OLhDtzLd+CXiRyar4f0=;
        b=Bfi5zrO6NmV+5QKCoUFtYyz/eMhdol6PAK2csXPCwwYVPxADYO0ngOuO3iOp0hyPt4
         kM/grH4tMBqi9nh8DJ7MbAY2dMnJ6dhCqDfQcfOBTcofscZpByEec03GR23ABEpEz6D8
         Mjyx4Wg9AW375RInCORsHo2ovZQxZ+T9MzrMwYbnUxYd69WXDXk2N2/poyneowP1kf+W
         CdSmoyTEgD/oMcCSAH9QQsFCSN81lZ022Kyy2raCLt1GAdyhGFu8BUM+q7Vymrj9fOT/
         Ca4jDOpKYF3/rOohxXwnCiLa7RUv7uIQ42j3CuK6X/MVX91VA4NtQ3Ch2XrvIxD+rWE5
         zWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cjDx7bn6TdwoZibOxZJcJio7OLhDtzLd+CXiRyar4f0=;
        b=decMcQgbQjeNFK6E6biaA2bphwlNCsOScgG/grE0uzG6hCJWQlPpQ6CMIc3krJE959
         p48GuZivE+kvxgQuJqBNGie5MNB4iVafLy8WOHVex7x/3Ak3pFf1fxFIzhRDQPLaUGkd
         N5mG5hAzfjvTjEhKx+UWqe+Umzg3IZ/bQRzpyQOpcEhz1uPzuug1l+8H2DKpL20XZF/J
         3WxKoPAbvlf0vpNHhiQbZrJ6KB9qtu/W1eBzZnXuHRiE8fNeSR7Yx96JR69LNBE8fvlQ
         keMW6BdaXvlCTQ6TGoQVWTEs9trt8QiLFqDrJI0y/3Vc6TgM25RflsDK2yi4XKGym9q1
         7qIQ==
X-Gm-Message-State: AKS2vOxVCpzvQsw96Q2jqdhTgO6mnadPqdCpL6Xz41Rh2wBGxdzfq5ZT
        nlG/iRIhblXrs2Umvr8=
X-Received: by 10.84.175.67 with SMTP id s61mr15916407plb.151.1498329701007;
        Sat, 24 Jun 2017 11:41:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:c3f:f54c:5646:5c2e])
        by smtp.gmail.com with ESMTPSA id 66sm18029923pgh.59.2017.06.24.11.41.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 24 Jun 2017 11:41:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 7/8] sha1_file: do not access pack if unneeded
References: <cover.1497920092.git.jonathantanmy@google.com>
        <cover.1497035376.git.jonathantanmy@google.com>
        <cover.1497920092.git.jonathantanmy@google.com>
        <fb656dfeb96e3c69f612fed924d0d9dec592c772.1497920092.git.jonathantanmy@google.com>
        <xmqq8tklqkbe.fsf@gitster.mtv.corp.google.com>
        <20170624124813.wajhxkrqhw4xoee4@sigill.intra.peff.net>
Date:   Sat, 24 Jun 2017 11:41:39 -0700
In-Reply-To: <20170624124813.wajhxkrqhw4xoee4@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 24 Jun 2017 08:48:14 -0400")
Message-ID: <xmqq7f019qjg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jun 21, 2017 at 11:15:01AM -0700, Junio C Hamano wrote:
>
>> > +	if (!oi->typep && !oi->sizep && !oi->disk_sizep &&
>> > +	    !oi->delta_base_sha1 && !oi->typename && !oi->contentp &&
>> > +	    !oi->populate_u) {
>> > +		oi->whence = OI_PACKED;
>> > +		return 0;
>> > +	}
>> > +
>> 
>> ... this "if" statement feels like a maintenance nightmare.  The
>> intent of the guard, I think, is "when the call wants absolutely
>> nothing but whence", but the implementation of the guard will not
>> stay true to the intent whenever somebody adds a new field to oi.
>> 
>> I wonder if it makes more sense to have a new field "whence_only",
>> which is set only by such a specialized caller, which this guard
>> checks (and no other fields).
>
> The other nice thing about whence_only is that it flips the logic. So
> any existing callers which depend on filling the union automatically
> will not be affected (though I would be surprised if there are any such
> callers; most of that information isn't actually that interesting).

Hmph, but the solution does not scale.  When a caller wants whence
and something else that cannot be asked for or ignored by being a
"pointer to a result" field, such a request cannot be expressed.  We
either need to make all fields in oi request to "pointer to a
result, if the result is needed, or NULL when the result is not of
interest", or give a bit for each non-pointer field to allow the
caller to express "I am not interested in the value of this field".

In the usecase Jonathan has, the caller's wish is a very narrow "I
am interested in nothing; just checking if the object is there", and
passing NULL for oi works fine.  So I'm inclined to suggest that we
take that approach now and worry about a more generic and scalable
"how would one tell the machinery that the value for a field is
uninteresting when the field is not a pointer to result?" mechanism
until a real need arises.

Thanks.

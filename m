Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04B8E1FC44
	for <e@80x24.org>; Tue,  9 May 2017 02:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbdEICsT (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 22:48:19 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34016 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbdEICsT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 22:48:19 -0400
Received: by mail-pf0-f194.google.com with SMTP id w69so6236493pfk.1
        for <git@vger.kernel.org>; Mon, 08 May 2017 19:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=stWPUld/3/IyOOiJQfSUYgKJBSH02CIacbkifgo7uWM=;
        b=tVRUw+G1B5HxQcg3ekzyK6i252xq3rVlzamhpakBcfFknV04zmh8MXgh/4Sa7HE7CB
         6IiZ7Q/FjC/DrK09RwqOqfQJGaAbeZEBgUI4WY57wVdo4QY/SkGZjgW/Lcn+TyFfxfJR
         6zDzphwZj9Vy85GliE2DFu3vFN7RWuCJ04lLjE06w8LHUTyIS7i+jbCTCK3tzVfmpptC
         VR02Pbau7aDEaQWx5++SFEBvsLihyj/XIa0F2KZp6z9XYo5NuXDmeJlN+tlxSyNTgqIb
         pk4YuOCLd0WBzR6CyA4LLOsCvp2qkXONmMC/sUPW6ulxIAdEwx5j3kRz2irySxR5alt0
         T4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=stWPUld/3/IyOOiJQfSUYgKJBSH02CIacbkifgo7uWM=;
        b=CZ5JP33I6uMLAg+vmvhfOrHxs1t0LeuY3jORnHkqmmOXx65xQueG+XTpcJzmxHrHh5
         e+/BNefQ4kdPppWKcy4WCsRB6pv40zKbOihUuu2kNzPIPJBtSZwK+MPj/1VSncqK8fX1
         62j6O2hXwVyzxBl85AO1FR8No3YGlClt9wQ0m9HGZQdlqmtRQ6rzDuxGflZ7e1RlJjNw
         RMiNuCPl5h8tgrCejpP6ntNCtmM7bIepevEhnfE3+x7LpcTd5m1i4yyd+FgH0gPhE9Lo
         pHYK1Ek0L01unvWJLw/a4C3Ba+mLiwhBaXzBjKGp+xOkBgymaU9jJRrN6oktriM+T/Qo
         9rSA==
X-Gm-Message-State: AN3rC/48VZH2Pbmv3Yj3nWRSbzNAhfchXW9jPKMZZpix5ddbMbt7aVte
        j8Sn8X3QKMMG2g==
X-Received: by 10.84.191.228 with SMTP id a91mr89529611pld.62.1494298098245;
        Mon, 08 May 2017 19:48:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id d1sm24803391pfa.56.2017.05.08.19.48.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 19:48:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pack-objects: disable pack reuse for object-selection options
References: <20170502084326.65eisqmr4th5cbf7@sigill.intra.peff.net>
        <xmqq4lww9cas.fsf@gitster.mtv.corp.google.com>
        <20170508073143.lu73w5b54lvstty2@sigill.intra.peff.net>
        <xmqqd1bi7ta5.fsf@gitster.mtv.corp.google.com>
        <20170509020010.meefcustv7uufard@sigill.intra.peff.net>
        <xmqqfuge6akl.fsf@gitster.mtv.corp.google.com>
        <20170509022114.s3tpxrgtplsopr4x@sigill.intra.peff.net>
Date:   Tue, 09 May 2017 11:48:17 +0900
In-Reply-To: <20170509022114.s3tpxrgtplsopr4x@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 8 May 2017 22:21:14 -0400")
Message-ID: <xmqq4lwu68zy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, May 09, 2017 at 11:14:18AM +0900, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> >> Ah, OK, and now I understand why you called this a "bug" (which is
>> >> older and do not need to be addressed as part of 2.13) in the
>> >> original message.  The new tests check requests that ought to
>> >> produce an empty packfile as the result actually do, but with the
>> >> current code, the reuse code does not work with --local and friends
>> >> and ends up including what was requested to be excluded.
>> >
>> > Right. Did you want me to try re-wording the commit message, or does it
>> > make sense now?
>> 
>> It does make sense to me now, but I do not speak for all future
>> readers of "git log", so...
>
> I guess what I was asking was: do you still think it was unclear, or do
> you think you were just being dense?
>
> I don't feel like I gave any information in the follow-on explanation
> that wasn't in the commit message, so I wasn't clear if I worded it
> better or if it just sunk in better.

At least, "the current code is buggy when --local and friend are
given and includes needless objects in the result" was something I
learned only during the discussion, and would never have guessed by
reading the log message.  The second paragraph does talk about "This
bug has been present since...", but the first paragraph does not say
anything about the current output being broken.

So, I am not sure if this was a case where I was dense.  I think the
first paragraph needs a bit more clarity.

    If certain options like --honor-pack-keep, --local, or
    --incremental are used with pack-objects, then we need to
    feed each potential object to want_object_in_pack() to see
    if it should be filtered out.  This is totally contrary to
    the purpose of the pack-reuse optimization, which tries hard
    to avoid doing any per-object work.  Therefore we need to
    disable this optimization when these options are in use.

Perhaps "... should be filtered out." can be followed by "However,
the current code fails to do so, and we end up including these
unwanted objects in the output.", and then "This is totally..."  can
instead begin with "Besides, having to do per-object filtering is
totally...".  I wouldn't have been confused if it were like so.


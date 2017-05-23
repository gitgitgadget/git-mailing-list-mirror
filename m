Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DC7D20281
	for <e@80x24.org>; Tue, 23 May 2017 22:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1765007AbdEWWkL (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 18:40:11 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35681 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764994AbdEWWkK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 18:40:10 -0400
Received: by mail-pf0-f182.google.com with SMTP id n23so127607972pfb.2
        for <git@vger.kernel.org>; Tue, 23 May 2017 15:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3Q5fBofUJMBl+IFnZBd/AeaPFVLy+9WZtzrPU1EPwh4=;
        b=CQviKCiO3lFBUzJ+kCgCO5gYqLE3KLr4d9c+m3/3kHqK+t4lpJYbLvSFAIBKG5Fw1b
         byKnZRJ9LXYrnjt4N72nXzJVgpZqqKrNLH0Ykot+22e3Bj6BRzcyW/dU62+k+eJfbM3z
         oOkAoYg73vSSsf0yG+dhvauUm5mTa63Yp3X9DmPjSXxzA5624+1F3jzeiQwGWVyfad24
         3xlaTbCYE3YZNYvZakFaar4AoJEsZEYa9JxQgxy8r5ojMoQtVdrWMt6GodOrKjP9JViD
         1Tb/c8kBPArydgQ272BPuPWtIIXdI4xd/NjBrI+19xH0KoN4sjFffs/z2khKz5x15BGA
         PF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3Q5fBofUJMBl+IFnZBd/AeaPFVLy+9WZtzrPU1EPwh4=;
        b=X4Hiu3/H9MNFGhJGPh9sESK3gY9sNYfxmCQISyt8Zcxdczqa087LvTviYr9pgIk1UN
         RdhkShAjSrnP4H3Ue3As4Zv2XJar2EjdMxrhaurAECQ/DOeV5GeKNY0PEnOk9H7SMgmL
         aOxcMOje0daeBtQSQGHCVKNJr0518HhdhtAtX9k+A5bZd9vu5PbVeCbNdMU96t1Lrcdw
         kfw7USmi9F3ZYHMODaTgNADaSdZ1HF+NS0O0Fiw1rHkBf1yR/LY+7o9jF+RnhhfleaQX
         ovTNp5LUOo8auHnSqRbhxV2dFEmsvaQRHRH/VvZeMf/3yTejs9DXGVguTW91mTChdj0W
         vkmQ==
X-Gm-Message-State: AODbwcC2B7OQ9jFMAW39zB2FW4/KLUylE8aTi4Jk0JqwgmO3/8/oriAv
        tUpGPXfV3FrgjjpY2SZakg==
X-Received: by 10.84.217.30 with SMTP id o30mr7512054pli.26.1495579209433;
        Tue, 23 May 2017 15:40:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b9c2:d2d1:97c0:9dab])
        by smtp.gmail.com with ESMTPSA id a78sm4270249pfk.122.2017.05.23.15.40.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 15:40:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Tyler Brazier <tylerbrazier@gmail.com>, git@vger.kernel.org
Subject: Re: `pull --rebase --autostash` fails when fast forward in dirty repo
References: <CAAZatrCaoB7EXVrCvC9RKmO02G5xcp8GPBaJefHfv7zAXVpL3Q@mail.gmail.com>
        <20170523131231.zqjkymypbilv6tyf@sigill.intra.peff.net>
Date:   Wed, 24 May 2017 07:40:08 +0900
In-Reply-To: <20170523131231.zqjkymypbilv6tyf@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 23 May 2017 09:12:31 -0400")
Message-ID: <xmqqa863jiyf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ...we can probably restrict it to when autostash is in use, like:
>
>   /*
>    * If this is a fast-forward, we can skip calling rebase and
>    * just do the merge ourselves. But we don't know about
>    * autostash, so use the real rebase command when it's in effect.
>    */
>   if (!autostash && is_descendant_of(merge_head, list)) {
> 	opt_ff = "--ff-only";
> 	return run_merge();
>   }
>
> AFAICT from the commit introducing this code (33b842a1e9), and the
> surrounding discussion:
>
>   http://public-inbox.org/git/OF95D98CB6.47969C1C-ONC1257FE1.0058D980-C1257FE1.0059986D@dakosy.de/T/#u

Sounds like a sensible solution.

> But I notice on the run_merge() code path that we do still invoke
> git-merge.

... wouldn't that what we want even when the merge happens to be a
fast-forward one?  I am not sure what you meant by this, but...

> And rebase has been getting faster as it is moved to C code
> itself. So is this optimization even worth doing anymore?

...that might be something worth thinking about---my gut feeling
tells me something but we should go by a measurement, not by gut
feeling of a random somebody.

Thanks.


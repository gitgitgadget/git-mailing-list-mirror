Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB8CC76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 21:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjC1VqQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 17:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjC1VqO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 17:46:14 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952911712
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 14:46:13 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id z19so13049900plo.2
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 14:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680039973;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oi14APOOv6Q1fNO63fK4l139tz0crVVtscS18fKHVKI=;
        b=V4m/7jueSHhIkBpexONlXXi9aCfBTa+fa6HIpzc3eld/JHN+JNrg3/pUQChljk3BLb
         TPZP/w/dT8JPCDy82rqhZmAyyhWqAHQN2uCTl/0ssi/BnofR1cwPkgxTESdjwO2h45ug
         X10yAf/UNejfUe2zl8X+swrXlJZsZhc+gN3tEbjPMwMzm7LgPZYb/eTBQfqQGaLPUbBB
         aaBmXc9lUZgSm/9g/QFTFlzOeElAYthhqpkEgN5NiVcLIiP5grkgpVjdLwluB3hfXn3K
         ggT164SDl0GHPJQHOqDRHoGPbUtHZyrH3yK5QwA5uLHhgFIGljfawqEdP3pljImB0M8i
         G/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680039973;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oi14APOOv6Q1fNO63fK4l139tz0crVVtscS18fKHVKI=;
        b=iEfSP57xQq9Rh+c46sgattdjBgUav0oJKsF6XLi6Bxh2QQaSavsnnDhgK7ctXkR6qE
         S9Qy69EIZrrt8mFW89YE20VOwbDdlCyWCd8oVLDIBjmRGC9nCoMG1Vj18aXM0TimRd8d
         BtTwb7mjprhIVksxelndeMQ0xvj0K2EWUHpk6CPStdtqqDTEz+t6FXMhxrMb3JC6Zy2M
         fTKbgHtmuBXLNjtNHXqXSkEYbO6Er+N6lTy973PbcB//KKYHz9KB87dps5KIL/if3q7k
         3S+gM8qNlIphM22saOfg+EifOTTenM7bFapNLzqYCz2h8McLwkKgyxBtT2i3bZQIByia
         I/jg==
X-Gm-Message-State: AO0yUKVMclSAycTO1aSA659RsmH9zTozrYDyygfdzRcolwpCQpLY4vsm
        1TGKohfobR0ZylLfsLtYL2w=
X-Google-Smtp-Source: AK7set8FwBUNcoYoIRTcn9X0IxUS1xkUcYbA6l1FKzm3H/rO4XmGUgIXAqHGtNnMd6T9eRfREh7y4A==
X-Received: by 2002:a05:6a20:811a:b0:d0:11bc:eed6 with SMTP id g26-20020a056a20811a00b000d011bceed6mr14134198pza.50.1680039972898;
        Tue, 28 Mar 2023 14:46:12 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id j11-20020a62e90b000000b005825b8e0540sm3905173pfh.204.2023.03.28.14.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 14:46:12 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH 3/4] tests: drop here-doc check from internal chain-linter
References: <20230328202043.GA1241391@coredump.intra.peff.net>
        <20230328202819.GC1241631@coredump.intra.peff.net>
Date:   Tue, 28 Mar 2023 14:46:12 -0700
In-Reply-To: <20230328202819.GC1241631@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 28 Mar 2023 16:28:19 -0400")
Message-ID: <xmqqzg7wczx7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'd also be OK dropping this. 12% is nice, but this one test is an
> outlier. Picking t4202 somewhat at random as a more realistic test, any
> improvement seems to be mostly lost in the noise.
>
>  t/test-lib.sh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index cfcbd899c5a..0048ec7b6f6 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1101,9 +1101,10 @@ test_run_ () {
>  		trace=
>  		# 117 is magic because it is unlikely to match the exit
>  		# code of other programs
> -		if test "OK-117" != "$(test_eval_ "fail_117 && $1${LF}${LF}echo OK-\$?" 3>&1)"
> +		test_eval_ "fail_117 && $1"
> +		if test $? != 117
>  		then
> -			BUG "broken &&-chain or run-away HERE-DOC: $1"
> +			BUG "broken &&-chain: $1"
>  		fi

This "here-doc" linter is a cute trick.  With seemingly so little
extra code, it catches a breakage in such an unexpected way.

Even with a very small code footprint, overhead of an extra process
is still there, and it would be very hard to figure out what it does
(once you are told what it does, you can probably figure out how it
works).  These make it a "cute trick".

While it is a bit sad to see it lost, the resulting code certainly
is easier to follow, I would think.  I do not offhand know how
valuable detecting unterminated here-doc is, compared to the
increased clarity of hte code.

Thanks.



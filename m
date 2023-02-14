Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FE6C636CC
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 02:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjBNCR5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 21:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBNCR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 21:17:56 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384F68A5F
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 18:17:55 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so14072278pjb.5
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 18:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3ud2o3Ac2nqPdzvAc9JVJyX9nZd71l57BSZkAfmJKU=;
        b=jgJSjBfCHpej4Z7akT3WahuMB92MJJ8reE7f1k0Ujh5dmJ5dc//famuA7rZIZ3fJ8G
         7N0h/B8dqlw8rdNNUBWGleBuIpsiYMjwn25futOvoxGvjj5PTIsFBp67gogSZvyKYPTw
         jJdPc42g8HRH7BYRQ84gtS9WMQfeeLjBo6V3BwCKFi+pkBFrMRxFaTh+xcDgYHQ7vP2o
         1T5xbqszKs73kQ8VWg7NEdS5WVjL+yaUKlbNyCokQ6MUVOXyq9GFujCguYV+WeAyRiC4
         Vqw8UP7D5rRnFPJzgeCRUBsj7MIgL8SZz5uMFnHHUMCyz46fuO4dob0wbSWj5tyaXZqA
         9Iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j3ud2o3Ac2nqPdzvAc9JVJyX9nZd71l57BSZkAfmJKU=;
        b=ogsFe3X53FpCnHqVuNFg1N52bh48XdBqv1epmjm6fEJndrjmuc7k17J9CVBICtynCp
         Va+Hy1KdVAQk7WB2VNDuG0ENSr16tE1HIN2o8ODM2etpjQbJImQoa3T4rA+oZSfzmU1J
         1maOidqf/ERgGG/pKZeWDr+/RuOetNAxPICO9WOw0eZe2T8S1PHNBMPQi1F6+x2HClqK
         0+aryB2mAplRGS0Li6xKFOMKU2ktiVWkprQBCMUAQxWmyAhC74P+rTTUVg6QEYPHMyA6
         ew36RkbqkQx6G0jUDSid/eAPTlOGY1Y1d9lJeQkbwYg2ZhsHKBXovTyN9ZReIZRLvdUD
         9Brw==
X-Gm-Message-State: AO0yUKWBIx39LCHe8zlQlo0OG/f2N0jvd4pV5REXjEr0prOYNmjEVgv8
        b7uj6Gz8R8yZ45DZOJ4cUgY=
X-Google-Smtp-Source: AK7set+q+uFw01AxwRKl96KaCdogri6IHeOx5LoDZakOYneRpi+10lCDlibZl9Am7Gb5wFXP5xFK2Q==
X-Received: by 2002:a17:902:e886:b0:199:15bb:8316 with SMTP id w6-20020a170902e88600b0019915bb8316mr1101098plg.68.1676341074560;
        Mon, 13 Feb 2023 18:17:54 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id k19-20020a170902761300b0019a87ede846sm4789826pll.285.2023.02.13.18.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 18:17:53 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [RFC PATCH 6/6] add: reject nested repositories
References: <20230213182134.2173280-1-calvinwan@google.com>
        <20230213182134.2173280-7-calvinwan@google.com>
        <Y+qgwHx52DSAfsEb@coredump.intra.peff.net>
Date:   Mon, 13 Feb 2023 18:17:53 -0800
In-Reply-To: <Y+qgwHx52DSAfsEb@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 13 Feb 2023 15:42:40 -0500")
Message-ID: <xmqqilg57zxq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>>  "	git rm --cached %s\n"
>>  "\n"
>> -"See \"git help submodule\" for more information."
>> +"See \"git help submodule\" for more information.\n"
>> +"\n"
>> +"If you cannot use submodules, you may bypass this check with:\n"
>> +"\n"
>> +"	git add --no-warn-embedded-repo %s\n"
>>  );
>
> I was a little surprised by this hunk, but I guess if we are going to
> block the user's operation from completing, we might want to tell them
> how to get around it. But it seems odd to me that the instructions to
> "git rm --cached" the submodule remain. If this situation is now an
> error and not a warning, there is nothing to roll back from the index,
> since we will have bailed before writing it.
>
> If we are going to start recommending --no-warn-embedded-repo here,
> would we want to promote it from being OPT_HIDDEN_BOOL()? We do document
> it in the manpage, but just omit it from the "-h" output, since it
> should be rarely used. Maybe it is OK to stay that way; you don't need
> it until you run into this situation, at which point the advice
> hopefully has guided you in the right direction.

If we are keeping the escape hatch, it would make sense to actually
use that escape hatch to protect existing "git add" with that,
instead of turning them into "git submodule add" and then adjust the
tests for the consequences (i.e. "submodule add" does more than what
"git add [--no-warn-embedded-repo]" would), at least for these tests
in [3,4,5/6].  

Also I do not think it is too late for a more natural UI, e.g.
"--allow-embedded-repo=[yes/no/warn]", to deprecate the
"--[no-]warn-*" option.

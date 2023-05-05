Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4266C77B7C
	for <git@archiver.kernel.org>; Fri,  5 May 2023 05:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjEEF2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 01:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjEEF2K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 01:28:10 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E916DA5C8
        for <git@vger.kernel.org>; Thu,  4 May 2023 22:28:09 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-51f6461af24so924206a12.2
        for <git@vger.kernel.org>; Thu, 04 May 2023 22:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683264489; x=1685856489;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3MJ2PDAXKbvRDEjyeksoezjKAuXyRQ3sr3Z8+dk3vUc=;
        b=p76M683FP7roTtyev+AT8WbuOUKtb4BqPl7Z/+80F+m4hgGjUUq9atg53uCNaamdcd
         yGSKDghnMczTf8f9RmIAkU3DrrMOvgkvRUXmYDfeGkM9LGqH0eunoFOlEsSPncBTmHcx
         d+QxVHdUFg5ISzsaaMFbG/ohotv7t+n7oGVHWTAtKxz5fd5Z1UGRgML2Tqbn1fWID1uu
         vgFLNP2Mj6Cd4doCIxCopVhZ7RUp6uBb6VcVAhjubhMBrbuClB+5MsZvhMCYEW9Zjy+a
         QuEFNjq2vkegvB9XfnvN8LyNDnV1sEBNWAz1Pnkham0ce25AXRv/GiVdyRKcwSHslHkA
         OMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683264489; x=1685856489;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MJ2PDAXKbvRDEjyeksoezjKAuXyRQ3sr3Z8+dk3vUc=;
        b=ZpC4E+K63bJUPwPFBE5AagE47WPnp6zdRzM0lLqjypl3MP0rsMxR8FTcMk3Vl5Gitz
         mHlJQ8KwJ5YCoZQMYCHR/vGd0AuvIsPI6xIvTk4atpUQBGnhdvd4YVSGZz6khbJQXb62
         UIpMljovNZZLahKqBDhdIY3MHLdxeoJ/qkJ8XG4NHPcGJDRhZiSPNc9gL8PvDkz6FYZD
         ms0Mlv8+fdwYfROsiRTrgDQPAWfrofMocWkhBP+AK4VCRG0rQzZkAKfVAXPkPfN/SwXf
         PgnLDV7hB9t0kT9OuhCDU7vDpIzfPEjbIO6A0uV7YQQfEGgLHUT9z9p51ssbM82QmSdG
         F5Dg==
X-Gm-Message-State: AC+VfDzg2n+2SeEdwTCIG5yLMh6AMIRFb/v9nSeqG9MuCzbdaYwVqx7m
        HKz+XOcOY2oGMY6RXGzvr2mPBtK3wDM=
X-Google-Smtp-Source: ACHHUZ7MRQGPKtotDWwWwo6zMvZ+JyeF03rb36uSiTINJs/iuvOlMgMZ/HfGP7ZwlIyRKdPjwvFwbw==
X-Received: by 2002:a17:902:e808:b0:1ab:1dbe:20ca with SMTP id u8-20020a170902e80800b001ab1dbe20camr214257plg.56.1683264488891;
        Thu, 04 May 2023 22:28:08 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id p22-20020a17090adf9600b00246774a9addsm4043029pjv.48.2023.05.04.22.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 22:28:08 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: [PATCH] diff: fix behaviour of the "-s" option
References: <20230503134118.73504-1-sorganov@gmail.com>
        <xmqqsfcdtkt0.fsf@gitster.g> <874jote2zl.fsf@osv.gnss.ru>
        <xmqqmt2lqofb.fsf@gitster.g> <xmqqttwskse5.fsf@gitster.g>
        <87o7n03qgq.fsf@osv.gnss.ru> <xmqqpm7fizsl.fsf@gitster.g>
        <xmqqjzxnixqr.fsf_-_@gitster.g> <xmqqfs8bith1.fsf_-_@gitster.g>
Date:   Thu, 04 May 2023 22:28:08 -0700
In-Reply-To: <xmqqfs8bith1.fsf_-_@gitster.g> (Junio C. Hamano's message of
        "Thu, 04 May 2023 16:10:02 -0700")
Message-ID: <xmqq4joribyv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>  * Then the interaction between "-s" and other format options were
>    poorly implemented.  Modern versions of Git uses one bit each to
>    represent formatting options like "--patch", "--stat" in a single
>    output_format word, but for historical reasons, "-s" also is
>    represented as another bit in the same word.

An obvious improvement strategy is to stop using the NO_OUTPUT bit
and instead make "-s" to clear the "output_format" word, and make
"--[no-]raw", "--[no-]stat", "--[no-]patch", etc. to flip their own
bit in the same "output_format" word.  I think the "historical
reasons" why we did not do that was because we wanted to be able to
do a flexible defaulting.  We may want to say "if no output-format
option is given from the command line, default to "--patch", but
otherwise do not set the "--patch" bit on", for example.
Initializing the "output_format" word with "--patch" bit on would
not work---when "--raw" is given from the command line, we want to
clear that "--patch" bit we set for default and set "--raw" bit on.
We can initialize the "output_format" word to 0, and OR in the bits
for each format option as we process them, and then flip the
"--patch" bit on if "output_format" word is still 0 after command
line parsing is done.  This would almost work, except that it would
make it hard to tell "no command line options" case and "'-s' cleared
all bits" case apart (the former wants to default to "--patch",
while the latter wants to stay "no output"), and it probably was the
reason why we gave an extra NO_OUTPUT bit to the "-s" option.  In
hindsight, the arrangement certainly made other things harder and
prone to unnecessary bugs.

Anyway...


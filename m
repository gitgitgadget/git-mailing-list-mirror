Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6879DC4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 04:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiLIEDx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 23:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLIEDv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 23:03:51 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C91199F28
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 20:03:46 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id g10so3604681plo.11
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 20:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6eihkZ2Kp1fLe2kzPok+blS+I0liN4PA1VVayiME49c=;
        b=PTc/EYg/W6Q/hjh/62ZKTbnJnVoQfclRFxOt9GxoyHG1Bi0YHq4RkoCOUJaf8n5vRu
         T8V/k8mNpoZSDJPnvBfo+qr4mNuMeqHoUiyEc/0zLnAiKhBywz81gk3mas+f+WX3jbR7
         IF7/s7kGDDO2Ab03YH6IyKa0Ed274/I4jFCYbdSA7sy1iS6kxF6i80aByulPEfeG9FAk
         EbioEKfu1Wus6ZWDTNNO4tS6sdNAYcK+FAFDUecMeGzy8ny2kPlNEET9uOIZ2OgJVE8G
         EHrBbxIjEW47TSCjRKS58Y4wTSgygne6FQdzJSqn3bitMGB67hDvCH3UF6N+yIZYB+i8
         dZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6eihkZ2Kp1fLe2kzPok+blS+I0liN4PA1VVayiME49c=;
        b=WqFRDJ2sp3sZCnJyzTaypZcyGgMZd/lEA93CzINXcGPkR8jjpfxveR2l6ZvQ1az2wH
         N7T1fhfKKGIiAxNi/wKu7RBORGaLAuCQ5z3eb+oiRHpdKq7O00+/qjyVdWjvCJNAI8Aj
         jHBLxn+OblK7fiSdaFQjKHV9HZ5gDcuWz+FhWa4VNs0MJIxOksJFxrLIo3dtT4vc6qqh
         VpdSahOt3Un3SYhCmVaOvNDArQnzHE7pJjjvWCKGNyLoYjXfkF82wbjhcV7T/t5nZJS6
         YZrkpfzK98VgesVwq3OuWGUnUJiM+Cnl+Gq91fDgpX39mr06kmh0XspoMB0+ic61IOrj
         kO0Q==
X-Gm-Message-State: ANoB5pka7PK1VQVQtWBp4Ggkg6UVj9tzgNgaK4E8Vc5h1cV+hS72Y/uc
        lklA8no5Ua8LCCuFPx8d6l3F7loQj5XTHQ==
X-Google-Smtp-Source: AA0mqf7DvbXe6Exz5O1Ju4xmD5oHyDIhiLiRslQuiB7rqX/IYNA/vPNXyOEBNoiE+R9WldD6O1bOqQ==
X-Received: by 2002:a05:6a20:6918:b0:9d:efc0:62 with SMTP id q24-20020a056a20691800b0009defc00062mr8341938pzj.10.1670558625477;
        Thu, 08 Dec 2022 20:03:45 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090a890600b0020bfd6586c6sm240673pjn.7.2022.12.08.20.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 20:03:45 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, David Caro <dcaro@wikimedia.org>,
        git@vger.kernel.org
Subject: Re: Skipping adding Signed-off-by even if it's not the last on git
 commit
References: <20221206170646.6lnpr6h7oprziy5b@vulcanus>
        <Y4/xSObs9QXvE+xR@nand.local> <xmqqlenj7t0b.fsf@gitster.g>
        <20221207084027.7dhyaatkzaawrg4g@vulcanus>
        <Y5EQCD4XCsN10HO+@nand.local> <xmqqtu266cj5.fsf@gitster.g>
        <Y5GRx86i3ZIiVxb3@coredump.intra.peff.net>
        <xmqq5yel2wuv.fsf@gitster.g>
        <Y5KSfsxLO7com2f9@coredump.intra.peff.net>
Date:   Fri, 09 Dec 2022 13:03:44 +0900
In-Reply-To: <Y5KSfsxLO7com2f9@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 8 Dec 2022 20:42:22 -0500")
Message-ID: <xmqqcz8t1avz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> >   git config trailer.sign.key Signed-off-by
>> >   git config trailer.sign.cmd \
>> >     'git var GIT_COMMITTER_IDENT | sed "s/>.*/>/";:'
>> >   git commit --trailer=sign
>> >
>> > which is only a little more typing than --signoff, but it's not very
>> > ergonomic.
>> 
>> It does not look _too_ bad, though.
>
> What I don't like about it is:
>
>   - the external cmd is complicated and slow. It would be nice if you
>     could just set trailer.sign.ident=true or something, and it would
>     use your ident by default if no value is given (and maybe even do
>     completion similar to "commit --author" if a value is given).

Ah, "trailer.sign.value" to use the same value does not exist, and
the closest kludge we can use is the .cmd thing?  Then it is a shame
but it should be easy to correct?

>   - you have to know to be clever enough to define and use
>     --trailer=sign. If --signoff didn't exist, that's not too big a
>     stretch. But since it does, everyone will naturally reach for it
>     first.

We could reimplement --signoff to actually take attention to the
"trailer.sign.*" thing, if we wanted to, and that makes it very easy
to explain, I guess.

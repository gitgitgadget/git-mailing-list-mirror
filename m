Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635A4C77B7D
	for <git@archiver.kernel.org>; Thu, 11 May 2023 01:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjEKBuj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 21:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEKBui (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 21:50:38 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91EA65AA
        for <git@vger.kernel.org>; Wed, 10 May 2023 18:50:36 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64115eef620so54441000b3a.1
        for <git@vger.kernel.org>; Wed, 10 May 2023 18:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683769836; x=1686361836;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnlOcZ2K1VIx7eR2H0acgsbu/v/fyABOuaforuAsyVU=;
        b=JpLLlijZIlh5KwjhU0SMseDFXS8rbJIy+y9KT+p1+L3royz2FBUfEZNu+eXd/OhWNv
         4PcEyPWn1ggYF5rXK7LtGPNhghPsxcc4OZEJW2ylLVG/76Dol1OV4n13fljZRB0wl/TI
         HkloTfqnIkqLgVtePnwYzfbqpdF2mRxxTgMX6TLUby30Pp6GYnEXXnELOYp6l9ktdBRT
         JiBekhqTyKjj8e455nmQIDm64HGs7lICFu7M8JEO2kfx9sChSodjs+TqFlCAbCCSGCXc
         7oRoSCV943+xu0I6gls5Eb8RJakI9CjdBYbi/7koeqQNtXpTk6we08ZQbty3fBjU8hgo
         c8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683769836; x=1686361836;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nnlOcZ2K1VIx7eR2H0acgsbu/v/fyABOuaforuAsyVU=;
        b=QS8przHxKBQ0X0PFluEXLRItHaIM/FuGyQFkyu8UsnW4UmDDmzbg+LTikE0DECF85u
         fY93hpNKi9oBGTKU999HFKpUm3bvEWLoS0qKUJY+PZOEzB7t/48dHJDMlvnEFeUJdxdS
         s1L2gJLpwAW4/+DZ+4VkzhBfgJUWUubNoWhpsBUpkNB3I7MeeaNosscxNm9f10VWW6sg
         lfub6oTJ6Fm0ZeGKepLqokRN27pmV/kabhQ6jYd3e7jTElLdQ9H9yYtoMmATSIkNGEGg
         ArmKwE7Tai62Z3f2GsU4OWPgaeFiHGuaYFONTjL0bgE3lLhr9ip/StkwGPYhR9dIvHJV
         qZgg==
X-Gm-Message-State: AC+VfDyD2KRtESA24Xogi0rdSzTzoWwamWEcAWK10szff+WoXFkvx7ez
        ZJanITa02HPMonUCGf5ZDpA=
X-Google-Smtp-Source: ACHHUZ4r62T1v8xMSMCPUeLtD4hizcuvSkpAuxVPCXre2cTi4zQTzTCYapZz0E3JpzrIE9B1hjZ6sg==
X-Received: by 2002:a17:903:41d2:b0:1ab:28b4:6d5 with SMTP id u18-20020a17090341d200b001ab28b406d5mr32402262ple.5.1683769836115;
        Wed, 10 May 2023 18:50:36 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id l8-20020a170903244800b001ac2c3e54adsm4476050pls.118.2023.05.10.18.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 18:50:35 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] diff: fix interaction between the "-s" option and
 other options
References: <xmqqfs8bith1.fsf_-_@gitster.g>
        <20230505165952.335256-1-gitster@pobox.com>
        <645995f53dd75_7c6829483@chronos.notmuch> <xmqqsfc62t8y.fsf@gitster.g>
        <6459c31038e81_7c68294ee@chronos.notmuch> <xmqqjzxgzua0.fsf@gitster.g>
        <645c25dcb590b_7b63e294ea@chronos.notmuch>
Date:   Wed, 10 May 2023 18:50:35 -0700
In-Reply-To: <645c25dcb590b_7b63e294ea@chronos.notmuch> (Felipe Contreras's
        message of "Wed, 10 May 2023 17:16:44 -0600")
Message-ID: <xmqqpm77zlec.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> The "author" refers to the author of the "proposed log message" of
>> the patch in question, i.e. me in this case.  The author of the
>> patch under discussion thinks it is, so asking "Is it?",
>
> This is the full quote:
>
> ====
> Let's fix the interactions of these bits to first make "-s" work as intended.
> ====
>
> If instead you meant this:
>
> ====
> Let's fix the interactions of these bits to first make "-s" work as I intend.
> ====
>
> Then that's not a rationale, you are essentially saying "let's do X because I
> want".

This will be the last message from me on this.  I wouldn't have even
seen the message I am responding to, as I've already done my "once
every few days sweep the spam folder to find things to salvage", but
somebody notified me of it, so...

I didn't say and I didn't mean "as I intend", and you know that.

I, the author of the patch under discussion, know that it is the
intention of the author of the earlier commit that introduced
"--no-patch" to make it work identically as "-s".

I even had a quote from that earlier commit in the proposed log
message of the patch (look for d09cd15d) to substantiate the fact
that it was the intended way for the option "--no-patch" to work.
So, either you are arguing against the patch you didn't even read,
or you are playing your usual word twisting game just for the sake
of arguing.

>> And it led to unproductive and irritating waste of time number of times, and
>> eventually you were asked to leave the development community for at least a
>> few times.
>
> That is blatantly false. As a member of Git's Project Leadership Committee, you
> should know precisely how many times the committee has excercised this power,
> and it hasn't been "a few times", it has been one time.

You were asked to leave in May 2014, and according to that message
from May 2014 [*1*], apparently you were asked to leave after a big
"Felipe eruption" in the summer of 2013 [*2*].  These happened long
before the project adopted a formal CoC at 5cdf2301 (add a Code of
Conduct document, 2019-09-24).

But apparently the "fact" does not matter to you.  I know that your
next excuse will be "I said the committee never exercised this power
more than once, which is a FACT", which may let you keep arguing
further.


[References]

*1* https://lore.kernel.org/git/53709788.2050201@alum.mit.edu/
*2* https://public-inbox.org/git/7vsj0lvs8f.fsf@alter.siamese.dyndns.org/


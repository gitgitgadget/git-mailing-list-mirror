Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72784C38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 12:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE2220CC7
	for <git@archiver.kernel.org>; Thu,  7 May 2020 12:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3y7I3w/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgEGMRX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 08:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbgEGMRW (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 08:17:22 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823F5C05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 05:17:22 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id j3so6030863ljg.8
        for <git@vger.kernel.org>; Thu, 07 May 2020 05:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WzWAOyb37YVIPQY/jrStfLvNf80Mdk98IjVbiE7i7jw=;
        b=m3y7I3w/93Kd3WW2cPA0vZHk/THsqE4ccwHxO2TSO1ec2S3wgg4ODWmYpftDRamvh5
         izq05Q3904LDF5R2J+4daSxIjseKb4uKtsnVgajDwV5pWQ2J9tbE9R+Cbs90MaDbxlm8
         PI6XHoQyfe7zMlyz+a1cdMpEdddqLERMlScEzQAEfwn/Yq5+IeBF8wL1lDiv/kip4TTO
         q37zOpR2TgFgaLeyQVOzYq4UzQmlpr7VQ4JJkskHZVlI1Ms1JvbPsSpUc+VQubLGc1ok
         NdhHg41+5wXDndB7eo0D7kVuyxErNEPi7H8t0dl8mxD6gk76o1A+WPn6JKkFVbM+CbfS
         LpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=WzWAOyb37YVIPQY/jrStfLvNf80Mdk98IjVbiE7i7jw=;
        b=IjIRcriQgWr2ctayG1/e/fBH3/TTkE7YdXmHhO1wHN3218JFr0fK6/IoC321eUQ6BS
         CToKyECY5dr1qZbxSPh4+fF8L5X4oDv7H3Dxv9PCHOM/UM2CeBsv0pXpg5g0JVJ+XuvF
         MzkYDqa0YPIVEgfSaouU5skP6xeZQHq1QxnfkIxhkPak5AWtXhqJQSNQDQnBIRflHjTK
         jT2bUCuEqltibEjvqsic4FMzoQ1si5FhCjWF7A9UwGiQTRnK8JrCf+QPaDmhaxCC8FIa
         6UMcMMyFDMeuEoLmwDpLqdhUFn1Ixyr5u0UyOAkVLe/jYsurAH5f/QBilwPTUyIcnneZ
         /8Jw==
X-Gm-Message-State: AGi0PuaR29vAj0VW8X98BkWtvwm3j/oYOC4jP7BpunZajezcc2PB2T1v
        dTcmBQj9TbqOkcAbwZjPG4qpyTKh
X-Google-Smtp-Source: APiQypKlVoNom+zZOMGGUrhzQnzQftQBmTWSvjlgqrcjPZ75C0Kwhrls3VdBTJbuaF2W/RrOqgmVVA==
X-Received: by 2002:a05:651c:549:: with SMTP id q9mr8385748ljp.236.1588853840353;
        Thu, 07 May 2020 05:17:20 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id y9sm3208562ljy.31.2020.05.07.05.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 05:17:19 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Solomon Ucko <solly.ucko@gmail.com>, git@vger.kernel.org
Subject: Re: rebase -i: quick/inline reword
References: <CANtMP6oKN6Ueu=fqFYv2VhUP5S-ifbSzPTARvbEg4eV0pcRcHw@mail.gmail.com>
        <xmqqzhak4a9o.fsf@gitster.c.googlers.com>
        <20200507114630.GC3027470@coredump.intra.peff.net>
Date:   Thu, 07 May 2020 15:17:18 +0300
In-Reply-To: <20200507114630.GC3027470@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 7 May 2020 07:46:30 -0400")
Message-ID: <87zhakgcs1.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, May 06, 2020 at 09:52:19PM -0700, Junio C Hamano wrote:
>
>> Solomon Ucko <solly.ucko@gmail.com> writes:
>> 
>> > ... It would be much easier
>> > if there were a mode where any changes to the commit titles in the list
>> > modified the commits' titles. Maybe `git rebase -i --reword`?
>> >
>> > Any thoughts, suggestions, questions, etc.?
>> 
>> It is probably a bad idea, as it encourages a single-liner commit
>> message without any body.
>
> There is another legitimate use (or at least one I have wished for many
> times): when manipulating the todo list in my editor to choose patches
> for editing, I sometimes notice a typo in the title and correct it. And
> of course that does no good, and I get annoyed. You'd think I would have
> learned after all these years, but I continue to make the same mistake.
> ;)
>
> I've often wished that changes there would be quietly persisted.

That's exactly my case as well.

-- Sergey

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634E4C4332F
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 00:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiLEA6w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Dec 2022 19:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiLEA6u (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2022 19:58:50 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50731262A
        for <git@vger.kernel.org>; Sun,  4 Dec 2022 16:58:48 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 124so9931546pfy.0
        for <git@vger.kernel.org>; Sun, 04 Dec 2022 16:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+LJpCyTiCFStAsCr8DJbe0zxk8yttylUtjRbP9prL7k=;
        b=fslK7rs+lgxDotDEQMzRDgKQDLIdYM82pS5YkC5aFAI2R2JEy96iGuZ9CSELqZdc23
         VOpoCdJa+i0A69zAOQApFaZ7QA6JH1JdrxNQtzs23Hc/ccWSKt4IGKRAKCFNsFts5Uuj
         o7os+cnsE29cgE1Huda/QH6daHqtM7kgS4iiTKLaZS/Tn4bRDZ4D9oV+kNORUZw7LSj5
         86Xi6oKunwslEuz0aOBTGSfUTMaAyYkmOCvbnGtt+u1Ij7Wd5Z/IIipgBrbC+kKmgiVJ
         lL4Uombk6Vqi/y1EDBnkCPlyn7DQ8Q+jGB1vm0DCOzilSVHVuUSKbwyf0LO0BEcpEi+J
         xKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+LJpCyTiCFStAsCr8DJbe0zxk8yttylUtjRbP9prL7k=;
        b=PPgxBBcl8IJ+d4aaPBi/d7jcSraeaOUDppcnz4tzHHgW+CLItzwDLPzeyew6kOYTxJ
         ocBeNhBjJJsnbWy6R9B7/3Ho16pK7G/lUNw/gqdBawjyqZWBDttDJYFImjStbO4KXAlp
         OOkWwlHzsuNqPuumBjjCeEwPNT72NuW28dIfRMqUO3O/mG4OLzHnr3smq75StX0Ki6Gy
         LRnzTQIN+/s1ZbGjeMFixDqeDLIFdQ0AEQjFeg7hbRzW8F8TSZSQHCA06MYRT4gaO//C
         V1h+qxkFGkDSO4Gz1c3LtwkSxrdb/PNVoGP3vU3UH8oJvesif1KxYr6QYDUVUu+akXCG
         Jx6g==
X-Gm-Message-State: ANoB5pl1q4MSVv4SwNSATWkKxPJHbnbD6eLfILgRN8zG65Hl7UTP3ghh
        Djkxg9uJ7ERFkqeP516Zb1U=
X-Google-Smtp-Source: AA0mqf7Z2EngJBY2ij7eevTrl4jl70Clqy3i3BoXZgZVZtUGbGObU2+IJFCsJ8rQb0vWXa8/+bzKOg==
X-Received: by 2002:a63:2160:0:b0:46f:f26e:e8ba with SMTP id s32-20020a632160000000b0046ff26ee8bamr57225405pgm.250.1670201928306;
        Sun, 04 Dec 2022 16:58:48 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id iw22-20020a170903045600b001897d30143asm9198418plb.289.2022.12.04.16.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 16:58:47 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Victoria Dye <vdye@github.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Stefan Sundin <git@stefansundin.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff Hostetler <jeffhostetler@github.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH] fsmonitor: eliminate call to deprecated FSEventStream
 function
References: <pull.1436.git.1669991072393.gitgitgadget@gmail.com>
        <221202.86o7slfzot.gmgdl@evledraar.gmail.com>
        <3e2bd865-3ca5-b0f7-095e-f8b97ec8822c@jeffhostetler.com>
        <221202.867cz9fwnf.gmgdl@evledraar.gmail.com>
        <4711d955-02b2-f599-7f89-b442dd0b6215@github.com>
        <221202.86359xfs5c.gmgdl@evledraar.gmail.com>
        <1b090929-f2da-f075-01d4-458804fc0717@github.com>
        <xmqq1qphuwj6.fsf@gitster.g>
Date:   Mon, 05 Dec 2022 09:58:47 +0900
In-Reply-To: <xmqq1qphuwj6.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
        03 Dec 2022 10:05:17 +0900")
Message-ID: <xmqqv8mqsm2g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I'd still prefer that our commit messages keep records of the fact
> that we stopped supporting certain older systems and what kind of
> due dilligence we did to decide it is a safe thing to do, which all
> already happened in this thread, thanks to you three discussing the
> issue.  I would be happier even with "Anything older than 2014 does
> not matter to Apple, and we follow that stance" than without any ;-)

I'd propose to have an extra paragraph at the end of the commit log
message.

1:  02a55477b6 ! 1:  df739b6087 fsmonitor: eliminate call to deprecated FSEventStream function
    @@ Commit message
         maintains the original blocking model by waiting on a mutex/condition
         variable pair while the hidden thread does all of the work.
     
    +    While the deprecated API used by the original were introduced in
    +    macOS 10.5 (Oct 2007), the API used by the updated code were
    +    introduced back in macOS 10.6 (Aug 2009) and has been available
    +    since then.  So this change _could_ break those who have happily
    +    been using 10.5 (if there were such people), but these two dates
    +    both predate the oldest versions of macOS Apple seems to support
    +    anyway, so we should be safe.
    +
         Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     

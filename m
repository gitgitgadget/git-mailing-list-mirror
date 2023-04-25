Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BA8C6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 18:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbjDYSzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 14:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbjDYSyu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 14:54:50 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0112A17A0C
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:54:27 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3ef6e84945dso14571851cf.2
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682448841; x=1685040841;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wanf3UCTUVHvzBpyr/lpslFfmG+XUIvkWxmu3Xb+mfY=;
        b=qZzY7UWFZ2c8XEdrMiazwIdFrZouOUFY9bD/9CGFqeSM7iNi6K7HwzY4bxZiH/af54
         9f0fE5gN/HkIxgIJZOv2wgBn5L/Lm5PegpPGfodIiv6CCCvWIjD1Wnz8PdRHbathpp9O
         ljn+J9BY5UBuvBDnonT+vpBjPHl2qODvLgeOmD/4aR7vktHi2irW4MQydXGulyb3PDfI
         9gUHJj/JLeMccqunumi5/u9o9csUmGV9WTNg4Lc//1zI1mg3F1Qzjb8T4jzl6mqeLzeT
         HVCgbJC5FLOc5jcbPLvpvxCUTRT+bQ9qTUl2P/tI3uZiZG5acD64h8YEkGbS4Vktw27W
         2OTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682448841; x=1685040841;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wanf3UCTUVHvzBpyr/lpslFfmG+XUIvkWxmu3Xb+mfY=;
        b=Dx4vnzvx2S6kqulH6o65mpLlaMNcicfKXWPHQLMH+SD6tNwB3DvN54mOPTV2+iGb3s
         6bqZzKkWwcs7TJrRyFuKLJPSk0kO87mFMq9mD01IPAG+Rwz5ZcZpwTN/7xextQAdUKye
         Kk308WLrdmeLlXsYSRccTfSi4QJYQ5LrQrcCb+mC0hzaJpXO+HjVqdsuQ/iSpxQoxcwo
         kReiAfmTlJ2q2HRkllP63q1X57whatWD7xeJ6mrHQ7y6Pj1LnSOyO0L643wyFbeUVXST
         AxJdJeMF01qMPvTSHL/BKJp5S9O/gFoIRZoptuaqStVko68naubdSX3qnPt1q1W0KRzi
         K8/Q==
X-Gm-Message-State: AAQBX9diixrxq/dTbyxCrB8om5u6dDl1HADn0egUVyRke7rz12gnKM/q
        4ZR+NYAYiDMur/0G6+leoaB65YBnAEc=
X-Google-Smtp-Source: AKy350YKQFvJIcOL36NSgBRnQtlJUGe62Z2lizyYSybZVZ0RwGYrzvCM+9PEPaeUspHN5sLnbHFABw==
X-Received: by 2002:a05:622a:47:b0:3ef:3fd8:9209 with SMTP id y7-20020a05622a004700b003ef3fd89209mr31475475qtw.48.1682448840961;
        Tue, 25 Apr 2023 11:54:00 -0700 (PDT)
Received: from hurd ([2607:fad8:4:3::1003])
        by smtp.gmail.com with ESMTPSA id m13-20020ac807cd000000b003ef311b39d7sm4628271qth.96.2023.04.25.11.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 11:54:00 -0700 (PDT)
From:   Maxim Cournoyer <maxim.cournoyer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] send-email: add --header-cmd option
References: <20230423122744.4865-1-maxim.cournoyer@gmail.com>
        <20230423122744.4865-3-maxim.cournoyer@gmail.com>
        <xmqqh6t57x0y.fsf@gitster.g> <87y1mgortc.fsf@gmail.com>
        <xmqqcz3s3oz7.fsf@gitster.g>
Date:   Tue, 25 Apr 2023 14:53:59 -0400
In-Reply-To: <xmqqcz3s3oz7.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        25 Apr 2023 09:29:00 -0700")
Message-ID: <87leifpzco.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Junio C Hamano <gitster@pobox.com> writes:

> Maxim Cournoyer <maxim.cournoyer@gmail.com> writes:
>
>> I'm not too familiar with the email format; but I presume an empty line
>> would signal the end of a message?  That'd be bad yes, but I think it
>> cannot currently happen given the 'last if $line =~ /^$/;' guard at in
>> execute_cmd around line 2023; it'd means headers following an empty line
>> would be discarded though.  The expected use case is indeed for a user's
>> script to produce RFC 2822 style headers to messages.
>
> Yes, silently discarding the end-user input is what I meant by a
> disaster.

In v3 just sent, empty blank lines are now detected and reported as an
error.

>> The former (a true default with no way to turn it off other than
>> redefining it), which I believe is the same behavior as for --cc-cmd or
>> --to-cmd.  There are no '--no-cc-cmd' or '--no-to-cmd' options, although
>> their result can be filtered via the '--no-cc' and '--no-to' options.
>
> Yup.
>
>> Looking in the source, options supporting '--no-' always appear to be
>> boolean toggles (on/off) though, so I'm not sure how a '--no-header-cmd'
>> that take a value can currently be implemented.  Perhaps it could be
>> added later if there is a need?
>
> Perhaps we can do without a configuration variable first, and
> perhaps the variable could be added later if there is a need and a
> proper way to turn it off per invocation basis.

I'd like to preserve the sendemail.headerCmd configuration variable; as
it properly enables the use case that motivated this change :-).  If it
means I need to add some ad-hoc --no-header-cmd, I can do so; let me
know!

>> I've extracted such postprocessing into fold_headers and applied
>> execute_cmd to it in new invoke_header_cmd subroutine.
>
> Sounds like a good approach (without looking the actual patch).

OK.  Make sure to look at the latest revision, v3.

Thanks again!

-- 
Maxim

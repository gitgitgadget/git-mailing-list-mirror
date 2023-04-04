Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90874C77B6E
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 20:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbjDDUOb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 16:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbjDDUO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 16:14:28 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78322121
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 13:14:27 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id kq3so32393748plb.13
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 13:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680639267;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3jW4DkEULq7DU+jLhC0kYxSU/IV5ZYe1KQ9qaQB2uHQ=;
        b=gEk2zkKKIUq1Pgb905jijbndOLLVmGmAuTWSkyY34S0r7wHagt+HVQv1+HlGsUZVhZ
         LOUk9Xn0t2eKkVCbWGQDVESL3Y+wDbrPalHfO5e+lpgQeBtK384URHGyisPqtdOG8XGl
         vN+VJoRcUlAy0gH711g9cGVO+QKtF/udC/Xi5Ikzm1fz7lljpif1Su9e5avPjZ9uEwz8
         aucciU8VPy4zEemRsV0hcTzWF1eQu7351bVaS/ftV2fXkUCBz+GIANuCXBmoFbeL0+yL
         My9hZG66vjz4gcTlaWykXq/tMq8j3nyVho8LuEEZzSLc/wzZyereoOheGk3jBeEYbh5z
         kq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680639267;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3jW4DkEULq7DU+jLhC0kYxSU/IV5ZYe1KQ9qaQB2uHQ=;
        b=QO/tKyRlXBtciOd+EeOkqSmN9v4jMRyyEamUgMX+JC7071jXUr88zSYxYPOtuLYqxe
         vQqWvjwzqRGo5RQxXCttt+r+xbofwvHTVXN2dMxfWIVsj1ThtFDTQdLEtfm+xRPUF55d
         etvwLLFBLN7q/N/nln8nzcxJchKobPTSsIDDk39z4gIc6hqQNGoCuDAIOUWK9fBWNbvq
         aqxjsW9PWc5xGIVD0Ewi44frMkAHpOUdQrrHCbWQVLQaoQO2mz9Ak/+omAB1raSiGqFG
         xY7oI+OwOw9lO+b9Tsoo4YDl/UaRaISVOyMMZ/FYUQaw1mD0ugNzz/gDA16DsivVuwyT
         dYGg==
X-Gm-Message-State: AAQBX9fnjmXO2v5Kw0zlAYzk0P/Z264moVckZWl2gsWFXOYPU9++zsov
        IwOi6Aij0AiXpcQ1S5Bx+NQ=
X-Google-Smtp-Source: AKy350Yjy4OxesSx+SU1keBsWLXIrUijTLnIMOPLmlW/kAXXjOGZ90DtRreiAtpUlffoyQx7fnD1UQ==
X-Received: by 2002:a17:902:d510:b0:1a1:8007:d370 with SMTP id b16-20020a170902d51000b001a18007d370mr161631plg.33.1680639267100;
        Tue, 04 Apr 2023 13:14:27 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id p3-20020a1709026b8300b0019a91895cdfsm8743148plk.50.2023.04.04.13.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 13:14:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robin Jarry" <robin@jarry.cc>
Cc:     <phillip.wood@dunelm.org.uk>, <git@vger.kernel.org>,
        "Tim Culverhouse" <tim@timculverhouse.com>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>
Subject: Re: [PATCH RESEND] hooks: add sendemail-validate-series
References: <20230402185635.302653-1-robin@jarry.cc>
        <66099367-4ea0-7d2a-a089-7a88e27f695e@dunelm.org.uk>
        <CRNH5FOB91JE.14CZEA494X002@ringo> <xmqq7cus4m0b.fsf@gitster.g>
        <CRNHSC3H2B6C.UCSDE4Y6ET4A@ringo>
Date:   Tue, 04 Apr 2023 13:14:26 -0700
In-Reply-To: <CRNHSC3H2B6C.UCSDE4Y6ET4A@ringo> (Robin Jarry's message of "Tue,
        04 Apr 2023 00:59:42 +0200")
Message-ID: <xmqqbkk3z9p9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robin Jarry" <robin@jarry.cc> writes:

>> it.  Does send-email work on it correctly if you did e.g.
>>
>>     $ git send-email dir/000[12]*.txt
>>
>> or something silly like
>>
>>     $ git send-email dir
>>
>> or does it already choke on the first file because of the filename?
>
> It seems to work with both. I guess, NUL bytes separation it is then...

Feeding the filenames as the command line arguments would have been
much simpler X-<, but either NUL termination or c-quoting the
filenames would be needed _if_ we want to support crazy folks who
feed us such garbage filenames.  Letting hook scripts understand NUL
termination is a chore and it still is debatable if it is reasonable
to support, though.  I'd say it would be sufficient to just declare
"files whose name has LF in it is not given to the hook, ever" and
users would avoid such a filename if they care.

Thanks.



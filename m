Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0480DC77B73
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 17:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjDSRB5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 13:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbjDSRBz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 13:01:55 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB61D26B6
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 10:01:53 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-51f3289d306so1708789a12.3
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 10:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681923713; x=1684515713;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8GGSjXcORVr/RCA23sOkE1A35aJgBXk0SfC9T8DFQ5Y=;
        b=ChzeQXRPqYoPgh+YDXoOUKCzDawEsvTivpEX608QVGNoksxw1IZz0BKRcGk6wyNL3g
         SPuA/w2i2oWVdmzWeXGwQuTg61/jvc9nDzRRJuHALfweLeZ7vsclwFlW92V6mQYHLows
         /y06x89pZqX0hAbKQ1/Hukgyf2Ed1VqvLQQsoAll4BBmTzrzjMc8DmbNgE51rbN81gtI
         jg5bmKpKQEikRKknBibV2tjPETwAtJ88emwOVFiVtmwkQ4etaXxGh7f20NTNscSoNxQB
         6y1j8iTojegaSy9pxG6kxAa0suJ43MzylrK3tvbsbk8G3rkTucNzk1+8Al+y9l5TU4xU
         mHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681923713; x=1684515713;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8GGSjXcORVr/RCA23sOkE1A35aJgBXk0SfC9T8DFQ5Y=;
        b=CKrc028ijb4eWYSa0ayc6fJUpD1f8FTJDPTnzNaqbzsAYs9CJ4GyrQaLhy5XVKiQ9N
         nZxlQK1NL1N90YWxFdQLfbi+wvZQvyDXb2gyS2aGSKKEOSwOa1Ux8wuVJO7ikYWrl4D4
         E5mm25ES7VTiMAehSSdMF8IQwOyZ5/5/0Tl3celXutZGk+VDZlVE6zS1YoYbb8hNl3pa
         Fq4CGPYkX3tazQypIgtmNxlCl+PKFoNRtxwrYvW8ELixfJrM6r5hUeZMtMmCj/+76Nbq
         ni6SVvKjXldvzEwl7daGj1jZQG5sHxHvqOKn5hvZtkWZ6HwfHSljdmqqmpy7p+OcCwzu
         SGHg==
X-Gm-Message-State: AAQBX9ePMpVj72D3twUGW0JFMQJDeLfVzWRCv3POdbcdWflEHIkMEE9o
        ShSU8dF0j4aXkN/FNc7eKj8=
X-Google-Smtp-Source: AKy350aTgCjbAauwgnbevbbfhcRmrneBIK8ryXvc/8UCPud1rhegBBUlivDym3Jgb0mKFbuxFg7I4Q==
X-Received: by 2002:a17:90a:17ac:b0:247:6edf:e934 with SMTP id q41-20020a17090a17ac00b002476edfe934mr3404795pja.42.1681923713078;
        Wed, 19 Apr 2023 10:01:53 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090adc0400b00246aba3ebabsm1628756pjv.45.2023.04.19.10.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 10:01:52 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Strawbridge <michael.strawbridge@amd.com>
Cc:     Luben Tuikov <luben.tuikov@amd.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v9 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
References: <20230120012459.920932-1-michael.strawbridge@amd.com>
        <20230120012459.920932-3-michael.strawbridge@amd.com>
        <e353df62-c189-755f-5536-5ea91177c55c@amd.com>
        <c1ba0a28-3c39-b313-2757-dceb02930334@amd.com>
Date:   Wed, 19 Apr 2023 10:01:52 -0700
In-Reply-To: <c1ba0a28-3c39-b313-2757-dceb02930334@amd.com> (Michael
        Strawbridge's message of "Fri, 20 Jan 2023 09:25:49 -0500")
Message-ID: <xmqqttxb956n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Strawbridge <michael.strawbridge@amd.com> writes:

>>> +Below is an example for a few common headers. Take notice of the
>> "example of" not "for".
>>
>> This maybe clearer:
>> "An example of a few common headers is shown below. Take notice ..."
> ...
>>> +test_expect_success $PREREQ "--validate hook supports header argument" '
>>> +	write_script my-hooks/sendemail-validate <<-\EOF &&
>>> +        if test "$#" -ge 2
>>> +	then
>> There appears to be an extra indentation of the "if" statement.
> Good catch.  It was a matter of spaces and tabs combining that wasn't
> easy to see.

I was reading the list of stalled topics in the periodical "What's
cooking" report and noticed that this topic has been marked as
"Expecting a hopefully minor and final reroll." for full three
months after we saw this message.  Should we be waiting more?

Thanks.

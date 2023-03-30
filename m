Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20B6C74A5B
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 00:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjC3AU7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 20:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjC3AU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 20:20:57 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AF510D4
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 17:20:57 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a16so15685890pjs.4
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 17:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680135656;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K5BKQBbRIwk1IlRzjSR5p1h+qXbhjRi4LV3PRW8kHaQ=;
        b=XrAzkFN/1SfSK2Uomo47UI2zZxVR+apJv+7pL4ldWpbAkXkW1OzZNZ6Ay01DY83POL
         VU987pxXYI+/MPPS6UPM3+StGe+dxA2JMnztsmrPB7KH6v3mEXjMbZLD6mWpKhYOpUo7
         r+ECKlmyDMoUFWFdHPWlfTIn1PCGBSKa3IW3U/J6CaV/OBBTmDRX7gcuAU1hmPYj65Jr
         9k64uSTJbWzKy9XxzKDQZNndYmp7oueg4/15AZ8kuAXgfH6dsWDO3Qo1mIsXcAm8eFRj
         q1k2rIqsnFbFDi4/3G7WBiH6WiK8y5sUrbx8L4L5zHtM+fTQ2gjACSm5rgYbF4hWNVTz
         ACvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680135656;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K5BKQBbRIwk1IlRzjSR5p1h+qXbhjRi4LV3PRW8kHaQ=;
        b=Jcy9KwT9gg9QQWjTB+gSJK0rJTBHlUZS8L3kZ39e9JqHILUptKgxD67eC3tOWViGlt
         WXQB54nafP+MDhBVpPJgwOqPh+8Jp2L7/blQQ6OU3eik28UQdszHRpMr/RjBcypdX0dM
         WlaEjc/RGXSkdBqstNNtqnaZpYqgd5XzehlbJtOLPgn12dbaCq2zt7G5jGtVOw4uBb2m
         5u++BIpmBgaMyPPhKmvTJ8yMTEooLHg6d5wU4+HzE3Nh3fG8kxXg4XWAL8cL6HAv9knU
         3WY76j9j4PJF0zeBKcE2VP3DUdzQg+CSWEofmkVFcdJEtlaqPKCf+RZSp9KWqAh3TuBh
         FQ/g==
X-Gm-Message-State: AAQBX9emmNbo/l7eLZ6Hd29KRx0VB7lNl9xnNpj57oSdBwflHK8ebwcP
        pQTDaVrQtjOZuq8TBUQtRSE=
X-Google-Smtp-Source: AKy350ZEeHEaI0upEnuaPtthsFeUaRJswbFT7W6D6uA1l+xqH+Wo7JMYRtZS1IfkhZ3U/K9Az1lQ9A==
X-Received: by 2002:a17:90b:4a8d:b0:240:6a1d:a14b with SMTP id lp13-20020a17090b4a8d00b002406a1da14bmr17938516pjb.28.1680135656428;
        Wed, 29 Mar 2023 17:20:56 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c10c00b0019cad2de86bsm23576532pli.156.2023.03.29.17.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 17:20:56 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stanislav M <stanislav.malishevskiy@gmail.com>,
        Stanislav Malishevskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Stanislav Malishevskiy <s.malishevskiy@auriga.com>
Subject: Re: [PATCH v2] http: add support for different sslcert and sslkey
 types.
References: <pull.1474.git.git.1679233875803.gitgitgadget@gmail.com>
        <pull.1474.v2.git.git.1679327330032.gitgitgadget@gmail.com>
        <xmqqlejrmj4y.fsf@gitster.g>
        <20230321172223.GA3119834@coredump.intra.peff.net>
        <xmqqjzzahufj.fsf@gitster.g>
        <CAEpdKf=pMcMn6q0wGGcrFN1yi1duguSNLDkqhDmvMBeKQ--yuA@mail.gmail.com>
        <20230323180159.GA1015351@coredump.intra.peff.net>
        <CAEpdKfm0S4tkLz8DMnkJmhMmJk8Cj1tUm7NbMe7kpATq0bkxCw@mail.gmail.com>
        <xmqqfs9n9yp4.fsf@gitster.g>
        <20230329232347.GB2314218@coredump.intra.peff.net>
Date:   Wed, 29 Mar 2023 17:20:55 -0700
In-Reply-To: <20230329232347.GB2314218@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 29 Mar 2023 19:23:47 -0400")
Message-ID: <xmqqmt3v5btk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Mar 29, 2023 at 11:53:11AM -0700, Junio C Hamano wrote:
>
> ...
>> > But I don't have any idea how to do that with hardware usb eToken in my case.
>> 
>> OK, so where does this put us, with respect to the change?  ...
> I would be OK taking the patches without any further tests. It is not
> really making anything worse in the sense that we already do not test
> any of the client-cert stuff.

Alright.  I think the patch has already been queued for some time,
and it is OK to merge it down to 'next'.

> If we can cheaply add some tests that at least exercise the code and
> hand off to curl, that is better than nothing, I guess.
>
> I think the ideal would be a new t5565 that sets LIB_HTTPD_SSL
> unconditionally and actually tests various client-cert formats and
> requests using a made-on-the-fly cert.

Thanks.


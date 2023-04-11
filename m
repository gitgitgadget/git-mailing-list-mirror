Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16BFC7619A
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 19:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjDKTOV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 15:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjDKTOP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 15:14:15 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3E64C15
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 12:14:05 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-24493a05a62so553517a91.3
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 12:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681240445; x=1683832445;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sv13vpRoBTogOEMfKSmMelgvzHGBXczKQaSW/1fKnTE=;
        b=gR/KfB3s9dApLJFClwyEAKQFtgTCuA0t1I4WxfAiif3IPavzpZPCXfN8T3C3dUCsF/
         xQ+vSL8TCIlU8lMrL61wsVE/2AUmrEckzxXr8CYgx9nBnlZ4gDhHPgLyr+P4sYU51cEh
         tphlgi3nqyjKnhpzjtPqCSfOo0JBc7T2tty/sBeRamYiyD3YcV/B6EhagsZoBvgWzSak
         6R5EQDn9+MMNLBv6NaxuSEBFU6j3AnKhU0GvJ29F6/W5qN1qZMnuc4+pnM4FFehNHODi
         F7RBePLOkt535XycbEM85DYRvEN0JATSihPbLN+8VZWlMiQJKFJ5Mc/AKY6oL17bQR0I
         /t3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681240445; x=1683832445;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sv13vpRoBTogOEMfKSmMelgvzHGBXczKQaSW/1fKnTE=;
        b=MC8ZZpOiaWDRVJ5qZdHXJ3OyMzRJPohUJ8qyU0SVtFIGaDkQMbAKBNbu4eWHtDgFJC
         dewzr1EcpYvPbqR5xxuZGMrMBTWn8OFAMRY510NJP1eA4XCDKl6Ll+c6mtANWx3m+D1U
         FgRfPz9yleIceSbtJ5LHGV9tY9Ejmn0jzJ20snA48J8/i5IoWSTlJgO6WpYKZ0mtRfXs
         zpIe/V0Lv1Z1PVWPxGzXYe8HMK/SPhUt77kY4HFdRJ7nGhL/qc+q5yopXXJ+YoogWxkh
         aML/nEy6TMd2fTaLXbZPc6zc1KuzFHCU3qw+KN+xdbAHFwjfoAFycUYUgTii3+nurgkL
         tsyw==
X-Gm-Message-State: AAQBX9eAtPu1MHN/F3x3+nkIYhav4pHoKtHIuyNajjMgDy0JEgZGtpuv
        M/G5Zr9eIslDWY8LIDENbJk=
X-Google-Smtp-Source: AKy350YN1IKA6OUNzYfxfxHgyragvxiYA1oI3vsXkINCQrEbG4dhaWUpUcu+ehbL8smYhGIiYaP3WQ==
X-Received: by 2002:aa7:962c:0:b0:635:e961:3350 with SMTP id r12-20020aa7962c000000b00635e9613350mr3947879pfg.19.1681240444822;
        Tue, 11 Apr 2023 12:14:04 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id t13-20020a62ea0d000000b006363690dddasm5005343pfh.5.2023.04.11.12.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 12:14:04 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robin Jarry" <robin@jarry.cc>
Cc:     "Phillip Wood" <phillip.wood123@gmail.com>, <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Tim Culverhouse" <tim@timculverhouse.com>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Michael Strawbridge" <michael.strawbridge@amd.com>
Subject: Re: [PATCH] send-email: export patch counters in validate environment
References: <20230411114723.89029-1-robin@jarry.cc>
        <79a7c59f-6644-1dad-3b85-fe0ca8beb968@gmail.com>
        <xmqqbkjubcyc.fsf@gitster.g> <CRU3FHOZIRVM.3N8I4FAZ2RGO5@ringo>
Date:   Tue, 11 Apr 2023 12:14:03 -0700
In-Reply-To: <CRU3FHOZIRVM.3N8I4FAZ2RGO5@ringo> (Robin Jarry's message of
        "Tue, 11 Apr 2023 19:13:19 +0200")
Message-ID: <xmqqile29qpw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robin Jarry" <robin@jarry.cc> writes:

> It is probably best to let git-send-email out of the picture. Since
> nothing prevents from sending multiple patch series at once, it may not
> be possible to determine the proper ordering of all these files. A dumb
> 1-based counter will be perfectly suitable.

As long as the design decision is clearly documented, I am more than
fine to make it the user's problem ;-) It is a better design between
the two, as the user knows better what their payload is.

> I can run the loop twice to determine the count of non-FIFOs and adjust
> GIT_SENDEMAIL_FILE_TOTAL accordingly.

It sounds like a reasonable way out.

Thanks.


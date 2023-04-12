Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088ECC77B6E
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 20:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjDLUhr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 16:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjDLUhq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 16:37:46 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887E130EE
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 13:37:45 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-517c5738c8bso926214a12.3
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 13:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681331865; x=1683923865;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wunXcHamPZYpwHxRUU62Kas6tesztmxTu+qF7dfi6cA=;
        b=OJ9yEq+KHD1wnGX56i1pI0rJjKiaIPuo/Ts7/wWlShHkYkWS87mxFK5nVrn5e3m6Hc
         Rt3f/efrsWXBkEeVvNFnDmRsPLZCmcT18f/dWLoNnifgEc5kTmPvHrKi9ODhiz6RY1m4
         9J7JMDDXD5jDUDmJ0hrjjXT5zRh5x6cybEpQDJnhA9gXZwwCXtCF+8CQlsddPk9jRsFK
         NFd8LRiWAfx2wDLp0+ods8yo4qzP5/YqUx9UpyPzL35FtVMXPrAD7+juUHHtcRG/c9Yy
         ctCkHDnMAwqXQ18DxxFrGq3gU2+Tds566Bt1/9oBTPZ1ZtrETw8MUsRjTXAjiyVu/GlL
         eTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681331865; x=1683923865;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wunXcHamPZYpwHxRUU62Kas6tesztmxTu+qF7dfi6cA=;
        b=MD5HgDR2inaEbI0JbWKcyzxe31QxtPBk2x+dkpyEyaI+SuZihB5c1YG3hWZl1668Kc
         glG5ehpZBWowzFT88PXl4+uIi6mMbJoC8mVcCvP4tBZfCYWraPMTC5wfNtEZrMf6vkFP
         IOrcfFsX1mCuIFUN6egTwTjHvJrZMR2MBdU9Ik3hVUsqqTDpK7e6sERZ4MMD4Ei/eFZm
         3G2MKWqNKIS6vPur3oDXdA89H6TLq/4TpajrrMI08tAFTDsNt6Ok7pC0Z5bvaq1nBEl/
         hUIAXTWIm4710EG2cc4XdFiqzbAoONiu80xQkOSabzNzoShEJX4DC4fZz2Afefla/zUK
         j2ig==
X-Gm-Message-State: AAQBX9dPK5JSvvPdpxMsPian8xg++aHwQO6MAewjR7dBytSC7wyU2Xgs
        SByFPKVcHjusIV1E0gExHhc=
X-Google-Smtp-Source: AKy350ZX9u6fyck3Gj0ICgwmV/+zM5egv2YQxw2K+2hMEdNO2ZI3bmBPXAo7Tyh0yiPyjLQOC6MPhg==
X-Received: by 2002:a05:6a00:180e:b0:637:aea0:b23d with SMTP id y14-20020a056a00180e00b00637aea0b23dmr240637pfa.10.1681331864955;
        Wed, 12 Apr 2023 13:37:44 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id c22-20020aa78816000000b0063a0f06f1ffsm5136755pfo.122.2023.04.12.13.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 13:37:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robin Jarry" <robin@jarry.cc>
Cc:     <git@vger.kernel.org>, "Phillip Wood" <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Tim Culverhouse" <tim@timculverhouse.com>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Michael Strawbridge" <michael.strawbridge@amd.com>
Subject: Re: [PATCH v2] send-email: export patch counters in validate
 environment
References: <20230411114723.89029-1-robin@jarry.cc>
        <20230412095434.140754-1-robin@jarry.cc> <xmqqfs957zs4.fsf@gitster.g>
        <CRUZR9IO75B2.3DTTR2N12SQRL@ringo>
Date:   Wed, 12 Apr 2023 13:37:44 -0700
In-Reply-To: <CRUZR9IO75B2.3DTTR2N12SQRL@ringo> (Robin Jarry's message of
        "Wed, 12 Apr 2023 20:33:18 +0200")
Message-ID: <xmqq7cug96qv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robin Jarry" <robin@jarry.cc> writes:

> Also, if I understand how worktrees function, applying patches in
> a detached HEAD will create blobs in the current git dir. These will
> eventually be garbage collected but I wonder if that could be a problem.

You are the user who just ran format-patch to prepare sending out
the patches, and you are checking your patches.  Wouldn't you have
the blobs already anyways?

> As explained above, `set -e` will force early exit if any command fails
> without being explicitly handled. I will remove die/exit calls.

I'd rather not to see anybody go in that direction.  "set -e" is a
poor substitute for a properly designed error handling.  Between

	set -e
	command A
	command B
	command C

and

	command A &&
	command B &&
	command C || die message

the former can only say "command B" failed because command B was run
under some condition that it did not like, but that is too low level
an error that is close to the implementation.  As opposed to the
latter that can talk about what it _means_ that any one of these
three commands did not succeed in the end-user's terms.

Thanks.

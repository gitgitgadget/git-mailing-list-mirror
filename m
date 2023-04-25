Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551DAC77B7C
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 22:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbjDYWYv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 18:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjDYWYu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 18:24:50 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D6C5FF1
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 15:24:49 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-246f856d751so4487570a91.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 15:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682461488; x=1685053488;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FoJpJorNI2tclbhblsXrTqH8M1wVFHcpCmRqlmdYUpE=;
        b=JsiPHqlOvCnri4XNcgOZ/72GexKfD4LHYNOjiojZYdJMx9Zf4VfJNLb14/gPguUFDB
         ARMQby1ulBXqZunaOPHmksiStEZl1yhuUJNkH1g8HoA2+ttKpaS/M4/o2VWlR5FASmbs
         dGzWr2BvDDJ3yTIJjEvKkncpiqXJSGEZ77kaeLVcmFx2a+J6wrgZt5+of+1eCCGVpmFA
         /Snyu4CX+G2jk8Vo3SK5UoubFrkkxxPwNmkeTucco2UBuW/pCsPorB+XXn/Ouv8EjJBV
         tmAKM4t+7UgZD8lcFPolCoN5j/W+Z5fNPHdcskFucQVGH30LZvwF0vbskqWOR9bV7mbx
         4mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682461488; x=1685053488;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FoJpJorNI2tclbhblsXrTqH8M1wVFHcpCmRqlmdYUpE=;
        b=l9Vz+ba+gwFa4MMw1qJNtxb7SVzeX6gfClvvMKhbA2eWtq3hLV/coXP1Nv9aZav7TK
         mEHxSNMxA3RqhVKir+EFDB87bFwvSHU1VhtcSoUxwl9GSK94j+zx0AREe8CxVC6prhjk
         hfmE83BeFb/e0YYoR2MMI09VX6uqWqxTxHaSX5i/O8HnwrVx1fO/LhPEHf8p3JXMCMwe
         Mx2CbVFqtMSIC/55nl49K8BzxP3/UUR0jt1g3YefTz/60wHnAVknNcxIjRW+8iNCTPQ0
         MjpyeVqq9O9UFnPD+8nZfkPLYG+2Y3bzRvWAHtMMx5mLwuTI7Pps+Is1NpDfPcLKaORJ
         uGDw==
X-Gm-Message-State: AAQBX9c74eEHj1KyNVRCeWuZNdkitX9My03UKMSWWZ2XH63b+fL/VMe/
        Cw80tfkBbGOK6GNTVwwfOcxZrv5mx0U=
X-Google-Smtp-Source: AKy350ZVpdEYsw7yOODlmuFrLm63cMuWl/54M9OAGnadjTTOZKh6scQKFmQagiEiV7+b5Wnq5DR12w==
X-Received: by 2002:a17:90b:4a10:b0:246:bb61:4a56 with SMTP id kk16-20020a17090b4a1000b00246bb614a56mr18798059pjb.27.1682461488557;
        Tue, 25 Apr 2023 15:24:48 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id f21-20020a17090ace1500b002469a865810sm10321758pju.28.2023.04.25.15.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 15:24:48 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>, Adam Majer <adamm@zombino.com>,
        git@vger.kernel.org
Subject: Re: git clone of empty repositories doesn't preserve hash
References: <e7a8957e-6251-39f1-5109-87d4dd382e81@zombino.com>
        <xmqqr0syw3pe.fsf@gitster.g>
        <d04c430e-b609-b0a1-fd0f-0f3734d5c3b1@zombino.com>
        <20230405200153.GA525125@coredump.intra.peff.net>
        <xmqqa5zmukp5.fsf@gitster.g> <xmqq355euj2i.fsf@gitster.g>
        <ZEhHsJh20gtiDBd9@tapette.crustytoothpaste.net>
Date:   Tue, 25 Apr 2023 15:24:47 -0700
In-Reply-To: <ZEhHsJh20gtiDBd9@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 25 Apr 2023 21:35:44 +0000")
Message-ID: <xmqqcz3rzjkg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> So it looks like this has made it into master and works for v2 but
> breaks things for v0 and v1.  I noticed because the Git LFS testsuite is
> broken and the following test demonstrates it:
>
> ----- %< -----
> diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
> index 6c8d4c6cf1..3be5057579 100755
> --- a/t/t5700-protocol-v1.sh
> +++ b/t/t5700-protocol-v1.sh
> @@ -244,6 +244,17 @@ test_expect_success 'push with ssh:// using protocol v1' '
>  	grep "push< version 1" log
>  '
>  
> +test_expect_success 'clone propagates object-format from empty repo' '
> +	test_when_finished "rm -fr src256 dst256" &&
> +
> +	echo sha256 >expect &&
> +	git init --object-format=sha256 src256 &&
> +	git clone src256 dst256 &&
> +	git -C dst256 rev-parse --show-object-format >actual &&
> +
> +	test_cmp expect actual
> +'
> +
>  # Test protocol v1 with 'http://' transport
>  #
>  . "$TEST_DIRECTORY"/lib-httpd.sh
> ----- %< -----

Interesting.  I applied

 - the above addition to the t/t5700

 - reverse of 96f4113a (Merge branch 'jc/clone-object-format-from-void',
   2023-04-11), but only the part outside t/

on top of today's 'master', and tried to run t5700 and t5702 (the
latter has new tests added by 96f4113a to protect the change in the
topic from future breakage for v2).  It seems both t5700 and t5702
fails.

The latter failing is very much expected; the code change reverted
by the above experiment is what made it work in the first place.

But the former not working, after reverting the change, is totally
unexpected---doesn't it mean that the change in question does not
have much to do in the breakage?

In fact, the new test to 5700 applied on top of v2.40.1 fails, too.

Or are you complaining that the fix merged to 'master' only covers
the current protocol and not historical v0/v1 protocol?  I couldn't
tell, and didn't get that impression from the phrasing "breaks",
implying whatever that was "broken" used to be working.

Puzzled.

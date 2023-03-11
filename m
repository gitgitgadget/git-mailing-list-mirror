Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4DCC6FD1C
	for <git@archiver.kernel.org>; Sat, 11 Mar 2023 20:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjCKUij (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Mar 2023 15:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCKUii (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2023 15:38:38 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D46822A17
        for <git@vger.kernel.org>; Sat, 11 Mar 2023 12:38:37 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id h31so4932667pgl.6
        for <git@vger.kernel.org>; Sat, 11 Mar 2023 12:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678567116;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6tpVyfzaNix2x04cEGz3rxLNInrSfusM9gfqSjmpHw=;
        b=UmzzpGeQqfLPuFX4oW0SgSM71OJ21HFqtq3XXMnbENxkDXbaAycMuETgWhcf0bBdNb
         ML6SunJo8yGeB6tGeThtTCUTCdPM79i3v6O81Tfa109KFQmgNXKkS9NoS/GPjf3cWWTr
         gQJxrTtg53x7zvNu6wkNX27sLu8/JXrI84qnY74YBgT3vBp/oslokeD8WjpNcYVHRNZ+
         wipELmziF830ktiFn/EJz7Hf0/cMdVOnzm58L+2PP8k+DxST8aq5B2rFsi9y5gQmHLDF
         Du3SzwAClr8mvTmkJSGF0N++ABIeP58izZaGCdteU9yjRrGVSKb1u5cWDJItGvkjUzoJ
         27Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678567116;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v6tpVyfzaNix2x04cEGz3rxLNInrSfusM9gfqSjmpHw=;
        b=Gvc19ObKUPDg/BxBH1TPhaXOU56LMQeHjp4fLIkzFofhxBwfO6P8nTwK4Sd4lhJEHL
         S3lLAZIK38nRqprDGXKEG476W8XRTpnpd86V2OXIAn89YwAkHiH2M7BN8YGPd5Kz8Gga
         rCqPjubXG201LNJL5rI7Oi625sX8fJ+FMbcLQdbvCnfzDOHkXCZBg+iU6ko4/w+WKo/7
         DnHt66YOhkqAkFgMPIPZ8Mo981tCtToHd/uZVUVsbRVgZkwHi1j3F5ehqonWk6+F9P4x
         4c+b8Ffmvxj+5FCt3I1iY8ieqfCaP20IGm8ZMYQ0qegQtgOdWg38gqBSUq0rrasGy1E1
         7xiA==
X-Gm-Message-State: AO0yUKXIelj8AfjHqhxFUP4/4Uy1tU1W+Z1hY78u2A1MkWrIMszZY8Bt
        9iDiNfFoj95Xdxhg5HxnSkg=
X-Google-Smtp-Source: AK7set+39iqErVfQ1CnneyZYgrOv8en0xvmJ8uIEfCbKsIcpgedOE4Vmpvvpkjsvv2DAiVag1sIT5Q==
X-Received: by 2002:a62:7988:0:b0:623:6150:2e07 with SMTP id u130-20020a627988000000b0062361502e07mr521610pfc.15.1678567116456;
        Sat, 11 Mar 2023 12:38:36 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id n13-20020aa7904d000000b005a8512c9988sm1860790pfo.93.2023.03.11.12.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 12:38:36 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: rj/bisect-already-used-branch (was Re: What's cooking in
 git.git (Mar 2023, #02; Tue, 7))
References: <xmqq4jqww660.fsf@gitster.g>
        <ce31ee34-df93-5824-d7a8-5a0e19498d77@gmail.com>
Date:   Sat, 11 Mar 2023 12:38:35 -0800
In-Reply-To: <ce31ee34-df93-5824-d7a8-5a0e19498d77@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Sat, 11 Mar 2023 11:24:29 +0100")
Message-ID: <xmqqpm9fxbuc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> Maybe we can still adjust this to a more accurate description of the
> current state in this series, something like:
>
>   Allow "git bisect reset" to check out the original branch when the
>   branch is already checked out in a different worktree linked to the
>   same repository.

Thanks, will replace.

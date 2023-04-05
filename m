Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F2CC7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 19:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbjDETEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 15:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbjDETEo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 15:04:44 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CC572A2
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 12:04:31 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id kc4so35304646plb.10
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 12:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680721470;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4n4M1+aDTd8YzzRnMqhtHrhY3TMWEHwK0tLeU2UPps0=;
        b=RBXpdNUMaaKcfq3fTQK5oul3GJQl8Wcln14TxfajuyDQ/3ojPPmZhgoN/0/MGKPWkL
         FfIwieMQLO0TiA6P/BTOJA6X74grGEd2wDY9+lQBsCTe4s/RdW9iUStNAuczSf1PzNTh
         5PV/bD3AKXsMCHLHPXJ4NBaiASxDktEgYbbs30A7eoOyYk/OBjf4DlVMRnhQ+NBbJfWb
         AvLqYMTMOEnSmjAp+SvgSRffmijqcscXOpmAEVn1vIL+ZNGk6Wcyoxxc2uTnoVXR7lxZ
         RCnoLAnM4TZdwc2HNUG2v7IxRogK6uITjHpcyRH+OF4uluJZfU7kLfF47Cs0cEaM2tLr
         2zXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680721470;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4n4M1+aDTd8YzzRnMqhtHrhY3TMWEHwK0tLeU2UPps0=;
        b=6AIRFfBcye/G/eeQl4r5CRqCFVWmDY5jdcBDP1CX24vHc0/eaMjIaFFqSFv8d7rzYf
         QvFPayibOkB0gs655pqFAz8d2zYDWKswGQTKV7PUVz9mhXwmS4rtMgHu70GQRSZLr3SJ
         52NzOxvNXek9thQDRnFVjbQMJq9pSLjcRkl5OKK9/oOnRk+PoNOzyMtDkUZLUV8pvjKh
         Q/QFrZaj8q+ZD5EVpDhNHMPZbnABAyN4IdhwPFcdBqGoithnERv0OMlPdhYiWIcWi5fa
         qRIfMd4m6qkfuIywu2xnEuI3UQgyQ4ahP88X3WiL6KQxyFkknkFRveFAUEO09X91WtVH
         TJSQ==
X-Gm-Message-State: AAQBX9ehk5gojhl1BLEx1/J9ziuhXRC01hkOJZOusNgW9oyPA1Fn/++2
        jORxgBGQUNSC3oerHLelR/w=
X-Google-Smtp-Source: AKy350btcE9fcohsQk+C8fSOmbzzN2zJmncDg1SWKbR/MnXXU8Cq4fFKmba742vxfrjcGJhaXatftQ==
X-Received: by 2002:a05:6a20:1a83:b0:cc:a8d7:ad7e with SMTP id ci3-20020a056a201a8300b000cca8d7ad7emr121764pzb.60.1680721470419;
        Wed, 05 Apr 2023 12:04:30 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id l28-20020a63ba5c000000b004fbd91d9716sm9340997pgu.15.2023.04.05.12.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 12:04:29 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Majer <adamm@zombino.com>
Cc:     git@vger.kernel.org
Subject: Re: git clone of empty repositories doesn't preserve hash
References: <e7a8957e-6251-39f1-5109-87d4dd382e81@zombino.com>
Date:   Wed, 05 Apr 2023 12:04:29 -0700
In-Reply-To: <e7a8957e-6251-39f1-5109-87d4dd382e81@zombino.com> (Adam Majer's
        message of "Wed, 5 Apr 2023 12:28:12 +0200")
Message-ID: <xmqqr0syw3pe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Majer <adamm@zombino.com> writes:

> I've noticed while adding support for sha256 repositories for Gitea that,
>
> git init --bare --object-format=sha256 a
> git clone a b
>
> Then the repository b is initialized as default hash, so sha1. It
> seems that receive-pack will list the null OID in the header if there
> are no refs available, but the upload-pack doesn't list anything and
> hence the header with capabilities and the hash function is missing
>
> git receive-pack a
> git upload-pack a
>
> What is the right approach here? Could upload-pack send a NULL OID
> followed by header info that is then used by clone?

Interesting.

Does such a clone copy the name of the primary branch from the
remote repository to the newly created repository?  I recall we had
seen such a feature request but offhand I do not recall how we
solved it.  The need to transmit a capability even when there is no
concrete reference to be fetched to satisfy such a feature request
should be the same as yours, so there may already be a good place to
add that information.  Or we may have ended up not solving the "what
is the name of the primary branch in this empty repository?", in
which case, the solution for this "what is the hash function to be
used in this empty repository?" should be designed to be extensive
enough to allow us later support that feature easily.

Thanks for raising the issue.



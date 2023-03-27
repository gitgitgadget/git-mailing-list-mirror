Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54C5C6FD1D
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 16:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjC0Qay (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 12:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjC0Qax (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 12:30:53 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9FC1BF8
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 09:30:52 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso9473611pjb.2
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 09:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679934651;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=niDQe7LHQCLj2Rd1eWWLziCuNqEr2tFgtHhSH+1loxg=;
        b=oVPZrKiizw3I1nP5bSB/kDPG9uMtnDEHgT5yswBm191dwjSbJbTuMWhpkpxiFKzqIf
         +/5bQTqzJXm3b/HygGmsnMxTjqsBbgHAHvzPnBKY2gwAg7RQSUKB1TsRvXlNKpHmHHvX
         LhBRJloOcaqf4vEBYjIFzpygOGihNm6G0zZqVD6eqLj9QD69G6dWLjyYiotQvUlL3/EL
         cQb6yUOy3wrC1+vm/e8y1CnhGYLhaXkWhD9lWCWan97+X4Qt5XKUndOp70u3N3voUO2x
         Lo5ggzsovq5hXoxhdOxPbbprbjK6n5SXXn3TxfdnLZ6Pu6CVfAfLe/Gd2C9MYy0TIsU5
         9J8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679934651;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=niDQe7LHQCLj2Rd1eWWLziCuNqEr2tFgtHhSH+1loxg=;
        b=ZIoJih2UNGva8nLRndyUlJ8Ml/8kgYRBJ3FSHsI43ccQJ1P41EFM185W3owfJry7Ng
         hw2YvLDc/aLuwMjyEFNKaf/HuV810HQRKDdepClEV8u0IGVzRwJ0CNcyPGUEMuyhgyTD
         8lgtO8R0bs8XfaT/4dEr4wl8SMgFQtQ4vyNPnIQU7+Ons3gP9QGnOgwhbrcip1d9mhr+
         0IMVg5Kla/eG5CTvZhypFizRDTyhYE/58QRBxmLHwIf++S7zoTUdwhY1+AnQ+SxPXs/i
         Q6uIpuWPjyvIm2GG0J3cjijtSwy315LmcSGD1+QdBr/Jl6iERVjVnMqImu8zRLaNo/qn
         0bVw==
X-Gm-Message-State: AAQBX9cHeqncy14tSmxro6rfZrxUPXmTiTlYf9MMTslzTsLQpWbWpyNU
        6vBCpVQl0sMJfSxPvDkjk+s=
X-Google-Smtp-Source: AK7set8fLwuGyIS190PqcNDZcuft9l0s28A0FNm1X/Fh4nV00fFoZeD0Jgf7w+Dn1G0ha1pYWc2Sew==
X-Received: by 2002:a17:90a:17a9:b0:23f:452c:7a4f with SMTP id q38-20020a17090a17a900b0023f452c7a4fmr12761093pja.46.1679934651555;
        Mon, 27 Mar 2023 09:30:51 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id s17-20020a17090a5d1100b0023d3845b02bsm7678696pji.45.2023.03.27.09.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 09:30:51 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Mario Grgic <mario_grgic@hotmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git bug: Perl compatible regular expressions do not work as
 expected
References: <MW4PR20MB5517583CBEEF34B1E87CCF1290859@MW4PR20MB5517.namprd20.prod.outlook.com>
        <MW4PR20MB551779102E85B305E9F675E990859@MW4PR20MB5517.namprd20.prod.outlook.com>
Date:   Mon, 27 Mar 2023 09:30:51 -0700
In-Reply-To: <MW4PR20MB551779102E85B305E9F675E990859@MW4PR20MB5517.namprd20.prod.outlook.com>
        (Mario Grgic's message of "Sat, 25 Mar 2023 11:39:20 -0400")
Message-ID: <xmqqcz4ucg1w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mario Grgic <mario_grgic@hotmail.com> writes:

> Confirming that putting back NO_REGEX = YesPlease in the Makefile fixes the problem. I.e. the following patch fixes it for me:
>
> --- Makefile	2023-03-25 11:24:01.000000000 -0400
> +++ Makefile.patched	2023-03-25 11:25:11.000000000 -0400
> @@ -1554,6 +1554,7 @@
>  		APPLE_COMMON_CRYPTO = YesPlease
>  		COMPAT_CFLAGS += -DAPPLE_COMMON_CRYPTO
>  	endif
> +	NO_REGEX = YesPlease
>  	PTHREAD_LIBS =
>  endif

It will unfortunately break multibyte support on macOS by reverting
what 1819ad32 (grep: fix multibyte regex handling under macOS,
2022-08-26) did.

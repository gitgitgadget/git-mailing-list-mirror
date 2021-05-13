Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD2DC433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 06:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ED1161433
	for <git@archiver.kernel.org>; Thu, 13 May 2021 06:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbhEMGq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 02:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhEMGq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 02:46:26 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C23BC061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 23:45:16 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id t4-20020a05683014c4b02902ed26dd7a60so12696284otq.7
        for <git@vger.kernel.org>; Wed, 12 May 2021 23:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=UwbJXwbh7hL5CWUFq07z+Mc8Njbry4UJcKQ9LFC5Yz8=;
        b=M/gT4n7tx19x34sSlGxYFR0r1+fVN6GEidqlnEkvj5iBs+dFSTT7G/anQgyZ0KzZmx
         wYxdl2pOTySihx+war9BWa3VajSCBSlcraMIkrG/kY5KUQjeYDKY/W6xgxfIHVx0u6bY
         bQ18v0+WZ/BjA4/53unUDnJDZjIos0bsjfL3T76fQkQi+zEWfJxK36eG6z7q44IXVkGm
         BvgEv22w7dJrl5LUGO6QdyR8vz8I/JDA4nrxPMNyTj15UywJIa+jaNmOqvH6BEZAsk+w
         vYuPCpEdM7mgAJDG3LVcQvnLIwZWCM3D3y7y9QqBFf0//6hYFswRUBgsL6O00bu63PoF
         e7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=UwbJXwbh7hL5CWUFq07z+Mc8Njbry4UJcKQ9LFC5Yz8=;
        b=D09iqBahUxLCJr1w0MfnnKj3gr7EEhjJfF7UXU6OaYswHQOyfFuvPN+07IW2/k6SFs
         GSqEOqb9V5ymDi2xdnj0Rbr4oFiTL+A3ngmPrZJLSJbxDt0rB6R8Elr9HBhB2+OqTPC5
         CueT5G1tIb0o7JVDOcCZ3946qg31cGwkVTgz+G+XyU9o+78fXOT5KAzqK/DwGFvUXbTK
         KiuYYhFVwckGxbwKjpXO7ebXUSbGW6cL+BAFFQyZR69wQJBy2hh14uslCOvxqJ9iaKTR
         /NekbMNd0XIduFKxf/hvq6flCFWtOOgc2XStAU7MfFH1mB+L6BVhyw0QRp1P6z9haVWT
         c0UA==
X-Gm-Message-State: AOAM532qj08IINQGd+Dw080/V/flhjjafaTae2afyKDBAhe1Us+dCPA7
        AjAXZ1944zw8hVmnPl32ofA=
X-Google-Smtp-Source: ABdhPJx+eM/mcp1IB91JZ19amIY1moFz+1XrM/RPYm2PV68+60iHGzsvbtUAgipRbGg0Z3WToG/Kxg==
X-Received: by 2002:a9d:6a18:: with SMTP id g24mr32844143otn.368.1620888315574;
        Wed, 12 May 2021 23:45:15 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id g6sm512120ooe.1.2021.05.12.23.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 23:45:14 -0700 (PDT)
Date:   Thu, 13 May 2021 01:45:10 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <609ccaf67710b_3293208be@natae.notmuch>
In-Reply-To: <patch-11.11-217c5aed491-20210510T141055Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
 <cover-00.11-00000000000-20210510T141055Z-avarab@gmail.com>
 <patch-11.11-217c5aed491-20210510T141055Z-avarab@gmail.com>
Subject: RE: [PATCH v6 11/11] test-lib: split up and deprecate
 test_create_repo()
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1243,21 +1243,10 @@ test_atexit () {
>  		} && (exit \"\$eval_ret\"); eval_ret=3D\$?; $test_atexit_cleanup"
>  }
>  =

> -# Most tests can use the created repository, but some may need to crea=
te more.
> +# Deprecated wrapper for "git init", use "git init" directly instead
>  # Usage: test_create_repo <directory>
>  test_create_repo () {

If this is deprecated why not add a warning?

  echo "warning: test_create_repo is deprecated in favor of git init" >&2=


-- =

Felipe Contreras=

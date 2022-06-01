Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C377C43334
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 21:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiFAVk0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 17:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiFAVkY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 17:40:24 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C058D5D183
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 14:40:23 -0700 (PDT)
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 835A63F5EE
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 21:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1654119621;
        bh=dGb1MAgWhycV59e3Ov0gYSbnOS6Q24rTaywdrSt6fc4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=phQRTfqn5ktYS4EyUpHjuz4nsOnOxbinillK8U0keqvBKGO4yGJ6GkXjNy+t1vRRY
         B2O0eWiMYGz+RaZhQ7vXUgNEPyMkeDg8JSwZlsalfkoRjiewDKJMsIXpu3A/fqLh1q
         CtQXI/ejnPMttJEjx5yb7tlXMLkZpy/WVcc5373O2N9XSJd8gwd1EgdBm6vwT6WSSx
         kw4yMMXKtzojAKTxbYB6y02GWAtHH6wKJXFuoAf7VJ6DHjZqkDwkxDf1JZCM5wbBed
         2zmc0QZl19VjKxqL/rgDwNTunjkxTqUG/MOdKbbbv0eFdhWiZCUgPIbU2Ap3c9XChs
         0LS/TJMtwH+ug==
Received: by mail-oo1-f71.google.com with SMTP id z81-20020a4a4954000000b0040eafb31c81so1570199ooa.18
        for <git@vger.kernel.org>; Wed, 01 Jun 2022 14:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dGb1MAgWhycV59e3Ov0gYSbnOS6Q24rTaywdrSt6fc4=;
        b=6W6f1bbnHOkRXBwlYcGltUr4o+ndm7aXxj0VGoE0bbv/WD/rjBgHGRA7Mj3R3k1kww
         HHSBuDn4ZyYoUT9yU9BiPpjyBgknnyPMKCLluhPg2/iZNgfH9RbWR9480IzmOpKM+6mK
         6lk1I/ntJWiMuGeUnvvr683C7XalFUitwh3pbud77rqvaYdbCEpFYigExx0kAQ4bnlD/
         94P7LWPJM/fxWNVpvWZAvbfSjwSxe5YtltN9fGJP99B9uhfbrYz49WiX7NRvgiGLnrv1
         VZGA6kxiosQ/hu+NyQMz3oYuOVTK1GwA0MU7FZKoUYex8O9QFy9U2xX8UG0FSSMQtCsX
         fZ7Q==
X-Gm-Message-State: AOAM533KnCIR8jhY0MfYxShaab47wKgFgtT3SXXOLb6NlymAPqEUnRag
        4QWDcWIWw7wD0no7PUSmfU6W4QdTnPbHg0y1YGOMUKda8ReHdoS2reqndJ3jaVVrPF81nKDw+UQ
        CasSsVEDsC+LZ+hewIZhRJD0vPhRCphQCjEIZtfN8dY3KSg==
X-Received: by 2002:a05:6870:1686:b0:f4:2cf8:77b3 with SMTP id j6-20020a056870168600b000f42cf877b3mr990888oae.210.1654119620135;
        Wed, 01 Jun 2022 14:40:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPLG4ri5pJTiREQRl0HqwU7ICuDpS4BtDpIUpG1IT3DSkWbq0MqNUljVR3qaF5NqkL/yZKrc9GdvR6hvLSMW8=
X-Received: by 2002:a05:6870:1686:b0:f4:2cf8:77b3 with SMTP id
 j6-20020a056870168600b000f42cf877b3mr990883oae.210.1654119620016; Wed, 01 Jun
 2022 14:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ=HsVKX-NXePKU1G0UKRcFT5He8AjS_TQEirb3hN3chGFz9TA@mail.gmail.com>
 <xmqq4k14qe9g.fsf@gitster.g>
In-Reply-To: <xmqq4k14qe9g.fsf@gitster.g>
From:   Mark Esler <mark.esler@canonical.com>
Date:   Wed, 1 Jun 2022 16:40:09 -0500
Message-ID: <CAJ=HsV+DEP6WqyBpQq8ACsMM-KixN9-JRAMXNjML8AcjWosChA@mail.gmail.com>
Subject: Re: CVE-2022-24975
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Junio!

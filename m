Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E220AC433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 16:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241007AbhLMQpn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 11:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbhLMQpm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 11:45:42 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8568EC061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:45:42 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id o1so30246380uap.4
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gzj6YiWXGOMArS/h/B+fjRQLa9RYHx662pWKHTqJm48=;
        b=ONGCEo0eYLx5+D5G8Lg5z6yr1ygrF33/brBIEEXNiYgnnPNYFB6pBYAbrN8AeIfRJo
         ksE7uw7t3LenXWnjcrnKM8+/uyP69GasO/DPPCaCCyWzuwB5gerPtGqQPc6g+ysdpNRA
         vBxAbqp2reFBmYoVTtqkgXjX5EEOsLVKB2AAx9Hg+r1sGHKVg+UU5kOdl7rlSJFFjWiD
         w+yGpv4vAkqzfT2yH1GYmGsR3PQVNVMVDzGWEznY4CaXoc1HZelvijpkB6D/wxr0NGUL
         K5LWf1QFzlhvMtjox+HlfnXTUY7e4T48dxw7dw6Fh6M3hPq2MLjYnBcNJiUFsFVbfjAW
         dlfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gzj6YiWXGOMArS/h/B+fjRQLa9RYHx662pWKHTqJm48=;
        b=I+pgbqKZfWXXFRssjOx4V2EnbaoyaiHiaz7sfSvWWV2P9yfLKIBgxnU9LMoqomtZ32
         HmG/eSFWZWdnfj4KWHgmPYhAxgVLE56nKHexXThukqacecAWIZDjDiHxCfuEaQzN8IuB
         jTpfrt2IxPy2auI0DqZAMFszsFZSmQQgXLPCjGikXgyT4h9mE89BLk4WAt+TJkg6ACtI
         u0BD+qt0MqsCELXebRu45+02ASAmCaHuD8bdyy7yjSy2jnM+cMzQC38S5rjCuxOrHlTa
         u7r/GGf48ZUY3rVUxOoFCB+MCB8YpM7qUUfT4QGAZ9bJMSc6hYsDQyf9Lbq3RDQUcFKN
         lvMw==
X-Gm-Message-State: AOAM530ZGKxKqZZkX+nDrC+R25MeVGmvrNUkQijlYN7sh6jI7zBDEEf0
        L5P0GMrAhW2EdP1BEf2QBYxnVYOJSbRxiQI1sWbDFg==
X-Google-Smtp-Source: ABdhPJzJahk6CWFDYQevgABRgQQQLcnH90MydFWxtU3QSkqxUYEScLvuOUsa/CizoUwnZUKjjP9GpD+dSl89hEfQerc=
X-Received: by 2002:ab0:3c9f:: with SMTP id a31mr43808721uax.134.1639413941582;
 Mon, 13 Dec 2021 08:45:41 -0800 (PST)
MIME-Version: 1.0
References: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
 <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com> <9dce18d7349fe2a27859c224068fb5a386f263f1.1639411309.git.gitgitgadget@gmail.com>
 <211213.86h7bc8o9i.gmgdl@evledraar.gmail.com>
In-Reply-To: <211213.86h7bc8o9i.gmgdl@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 13 Dec 2021 17:45:30 +0100
Message-ID: <CAFQ2z_NFXEWe5rMgDuao+fdOio3tV_33ViwZaZnc5u2LgLxEBg@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] reftable: order unittests by complexity
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 13, 2021 at 5:26 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> A C99 comment, which I don't mind, but is explicitly forbidden by the
> style guide (and when I mentioned recently that we didn't have any
> portability reasons not to use these, there wasn't much/any interest in
> changing that...).

sorry, I missed this comment in a previous round. Fixed now.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado

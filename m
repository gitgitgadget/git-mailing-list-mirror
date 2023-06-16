Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB59BEB64DA
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 22:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjFPWF0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 18:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjFPWFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 18:05:25 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3642735A6
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 15:05:24 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-51f7638a56fso952270a12.3
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 15:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686953123; x=1689545123;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b5OACTTvWptck6fqN3HXf1TCEFKB5mWxrrxWOtUjmdE=;
        b=2b5Z187F7DbugfZ+sCg76+QIkzhgNuNZw3N3Oze7hw7dD+dxE53Fkl49B17rnT4sqo
         NZ6pFh8M8BNn6aG7q5Xhi0yqLRLen8GKINoV+GaiOkMExzxjssNn60WauevW2H6OGHsM
         cOELbhxe+fazg0x/psolPzvjVBmBcItrL1UdhxcM/Gdjp3pZmY8IuePEPlbv7NC428b9
         u+xTnn5udPOBLDp+ZVgTcYfqx/OBNanOK7a4zrZFbJx74trKUZuWjN9uVSm6TsewCcOy
         fuwesDz6i7K1EY/8lDjilMpooGUe6c8joDSarGLarFAwGJrm4XD5Auw1wZx2+LZ+1o9I
         /XQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686953123; x=1689545123;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b5OACTTvWptck6fqN3HXf1TCEFKB5mWxrrxWOtUjmdE=;
        b=CfkXluk1e3SM2ajM05KekMV2xcHCoknF4UJfEopdlhpnLd3bT7TWley0e1vkzLTD5G
         Lk7SG2lnX3fKferhP0OZwa4YxPDtFCCe+nrnQX7vIeJsGwd76+2VnUfQw0RhsFgoo4TA
         4shLKp2y0giWLtRgPNNbi+pkXM9SHfdGwP+iY4Szx1bS5Hta+3sDWlEtnhKbEMX2Xp8o
         du36oQcEv7kfJOTs9vjQxvUqtnQ1uPxaYZngDPmqFQ8xJSnjtkc1MMrBaSSkhWsZAvtv
         /VQlCjm3baRYSQ1vRkDEbLWXdccxb+xBmAPbEaRaz4ioQEXGT+eRbpj8vZEDsVWIXgBo
         tpOA==
X-Gm-Message-State: AC+VfDycPLT9k9v/r+eMfZH76l/pQZe/ETcHA1ObcZHlMIFmQCE1zN4K
        HpN2fWOD3JJfZ000GZ/5sGDkZgoCPPIL2c5IC2jrW+tqGK5+2Q40CxCBwUEldiKtjtbsFbf658u
        oy58oQxOeeTLwpEMXyNv8g0ld4JyNo9EgyF9Nj6UsM6vF9MTqanUcLcy+fRiqDZY=
X-Google-Smtp-Source: ACHHUZ4Ppjlkvi2SYnZdL9NXnzmId6+uh8RU0lN856cMd/Q3/r2WPW+65pb2IA2WjAvTZaa7h7VbaBHqF2hcFw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a63:1416:0:b0:540:6f8f:8463 with SMTP id
 u22-20020a631416000000b005406f8f8463mr47164pgl.5.1686953123554; Fri, 16 Jun
 2023 15:05:23 -0700 (PDT)
Date:   Fri, 16 Jun 2023 15:05:14 -0700
Mime-Version: 1.0
Message-ID: <kl6lilbnrrl1.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Is MacOS CI flaky?
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


1. https://github.com/chooglen/git/actions/runs/5294136258

is just

2. https://github.com/chooglen/git/actions/runs/5292953535

with a fix for "win build", but 2. also failed for completely unrelated
reasons on osx-*.

Casually clicking through https://github.com/git/git/actions/ suggests
that others might be experiencing similar failures too?

- https://github.com/git/git/actions/runs/5293250265
- https://github.com/git/git/actions/runs/5289074140

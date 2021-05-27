Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF968C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6E866128B
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbhE0A7k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhE0A7h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:59:37 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28615C061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:58:05 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso2818719otl.13
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ziKcaqDvhjOKk2rB1XS3v8rPyS6u00w3viqgkpSrO/g=;
        b=RhTabJNiogw7mesH0bgRjR7Bn3OOkBrOXd7AOZZWsPlrfX0+qIbO8kWL/dj6HUfLWa
         D+oayJF18lkvv7NXFzuJS1n+ulbtBvNefp/FfiR1N3mR2UnQG5tdKyuPct2KAuZHmkih
         d0HOV9At2PSI12OfOnwm+D2rtuXfGZ0HhslIkW2+XoKt2UdCSQXcaylScDsHAn7MbfHl
         4RHFls8f60EuBuKHmLh5+VFoC8tPL63Su3IwqE578Qd/R47wRLIsGVs32cSo1vwC3Hfo
         +9UO5VSQgv51+j5rQxANN5xShaOT8YsCiBTO2BMWo4JEpCgTCzWbNSn8IORCHOmyLzfR
         xvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ziKcaqDvhjOKk2rB1XS3v8rPyS6u00w3viqgkpSrO/g=;
        b=q5A4DAOs/+3z3UqQamc/9JLgZnFFWCSULjdXQP3Z1hCgluAltJ27ck4rYNWzYPgz+i
         rTfGTuMknADhwmZ3M9ysvZ30K19u7KGqQLrZnxw869FuewUQ42evGbChXUK2yPhu3pJK
         7AomUZbP0w5QkqB4ZpVddGdt6NTIauMLyR47hj8T1cKPOmyRqnw8l8YqQKeeoxzbuEFO
         mslhFZXTO9DO8/JR5H02o5tEZ91pUa0u1BE4g+YJPBLYW1Dr3WY297VYVRC8vwuQeTqt
         4AEr5U/Sx3PTGGMdcnQxi3fswfCal/6l5rUJBb2wI2hU0+P4/zclFOicjzgFJZrveg2+
         lAhg==
X-Gm-Message-State: AOAM532a3vXaAFhMdqYrTGQdwiziAUJ+1nKmSIoZtGRuNMKWAutk2uc3
        AFY33QnemEpd5sT5qwNaR3mrIHIB32gdaQ==
X-Google-Smtp-Source: ABdhPJzHiC823NLAKULXhwVTZ6HKleOoVbTBggpGkxeBxE95pZXOAluE5LkXrIYZ4r2eQV8rbC8Qfg==
X-Received: by 2002:a9d:4d97:: with SMTP id u23mr761611otk.48.1622077084588;
        Wed, 26 May 2021 17:58:04 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id r83sm186436oih.48.2021.05.26.17.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 17:58:03 -0700 (PDT)
Date:   Wed, 26 May 2021 19:58:02 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Message-ID: <60aeee9a14f13_770c208cd@natae.notmuch>
In-Reply-To: <CACBZZX6gOeTrLJwL-Zp5hEEbWCipioPgNKt7Tc41ixcQLQshiw@mail.gmail.com>
References: <537952234b691_10da88d308d8@nysa.notmuch>
 <CACBZZX6gOeTrLJwL-Zp5hEEbWCipioPgNKt7Tc41ixcQLQshiw@mail.gmail.com>
Subject: Re: [ANNOUNCE] git related v0.3
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> The general heuristic I use, which I've found to be much better than
> git-blame is:
> =

>  1. Find substrings of code I'm directly removing/altering, and
> functions I'm removing/altering
>  2. Do git log --reverse -p -S'<substr>' (maybe with -- file) for a
> list of substrings

v1.0 of git-related has a similar tool: git-who, which you can use to do
precisely that:

  git who -S'<substr>'

Cheers.

-- =

Felipe Contreras=

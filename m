Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C6BC77B71
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 03:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjDPDp2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 23:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjDPDp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 23:45:26 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9582D57
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:45:24 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1842cddca49so27066781fac.1
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681616721; x=1684208721;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MZY6IdTsNYeJL7bLfzoRmB3Fjg7w64nkJiCWLXaIhk=;
        b=dhWWjiV4ea5K/FP4Qw8bVrjGytciEjQ2nxxbDOjbEg803aoSkKKBhzdbknjw8ZJ1/F
         kWDqPSK9MXRoe9dfOPQj6hawDX1Km7sfpj7QPL+O8kN71V0UpaEyWrcTnAqIKcAZYHet
         cOm7K0pQERbkK/XNVuzfd3k0B3YQN8h17FbbC8UtkbEvwOwtGBqPyw8snZueB12LZjgU
         NV0tTQ4H/pkYhwsv8jrsqulaGU/64uoC+eO9AmPdqpaE0Jk3QnvHdmYJAcoFjnrQRk14
         lDydog0dfLXzT56laHNg5SjhSndgy1T40zK/wqQP+becAjWNcBKRB4Uq7Y80QeXSlKgj
         dolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681616721; x=1684208721;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5MZY6IdTsNYeJL7bLfzoRmB3Fjg7w64nkJiCWLXaIhk=;
        b=Hu8G0fOq4C9cYc62WXnIqzINuvhWv46TimQMV/0uP59vbMGwhgAQxIQOhqRz9VyBD3
         XeHzB5slErRjUH/2JVd9Ya2fEru2VXIumTiswv3J5QWk4Km8xGcCVujSnHkJW1H1ukD5
         0NQw8Ol2KKFZ33HSWbdNTjXV9VPMCNnD+KwbO1L2cEO/B8OvUJOvCeUuYu0gWpHJEymV
         7csMTjsuNiFUjnxqejlMGyQJ92aH418xUvnCRhylUe6pAl3czy0LDp3W+GCxKr0ENvLi
         DUuaOyTEYODlWeQQtcwtRt8Dh0SDYvKjaPV4gP0P3EG5A29v8l2kdlS/z1N2+c5Hq+wE
         10RA==
X-Gm-Message-State: AAQBX9fDPNymzwQxeqmLFryFns0RkbfxYyrsO8fAdRkVlCZQU2SWwfI4
        DjUUfQNQQp/cvhDnggXy7e/q6qv4nEU=
X-Google-Smtp-Source: AKy350YuObpJ9XADik7B5/9LybthVrCI2fHjx+GNkpPCjiMKA3MqDSulQ4t3MJgiT//zvIUkGjtq3w==
X-Received: by 2002:a05:6871:593:b0:177:ac71:a216 with SMTP id u19-20020a056871059300b00177ac71a216mr6789818oan.11.1681616721440;
        Sat, 15 Apr 2023 20:45:21 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id yy21-20020a056871259500b0017ae1aede32sm3287503oab.46.2023.04.15.20.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 20:45:20 -0700 (PDT)
Date:   Sat, 15 Apr 2023 21:45:20 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Message-ID: <643b6f503ad8d_3bb4294bc@chronos.notmuch>
In-Reply-To: <20230408001829.11031-1-felipe.contreras@gmail.com>
References: <20230408001829.11031-1-felipe.contreras@gmail.com>
Subject: Re: [PATCH] doc: simplify man version
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I noticed this patch landed in "next", but I found a typo:

Felipe Contreras wrote:
> There is no need for us to demand that that they add support for the
> version field when in reality all that is going to happen is that both
> fields are going to be joined.

s/that that/that/

Is there any procedure to fix this? Or is it a small enough issue to leave it
as it is?

-- 
Felipe Contreras

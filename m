Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9340C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 19:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjDAT6g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 15:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjDAT6d (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 15:58:33 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B00C265B5
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 12:58:32 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id z42so26439704ljq.13
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 12:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680379110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcnqrfVwBGs8J290Z8a7xlTnMbnHFfSxUtpnRmlHcDY=;
        b=mRY3023oDU1B+zXFmnp3ExqZLed3rAHzMFWcjYbTR2EzM+GIEzbSVaFMklFJwTisln
         2WtjNBioqD+XlvD7qs9aJBdk0nlTzKMpWtdyWfkYQQKs1ERk7VN99LEV+R5tWtz6rXKs
         PVIgZD4n45cVz1CadF99RmA/PAVfJxleGqBn488FtrKKnPk2C6rl83J+mQKUKfIkBHga
         bcEDVrTi8x6UOSnx6iRTJJ+emvwBWpU7IyYwp004xcGlKz94YPnNgZfmbSMbiZFkR1Ky
         oT0j780gefK8di4Qpzyx+VwuhTpW4I9aHRkBXXvNecOq6jBNw6OTOwSwn2znxX4ldVfy
         sonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680379110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcnqrfVwBGs8J290Z8a7xlTnMbnHFfSxUtpnRmlHcDY=;
        b=DsEBCI4zjchTKRgO97wpkYbcm6u3HpXgfO6Io9yCHVDHNHVoqY0ZNWRCakiR5rPEZ6
         hFFz7aGWA6EGV7RUQBuUQo1jO7lBiExZGzg6q+Y27gOtMZ6g+kUqq1sVPuEJLzDw4Cxq
         QWdF58w5qzeoePEZKjXIdNlS75bAdHaYCKDeoBqsCcEwYDk6zWE5iFhbMdo17TPA0Caz
         i7l5FitT9wdEYIIye26IlTzjWJI5Xpcn+U/zlNnRaNDbQWzcOIn9Lg095xGOGtbDEctk
         gg2AlgbwCTDpld+ZuVa527Hiy7HyYUH+nYfQ8XbNQRkoSXBrRj9GYw5ECvDPniK20F5h
         vNLQ==
X-Gm-Message-State: AAQBX9feC+URkvB7s70as2MagXqVeXGBCZb0vDNQI+/2eWCaDaYjlM3Q
        f87uhkNGr8/sDD9BYux69XCesLFcgUbckRH2vI2PVROl
X-Google-Smtp-Source: AKy350bxWx3cuTEHEIP+Hrfi+EzKPVuk/cP18YV6xBarrcrROVJNkWBIqJt5Tyr2CexlxtTFYDjPcXCx6/TV/hDIjcY=
X-Received: by 2002:a2e:8016:0:b0:2a6:16b5:2fba with SMTP id
 j22-20020a2e8016000000b002a616b52fbamr3223088ljg.1.1680379110094; Sat, 01 Apr
 2023 12:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqv8ij5g83.fsf@gitster.g>
In-Reply-To: <xmqqv8ij5g83.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 1 Apr 2023 12:58:17 -0700
Message-ID: <CABPp-BEk5pVUjWEqjS9dUMfuPEjCVniKXic0HNRwSmV_EPZNLg@mail.gmail.com>
Subject: ps/ahead-behind-truncation-fix (Was: Re: What's cooking in git.git
 (Mar 2023, #06; Wed, 29))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Mar 29, 2023 at 4:33=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> * ps/ahead-behind-truncation-fix (2023-03-27) 1 commit
>  - commit-graph: fix truncated generation numbers
>  (this branch uses ds/ahead-behind.)
>
>  Fix unnecessary truncation of generation numbers used in-core.
>
>  Comments?
>  source: <pull.1489.v4.git.1679311615.gitgitgadget@gmail.com>

The source link appears to be incorrect; I think it should be
f8a0a869e8b0882f05cac49d78f49ba3553d3c44.1679904401.git.ps@pks.im.

And if so, the series has been reviewed by 3 people (you, Stolee, and
Taylor).  Both Stolee and Taylor were in favor of merging it down, so
I think the status is just out-of-date?

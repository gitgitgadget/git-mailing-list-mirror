Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA45C77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 16:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbjEBQ1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 12:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbjEBQ12 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 12:27:28 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410C6198A
        for <git@vger.kernel.org>; Tue,  2 May 2023 09:27:27 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-546de76c23eso2169856eaf.0
        for <git@vger.kernel.org>; Tue, 02 May 2023 09:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683044846; x=1685636846;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRmGEsRcF3Ffc3mVhW6YiD+7IBxw1op50EVAHSnXLUs=;
        b=mT8z7UHkRtJpCR4SEhz9J0L01j0GzwLG0uWlHSu4PkIL2HsV9C62xcETHcrtCDUIRw
         AKhahxprdLWrW/v9Qjb5XHdq5mRpg10jH3ChXNsnIpI+ZRh/VJqp/a6iMAn/xxkAsLNl
         7wMuVV2LAGJEO1wcWzkUWWbnO+5dVgDJC1aCdRpUWIYTLXuRlL1WWs/g/pCz843G33qN
         Jm0qzaMDu1oSg/eAwbkpPcsREO0CEt4pqOo44236Fq+5m1/TTYUHtjAl11y5r+WG1Tol
         FFjIaqyuBYEHGkVY+QQTMf9ZL2eWVW82sJ+Bbdju31sS3Hwb7H4iGC6cPRqFhSTmrq0k
         k+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683044846; x=1685636846;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uRmGEsRcF3Ffc3mVhW6YiD+7IBxw1op50EVAHSnXLUs=;
        b=e6E9KG9nUx5UnmUuGOritqiyL9BvpV4pDKCGQfM1j41VF52nexVplXh98dLAWJZoZS
         qTtQuBQcWWyS09o7VWFL6m6dCHvALo+qMBiTYlSklhN7nTprf0JcnNytn6CfF9An8ty5
         KvPzBOXpgDdmnvnFHGu32gfLoJr0csW3wKT+f42A4juC14oO0CPbpl1k8Dy4iDTbRw/Z
         P75c3C2PnLD8OevNWw3e/S1UUJ9pwYGr0GUEMoh3sEt4B/Ey0d//W0g5TeFa0J9vJah/
         1KuMKhey9NxZPnTaLQNBA4LM1oBeA9hLGzi6iKkfwFqEjwVbaTZpZ3nPBGMGNyG1KQTx
         hu1Q==
X-Gm-Message-State: AC+VfDxRnbZ6Hj0vnAOp2OM2Z3JS7U2h0phMsAsi4eOlG0KchfNee3ns
        GwT1qorT6dIyxnfF/E70j5o=
X-Google-Smtp-Source: ACHHUZ5RzyuSVGdfRfc7tRMpZ6RbkPYJAy/kNarCwu0OWJJF/y4GhtYPMWgmToofK8C5J07tN9wwZQ==
X-Received: by 2002:a4a:c601:0:b0:547:6a79:18cb with SMTP id l1-20020a4ac601000000b005476a7918cbmr8484921ooq.9.1683044846542;
        Tue, 02 May 2023 09:27:26 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id e9-20020a4ada09000000b0052a32a952e9sm1180289oou.48.2023.05.02.09.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 09:27:25 -0700 (PDT)
Date:   Tue, 02 May 2023 10:27:25 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
        Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, eyvind.bernhardsen@gmail.com,
        gitster@pobox.com
Message-ID: <645139edf1a0_1ba2d29474@chronos.notmuch>
In-Reply-To: <20230502041725.7zbv3i4srdb7fqrg@tb-raspi4>
References: <20230501023533.35370-1-alexhenrie24@gmail.com>
 <20230501023533.35370-2-alexhenrie24@gmail.com>
 <20230502041725.7zbv3i4srdb7fqrg@tb-raspi4>
Subject: Re: [PATCH v3 1/1] docs: rewrite the documentation of the text and
 eol attributes
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen wrote:
> This looks much better, thanks.
> I have some minor comments:
> a) The commit message from above:
> >  docs: rewrite the documentation of the text and eol attributes
> =

> The word "doc" is used 2 times, that feel a little bit redundant
> (and should start with a uppercase letter)
> =

> "Docs: rewrite the documentation of the text and eol attributes"
> =

> Or may be shorter:
> "Rewrite the documentation of the text and eol attributes"

This suggestion goes against the Git guideline in SubmittingPatches [1]:

  The title sentence after the "area:" prefix omits the full stop at the
  end, and its first word is not capitalized (the omission of
  capitalization applies only to the word after the "area:" prefix of
  the title) unless there is a reason to capitalize it other than
  because it is the first word in the sentence.  E.g. "doc: clarify...",
  not "doc: Clarify...", or "githooks.txt: improve...", not
  "githooks.txt: Improve...".

If this is touching the documentation, it should have the "docs: "
prefix, or "doc: ".

[1] https://git-scm.com/docs/SubmittingPatches

-- =

Felipe Contreras=

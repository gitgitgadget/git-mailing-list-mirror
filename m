Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92720C433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 08:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B06E20774
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 08:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6nQp2bY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgHLIP4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 04:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgHLIP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 04:15:56 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82A5C06174A
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 01:15:55 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id v12so1230324ljc.10
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 01:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FlDXly75IPrjEMxcgAKhzSAk4fsxNcOTgRHzp714MfU=;
        b=d6nQp2bYSwSjhxCdybFhy4mO8tvv1czlLEZOuPZw/6r005Me88XChiY4HuLPP8zO8y
         EcC5NEHmk78QlKuN+zZzjKCsjqJvGHkIGOctuv+mEX/QkDHM3wFI6cYKIFdcnfQzFDqS
         Ee+5y+vK2wR2/pZhyQasMCoLWD/SfQ1Q44nrx8SUWE/pmJFIqFJawtEp9+QtFjMe5EX1
         jxZxnPK+thz7IikeMDX9wkmwDQe/ylU/RvSQSim1nxtWFiVhe00L2ALQYrcZhOM/houh
         89YJSvJl4oJ/Y/B4DM/jbJUGO3sJ4pQxR/8pztwFweuB5HMk4Yv+8zMheVYznML3FWb5
         4zUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=FlDXly75IPrjEMxcgAKhzSAk4fsxNcOTgRHzp714MfU=;
        b=p/bu4G7rZAd/I4Cv/ZNu1ifUj+5pn2HVe4Dy+cjql0cbg9AcjOst6YPbZNiFI7V0Df
         wCyJyLotUgR9AbE2DyLEcbWMIwWeAlDRJCKtjtPoikuE70OEhLu28gPYxzcDqh40GWiP
         HCXTygxq26RRe3RDEVDsGEUykHDsIOSA5h/qr0EUeMSkIKDzhqo8BHIezofA3rPg/Aij
         7uxju4WqomxgkCfyepr3Vwmi4REbEdP+GQjAy6o8ZafdOsBpBMZSe0U2zcbtEBdlOaiN
         u/CaL1NKiXltfLSLPV7bKHWpbDe74nxIwfNL6Az3M1qn+UhXEqmKEnjL5MMfOH23zf19
         wfPQ==
X-Gm-Message-State: AOAM531FyCOcwXYyXCroPTFOW1UmcmrRLA/g6mN0lPCwMMYfvgtwlJx7
        GHup8mo7iqv5R2K7EyuJBJHOVDbV
X-Google-Smtp-Source: ABdhPJzVrjX4sWwWL4nEVhOn0LNCtzjVy0bPPikMotKvz+GWmXFp1mnI0+Y5EnYHpC+W3uBUGyUmdA==
X-Received: by 2002:a2e:b010:: with SMTP id y16mr766911ljk.391.1597220152013;
        Wed, 12 Aug 2020 01:15:52 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m64sm307598lfd.0.2020.08.12.01.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 01:15:51 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #02; Mon, 10)
References: <xmqqsgcub811.fsf@gitster.c.googlers.com>
        <874kp9biho.fsf@osv.gnss.ru> <xmqq7du59eb4.fsf@gitster.c.googlers.com>
        <87364t563r.fsf@osv.gnss.ru> <87tux93pku.fsf@osv.gnss.ru>
        <xmqqh7t89870.fsf@gitster.c.googlers.com>
Date:   Wed, 12 Aug 2020 11:15:50 +0300
In-Reply-To: <xmqqh7t89870.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 11 Aug 2020 14:36:03 -0700")
Message-ID: <87eeoce0uh.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Here is the patch you've asked for, separately, as I honestly believe it
>> does not belong to the series in question themselves. This is on top of
>> the series.
>
> Well, the tip commit's title being "add test for --diff-merges=off",
> testing it standalone as well as in different ways to combine with
> another option that potentially interacts with it would make the
> commit complete, I would think.

My point is that this set of commits is essentially "make
--diff-merges=on a synonym for --no-diff-merges", so it should only
include the same test(s) that exist for --no-diff-merges.

If new tests are to be added, they should have been added before the
series, or after them, with their own reasoning, I think. Yeah, not a
big deal, just a bit of perfectionism here.

Thanks,
-- Sergey

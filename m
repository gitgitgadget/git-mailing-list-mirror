Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A3EC433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 06:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244953AbiDKGkI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 02:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244984AbiDKGkF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 02:40:05 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E27423165
        for <git@vger.kernel.org>; Sun, 10 Apr 2022 23:37:51 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bv19so5718104ejb.6
        for <git@vger.kernel.org>; Sun, 10 Apr 2022 23:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vmiklos-hu.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V1lepnj1W6fWSV5oguVoqYs4QZe483pXSKu92J3pag4=;
        b=teqKhzCnGgJ0ES13sFkyC3pXbHtZixGCnXgCJf09ve+L1m/taXA4Zc+q6uoivI4ZK5
         h1NA4IEwHCGz3bzCzWE4wXoc9EcCphKEX4aIHRhZgSn1Dn4pAvxKAW+7302LIUC3Nkxv
         oL1iQ3aCI/8yc+WyNX/nWq73UIUYaXBiQo1VZNzj3KmIuWdOsp+w1yMA41uW2AjjJzac
         esVph68GQNW2feMKL9pONKYEh2ziBHzZl/7sI77EYcECYhf7rMt6lfhYjG8kcS8vYBq1
         SoxlN1OL2CTlLSlNeYL24M5obL8gopuhYjLU6pgnY/9Xqo4v+cayXjA5sl9wucZGseRr
         7Z1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V1lepnj1W6fWSV5oguVoqYs4QZe483pXSKu92J3pag4=;
        b=x8KyQXSX624NzNLG+oyz3YVqtziAiFRGdZBYwdvwvaXTbu9xcklCNWS9O+ajV/KHfr
         BOLqD6hzhMI4czEccw2O08fZXBAMAtjJD25iVq7+jdVN3QPj34UJABpkxl9PgC09EvMF
         h8VybxnZENP04xZ1a91q+6TX2DU679stEUwkRxKbLzkFx6ZxePY+9lmEmy5wUuTMYd9T
         7Am0X0g0A+P0769pEAYlZbQnFJkfkVtl6ylEUUhPa7xscsPvaM5ncr0BE6D4bA0C3UeS
         Kin9WazMILQnuD/yGHKBSkVVRzymPxiK1aDDNNTeoUMiBGo7l8QrnDsO2WU6OQT1GrMD
         47lA==
X-Gm-Message-State: AOAM5308Lq6h3fThlQv13vQBUo0lBDvTcUDIG17ntVguhYp+LpggrRNW
        9VTXd4aFXePU5bTOFcodyczSo2EJnc/Pleog
X-Google-Smtp-Source: ABdhPJwToO6rM5DH63Lzv6/aRPbqUvjZRRgdWIJVpOH+tc/PZzeZv5YkRknp8t0hUZoR1f15ZvfTGg==
X-Received: by 2002:a17:907:6d04:b0:6e8:4ddc:1c6b with SMTP id sa4-20020a1709076d0400b006e84ddc1c6bmr13074575ejc.309.1649659069920;
        Sun, 10 Apr 2022 23:37:49 -0700 (PDT)
Received: from vmiklos.hu (94-21-185-252.pool.digikabel.hu. [94.21.185.252])
        by smtp.gmail.com with ESMTPSA id f5-20020a17090624c500b006cee6661b6esm11644859ejb.10.2022.04.10.23.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 23:37:49 -0700 (PDT)
Date:   Mon, 11 Apr 2022 08:37:47 +0200
From:   Miklos Vajna <vmiklos@vmiklos.hu>
To:     demerphq <demerphq@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Subject: Re: git log --since to not stop after first old commit?
Message-ID: <YlPMuxhpngs+x9n8@vmiklos.hu>
References: <Yka2GSGs3EIXm6Xt@vmiklos.hu>
 <xmqq1qygy9nd.fsf@gitster.g>
 <Yk8Gvf/fjVca9hDB@vmiklos.hu>
 <xmqqv8vkpara.fsf@gitster.g>
 <xmqqtub3moa0.fsf@gitster.g>
 <CANgJU+Wr+tKNPfeh4dst-E_LSnoYYmN1easqmkFUA9spp-rpKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANgJU+Wr+tKNPfeh4dst-E_LSnoYYmN1easqmkFUA9spp-rpKQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Yves,

On Sat, Apr 09, 2022 at 06:02:44AM +0200, demerphq <demerphq@gmail.com> wrote:
> When you do have the cycles perhaps it is worth considering whether
> splitting it up, so that --as-filter is a modifier for traversal stoppers,
> would avoid the problem of proliferating options.   Eg, instead of saying
> --since-as-filter you would say --since ... --as-filter.

[PATCH v3] in this thread is meant to implement this. I hope that helps.

Regards,

Miklos

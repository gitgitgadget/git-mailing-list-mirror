Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D112C00A5A
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 07:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjASHlw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 02:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjASHln (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 02:41:43 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E66C63097
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 23:41:40 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id x21-20020a056830245500b006865ccca77aso738216otr.11
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 23:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3fckHZ5bWVkZNSYMc36kAEA7h+NQCkHSqMEDS+T25Iw=;
        b=DlloiRoLkQH2OVXNSAL0AgQunZAIpdlUrAT3L+ynnWO7G7zI6HVQuXzpASvTs+2fQ1
         i4JWwSoJ5SUpIPnJJHSOEG2L0jRGQQvMLdS0Y53/SUFolKhsDBsHzec5qx5fJR3MBL06
         +Y9L95aaQagVO5LkFYxiShQqzBuEgE6/CvwpfilzDUF9qSPdsq/zqbbwTkyBeoP6fObw
         Y9WdGsACSrUJtl/24r0tFsOcQN0DT+5TsA0O/DSEX+rlym8JlCqhOooDNehe1ek9oon9
         OfHCzoB9h1+Foqr4bLoKl9aV1SMAKs1H9Ea8lh0O+LAj0jUla642nKYUOiRBylaw0Rs/
         aQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fckHZ5bWVkZNSYMc36kAEA7h+NQCkHSqMEDS+T25Iw=;
        b=5UiJ+llp+tTLkdSentbeM3C6JOFllEcD7yb4CwytT1DP1SLyQLIdhkclpqQRX34TW6
         omkqPuVW4m56qYzKgT6maHV5SmpwsZGPcJwYkqgfnQjXLJbS+lSI1JcETSVfocgI/xW+
         o2UI/SqbOzJdW4cVtvw8gvJRJSKncLv7nQj/Pq4zlUqcmCnpV5mpvUtsAR+BYNhTGoNV
         GHVfTYHl/UjV+XFt1iITWWBmVdRXx20POR3dg+tqVVoSvacWj+ataMizwrb+8G2RWWYB
         rL7z48YSSJJiXmIb9c5jtuzRZFLJd0Ajo9zeO+DdqtQ3LdixwPkpphbkH3y3GUSjegt/
         h9Hg==
X-Gm-Message-State: AFqh2koxHCa8GitoOR82ZCabDLSPbWOwIt3t6NjQzOAppN73wBuJjLgt
        1vWwcxgCNX+DWbZEte5MM15kj8AxOAP6jXHzZI4=
X-Google-Smtp-Source: AMrXdXs8GOSk3g6qsGDQ+m9y1FXiFKhlh7cZmDA3dQrz4bJlrqow324LB/n9RUyEj2hDtIEakJb+hryuttVmAAlJ0fs=
X-Received: by 2002:a05:6830:111a:b0:684:eca2:a02 with SMTP id
 w26-20020a056830111a00b00684eca20a02mr551334otq.252.1674114100096; Wed, 18
 Jan 2023 23:41:40 -0800 (PST)
MIME-Version: 1.0
References: <20230118061527.76218-1-carenas@gmail.com> <20230119055325.1013-1-carenas@gmail.com>
 <xmqqa62f2dj1.fsf_-_@gitster.g>
In-Reply-To: <xmqqa62f2dj1.fsf_-_@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 18 Jan 2023 23:41:29 -0800
Message-ID: <CAPUEsphr5hhszLmXc84_87gUq3Fc2yQo3_oxaP+UdODaCXHDeA@mail.gmail.com>
Subject: Re: Re* [PATCH v3] checkout/switch: disallow checking out same branch
 in multiple worktrees
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Jinwook Jeong <vustthat@gmail.com>,
        =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, that should round up the documentation for this behaviour nicely.

Carlo

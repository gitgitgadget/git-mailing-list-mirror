Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ADCEED603
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 15:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbjIOPLe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 11:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236027AbjIOPLN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 11:11:13 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215AE2D67
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 08:10:32 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52a49a42353so2681594a12.2
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 08:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=milientsoftware.com; s=google; t=1694790630; x=1695395430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :organization:message-id:date:subject:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+hjMBAgXoM4kW0GWAb9RXR93YdqNR/VErgCQeBVKiLg=;
        b=UXaoxhiXQN0F4/GAQIeZA6b5UdydV0QBZQqOSBtDznMw7d+UOrpDgQpRCnTpK6MGmD
         faV40D2pEV7glkG1PX+J7E5rx0CeklvJhJ5pWEmxpmQqZKtHpu6sHHHVNVfvqG7NneX+
         JavW9mZ8d8QcwEsEWJ7cC6KOR/EcL0Omcjh75dHTqgey32dePZSjZpU+PnWyVY3ONDXl
         5E0LymoUdMvigaRnZxUOYgtTZSP2UTy6PcFYlS9jT8wiqKYBlcBz/h/RSwRZznXXE9gL
         bI+QyHhleDw4P1DkUGBCZM0BD6sW4VeKnPoRlcYVvgjPkSn772iBan/0jDcISZKQFKiv
         O+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694790630; x=1695395430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :organization:message-id:date:subject:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+hjMBAgXoM4kW0GWAb9RXR93YdqNR/VErgCQeBVKiLg=;
        b=hUXeQGU0AiqOyG2uZBjD+DXyW35bJUtPMMBJ0yZtGG2XjxkLoFw0LawHED6rREpi08
         I3Cigh/j0fWR3xSvIcPVuXDiG/XzscjVej62uKVvEU6nhj5yV4BZLsQ7kRp0KyAe8bOJ
         tk6Ey80d6c2siFdJ2pr+6Ew8jOCrA3ZERPRpbuoQBSKbYLzrcZGZuUL0uvykL9t+25DK
         syliSIbpiPSU24E65Yh9BZLsODeNC4PkTZqI/QT/TCb4ew/lG+Kyn62feuXjO/aYiLWd
         IRh6MR81Kv0NzwsRzwsKhi7QBCiDdnQ4p/0gr6XgYeBjfYMzrjKYYeQF894n60u5ny2q
         qcxg==
X-Gm-Message-State: AOJu0YxZAtnsF7ZOpNOLPNW8ZX/Fr1NYbWyaumyVNw/PiZZGPa4b8Fcr
        DtK2x63KLeDSdMuhtp8LX936I6P1L0cARMMALDA=
X-Google-Smtp-Source: AGHT+IFoUbgCGL2BjV/cGwUE0cvGrgEpjMHoRp36mZvy2tSubgFRVdNwsnXFLpr19jG+h8rpI1XqrA==
X-Received: by 2002:a05:6402:14c8:b0:52f:bd60:b54b with SMTP id f8-20020a05640214c800b0052fbd60b54bmr1963029edx.37.1694790630207;
        Fri, 15 Sep 2023 08:10:30 -0700 (PDT)
Received: from utklippan.localnet ([2a02:5120:1005:1::21f9])
        by smtp.gmail.com with ESMTPSA id m1-20020a50ef01000000b005227e53cec2sm2403284eds.50.2023.09.15.08.10.29
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:10:29 -0700 (PDT)
From:   Magnus Holmgren <magnus.holmgren@milientsoftware.com>
To:     git@vger.kernel.org
Subject: Re: Please explain avoiding history simplifications when diffing merges
Date:   Fri, 15 Sep 2023 17:10:28 +0200
Message-ID: <2250343.okVFLFBGsW@utklippan>
Organization: Milient Software AB
In-Reply-To: <3337579.YDm8p7mPUg@utklippan>
References: <3337579.YDm8p7mPUg@utklippan>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=46riday, 8 September 2023 11:09:20 CEST, I wrote
> QGit was bitten by
> https://github.com/git/git/commit/0dec322d31db3920872f43bdd2a7ddd282a5be67

Maybe I should link to the QGit issue:
https://github.com/tibirna/qgit/issues/129

> It looks like passing --simplify-merges to override the default solves the
> problem, but I still want to ask here because I'm not sure I fully
> understand
> the reasoning:
> > the default history simplification would remove merge commits from
> > consideration if the file "path" matched the second parent.

As I wrote at the above URL, I realized that the old git log output without=
 --
simplify-merges and the output with --simplify-merges aren't quite the same=
=2E=20
The old output indeed omits some interesting merge commits, which may expla=
in=20
why the change was made, but git log --simplify-merges does include them, s=
o=20
it seems a reasonable default to me.

However, QGit has a problem: git log --diff-merges=3Dseparate includes a=20
separate diff for each parent, but only for each parent with differences=20
compared to the merge commit, *and* there's no custom format placeholder fo=
r=20
the current parent, only for the list of parents (%P/%p). How should one go=
=20
about adding that? I figure the format_commit_context struct in pretty.c ne=
eds=20
another field.

=2D-=20
Magnus Holmgren
=2E/=AF\_/=AF\. Milient




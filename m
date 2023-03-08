Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B373FC64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 06:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjCHGhn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 01:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjCHGhl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 01:37:41 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B759F203
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 22:37:40 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-536c02c9dfbso287561937b3.11
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 22:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678257459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g+F3wHq9FHttyJ8U2FpGW9bqYTZn1wHM9WSu6LCHPn0=;
        b=b8MTizG3huOIujA8uTV4Xk+xY9/92KhQu2ZNxmxw7HnbPdt0bU2fX48LqQxNF5DhEc
         Vsov4DvM39lTKBbFnhvalTlpxZ7eYKXv5LVXfDkrC+M+iHaEXpgpdTx+LppycTcSl9Tg
         L7ChWhkmGCDITC83HNG53Ky2iHp9/lr0cVh9ufELik3zCNO6xRhMNFsEflDtLQ3XKTel
         Tuv7WM+GHFLWuiPetB6AZ2fmW1MFOMyFmkYoH5u0jNpGNFdkNNpY5TqYljVTPNEEaD+9
         aKTeei7WdT4B2bQlH1VkhcGJuhq1zqiOVjeJbrJsUzuD1cnSjF/humUsOScvt9WgbnfS
         oRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678257459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+F3wHq9FHttyJ8U2FpGW9bqYTZn1wHM9WSu6LCHPn0=;
        b=mQCkAUbP+VP3FFNh5e/ftTp7B5Va7qrz7CRiCpvCgzVWGth6EfZdv/VxtHGTEIBtUm
         aXOY39FaNs3p9DPWRQ8TN0a2biggYLTQVL4QsUH8+o86v2BqacEe4rLvtESD4FS5j33d
         yBYPXAJAZW+i+5Zlt/5M5+n+LHPfMvnO2gatqWVPdhkp87wgqLEY4Y06pHrjhBYAIi6Q
         pIKv3hpj/2S4XsB+NZR/He4y1J7Jsz73nQvDaNHEM2/Kg0hV8sWcb8T5DtUuhz11tF1u
         8eg3wuKopwF8IxGyusGD7NzjtUgXayJNcZ8f/3eaRxPMglzeL6INlMNbiwZtQMO7ktwz
         SaOQ==
X-Gm-Message-State: AO0yUKXLg5Nde2KqwO/CkjbC0YoRkBl0BMOdyRR8H5WndEcKYbwwxseM
        tV3WN34b1NnP4rTZhpnm31tHTToNchBbJ1IQeEvk4BFUwTHTCQ==
X-Google-Smtp-Source: AK7set/YJoAZS7OFZf/AT4h/iUuBJ1AEYa3/kTUyc/Oi7PW39Qa/yi/5eyJpBDFwiN/gszhfxgJ+JdjDeQLTTo1EvCE=
X-Received: by 2002:a81:ac28:0:b0:536:55e5:2eaa with SMTP id
 k40-20020a81ac28000000b0053655e52eaamr10970480ywh.3.1678257458975; Tue, 07
 Mar 2023 22:37:38 -0800 (PST)
MIME-Version: 1.0
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 8 Mar 2023 14:37:25 +0800
Message-ID: <CAOLTT8TcX6Wit=AOFGNLjA4v9HAvJJxCEtt3JhgUR+3OARycNw@mail.gmail.com>
Subject: Question: How range-diff lapjv algorithm work
To:     Git List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, t.gummerer@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was recently reading the source code of git-range-diff.

Its Steps:
1. Use git log <range> to generate two collections of patches for
ranges a and b.
2. Use the hash table on both sets to find the commit with the exact
same patch as an "exact match".
3. A cost matrix whose length and width are a.nr + b.br is generated.
The cost of a completely matched item is 0, and the cost between two
sets of patches is represented by the diffsize(a, b) of the patch.
4. Use the LAPJV algorithm to find the best match between multiple
patches of the two sets.
5. Output results.

My question is:
1. In step 3, why is the matrix size (a.nr + b.br) * (a.nr + b.br)
instead of a.nr * b.nr?

2. Why the cost(x,y) which satisfies "x =E2=88=88 [a.nr, a.nr + b.nr) y =E2=
=88=88 [0,
b.nr) || x =E2=88=88 [0, a.nr) y =E2=88=88 [b.nr, b. The cost of nr + a.nr)=
" is set to
"diffsize(a or b) * creation_factor / 100 : COST_MAX"? What is the
role of creation_factor? [1]

3. How does LAPJV work here? [2]

[1]: https://github.com/git/git/blob/725f57037d81e24eacfda6e59a19c60c0b4c80=
62/range-diff.c#L310
[2]: https://github.com/git/git/blob/725f57037d81e24eacfda6e59a19c60c0b4c80=
62/linear-assignment.c#L15

Thanks.
--
ZheNing Hu

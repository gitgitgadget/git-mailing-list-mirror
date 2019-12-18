Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991FFC43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A640206D7
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DV5TLl10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfLRT3J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:29:09 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44061 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfLRT3J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 14:29:09 -0500
Received: by mail-oi1-f196.google.com with SMTP id d62so1699389oia.11
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 11:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PBiKar+2ZHhzhrsq/igZWMr1cr2Ygpl1OskN0xN6+dI=;
        b=DV5TLl10GNVy7f7RqnvnBXd5blXwOwUhMat/Grlv6PerD5ue6tGUbEluRZiNG0FXpu
         Yz7w3QWAC0Q6PW9unkFa3n42TnWwT4Uuni7yWrsllOxqcuUvKmUvueI1Qlwwx6lbi8t5
         cqKDj0CFzmJ9BMBpdDNh1TtCkv9pJFjnhjoMfwRweEyaMSh2/eFxA13uCO+emhUR+kRr
         v2yqhOvA3umz18hf/Fdk9hI7mbBQgLb96WqJlt5zfAtUZtra/+BGVGvAm9D8njViOKul
         j2pcI4aRaloAAccuM1Q/Fk/yNjC1TDT3SJYJHSbSs+RiPOxFQyfJcP7KsFljYEuGLmWu
         bNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PBiKar+2ZHhzhrsq/igZWMr1cr2Ygpl1OskN0xN6+dI=;
        b=I/v3pbR0beSvwMa+gmE7mmWYsdrPte6/8gI8wy8K8FiMMXiIKofpX82f3YMBhcwFsE
         w2k8JxxYv5CODTtZJZSl/SI0mljPgNUIDtB1xxdzKMDs95zgikQopSiKb1bWNrLlCYbT
         7qVJx/eJqK0q2pVeucjZz+BQUrIHmitiQR5RsDM5Scs3L7nsVmjju8267MFpT2Mk+u9i
         v6B8K5uHu35tp621Gfq6DEDkPeyl34Lsiz+vOeXwexQcc05ltOQhD9LkVGMR3zz3KjKa
         ddycP9lavXWVUZdLpNW1U1HNSUJSRzTWXBSaJhEFvwKiy+3Yg+d3zMIBjNLvwRIFGxle
         z+GQ==
X-Gm-Message-State: APjAAAVPWybaZpsm96OGlKJo2wMt2UyB8pO0iejh9c3UHfTeORVboB6P
        hE7lPfn0s/bVvsgAy9f8+FsS6IED96g1OtODuak=
X-Google-Smtp-Source: APXvYqzk36BfS7fKqyc+6Ovtl3PWMW8FX+/JRrW0pqPxXoYkyb3gc0XcbilHPwihXnMYqmqW7k+ub/jd1flu6li3IFQ=
X-Received: by 2002:aca:eb0f:: with SMTP id j15mr1209678oih.6.1576697348161;
 Wed, 18 Dec 2019 11:29:08 -0800 (PST)
MIME-Version: 1.0
References: <43395a82-34f9-30d1-b468-338e81467f39@web.de>
In-Reply-To: <43395a82-34f9-30d1-b468-338e81467f39@web.de>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 18 Dec 2019 11:28:57 -0800
Message-ID: <CABPp-BGT1hPAKz9_NdARbFgeaTCvYAvtQQ-_ceLH_2DtF8MUvA@mail.gmail.com>
Subject: Re: [PATCH] t3501: don't create unused file
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 18, 2019 at 10:12 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> The file "out" became unused with fd53b7ffd1 (merge-recursive: improve
> add_cacheinfo error handling, 2018-04-19); get rid of it.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  t/t3501-revert-cherry-pick.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.s=
h
> index 1c51a9131d..7c1da21df1 100755
> --- a/t/t3501-revert-cherry-pick.sh
> +++ b/t/t3501-revert-cherry-pick.sh
> @@ -150,7 +150,7 @@ test_expect_success 'cherry-pick works with dirty ren=
amed file' '
>         test_tick &&
>         git commit -m renamed &&
>         echo modified >renamed &&
> -       git cherry-pick refs/heads/unrelated >out &&
> +       git cherry-pick refs/heads/unrelated &&
>         test $(git rev-parse :0:renamed) =3D $(git rev-parse HEAD~2:to-re=
name.t) &&
>         grep -q "^modified$" renamed
>  '

Thanks for cleaning this up.

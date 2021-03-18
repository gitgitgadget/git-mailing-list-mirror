Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A300C433DB
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 11:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8E9964E61
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 11:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhCRLXN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 07:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhCRLWt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 07:22:49 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FD7C06174A
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 04:22:49 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id f26so6994972ljp.8
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 04:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u9GGmAnqt7D1vnkkrkqBJwBzQTcujLoLD2/vsBYG63s=;
        b=UusTKwrQ0ZLywkEa9fMDrVqRXpXl0L33fq6b28rVBemZb0IiVvN/DLesUmSsVUxc1M
         RtvGI8JPorOfwyxyBooyPW72Hwx/ATHj1ti3l+w+XrTGpjbJT8KzYG9pRCQnwK9H1wij
         BO7IExDbk6AMeng+TPxEz47JQwpawAAm4/sOnZS1wfsAc0AeVaWoHX7ijYarRPBrhN6N
         x7fanD4LaWxX8v4WjvYSMQ/bQG88rf6tx+z6b4A+DXO4fJLLg0ap50e6aGmLBPf0KzZ0
         rkfvlFLpXCExjii00WuwddfYmtWCw4YtYeTrH/DKpQDS4CZB6zafzsXqL/XykLci8nyR
         33RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u9GGmAnqt7D1vnkkrkqBJwBzQTcujLoLD2/vsBYG63s=;
        b=b7gFlJzPnJNTjyML23q0XJhj3XW/wPnI1jwNHPPK2lNy6ankPH8Stw1K3lBIkW6/N3
         9wtJS+7LOl9MrlpDCPWWAiJwsFENPJb8JrFKSDI6pJU14OiyP8+uHai0ebS5c3p1aoaE
         YiXlyLvuC7WNCSHYE0tw6lQt7imFqqX/Htq3Iy2A3cvigPRgapxs2gmhstlGkDL0K3kT
         OOXYcT2toWidTmsqrMfxgvz1Ld77eQV2mo4GTQZO+R2pBrSJxfGpFuN2yS/wMcVG9U6c
         rUS9n1sV8IbvMNfFF1th8pZ1dKMqHwnyPoH0/+B/5x72OwnWWz7i9JWDLealZMLviIl0
         HggA==
X-Gm-Message-State: AOAM532/aKqUEG1Ov3AeXhouJGgM0cD0o75FDkf4oU8KGy4yaS6kJXyi
        Id6/qIv/l7B1prXIMbcLETwWH5M2/OH2TPupdo8KtD88SUM=
X-Google-Smtp-Source: ABdhPJzlVAmqWHPkv0Iq6wPggbQz2bXpn4AuJCm5vYM+Z/JMf2S/NuH5kO15KsfaIvX3QxgmFTs4hKzWQfgtLFm/3So=
X-Received: by 2002:a2e:144c:: with SMTP id 12mr5004763lju.113.1616066568029;
 Thu, 18 Mar 2021 04:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210225012117.17331-1-avarab@gmail.com> <20210225012117.17331-2-avarab@gmail.com>
In-Reply-To: <20210225012117.17331-2-avarab@gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Thu, 18 Mar 2021 12:22:36 +0100
Message-ID: <CAKPyHN33Aj63FuSMPJfz6W3F6EUt6ZLZzWaYS5puiKa13uHctw@mail.gmail.com>
Subject: Re: [PATCH 2/2] remote: write camel-cased *.pushRemote on rename
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 25, 2021 at 2:21 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> When a remote is renamed don't change the canonical "*.pushRemote"
> form to "*.pushremote". Fixes and tests for a minor bug in
> 923d4a5ca4f (remote rename/remove: handle branch.<name>.pushRemote
> config values, 2020-01-27). See the preceding commit for why this does
> & doesn't matter.
>
> While we're at it let's also test that we handle the "*.pushDefault"
> key correctly. The code to handle that was added in
> b3fd6cbf294 (remote rename/remove: gently handle remote.pushDefault
> config, 2020-02-01) and does the right thing, but nothing tested that
> we wrote out the canonical camel-cased form.
>

Fine with me.

Thanks.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/remote.c  | 2 +-
>  t/t5505-remote.sh | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index f286ae97538..717b662d455 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -746,7 +746,7 @@ static int mv(int argc, const char **argv)
>                 }
>                 if (info->push_remote_name && !strcmp(info->push_remote_n=
ame, rename.old_name)) {
>                         strbuf_reset(&buf);
> -                       strbuf_addf(&buf, "branch.%s.pushremote", item->s=
tring);
> +                       strbuf_addf(&buf, "branch.%s.pushRemote", item->s=
tring);
>                         git_config_set(buf.buf, rename.new_name);
>                 }
>         }
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 2a7b5cd00a0..34fc3fa421f 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -757,6 +757,7 @@ test_expect_success 'rename a remote' '
>                 cd four &&
>                 git config branch.main.pushRemote origin &&
>                 git remote rename origin upstream &&
> +               grep "pushRemote" .git/config &&
>                 test -z "$(git for-each-ref refs/remotes/origin)" &&
>                 test "$(git symbolic-ref refs/remotes/upstream/HEAD)" =3D=
 "refs/remotes/upstream/main" &&
>                 test "$(git rev-parse upstream/main)" =3D "$(git rev-pars=
e main)" &&
> @@ -773,6 +774,7 @@ test_expect_success 'rename a remote renames repo rem=
ote.pushDefault' '
>                 cd four.1 &&
>                 git config remote.pushDefault origin &&
>                 git remote rename origin upstream &&
> +               grep pushDefault .git/config &&
>                 test "$(git config --local remote.pushDefault)" =3D "upst=
ream"
>         )
>  '
> --
> 2.30.0.284.gd98b1dd5eaa7
>

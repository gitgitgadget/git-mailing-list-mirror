Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140B8C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 11:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242242AbiCGLNQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 06:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239187AbiCGLMo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 06:12:44 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E92DCE3F
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 02:34:53 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id g21so16117169vsp.6
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 02:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TMVbh0p/ZLtYHg/ZWYMGP6PqN+jwHsgtY18ZP5a0vaY=;
        b=S+eoPe6vyzJ9X+vCAnHGlKC7T1zlwE/nF20oabqKXpsfaDfXdizPNuTyQP/4sOaop6
         DNFX/YJ5k8clvXhUzxNG1ksbGEkz4wO8ZrY4Cl1fTbWvSioM8C3rR2JTd3duRC2Ub9uh
         Zo4hZkqJhmMcT5T/DX6OElwgMFSIj7fYijX/vUsUwtFOHU/luPXNyIclGZRQ2gAyIIKn
         7R5H3TfXMVl2cJs5WuH3MTT/WTJfBw6LoawelDW8y1oL9Ha9VK69uZfkTHqUogdi4RS4
         veWhnmbv0t3iF3XOFe/zD8lgJNIf4wnC+3w2MFIA0Pjuj165o3C5Q9pBwpMNVqu9QDn+
         TUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TMVbh0p/ZLtYHg/ZWYMGP6PqN+jwHsgtY18ZP5a0vaY=;
        b=2xqUOdHm/kO2RH9mNrLxu1B5O8uXx86GZPx3lGh3Dfsl3MVdUfruLYkrhvtIbaiQun
         eBzzLrDrkzkRlidsbqDKLQj+SxsWGsLYQO8dceXtYLKNRyGI0wAj8aTbJ/kQciBsu0Th
         OurXqtuAQOW8f6fsrubJCgAsJavkkISv4Lzh99mdc9jFe8sJ6C0YrcaHr10ZIB2oMhHR
         HcS1la8bJy5znIkPFo21vUmHH+zxd1SrzObSRLb5vsQtRIbLnjiiZTC2DY3f6xma+TEi
         VamWv7Msf7hkT1wtGBl9I4ovmbUpc0zFmLqDtEGziPhJhaCqTOKSsXmTF61WVn0rgeC4
         y+CA==
X-Gm-Message-State: AOAM531DMdP2nA96UmzIyma+TUDWIo6naLTyxYU9CLUFzq1xkUVzoAM+
        1yd6bu1jGh/QRJzv/GNe5ooQ7vzeoKNgdnB33muY8vSFWnqMtg==
X-Google-Smtp-Source: ABdhPJygM6W00ePlzTuttV4bBT7RpQfofrCERf1N5DMcGRvoAZS3q592w2kvUm2qJ6krCYKRsXXPP+x1sxtIXf9GNu8=
X-Received: by 2002:a05:6102:2912:b0:31a:5ab3:f44b with SMTP id
 cz18-20020a056102291200b0031a5ab3f44bmr3849179vsb.53.1646649291540; Mon, 07
 Mar 2022 02:34:51 -0800 (PST)
MIME-Version: 1.0
References: <70a0325ca8ab0492a9b0873ee3fba576c5ab90b9.1646173186.git.me@ttaylorr.com>
 <220302.865yow6u8a.gmgdl@evledraar.gmail.com> <Yh/1zFChEXz7r1vN@nand.local> <220303.8635jz5mcz.gmgdl@evledraar.gmail.com>
In-Reply-To: <220303.8635jz5mcz.gmgdl@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 7 Mar 2022 11:34:40 +0100
Message-ID: <CAFQ2z_Po4erN5Dpd7SJs9qANxNYh6rvcuYwnVdOkb0DbBeFDEw@mail.gmail.com>
Subject: Re: [PATCH] builtin/remote.c: show progress when renaming remote references
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        sandals@crustytoothpaste.net, gitster@pobox.com,
        Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 3, 2022 at 12:04 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> >> As an aside I think the reftable code "emulates" the D/F conflicts of
> >> the files backend, but I'm not sure (this is from vague memory).
> >
> > Perhaps, though I'm admittedly not familiar enough with that work to
> > tell know for sure, either. I don't think I have a ton to add to the

correct. Look for the 'skip_name_check' option, and reftable/refname.c

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.

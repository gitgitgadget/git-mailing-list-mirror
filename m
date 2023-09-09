Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E43EE14A9
	for <git@archiver.kernel.org>; Sat,  9 Sep 2023 18:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236253AbjIISpN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Sep 2023 14:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjIISpM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2023 14:45:12 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BADD131
        for <git@vger.kernel.org>; Sat,  9 Sep 2023 11:45:08 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50078e52537so5249024e87.1
        for <git@vger.kernel.org>; Sat, 09 Sep 2023 11:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694285106; x=1694889906; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NBXw+zm2dNKbN+cP2ogXHSMQfQGfGQ3iXtPvPd+GNJ0=;
        b=bnZMWiOw0ELGz1MQCrypDrNCtpn26trc9QU6hE53j2VXRjzLjIesL4ZAMW9IgXyUcs
         ESIeLtdbVRGyh7a+jUJ8Rd4ochGpRHmennZyCOh96SYxW5dZmGrg+SepIPiU7pv9XMH/
         IP/zPV3WFUS9Qz0mmSc3etgs3ZcSopIbJPy2bK9VyMgzVHu6CigkuGNpntvZeJrMvCVV
         k36fkrODwiR5Fabc4Bmc1js/q7FC7drlTqCEbb7Lhv+QMRUR55mLqv87U2PZeOnZPuxv
         ZOjQN1UZbpR7kFt/x3UBZ5UpJfeRzrRi+B3lMPM6i9/QBzquKphta4po23kZWjo/9dki
         Qqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694285106; x=1694889906;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NBXw+zm2dNKbN+cP2ogXHSMQfQGfGQ3iXtPvPd+GNJ0=;
        b=Anq8PShtxJN3+oTsjAfNE4rzEaE/ciXDH09lr8UEKtKFjK9okbMw5wvhbHkH8OxBM9
         TTRzSa+cQb3sY1beM+C/3yjfL4FttKn/5mRqh98N1S6/MsDhTC6N1JWE1KDE8Im4eVYa
         EHnv1fszxcwVkbk/PYjp8FZM7Ui0pMcJ0MhgjfPtf0o07hNtf0HAz3rueYvOJT3g770t
         aAG8y/6yBk3vBosny5xFf+ETdqOheZ74Vv9yLhF5OfqeFT/DCcZsXnp3X7ZKWAhyvxzO
         2VcqxPxfSv35zT6+h/bZjPOmsSDB1vwkovBtOSmglSZXRNPdwWLVGGvh4VrJnhD9tamC
         zS2Q==
X-Gm-Message-State: AOJu0Yz5lIuCAASsvQxw/OYu3V5eRXRWY+/W1v3WYXE3uFLgltcEdWKK
        iS3YOnp6OoCWsMcUSUJvGxrIgRM4W5EFhSvFP+KbPuDs
X-Google-Smtp-Source: AGHT+IHjiwSiubNh7MIM5RydwvBhYLvm0oKycQi22Wfi6J7CxklzANpv1bf0J/sDSgDSeG11C5gBy1r5Pzn+QwFPGLo=
X-Received: by 2002:a05:6512:3ca9:b0:4fe:21f2:a04a with SMTP id
 h41-20020a0565123ca900b004fe21f2a04amr5392078lfv.8.1694285106358; Sat, 09 Sep
 2023 11:45:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:9756:b0:9a1:930b:7f7b with HTTP; Sat, 9 Sep 2023
 11:45:05 -0700 (PDT)
In-Reply-To: <31866645d2ac4cb1be17e35fae742cb2@cscs.ch>
References: <31866645d2ac4cb1be17e35fae742cb2@cscs.ch>
From:   Mikael Magnusson <mikachu@gmail.com>
Date:   Sat, 9 Sep 2023 20:45:05 +0200
Message-ID: <CAHYJk3SfG01wqFDC0O_iUueBn6JXi6kydyfGGoZfd5kgVVSfbw@mail.gmail.com>
Subject: Re: diff alias which used to work in version 2.27, failing from
 version 2.28 onwards
To:     Reverdell Auriane <auriane.reverdell@cscs.ch>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/24/23, Reverdell  Auriane <auriane.reverdell@cscs.ch> wrote:
> Hi,
>
> To output the diff of a specific commit, I created the alias dici (see
> below), git dici 12345 or git dici to output the diff of the HEAD:
>
> [alias]
>     dici = !git diff ${1:-HEAD}^..${1:-HEAD}
>
> a trace for this alias gives (same trace for both git 2.27 and 2.28!):
>
> 14:38:45.275964 git.c:439               trace: built-in: git diff
> a2028e7b^..a2028e7b a2028e7b
>
> The commit number is put again at the end of the command (the wanted alias
> is supposed to output only `git diff a2028e7b^..a2028e7b`), this was
> accepted by version 2.27 but not by the version 2.28. For now, my temporary
> fix is adding a bash comment at the end of the alias:
>
> [alias]
>     dici = "!git diff ${1:-HEAD}^..${1:-HEAD} #"
>
> Note: the first alias still doesn't work with the latest git versions
> (tested with 2.40.0, 2.39.2, 2.37.5).
>
> Is that expected behavior? if yes, how is the right/clean way to discard the
> command line argument of the alias?

If you want to interpolate arguments in the command string, the safest
way is something like
dici = !sh -c 'git diff ${1:-HEAD}~..${1:-HEAD}' sh

(but why not just use git show?)

you can also use the ^! syntax instead:
dici = !sh -c 'git diff ${1:-HEAD}^!' sh

-- 
Mikael Magnusson

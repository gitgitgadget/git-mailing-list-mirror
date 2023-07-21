Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A59EB64DC
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 16:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjGUQJ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 12:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjGUQJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 12:09:26 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74ED530D0
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 09:09:24 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e99584a82so2861338a12.1
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 09:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689955763; x=1690560563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PLgU6/9fs+7VqLnoxpeDdGfPDQNcSTq51l/dw0FLfQ=;
        b=jQOcsDT2EFd02H8qXiuAl8+H5ouXo/USxmBuQUlakdmo/E9km5UYJpL5HqGoY2PUHi
         nskqTZQalzYCJ14cxmGSFvXBq+Ml/KmB/KbqhdVavKkYeU+yU6nLYmnvnUPcq10J4FB0
         kpirA7UiUKl46qdnB8zzUHtg9UgqOr4Pz2nS1I4TtqpY0crjpd4u/GhDuHgAB4YZe2ur
         uMBqh8HN5UqdkGgjCm7twSaF97cmhpeof0nEc/WoLpnFOGJ0hEmNrpE6ZVGEke1LYfZr
         Se756ntSbYvx5p0HLKXgtVuDIAwzwOiym+tsOvU1gSh628zzq1jgwlHVGFb8SU6iNgLz
         O1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689955763; x=1690560563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PLgU6/9fs+7VqLnoxpeDdGfPDQNcSTq51l/dw0FLfQ=;
        b=FWaoChYiHj/o7N4RcBAMEjZ0QCMmWb8BnirNhsmES/bq4plVcF/HUwMo2i2HN12o2n
         CFoEI6GM6dezkjgXuEVDo6ccvZ7Dk0iaQwRCRopujwwuwCfEoL15tr2/+xQM4IzV2F08
         9HlvFbs6T3mztB/72o2iBL+HgZeitrOWwUJUIaw79NC1nC5fTCCVYG6wyNKfsuGrc9Qi
         f9h59L4nc9rCmLisdJBDcT2yefHZmf0J2015slu4yce4Z/vV8UppXNW3CnjigNVvE77N
         cO8quQmi+u5USkB2cROl6IUeUfCGOW5yAq55g2CKeJMtXJLjZ+qxfnlqSVEgYdjQHGcq
         2hLw==
X-Gm-Message-State: ABy/qLaHVk98R3FqFUltgTyXrT26rWMyOAKgQvtecADOrReFfGecJvne
        f+SLUqkF7YgLw3ev6NZOKVeD7wKIKdqAbRvaV2Qb+Cf8
X-Google-Smtp-Source: APBJJlG2dAedpSuoxNB1Oq/5Y2cbUX9pKLmJZH8BuoKPT3yPBZw50Y/pE0bABTDRq9OBU2UkHH2ffmywNf6rcjZaOtM=
X-Received: by 2002:aa7:da85:0:b0:51d:dbf1:c825 with SMTP id
 q5-20020aa7da85000000b0051ddbf1c825mr2146909eds.1.1689955762703; Fri, 21 Jul
 2023 09:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <046c01d9bbeb$a8680bc0$f9382340$@nexbridge.com>
In-Reply-To: <046c01d9bbeb$a8680bc0$f9382340$@nexbridge.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Fri, 21 Jul 2023 09:09:11 -0700
Message-ID: <CAPx1GvcxdJhAQA=sDJ7reu+shaeuzz+-xZKOoD0ZNo89hOgmbw@mail.gmail.com>
Subject: Re: [BUG?] Confusion with git stash list
To:     rsbecker@nexbridge.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 21, 2023 at 9:05=E2=80=AFAM <rsbecker@nexbridge.com> wrote:
> It is simple to set up. You do need at least one stash, but the contents =
are
> irrelevant. So given any repository, use git stash push. Then use git sta=
sh
> list --all.

The `git stash list` command is secretly just a front end to `git log`
that inserts particular options, so `--all` is passed to `git log` and
does what it does. That's why you see what you see (remember
that `git stash list` includes `-g` / `--walk-reflogs` so `--all` here
means "all reflogs").

Whether this is *intended* is another question, but to stop it,
`git stash` would have to notice and alter / remove `--all` before
passing the rest of the command on to `git log`.

Chris

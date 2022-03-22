Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F72C433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 12:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbiCVM52 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 08:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbiCVM5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 08:57:24 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A248D5BE4E
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 05:55:57 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id yy13so36012493ejb.2
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 05:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=G9UvGUpbb6K0hndrgyZGGICDLQet5+jEMNxZWFc+SWY=;
        b=QI+118J206+/2Y+kYWyIowwMaV+tOB08V+yNsS74+C2lakjINKVu4ONA6J7rpaXH+K
         lrWCHCVjegZQ5hmimlfGZhmNMOkELHouN0+nmnvItNAFjGVhK9wgip2isk6q1CQnz/FG
         uV9pdcWKmrMcFUO99HYvPS6TqKBnSAsBi0PGx+3cbz55q9Mo974tELwNr5sWeop25jbM
         NVQ3OTa0wBsznbB5h+OQrHoHATOuCiMXy+mWh+RSZZCCEo1rEkL013EMaw32te1sjknf
         UWJzwhwkZA5hL2zbaLS6aWIHJoDaetTuTlz/MCoNmwdhFeHhNl46Rdvx5PZjoK/R3lVE
         JveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=G9UvGUpbb6K0hndrgyZGGICDLQet5+jEMNxZWFc+SWY=;
        b=UUT877k+w3jodYLafurvc05ONpyCOAz/r13J5OoAD1o1Jxq1VVJR4asR4hbhCTr438
         LpTjQ1/AmHoIMpcxQvQLsd43Qsrxv7VkSNHDrHe0j9Ts/+P1NvYnrkthYdA3TYWcNTjW
         /2L5OPB1uhaiO9xBXdYXEgMtl9B1mn3IQwbYkECDwUQCVkkYKreppPFOa5JwVXAseHoH
         UKbEUaTsj8tvgxAMpdxc+2UUvI5indrxwni32Sznv1iuXLxf13a2OJxRPq56YN1TRDc+
         IEqmSfji3S5a6JhAhKp3Xx4Z0TjHQ2QChNWIIzlG5XgmBfAxB6iEDGR7SFHiTlflAErI
         sPzQ==
X-Gm-Message-State: AOAM532cMd8Iu9nH2+GeOrSvhmkFVOw2vlV8c8hdYqaIQNF1tDdfxAwI
        qbbeNB6HgOZa1dZ0gfaheyvm4qQBn+H36A==
X-Google-Smtp-Source: ABdhPJxOamMFJC01V3aVvxwyOxUlhw6610chKmIz63XZkRtq3uK/VIICbMpIrMDh+C71iv67jYm8KQ==
X-Received: by 2002:a17:907:7e96:b0:6da:f7ee:4a25 with SMTP id qb22-20020a1709077e9600b006daf7ee4a25mr24810489ejc.436.1647953755681;
        Tue, 22 Mar 2022 05:55:55 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t14-20020a170906608e00b006d1455acc62sm8401883ejj.74.2022.03.22.05.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 05:55:55 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nWe3G-00028F-Kt;
        Tue, 22 Mar 2022 13:55:54 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] Documentation: simplify synopsis of git-repack(1)
Date:   Tue, 22 Mar 2022 13:52:43 +0100
References: <20220312113136.26716-1-bagasdotme@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <20220312113136.26716-1-bagasdotme@gmail.com>
Message-ID: <220322.86r16up2n9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 12 2022, Bagas Sanjaya wrote:

> Simplify SYNOPSIS section to only mention [<options>...] placeholder.
> Redundant options list can now be avoided for aesthetic and clarity.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>
>  Shaoxuan Yuan suggested me to do the simplication, as in [1].
>
>  [1]:
> https://lore.kernel.org/git/CAJyCBORGGbn6d5UYMdRnfrbn9OONcgMMxaCyJ4qUoQY3+s8-uQ@mail.gmail.com/
>
>  Documentation/git-repack.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
> index ee30edc178..39dac64833 100644
> --- a/Documentation/git-repack.txt
> +++ b/Documentation/git-repack.txt
> @@ -9,7 +9,7 @@ git-repack - Pack unpacked objects in a repository
>  SYNOPSIS
>  --------
>  [verse]
> -'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m] [--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>] [--write-midx]
> +'git repack' [<options>...]

I've been correcting some of the "git <cmd> -h" output recently, i.e. to
update some of these, and disagree that we should just have this be
<options>.

The point of this section is to give you a view at a glance of the
available options without paging through OPTIONS.

This change proposes to basically do away with the section
entirely. Since most commands take options we might as well remove all
of the SYNOPSIS sections if we followed this pattern.

Now, I don't think we should do that, but I don't see if you do why
you'd be targeting git-repack in particular. If you think it improves
asthetics & clarity isn't that something that you'd think would also go
for the rest of Documentation/git-*.txt, or just git-repack.txt for some
(unstated) reason?

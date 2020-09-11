Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79085C43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 15:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 278D421D47
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 15:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlINGH8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbgIKP6J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgIKP5k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 11:57:40 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E92C0617A0
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 06:48:59 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id k25so7873432qtu.4
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 06:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5un/WzoJ6d/9pNvnOBrHLPfYRxbTnxzlqBX8mvtW8wE=;
        b=GlINGH8z9plPDbacd3I0sPzOf2T3aedlVByzoxJsEvd/fGd6MFQZhMjhciP8zq1l8x
         C78pAkiQuFSvVFKPE4h94h/wv7yeYCQG6IBO+3t0t0AjfpCAdLlpj8YBUhMh7okvvGxN
         GG4i/ecKdlv5ZRl8ib8UElJNbEaY1zvLoBIDFbCVPQbGurbtxUZz7+fvOIXn6VQAJmvt
         ets0FCPTI/alO5I4pfLKhlMsFFoFN7fiEIjVc0ys5zmvEe2hL0kwD4rs0YzBf2caksJZ
         fM1hP+napECeLpHJbyuI3jVQ6h98GyY1OUCNa67CaEsz8sD/9QwO8psru3Ks9pEyCOwC
         J6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5un/WzoJ6d/9pNvnOBrHLPfYRxbTnxzlqBX8mvtW8wE=;
        b=RyMK5vjcBVSfYqsULUSwgrcsCgpKRlpZ1iq9lV1AzmGUaWncj5da+CvutqO0Ab8yxJ
         n4dWhDD2nAfaMzKoIrgOclebIS+WeX8fK45akAPtNgiDv4pw6VH/GbML//OX8p7I6q4K
         yag87Bb3L40cWy2fyduZLuiNDobTXbOtsxVtzDMWDlOda1/NfdXluZtUH2NOH7LrlACQ
         vGW60r6cMTL33HvcRTmSUCV58Qm3sZVYhtn1OzPiHv8gTl23De84RHXrwlIaJ0Fqh488
         MeYAuJQqDrmvtYkTPaMfPQdwxO4BYJpJmfgdP1bZs6Xzpl4YR78oLJBZA9Jdolaa4gWY
         WL+w==
X-Gm-Message-State: AOAM533jmT8Y0ARDc/aQVu/OEO6EUvgXluylc1j7HpLib3oqsjpWtDRB
        HKCcKHPAl3pewo6S8StvGnMFKhtlp8E=
X-Google-Smtp-Source: ABdhPJzpioykUQRby1fsMbAIh55TvVaH5y47HelMQgKaqjxx0wllS9eP1/4tVbdlX6X1PvzrrmMkSA==
X-Received: by 2002:aed:2d06:: with SMTP id h6mr1905918qtd.301.1599832138854;
        Fri, 11 Sep 2020 06:48:58 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id w2sm2614305qki.115.2020.09.11.06.48.57
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 11 Sep 2020 06:48:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] ls-files: respect 'submodule.recurse' config
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqqv9gms1fp.fsf@gitster.c.googlers.com>
Date:   Fri, 11 Sep 2020 09:48:54 -0400
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7D473EAB-7395-4904-A4F4-9EE13662998B@gmail.com>
References: <pull.732.git.1599707259907.gitgitgadget@gmail.com> <xmqqv9gms1fp.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

> Le 10 sept. 2020 =C3=A0 00:25, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>=20
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>=20
>> `git ls-files` learned to recurse into submodules when given
>> '--recurse-submodules' back in e77aa336f1 (ls-files: optionally =
recurse
>> into submodules, 2016-10-07) but it does not respect the
>> 'submodule.recurse' config option which was later introduced in
>> 046b48239e (Introduce 'submodule.recurse' option for worktree
>> manipulators, 2017-05-31).
>>=20
>> Add a 'git_ls_files_config' function to read this configuration
>> variable, and adjust the documentation and tests accordingly.
>=20
> I am afraid that this will break existing scripts big time, and I
> would not be surprised if 046b48239e refrained to do the equivalent
> of this patch very much on purpose to avoid such a regression.

As I read it, 046b48239e was just the introduction of the config and
it's implementation for read-tree/checkout/reset, and the other commands
with '--recurse-submodules' would come later (as was done in the =
following=20
commits in branch 'sb/submodule-blanket-recursive').

Also, in gitsubmodules(7) [1], 'ls-files' is used as if it respects =
'submodule.recurse',
so I think that was Stefan's original plan. (It's been that way since =
the introduction
of that man page in d48034551a).

> Anybody who writes a script using ls-files _without_ passing the
> --recurse-submodules option expects that the ls-files command will
> stop at submodule boundary without recursing, that the script can
> notice and pick up mode 160000 entries in the output from ls-files,
> and that the script can decide if it wants to descend into
> submodules it discovered that way.
>=20
> It is easy to imagine that such a script will break badly when run
> by a user who has the configuration variable set, I would think.

I understand, but I would argue that such a user could easily adapt =
their
script to add '--no-recurse-submodules' to their ls-files invocation if =
that=20
is the case, no ?

> So, no.  I am not enthused to see this change.

OK, if I'm not able to change your mind, what would you think of a =
separate
config variable then, say `ls-files.recurseSubmodules` ? This would be =
more granular,
so less chance of breaking existing scripts, but still provide for a way =
to configure=20
Git to always recurse in submodules, including for 'ls-files'...

Thanks,
Philippe.


[1] =
https://git-scm.com/docs/gitsubmodules#_workflow_for_an_artificially_split=
_repo


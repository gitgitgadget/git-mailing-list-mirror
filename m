Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD904C43334
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 01:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiGEBb4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 21:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiGEBbz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 21:31:55 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AA8BF4D
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 18:31:55 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z41so13486811ede.1
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 18:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XOk4zTWUjz73CRVoL5JBgKH/ieuo6ZcoJcUAiB9Y5T0=;
        b=cDkRhjDyGeCURP7leMw/FfRFp9BfVWbumn4X7vA3IxqN4ko1jsdHPPz/BW2teqe3+d
         0gGF7S1Jh4EBCbTPhhfTSw5tru6/Hc0a1pt7mn6ELK+J5SvqxbPuTLBSB55YEK8fq0Sd
         9XNF5tjHJWH1FQDTJYAo6C32VsI0XXt/CMnxzF/EtDwzhkohgVTSxdlF2eMnyEbQO/oC
         cXfEn+BBrtrxv8j1Ns3D5IjtF/Yi4DGebVRw6dqTtUot9zUxJHic7twHGGKt991FZ3et
         YYtj64BAFxADf9cM483Y71JMYt3y8yQkutProyHvBtZ7b12qEYU24CiGEs0ucDyl6DN/
         hnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XOk4zTWUjz73CRVoL5JBgKH/ieuo6ZcoJcUAiB9Y5T0=;
        b=UJpspjTpAr6O9lhwvyRuUsJW5MnHNchfTGLp2A136NMJDT2BtF5QVra2fDkirm3hhp
         ZzZItWnUHsCKOuRl0e9C0TwI5A2zXotogAbR/T3NugJ3PRfQY6V62yD3jxRgkirizaoC
         ydHH14sZZPMDSCPVmKqGSQWNJS6vMXq/n501p/XPPDEReWCuvedevG4jBfwla/JJTrzJ
         tZWKXmOJDz+SGilWl6+r8rOcac7Uv6jIBmL6zVqD2Yo7SAed4u8g3wkI4EqXquswaF5w
         417hsMhF3+t0iDysqYU8ym2V+UhbX/RtWB8N5biZrVdsIZ0wG4g4G25Ny7MZ4/ObWlJB
         VZcw==
X-Gm-Message-State: AJIora8CVGDoG//C9FgORT3xhrk6dbhXOPtW9mKpzlmXyv5GbinALC3k
        F2iwPiARr/C+Qrf84l3OrVYz08VvOaNlEfQLzsCPmcjvP7o=
X-Google-Smtp-Source: AGRyM1vk/b+jTpUvtlHRSiagORFhB0p58fNuuwCaElqUaRjzl2Rpzd6X/AxDsfD1G8sAX7tVJeV3mmb2/0rr/H5ED5U=
X-Received: by 2002:a05:6402:27cf:b0:435:dae6:26aa with SMTP id
 c15-20020a05640227cf00b00435dae626aamr42594836ede.323.1656984713483; Mon, 04
 Jul 2022 18:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqo7y85t44.fsf@gitster.g>
In-Reply-To: <xmqqo7y85t44.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 Jul 2022 18:31:42 -0700
Message-ID: <CABPp-BGTYCsa8LNPUNKpfbRqZKba-fx=R22ryNn3HB8XDoarXQ@mail.gmail.com>
Subject: en/merge-dual-dir-renames-fix (Was: Re: What's cooking in git.git
 (Jul 2022, #01; Fri, 1))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 1, 2022 at 4:23 PM Junio C Hamano <gitster@pobox.com> wrote:

> * en/merge-dual-dir-renames-fix (2022-06-30) 5 commits
>  - merge-ort: fix issue with dual rename and add/add conflict
>  - merge-ort: shuffle the computation and cleanup of potential collisions
>  - merge-ort: make a separate function for freeing struct collisions
>  - merge-ort: small cleanups of check_for_directory_rename
>  - t6423: add tests of dual directory rename plus add/add conflict
>
>  Fixes a long-standing corner case bug around directory renames in
>  the merge-ort strategy.
>
>  Will merge to 'next'?
>  source: <pull.1268.v3.git.1656653000.gitgitgadget@gmail.com>

=C3=86var pointed out a for-initializer that shouldn't yet be used since
we've only used that in a "weather balloon" so far.  Let me send in a
re-roll to fix that one issue before you merge down.

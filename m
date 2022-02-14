Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15FAC4332F
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 16:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356478AbiBNQiC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 11:38:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356551AbiBNQiA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 11:38:00 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B6260D9B
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 08:37:45 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id y10-20020a17090a134a00b001b8b7e5983bso11263432pjf.6
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 08:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=/Qnn0S+Br64lIpmKoFtSFe+N/3ziX+cmFhn2nSbUbjw=;
        b=jKKdgV71Cpf4btVc4CY01zNRCZddokIHq15/mO1nGwuGK8Pg2SnG3iJSSf3DHjxc63
         Huz2AJ4LV2S566XMghkzMk3F7wQw+pMxrQmpn1BXz2Q1gbg9qWA06XDgHl8WorH1xp70
         7jSoV5bZxdQqTauc/f+QkNxawWc2P+qWNQVVwuNj+wWGGZb+cn8qsseILh9QwJ7mokUJ
         yc0gx0q/4gDn80nkRMs0/EcMxMTMf/3OqmojCZLP8o0wHXrjaTMOEnx2PUJiJVgww+Xq
         FYAYHEu4ZP40QLWaGcTV+a3R9n1bwn2TcTEdDk3UChpknRCXgetkJKF8qC4deH6UAan5
         IbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=/Qnn0S+Br64lIpmKoFtSFe+N/3ziX+cmFhn2nSbUbjw=;
        b=wzxrM9riyjJ/kYSmES6/sfs5aKt2XMdaUn0pwP9HZdO14vP5FNLXoLp9u7GYvFaGYr
         T+ZffhEyzhbDFfSaxftC6RmVhg2FkCGdCunuqOqeb5VAy3JVKw2YuKhIkOhP1EL/qH5f
         gbI2k39tkJxX+XvNpZiickeqrtWa2nxlF1k7rbuirBdwwBQkXbxBT5bSR7bXnUVTq9yN
         o/zJ5rCimmcg2Uomt47sxPNbYD7+zUfQSn+TZbdMo8Lb1zlzq6hLEP5BnKuOsExUu3Cc
         NVRG/YENW0o9PsKEMO9dnDDC57ilDFZqWHQMS1N8Xoixw42bawUzODc+grnhGLMYd2se
         LeQQ==
X-Gm-Message-State: AOAM530YDj5baZnqfhSBebp8I7wD340iIY7AOosVsmSUrAyOaQu8jgJ6
        8NXcZiBKPnbJLXb8FdP5knczw9/gXdAhCg==
X-Google-Smtp-Source: ABdhPJxSf3MBllQdiQE6+v2akpWhhoBCnZF3dUsfQA2N4TMu0BxKci/T69PY6M9BQy5iLC3yy5GJgJzIBQJrzQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:e7c3:: with SMTP id
 kb3mr7746956pjb.202.1644856664556; Mon, 14 Feb 2022 08:37:44 -0800 (PST)
Date:   Tue, 15 Feb 2022 00:37:28 +0800
In-Reply-To: <xmqqr18770pc.fsf@gitster.g>
Message-Id: <kl6la6et76bb.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220208083952.35036-1-chooglen@google.com> <20220210092833.55360-1-chooglen@google.com>
 <xmqqv8xj71mt.fsf@gitster.g> <xmqqr18770pc.fsf@gitster.g>
Subject: Re: [PATCH v7 00/20] submodule: convert the rest of 'update' to C
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> This seems to heavily conflict with "clone, submodule: pass partial
>> clone filters to submodules, 2022-02-04" by Josh Steadmon
>> <690d2316ad518ea4551821b2b3aa652996858475.1644034886.git.steadmon@google=
.com>
>> in both builtins/submodule--helper.c and git-submodule.sh.
>>
>> It also removes the code that "submodule: record superproject gitdir
>> during 'update', 2022-02-03" by Emily Shaffer
>> <20220203215914.683922-5-emilyshaffer@google.com>, so what the other
>> topic ends up adding to the shell script needs to eventually be
>> redone in the C code.
>>
>> I think "superproject aware" topic would see a reroll due to a
>> slight redesign.  I am not sure how solid the design of the
>> "pass down partial clone filter" topic is at this moment.

Hm, I haven't looked at where the conflicts are yet, but I'll get to it
as I'm reviewing the rest of the feedback.

And on that note, what do you think of =C3=86var's suggestion to split off
the 'easy to review' and 'obvious' patches into their own preparatory
series? I wonder if this would make it harder or easier to manage the
conflicts.

> I can merge this to seen minus the above two topics and get it
> compile, but it also seems to have some interaction with 961b130d
> (branch: add --recurse-submodules option for branch creation,
> 2022-01-28) and makes the t3207, tests added by that other topic,
> fail X-<.

Oof, that's embarrassing of me, let me take a look at that. There's a
nontrivial chance that the "branch --recurse-submodules" tests caught an
actual regression.

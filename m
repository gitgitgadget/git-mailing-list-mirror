Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED744C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 09:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9B6360F11
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 09:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239385AbhHQJTG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 05:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239683AbhHQJSY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 05:18:24 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FEEC061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 02:17:49 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id p38so40267816lfa.0
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 02:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ofpMASfYAmmrPGlQwv4USVfw8Nk2tBIl8HCmNj2sBEU=;
        b=XZ8Lm5xNkE9wq1lIRm5qhoMI3FyN/UPKXC/7Fpy4gXf8GGywD/g6WWwz3DN8okr+Bd
         hargWH65eST1okTYZRSiDav5rFgtlodwKkWpq3w9+0rC/x8waMgIMWqCvBY1QVc40xPk
         WjL6uJQjAMUDQnq0R33CzU1GYTY1lZCRcqJDzR3mRfEeAu/lgjEFVIQN/9KNY/PkTEbV
         p3Frc/LeiL5nA5emgIp5GGThjikHt8OScshe342Dpw9NzdR4AbJ79s6pStj/oyvFjdeM
         pJg0tUVrU4IHSedlCvi/5FfvTZ1RnjNehi5iPLDa5G8vN/PvTj5HqFTV9LwCS26G1fYR
         j8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=ofpMASfYAmmrPGlQwv4USVfw8Nk2tBIl8HCmNj2sBEU=;
        b=qeO/Bgrehcs5P6ETbt9m6ZVOY+8FI5YqcvahYlH7puSsL42ZjXNqahpq+OeEsK8yQf
         BbuImoqQHCNnpVtzSXliCFworXOkCXajV67D4G44gXrVChoCL4sTXbPx4Vy20N2IFmW+
         vBsHbIxikcL4aMUr/+dIKfcw5fqGnDZHFM9znQD7j/NvM52cmzG2gxUmMRLjs+T57b8N
         I/lHM3XZx6WJGQ16fZv4FNzUkP3P3IqEeJiwOsCdB6XVEa58INGikmahVFcpNnyqMvk3
         6EXHs2auFXoQW3KtIPuKT6yBWZqRblJvjM+Vn4p/9CvfwDCHLaOG1IJgzENQkobJxw3w
         QdZA==
X-Gm-Message-State: AOAM5300oEin3utEsWHxwkrbuOvnIa+irR541PvYo0ESWuU3QP7nEni4
        eQVQkPaEWwD2dzIe7fdz4S0=
X-Google-Smtp-Source: ABdhPJwaDHvzWZYpRu5bEolZXcI2PP452pjHU2EcRyl+evRiqdK2cy8arwSdjfmpYCcytTPR81V94g==
X-Received: by 2002:ac2:46e2:: with SMTP id q2mr1718620lfo.18.1629191868430;
        Tue, 17 Aug 2021 02:17:48 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o1sm134493lfl.67.2021.08.17.02.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 02:17:47 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Hudson Ayers <hudsonayers@google.com>,
        Taylor Yu <tlyu@mit.edu>, Joshua Nelson <jyn514@gmail.com>
Subject: Re: [PATCH] Revert 'diff-merges: let "-m" imply "-p"'
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210520214703.27323-1-sorganov@gmail.com>
        <20210520214703.27323-11-sorganov@gmail.com>
        <YQtYEftByY8cNMml@google.com> <YQyUM2uZdFBX8G0r@google.com>
        <xmqqh7g2ij5q.fsf@gitster.g> <YQ3n9Z2nH35429mC@google.com>
        <035b4e99-e708-f31b-2f13-e255d99dea33@kdbg.org>
        <YQ6P0OWPPksWG5Hf@google.com> <xmqqv94hi3zw.fsf@gitster.g>
        <YQ7MGoNswyZJHjkZ@google.com> <xmqqy29chim6.fsf@gitster.g>
Date:   Tue, 17 Aug 2021 12:17:47 +0300
In-Reply-To: <xmqqy29chim6.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
        07 Aug 2021 17:42:41 -0700")
Message-ID: <875yw4l9ac.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Please don't treat this as an attempt to be argumentative:...
>
> I won't.  I asked you what I didn't understand in what you said.
> Answering the question is not being argumentative ;-)
>
>> What's relevant is not whether the script author was in the wrong or
>> in the right.
>
> I do not agree with this reasoning at all.  Only if vast majority of
> users incorrectly used the command and the option, we may need to
> consider such a move as an exception, but not as a general rule.
>
> But "stash list" example shows that "log --first-parent -m" without
> "-p" in a script has a valid reason, and a change that hurts those
> who correctly used a command and an option in a way they were
> intended to do _is_ problematic.

The patch never meant to be entirely backward compatible in the first
place, and, as far as I can see, "log --first-parent -m" doesn't make
sense anymore, since --fist-parent implies -m, that has been settled
already.

Thanks,
Sergey Organov

Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFABC43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 23:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE25024658
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 23:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmJvmyGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbfLEXQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 18:16:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39804 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfLEXQE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 18:16:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so5701221wrt.6
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 15:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gjonClAzsuBrWP9GzTnhk8kjMLSxyJj9Oy/So/JAVOw=;
        b=OmJvmyGrz+89j1g8fIacN6twtn29qARZuVzhpOgEZF9Pg/FlYAJyoru55y5RWZ1Ae0
         b2Knt8btTvlnh/v1CyvqekpYKldlRb1LiMDDkJCyGMNXUEvEgVPrjrkNbUfMwQQf5Rrb
         z3Lnov/0Mw9g5TlwDn+W4lnznvuzCxwd7V3/CgD7/ROda9M5bPz9ZJhIH+KmllV3VURX
         iZNpoDA5gwyd2c+I7roly1bXpVIVfsiG28ZRQ4KdKtsqKtHONMPfIo3Z5OfCq2Jyl5eB
         hoSdQ215oAKADJO6sGGCbNbWOVexJqV5pLtJXRr0NweQf4iZ9VyQIVis7yqyoT6jzBiI
         JqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gjonClAzsuBrWP9GzTnhk8kjMLSxyJj9Oy/So/JAVOw=;
        b=YIPMQTm7K+1oCjLUtYi7j9zEjLKYFcNTjpVD26vHrcc/fBi4Tf4AJaqUyBRbtd7Eer
         nFbqCWR1cALFtR4JRzLVaGkXAh7TcBS4nGK8LV7+w+F23dUkp5Sob5UEzlUfACCaeT3n
         nJv+PwCz4ZkdAW8cXwZH362SHp+JKtHVsbV7zlySaI8mJ8fNP/igieZUY2eq23Ndf+Km
         31pW36jUmeZqC9y1H+ocJy3OfYNZj7N+vPXmYEHQDknNyIqR8uNj90LR+Jt32sxS4A1J
         oBtUHRH6xuur8NiuJq9EasyBqMCQPkLlgXGM+h74hNkC9fdMr/jaNdeY9uVKQsIlllia
         f9DA==
X-Gm-Message-State: APjAAAWWb6RNRprebhQ2r1e7IJSPPXhG9Yyz6dyV1K3am5tIMFh6BOHH
        KhUGq+WoflLzjI9Q/YEI3us=
X-Google-Smtp-Source: APXvYqzurnSEcaNbQs6ZNFvilCercFmzOVHRdzZZYT7fU4Inj0afMG4QmeSe845WEwA1fLwj8DfwXg==
X-Received: by 2002:adf:ea51:: with SMTP id j17mr12525609wrn.83.1575587762009;
        Thu, 05 Dec 2019 15:16:02 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-658-1-58-185.w92-136.abo.wanadoo.fr. [92.136.153.185])
        by smtp.gmail.com with ESMTPSA id u14sm13677834wrm.51.2019.12.05.15.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 15:16:01 -0800 (PST)
Subject: Re: [PATCH v3 0/2] rebase -i: extend rebase.missingCommitsCheck
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20191104095449.9964-1-alban.gruin@gmail.com>
 <20191202234759.26201-1-alban.gruin@gmail.com>
 <xmqqmuc73gk7.fsf@gitster-ct.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <580f1a75-be77-8720-b368-e87a70fe8fec@gmail.com>
Date:   Fri, 6 Dec 2019 00:15:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqmuc73gk7.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 04/12/2019 à 22:51, Junio C Hamano a écrit :
> Alban Gruin <alban.gruin@gmail.com> writes:
> 
>> To prevent mistakes when editing a branch, rebase features a knob,
>> rebase.missingCommitsCheck, to warn the user if a commit was dropped.
>> Unfortunately, this check is only effective for the initial edit, which
>> means that if you edit the todo list at a later point of the rebase and
>> drop a commit, no warnings or errors would be issued.
>> ...
>>  rebase-interactive.c          | 57 ++++++++++++++++++++----
>>  rebase-interactive.h          |  2 +
>>  sequencer.c                   | 53 ++++++----------------
>>  sequencer.h                   |  1 -
>>  t/t3404-rebase-interactive.sh | 83 +++++++++++++++++++++++++++++++++++
>>  5 files changed, 147 insertions(+), 49 deletions(-)
> 
> This passes the self-test when tested by itself, but when merged
> near the tip of 'pu', it breaks t3404.116, it seems.
> 

After a quick investigation, it comes from
pw/post-commit-from-sequencer.  Since then, tests are expected to setup
the editor and run the commands using it in a subshell.  So the fix is
straightforward.

Perhaps I should take ag/sequencer-todo-updates, merge
pw/post-commit-from-sequencer, rebase this series onto the result, fix
the issue, and reroll the series?

Cheers,
Alban


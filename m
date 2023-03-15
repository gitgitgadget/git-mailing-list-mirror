Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F3AC61DA4
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 16:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjCOQvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 12:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjCOQu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 12:50:56 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03B9E042
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 09:50:54 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-544787916d9so52260107b3.13
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 09:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678899054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12jH+bXOvGUy2uVSaXVNL8FccQ5c6p8YyFoao3Zau7c=;
        b=JMS8cxc517bjFZ+PhVfzfpTET/WsO3VvBdQ8LxcEdGWgIankQT6JP6ISfPjxd5b7RQ
         tA8Wef1hrxsOqW9MrKnwIQacd1jEPzm0AQBUe87PMQYoYRXBjr7FQ1KMgNam+77E78X2
         kFY87EhdSJSJovhh00R7g0qWyqGQCnELEVnxR0f/3XTBQgnhsRoAB/HLctxQ6KGIwRLI
         KHlX2+v66wsHPL4pF25Edy1+fbBxIXi22rogVMhqc7osRcnPHenZ5Z/lvyeb+0FI19+Z
         5M0Y/3VfLOH3zqWzYi9WdeLLGpOt0jbhcmRBOnYrlV4IouaAgYL1Lslh8LYRM7slPLKs
         PqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678899054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12jH+bXOvGUy2uVSaXVNL8FccQ5c6p8YyFoao3Zau7c=;
        b=AwFNsnjCyd8KDP3WzeHMhEh3AMHRmeKbiqbQT30Iygn5CeNjOBy0PA5nH6fk7PDyH3
         YSKFmryKfx9IpnOPLE67FEN/1Pwa7duaZzylz+DQXmh9hKzgg90Sm3JUFlTE1qrMLsXv
         nvOF+YZquvx5tmNQzec9UwDF+gOJg+CvlmjtgY91crblYXrC/okXkXMlqDgMZxWjKCoo
         WJfbi8LJTrfcLurYGUvgr1GaTpGPNbaVTIs/PE8grDfQC7osiiKdQVK62n6hK/t3rFwL
         OwnDE/dnpK1Qt7XJK3EfrGPBBtaSElfBpZk0jgesiuWFtuEWig/1V6nUkhR1yxJKiht9
         gI3w==
X-Gm-Message-State: AO0yUKU6GI2pMZPwoyrhwxltPRFixklnlf7um35ALeMtyQvSsi5JToyW
        efmlxi1WbRIJziLtVNxhS6/+vfFjZvcZTqhd7Woh8PFQ
X-Google-Smtp-Source: AK7set9zSNHC0Qa3LdfFAhNa/n/B9gqO3Qfni1bQaoR8MZjWjBTdKpBfkNzImW6aLUo21yx2+wP3ngdaMCoL1xXj7VU=
X-Received: by 2002:a05:690c:d94:b0:541:698b:7bdb with SMTP id
 da20-20020a05690c0d9400b00541698b7bdbmr444300ywb.2.1678899053715; Wed, 15 Mar
 2023 09:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk>
In-Reply-To: <cover.1678893298.git.phillip.wood@dunelm.org.uk>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 15 Mar 2023 10:50:42 -0600
Message-ID: <CAMP44s1y9mp7-dyLtrKsvgzenG9buVM-V6OBnaTKD0cv+aA7zg@mail.gmail.com>
Subject: Re: [PATCH 0/4] rebase: cleanup merge strategy option handling
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 15, 2023 at 9:39=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Cleanup the handling of --strategy-option now that we no longer need
> to support "--preserve-merges" and properly quote the argument when
> saving it to disc.
>
> These patches are based on a merge of 'master' and
> 'ab/fix-strategy-opts-parsing'
>
> Published-As: https://github.com/phillipwood/git/releases/tag/sequencer-m=
erge-strategy-options%2Fv1
> View-Changes-At: https://github.com/phillipwood/git/compare/c2e329a52...3=
e02eeff7
> Fetch-It-Via: git fetch https://github.com/phillipwood/git sequencer-merg=
e-strategy-options/v1

FWIW I reviewed the changes and they all look good to me.

--=20
Felipe Contreras

Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C30C35249
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 03:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE9621582
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 03:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C29xbdj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgBED3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 22:29:39 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46394 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbgBED3i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 22:29:38 -0500
Received: by mail-pf1-f196.google.com with SMTP id k29so419009pfp.13
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 19:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qi74jWsFpo8iyl2sNID+h31YmRx4Qhhtk1UUltWPgP8=;
        b=C29xbdj/2aSYKl2bSb+O+BuxU3oSZO5r5FTKDMUL8DnFA9uJJ4Efcau5EHvYQPkKlm
         Zi5q248rErUYkemeBQuAAlUMsjAUAscM4BJInQvgE4F0jZtUv8kaMrIBAMpmiwvy0DJE
         kgXS4PKfF798nElCTsiClS5cx5JGJhCseT4PQ+SxuYxZnFlxIj/MWddcjpK9WEIQ6irK
         G7cuAFrDkNML4zt8fQacEchciMqPWypnqaj/5dEsC/4/zf2hGBRxJb7xY8+qzSTVO4NB
         8JchNL+e1FaoCo0YgQaOgL7xbozi/3ehg/h0K6vL3zFsoJct40x0uJRvOjEw2ThKfJ6Q
         nysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qi74jWsFpo8iyl2sNID+h31YmRx4Qhhtk1UUltWPgP8=;
        b=V5hGKnx3lUlS5tDHKoFBO98Owx06JcUie0wNQA/mcZCt2+FqcWvvJv9k3dZSpcjYPN
         nYKcs9Wt4VgypqkqanSDnT1sRwI6Y/jWZJa9DlkcKhJIjvxX9a6pKX+17D66q4G8PYBT
         mXzapXhHgSVjHjCZLUy8HvrXHxbFsOdMyZkRP1O8b1LelOYObwbI5ccvM7LlQzmhi8Gh
         Vlh3DVb3zXj/Y2eip72B1zuhC5zUnaoJVE1MjLFcAaOGPYAMIXSFkVRhdZBvZHB8ZriB
         B92rFnLe0uggIsynT1GwmuaeFkhxDMan88+cHXvZC3Oaueyy8sVTHEnjpSMY9XlYO2cH
         FXpg==
X-Gm-Message-State: APjAAAV7r91zhk69ikAJ9r+QM2zDUk9W+ygH+AQF5kHCxz82i3b3y3AO
        SuOeqm8fuuthcpqttxAZMHk=
X-Google-Smtp-Source: APXvYqwBVdS+u/W93mGvtu/HpYYxcbeiWFSAcxOvqnUqkSobOdz1jpyQlkTmVknweuI2rW8iL/YLFQ==
X-Received: by 2002:a62:7a8a:: with SMTP id v132mr35881344pfc.111.1580873378002;
        Tue, 04 Feb 2020 19:29:38 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.171])
        by smtp.gmail.com with ESMTPSA id b15sm24987731pft.58.2020.02.04.19.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 19:29:37 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     dpsman13016@gmail.com
Cc:     git@vger.kernel.org, Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: Need help to start contributing
Date:   Wed,  5 Feb 2020 08:59:25 +0530
Message-Id: <20200205032925.5272-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CACbxD0AG_eX4kH3SyY7FWZLcd4FymuOQ6Kii0czHFJ8SPyEdcw@mail.gmail.com>
References: <CACbxD0AG_eX4kH3SyY7FWZLcd4FymuOQ6Kii0czHFJ8SPyEdcw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Manav,

I am a new contributer to Git as well. In addition to what Konstantin
and Matheus said, I would like to add on that you can try improving some
test files[1]. They are relatively easier to change and will give you a
good idea of shell scripts as well. This is what I did as my first
contribution[2]. Also, I think you know by now that we contribute via Patches
by providing our "diffs" (wrt the initial code we changed) and mail it here
to be reviewed by the maintainers and experienced personnel. I request you
not to make any PRs as it won't bear any fruit.

If you need any help, you can contact anyone here. We are a friendly community :)

Regards,
Shourya Shukla

[1]: https://github.com/git/git/tree/master/t
[2]: https://github.com/git/git/commit/c513a958b69090c02ad422b0cd4622009bb4b9f5


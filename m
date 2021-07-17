Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E74FC636C9
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 18:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7B8461003
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 18:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbhGQSmB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 14:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbhGQSmB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 14:42:01 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA09C061762
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 11:39:04 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 42-20020a9d012d0000b02904b98d90c82cso13474930otu.5
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 11:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Dow6yjkMkWfjsXd+GWcJKgP+AHXBD2tdn/6xl1ewrDE=;
        b=iXbv5Eq80CRKi06qFCrr8uu9ocJfjaKA6WdJ3OhfVNwsQKeH0zKPq268qDf0xaZM8e
         W9s1QDTWmYhm6wweIXn/pZ7V19eCTeFqkIbAi9Pr/F6Jj6umgIcSg3pKthOrivJrVacl
         GLOHVkL+SfXDMFjr+VzoY8BbE0/rzpt6w2bpJJ77AwswJYUbCVEjgSObyiZ6WheYIaro
         psmVnwwr1X5Xb9e0Tre16KPyDxb4x2/k5+pUDMu7FFZwyv4iyweGycPn4IjvpLTKKJK+
         4yxrZm/nQSMSRW6EiDHbYAu9Q1AdzKTe02as7jj7fFKFNfNd7gcTVnyY0VRKfFtqyIKJ
         RBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Dow6yjkMkWfjsXd+GWcJKgP+AHXBD2tdn/6xl1ewrDE=;
        b=Bw2/EorNdSR4tLOHut93a4FS0qs938clnzmWnItPjavtFrGC5UDRk+zHz1iKDHux7z
         fVIia7yoZ+YWAJPQ8zZyQ0JdnVDU91Af4kmPtM8LnQhXrf0YBwiRH+ECfwHEPVutsTbi
         NJXRUfMDR3+e51WDB8sxcDCo8rFIDRUu3x+oQn50a0dYEpjOHkM7Ex2dH/r9F2RTTND4
         BWvFM++PqRwJCsGYSehT6ZT9PjObRrT+FmtYciR1VAZ3lB1ECst+UWy7i22oA6zk/4Eb
         FCSSpM5ygDCpgKTUfvktmAa+xWdW69HvOYiNYPWK1oNbi+dQTeQB9sUfTPXv3wSPfb+6
         wgvw==
X-Gm-Message-State: AOAM531d7VIF83c8+6OA39iZAkvuR5ZuJSmN48A4ILdWOWr+acfx/KGv
        gyeHKlwVVeZ8EQLUTDJFShY=
X-Google-Smtp-Source: ABdhPJzxJ6PBrL/1EENWtKkh7/6rgfq78C5CIXLaQlwK7LgugVoGv80dGBfZZp7PeiI1WVqnXjCEKA==
X-Received: by 2002:a05:6830:411d:: with SMTP id w29mr886680ott.118.1626547143524;
        Sat, 17 Jul 2021 11:39:03 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id v8sm2744906oth.69.2021.07.17.11.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 11:39:03 -0700 (PDT)
Date:   Sat, 17 Jul 2021 13:39:01 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Message-ID: <60f323c5e82e1_25f2208cf@natae.notmuch>
In-Reply-To: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
Subject: RE: [PATCH 0/9] Handle pull option precedence
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren via GitGitGadget wrote:
> Based on a recent list of rules for flag/option precedence for git-pull[1]
> from Junio (particularly focusing on rebase vs. merge vs. fast-forward),
> here's an attempt to implement and document it. Given multiple recent
> surprises from users about some of these behaviors[2][3] and a coworker just
> yesterday expressing some puzzlement with git-pull and rebase vs. merge, it
> seems like a good time to address some of these issues.
> 
> Since the handling of conflicting options was holding up two of Alex's
> patches[4][5], and his patches fix some of the tests, I also include those
> two patches in my series, with a few small changes to the first (so I've
> kept him as author) and more substantial changes to the second (so I've
> given him an Initial-patch-by attribution).

Once again this is the wrong approach.

  1. It's inconsistent with the current documentation
  2. It treats configuration and command line arguments differently when
     the documentation says they are the same
  3. It breaks behavior users are currently relying on
  4. It changes default behavior without warning users that such
     behavior is going to change (0 days of deprecation)

-- 
Felipe Contreras

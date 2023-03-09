Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253F3C64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 01:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjCIBdg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 20:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjCIBde (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 20:33:34 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C572B631
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 17:33:29 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id b12so237294ilf.9
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 17:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678325608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21ZDqJR92NzjWKdQ6ccS8dJSOJNoecgVP+W+fdjR/lo=;
        b=ntdCzW2s4Xn8FSOqmaYQU0YhHnOETbq7rLtHsX1HXKMOhgWSC/X/DfuRozG7NrHV3V
         +0iH0Lf6caA7lciviWsUTRdujJ+sJRH77kurLqEqNh4gFURU73WF6YYamP2e7+F/a2xc
         y2nkCrvpJR3RAvwWhsp5ruRuujC7iVjYWVyPHl6fS1hMUWq2wfnuZbYJ2rghSnCzbd0Z
         55PthIMwxh83SSnumqDIaZ97VBVJDB5YnNe+JK1H3KlnjPu+fD9G61MgNlx/DTy+oiMM
         j9x6QOwn7VM9vqKdLkQab4eL6CwGVdM9K6uXN3kbu3s1jOSBT051w6WjdHrS9f8A/ymq
         aYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678325608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21ZDqJR92NzjWKdQ6ccS8dJSOJNoecgVP+W+fdjR/lo=;
        b=Ne+3mnAynKJrz5KfLVhB6zaxEPLfuWDjz7S45RugDkelIioUDxFyPVw7XQ9q0kkfxH
         AvJxtpSW648q5DSu58Nse4V72ar6bGvToDB5WZ6uXeb80DXbVXQI7uRvJBZajBh/ehUC
         A58UKoM8J5YRxBw3KMwFSjyE2ebXN+kHuIqPlp2r2hZmgSwSgmBwF30SEl5olKCwahVx
         CGXaj2X2seCwYlRI7r3c0iJhA2j4e+yrkvksxDsJ3lrslhnoHkh7INMwD0FbcsLnTWfl
         k0+pZPlYWf3jJhOZjyzbDBxXw4GgROh2m6aRpX+l3YyzO+GvoNOoNdaxDzzbahwU5Uvj
         Tx7A==
X-Gm-Message-State: AO0yUKUNuC9Si8ghhzGbJDOHoV8X+lt7Ikv6iKujXnXC1O+WGevJd72X
        9cOqwc19UGhxiWRrrmBwYWvsdYCJomY=
X-Google-Smtp-Source: AK7set8jqy45SJFxjmbZ1fDbnlLQGuNjDxmdYnEYK3zB2HyDlcPwSKAEuAAeow3HKWhpfFrFjI4HPA==
X-Received: by 2002:a05:6e02:1447:b0:317:3f4:c5c7 with SMTP id p7-20020a056e02144700b0031703f4c5c7mr15847947ilo.3.1678325608294;
        Wed, 08 Mar 2023 17:33:28 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id j4-20020a056e02124400b003153213c586sm4997828ilq.30.2023.03.08.17.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 17:33:27 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, gitster@pobox.com,
        vdye@github.com, derrickstolee@github.com
Subject: [PATCH v3 0/2] diff-files: integrate with sparse index
Date:   Wed,  8 Mar 2023 20:33:12 -0500
Message-Id: <20230309013314.119128-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230307065813.77059-1-cheskaqiqi@gmail.com>
References: <20230307065813.77059-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2:

1. According to Documentation/CodingGuidelines

 write 'echo test >"$1"'
 instead of 'echo test> $1'

2. Add a SP after "#" to make sentence more readable.

3. When file present on-disk without modifications, add
test to make sure not only the two output must
match, they both must be empty.

4. Remove the useless test for HEAD:testfile.

Shuqi Liang (2):
  t1092: add tests for `git diff-files`
  diff-files: integrate with sparse index

 builtin/diff-files.c                     |  4 ++
 t/perf/p2000-sparse-operations.sh        |  2 +
 t/t1092-sparse-checkout-compatibility.sh | 53 ++++++++++++++++++++++++
 3 files changed, 59 insertions(+)


base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1
-- 
2.39.0


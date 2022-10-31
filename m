Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C155FECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 19:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJaTrZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 15:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiJaTrX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 15:47:23 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C730913F40
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 12:47:21 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so8670981wmb.3
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 12:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=73BlKlWo3h9rQrW/NNZMOHde7vwqLjTV3iKRf3orIes=;
        b=j58E2BQniBDduePtBED9nNMD8d26+FTE8J/ecaOhJOrruKpfzWhRrowsonwN0fufzV
         DP4DJ3XjH5YBMj9HaT0G29TIAu+ORGij0RdujhuCIIDcT4lhE3CAv/VuVVRwXtj0Rizf
         vJ/F68RM1C+AbvQC/a1u/zNocXhqfscyI3TEK+xr/EBQw4tra4COuLwnEI+5d8fE7q+R
         phipJXcCZpeg7zA5t82eVYQPdn3k/SY7o0Eh/9YIrXql4K/Y0/Ol4IbQ5UJj+1quHtV6
         4tk53wCsM+JyOoe/VB1zAOx+mtvlrG3r9pTH9JJHBmOr9Y1ciPllGHrNdqCG+m1BPJT3
         edTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=73BlKlWo3h9rQrW/NNZMOHde7vwqLjTV3iKRf3orIes=;
        b=3YVQvodQ+ixCYQNTwAq4PQCm3vhVyR0rAjRiw/DDNkM6GPuAIH+dU1eRft3K01jZ6u
         ZqTyDjkR/HM46lBi7GYmxF8Y3XavYLcBLeL4Vm+6ikTZZM5lJ3nN2npdFe4QR4D4Diad
         5Gyzzc+hunoLwpxlnyPX4H4dtlBBDTSo1JuQ142s3r0B1zrshSveGtXUAr2qoxWDc6wf
         ZpuRk0knbmZoGq/Detjd+7NoNYKtHo0t/cGU3fQ9aC89xeZVqoLxhrPWx6UuRPuekD66
         DlZiW87UpQORfbG07/2o1kplGM0/whk5qZv/QtXeF9f9JL5fN5x8s2CRCiQWbkAU+TMr
         nNyg==
X-Gm-Message-State: ACrzQf209tzq1qT1nwqam9pJKHhByV0cwAZOLubKqKgRTT+U3P4DPYO3
        9h/m5YU17qVjrn/dsEUa4I8cfsDpn+w=
X-Google-Smtp-Source: AMsMyM5fFLj4sV75ifZw7nEgBmNk2+M/jrv/D5h23kukiv8LqltuNR+oMC9cD7HAhRR87s9UJTNnaw==
X-Received: by 2002:a05:600c:548a:b0:3c6:dd03:2d31 with SMTP id iv10-20020a05600c548a00b003c6dd032d31mr9351328wmb.95.1667245639989;
        Mon, 31 Oct 2022 12:47:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id be7-20020a05600c1e8700b003a83ca67f73sm8612656wmb.3.2022.10.31.12.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 12:47:19 -0700 (PDT)
Message-Id: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 Oct 2022 19:47:16 +0000
Subject: [PATCH 0/2] t5516/t5601: avoid using localhost for failing HTTPS requests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While trying to figure out why the current CI builds fail in the Windows
jobs [https://github.com/git/git/actions/runs/3358829078#annotations], I
noticed that I cannot really run the offending test cases on my box because
the supposedly failing connection to https://localhost never seems to time
out as intended.

This patch fixes that, and incidentally also seems to fix the CI failures.

Johannes Schindelin (2):
  t5516/t5601: avoid using `localhost` for failing HTTPS requests
  t5516/t5601: be less strict about the number of credential warnings

 t/t5516-fetch-push.sh | 26 +++++++++++++-------------
 t/t5601-clone.sh      | 18 +++++++++---------
 2 files changed, 22 insertions(+), 22 deletions(-)


base-commit: c03801e19cb8ab36e9c0d17ff3d5e0c3b0f24193
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1399%2Fdscho%2Favoid-using-localhost-in-url-tests-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1399/dscho/avoid-using-localhost-in-url-tests-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1399
-- 
gitgitgadget

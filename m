Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 109932036D
	for <e@80x24.org>; Mon, 20 Nov 2017 09:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751021AbdKTJwK (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 04:52:10 -0500
Received: from mail-yw0-f181.google.com ([209.85.161.181]:39124 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750777AbdKTJwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 04:52:09 -0500
Received: by mail-yw0-f181.google.com with SMTP id g204so4033683ywa.6
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 01:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:mime-version:date:message-id:subject:to;
        bh=ABDuwddAEszRRoDu7wncetjkVrX3Q9EbciJjKwH4Sg0=;
        b=OCz0spzMkv9tjeKMfh19u6+HgmKJZnElzeP/2F7i12/HeuacvF85OmtMhr+5CBt1SJ
         I2BiEUwWur25TNbCYEYyhBHosh2Xzc4ZnzKCItOsmEiw73Z8+dZSW3EbuSLw7oOalMQl
         6ADw8xIyZaTLKDyoqaHkAyPynt4bOYAL1d10Klo7ou5znQFwdWIRTxMoCYS7wudsDxJD
         hH39rR0cge64XADJtgMdB+WL2b0SLBHsDJlvsytKj5jZoyKiVm9w6itpYEs6Lvt+QCfB
         JrQTChajm4cgZ/41SuLyo0UENWN3PY/08riWfn+zr+9kxB6mTIw82/eF0LBzrB/tPCcW
         xR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:date:message-id:subject:to;
        bh=ABDuwddAEszRRoDu7wncetjkVrX3Q9EbciJjKwH4Sg0=;
        b=A0xJYGb/MhOXvncPhzhdRs+9uIbweiNaQ2RyQuZOwLpVSyzjpJq9K7Kkhtzvw83tyY
         D04PlkgcAuEilyUIAVc9RynBlMn2Sew4jh5DoxwktNKAHypyHhvg5q/ICfndaCed8jlA
         akgyeJtKaLaVx91lkMEP8ol4AlnHzXZQ1/P5WVmim89TdN7oXXIDJo/+p7TTWjKY3pSA
         gQY3QJRX/QHCjgWTiVeLvf+95hb7AEvZzTy+0vN6UXL+PO3o4vkYlT5pCJ+1F41CPhIr
         UKb6o/OKcorXEHETrO87UocBkuGNtwm74A1YYGouUkp5ICvunC4ygYFlHL5H5Vh75tZ9
         LE0A==
X-Gm-Message-State: AJaThX6gSD/x+2YnZlJQAfhTmvLA7fbEpwbllirIleZeNvZHntrHCst3
        wSvRNX/DjbbOd/Yg6j3uhluXYYUELRU6s7+q1KbN2Q==
X-Google-Smtp-Source: AGs4zMacW7YxzeAnBiLdxOFnWZ3CVvPV31MXNt/wi+Yz9oVANLv87YeQOdevoyNFM8hbnSN4RAhfg+88hgd+Um3Jiyw=
X-Received: by 10.129.74.87 with SMTP id x84mr7145314ywa.214.1511171528906;
 Mon, 20 Nov 2017 01:52:08 -0800 (PST)
Received: from 1058052472880 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Nov 2017 04:52:08 -0500
From:   Viet Nguyen <ntviet18@gmail.com>
X-Mailer: Airmail (457)
MIME-Version: 1.0
Date:   Mon, 20 Nov 2017 04:52:08 -0500
Message-ID: <CANb5NdLCFiaUjit10aV8ewaJOe3UxM28+PwY96dHDM_95GRv+w@mail.gmail.com>
Subject: Add feature to stop tracking files while keeping them in the index
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

Currently, a file can be either tracked or untracked. So, I propose we
add a feature to stop tracking files while keeping them in the index.

Example scenario:
- A developer would like to add some configuration files with example
values, e.g. DB_PASSWORD=changeme. But in the future he also want to
update those files and to notify the others with conflicts.

Best regards,

Viet Nguyen

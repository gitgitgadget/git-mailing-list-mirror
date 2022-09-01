Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BBBECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 02:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiIACix (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 22:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIACiw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 22:38:52 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A34136B00
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 19:38:46 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id x80so11535716pgx.0
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 19:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=siKWoiweguDT56ZRs/drBCsf3/ydI46W/DXbLrn37FQ=;
        b=Id/OXyRciuu6mBQMIX3d6UPyvOmLQl2r/D+5WdF5ESp4DGmauHB9r+YtsZomuAteGT
         XtkRGlcs1NydFgCrkvjdHVEYMrx0WFEy8bApKGtXEGkCjNKIbR/8RKv7g8rLVpi2pgfE
         bJeHUSEzrkhhpTH8QCOb+JdRQeyRnIXXFzL+k6nS25Ncc235XIpUATkJm69w1U8KhBVC
         oAq+rA0ong4NDg8tBzx1OSOoje3gtybgD7i9RGM0EZYRoK4DC1GFnh1jXpSJ0epOXwxQ
         BBiccHY53Mc6DwtSF6inkyLDNGLsGUPcnqgR4kF1zA5yx/1np/yBUuma5Xu2+T/+vbLS
         yAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=siKWoiweguDT56ZRs/drBCsf3/ydI46W/DXbLrn37FQ=;
        b=RF/GQzyn2hhQP8X19KCWi6vzX4vxVLuXi1cyIxATPSGvlrByRdby7SHrk8JlOXHO4E
         FtB2185dgsefPRO1pHALkBwxHd0glgm6iHZt1RA+QQwFLmLluBOhWAj/PqDP3cLAPvPD
         yc9/+GuB3WXQVUNobkNsBBOi8D2m4YLJmm5NZxDU2Jl3gV9q2zgV6MJGQTCmFL8H1IX6
         jroyB8cZ4IuRZdl1Bo/IB7kRNhv49hy2DKOhriJBif9I0/f441Nh9jnBQO6LcDZylShV
         NieyhUiZlm67j0wJQFgF1HvensphG0qd41SUoY884+bm1dNEbjQrAxzBvKxY9Xhl1F8p
         6z5A==
X-Gm-Message-State: ACgBeo1HPvpaJS5pmYhAdf8TG15REr/+JGuSSRxIeI7ucen7vqo2iYmT
        p9V8QtzqkHgvYis9M8mqQpI=
X-Google-Smtp-Source: AA6agR6ztx9soO8d/3SNiRLnVNt2KunRkWl+m2C0D7e/x1LuirrX40NgonT4LfBBlOB/XUWRRUI0gA==
X-Received: by 2002:a63:b03:0:b0:429:c549:d1f1 with SMTP id 3-20020a630b03000000b00429c549d1f1mr25028800pgl.131.1661999926126;
        Wed, 31 Aug 2022 19:38:46 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.103])
        by smtp.gmail.com with ESMTPSA id jf9-20020a170903268900b00174f43129fbsm6060929plb.47.2022.08.31.19.38.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2022 19:38:45 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitgitgadget@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, mjcheetham@outlook.com,
        newren@gmail.com, steadmon@google.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH 4/7] bundle-uri: unit test "key=value" parsing
Date:   Thu,  1 Sep 2022 10:38:38 +0800
Message-Id: <20220901023838.19263-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.37.1.229.g42ab0356e5e.dirty
In-Reply-To: <7e4e4656e530395d055abac2a59e93866c9a0de2.1661181174.git.gitgitgadget@gmail.com>
References: <7e4e4656e530395d055abac2a59e93866c9a0de2.1661181174.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> +> +	init_bundle_list(&list);
> +	while (strbuf_getline(&sb, stdin) != EOF) {
> +		if (bundle_uri_parse_line(&list, sb.buf) < 0)
> +			err = error("bad line: '%s'", sb.buf);
> +	}

The command to write such a test is useful for people who
want to experiment about the feature, Thanks. On top of that,
I have a little question about the condition:

  if (bundle_uri_parse_line(&list, sb.buf) < 0)

"bundle_uri_parse_line" will call "bundle_list_update" inside, and
could get the result of it as "bundle_uri_parse_line"'s return, then
actually "bundle_list_update" could return "1", so I'm not sure but maybe
the line could modified to:

  if (bundle_uri_parse_line(&list, sb.buf))

at here.

Thanks.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C33D61F406
	for <e@80x24.org>; Sat,  6 Jan 2018 23:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752864AbeAFXdh (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 18:33:37 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:35605 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752613AbeAFXdg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 18:33:36 -0500
Received: by mail-it0-f53.google.com with SMTP id f143so5594093itb.0
        for <git@vger.kernel.org>; Sat, 06 Jan 2018 15:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=e7Ye8g0NlrPW/aE+vAN+V5QHpe6IVJOp1pH7KZzWTcM=;
        b=av4o4y4kcM0Hi6Zu7/DfojoFnImfJjyHgejbGUuifDj4e82DsLU/QlcgTh3i9l8Jk8
         gYj80dvZ/V7rB8qXrgVsBzAUh+e/Bxy4vZ4NVQX43peePCyoAUVfLhhrWLIZiI+ZLrp1
         ISxkq/NiUWTqCIN9s+AsDJrmfi0DWzsYkCIzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=e7Ye8g0NlrPW/aE+vAN+V5QHpe6IVJOp1pH7KZzWTcM=;
        b=j+P6+ccR43oHYkDo04r0kWsV1ry0YTjONr8qlQA9a+pJFt24IMnm13yEceicr7590d
         +8hJo2g9clNe2LLg/MQjQfHmAaPrgayIUebpu9fA9UAKFuqwqfHM8OGQsmHY4SJt5Wmy
         J8ZG17x14/8E0kT4fDHwqbyZ5E+VbsdUIqH9GHN9TF2cRHsSIdNAhTP6UgSKvRGQffhN
         Ppho7KuY3iW3GOw8IaTjbmf5JQFl+kLwS+kaaD7PZEYrEzp4eopZSiUxVCUIpQHbQQcM
         mvnMIYbDdlQxYuW8mTBYByl0lnRsUJEffgenoASOWPcXj6tHH4MVO6IGl+R0PAeq6sEh
         8lAg==
X-Gm-Message-State: AKGB3mLV+6LhagTP/9h9vm5Cj4SPEH3bF27sc7edySq9QS59IV4m/wXs
        kSDAL/nXt0ev1pHTubB5oc9lbq5e1ywSxC/mirorH9uw
X-Google-Smtp-Source: ACJfBotPe2CmlYkA9UqPMSXYaNT5wf/RL7sLeG+Gv6hGi7ip6CnqG4lwEilLT8nHxMj9q4hREMck5pKpUKt4rYc9YEc=
X-Received: by 10.36.93.20 with SMTP id w20mr48390ita.101.1515281615708; Sat,
 06 Jan 2018 15:33:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.145.7 with HTTP; Sat, 6 Jan 2018 15:33:35 -0800 (PST)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
Date:   Sun, 7 Jan 2018 00:33:35 +0100
Message-ID: <CAKwiHFj9n8sWcfcie6Qm6pFe4L4u9VL1gv5ZVbnXt_E_Dne7dg@mail.gmail.com>
Subject: Documentation for update-index
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The man page for update-index says

       -q
           Quiet. If --refresh finds that the index needs an update,
the default behavior is to error out. This
           option makes git update-index continue anyway.

       --ignore-submodules
           Do not try to update submodules. This option is only
respected when passed before --refresh.


However, it seems that the "This option is only respected when passed
before --refresh." also applies to -q (and --unmerged); at least I get
different results from

  git update-index -q --refresh
  git update-index --refresh -q

From the documentation, that doesn't seem to be intentional, but the
code in update-index.c seems to handle -q, --ignore-submodules,
--ignore-missing and --unmerged the same way.

Rasmus

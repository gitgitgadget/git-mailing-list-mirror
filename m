Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E86391F424
	for <e@80x24.org>; Fri,  6 Apr 2018 06:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeDFGaO (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 02:30:14 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44244 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbeDFGaN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 02:30:13 -0400
Received: by mail-pl0-f68.google.com with SMTP id b6-v6so59120pla.11
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 23:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CSo92zdi45hJfkZkBZtweBI57jKzMPI/BtUUMJZ00k8=;
        b=T0wb72/m+R7dqwZiGvIMcEcN/IUkelEk/OEJbUYnY4/RgO3Q4Sln9pNyZV5jK6/Yxu
         zWiBRpLJyL0/MauPKhfytAjpQ34HqkGlarDssJHK2hU/4fQAD9AdOjA164n8fhGf5RlZ
         pGGZ9f7lvQ0ISGvdifbA67vFVBTnEryX4Nu23H5sSJGnuKR5spwOPDqXH0OGFOCuiBWz
         1u29N3cerUo4MCV9v9vAOTav/MgnYrfipmRzRM+xjCtxsgs6sgE5Y8njDMs0wi4wu7vd
         70svgBWgXDq5bNbN4Bny6+CBbK9xRqm1NcLgnIU6pqSqIZdduCzskBvYX8whWURmqLaq
         qlrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CSo92zdi45hJfkZkBZtweBI57jKzMPI/BtUUMJZ00k8=;
        b=CBSQa0eMcdkMsivroTgmoeOV/TXs68nbf05M0wrBIHihehdW6ZFz7+pMF0R6rnHjJr
         EZ4xX9LOUZWSIWtofcTZn6YYug5pYx4314T5WJG0rdp7QK7eeBHNiDJX89O4nYJMDmJb
         59ZWAz6Rs9nDABqR1VBmnjCJGO5DByz+gWk2Ihdh6422rP/pfyPf6D8zHvAT6Dxv+HId
         XQxovC9hxNHoUkDTHtvpH0ss7DD4so6ehuDeAPnkwBdo1x/Un8366pZGc2Tnpy2pl4dS
         NvEZAPby5FmDKeKWjzCP4w5Jrcq9CyY40qSE9I0aUnfpYn3QuQVIoX8osuczvmkugqkI
         Fu2Q==
X-Gm-Message-State: AElRT7GjIAYEToE3wHnWJwHB9hj1S6NlZIaNI15KEybLOSqQAoTSqdZF
        rUVa4tOk4k5cvTDYESA83RWiM5UuL6w=
X-Google-Smtp-Source: AIpwx49ty5fK1XdesWbOKCXAJ6G4HjLpzC+a5WQayAGU+8absH9JP2GJpG50LGd+BuKeIrOgN5pF7g==
X-Received: by 2002:a17:902:ba81:: with SMTP id k1-v6mr26302030pls.170.1522996211849;
        Thu, 05 Apr 2018 23:30:11 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:3d01:699f:f606:da49])
        by smtp.gmail.com with ESMTPSA id x4sm18679013pfb.46.2018.04.05.23.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Apr 2018 23:30:10 -0700 (PDT)
Date:   Thu, 5 Apr 2018 23:30:09 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, sunshine@sunshineco.com, gitster@pobox.com
Subject: [PATCH v5 0/3] builtin/config: introduce `--default`
Message-ID: <20180406063009.GA662@syl.local>
References: <20180306021729.45813-1-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306021729.45813-1-me@ttaylorr.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is the fifth re-roll of my series to add "--default" and
"--type=color" to "git config" in order to introduce a consistency
between type-specifiers and the historic "--get-color".

I have changed the following since the last series:

  - Replace exit() with die() in the case where the given "--default"
    cannot be parsed. (cc: Peff).

  - Fixed incorrectly calling "git config" in t1310. (cc: Peff).

  - Correct typesetting in Documentation (cc: Eric).

  - Perform guard checking in a negative context (cc: Eric & Peff).

  - Add notes to Documentation stating when we do and do not sanitize
    values into a ".gitconfig". (cc: Peff).

  - Remove a hunk left over during rebasing (cc: Peff).

  - Replace one last outdated reference to "--color" (cc: Peff).

Thanks as always for your review :-).


Thanks,
Taylor

Taylor Blau (3):
  builtin/config: introduce `--default`
  config.c: introduce 'git_config_color' to parse ANSI colors
  builtin/config: introduce `color` type specifier

 Documentation/git-config.txt | 11 ++++++++++
 builtin/config.c             | 41 ++++++++++++++++++++++++++++++++++++
 config.c                     | 10 +++++++++
 config.h                     |  1 +
 t/t1300-repo-config.sh       | 30 ++++++++++++++++++++++++++
 t/t1310-config-default.sh    | 38 +++++++++++++++++++++++++++++++++
 6 files changed, 131 insertions(+)
 create mode 100755 t/t1310-config-default.sh

--
2.17.0

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB11D20281
	for <e@80x24.org>; Sat, 30 Sep 2017 06:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbdI3GWs (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 02:22:48 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:51137 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbdI3GWr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 02:22:47 -0400
Received: by mail-pg0-f50.google.com with SMTP id p5so819315pgn.7
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 23:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=baQES85LTl11SUnYq06Z4UrX82XYXOiQ6zD5tW6ceDE=;
        b=K5apWFAGvenyPKX9GSOWwb//YwKNRY2XwKPOQETUGtHe8pX7ZSvXy/ND1VZqx0ZBZo
         nl1sZRZbIL35erpd8QinCscHXDyqdmV/apZbvCMPoRkERUAXXsKHpwgizOqOt0OhxUuq
         jV6561qf1U25DLCm2njUGrR9x1qRNSl1oWBTK+ax7Q9glZEE+M9TqTBwA9CHSNVB55KW
         nLS4wQ++aHYm/nM+zGkt018mfbem8O45L3KcPJEntf+Azy90N55KFR7qc2/HdR6qCPFr
         57dFp68mkYfZiVWbMl4jCpr5Uo3dWU2YgSjb+dAna5P2ENbgkfSG8diBCQy9f3cNOaRi
         Ij8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=baQES85LTl11SUnYq06Z4UrX82XYXOiQ6zD5tW6ceDE=;
        b=rAB0m/buESuVccGpWt/cKnRvR/2IYYh3Id4CxDiEj68sDi/cUYS4eoxAeOEdjOwACA
         TbDq28jjkz3KVjFJirAqEfJzczCIwB+iAkbrd1URFQAh2bAvIRVXYVkJz9/Hp5fxeRf+
         WFbPuRYzhkeVCwWbSV6lFEGKlbt4MjNUMRHvDt7MvpO8dFZ9AUficZzHvYSriWll+mr/
         EvT7T9lfvSLdy2tPCB15BYnQwgSE4caPJgTSvvN0GMqsGYprcsqbjDS6dNX+x37uxizZ
         6dH+D4ubFsVkNNMswQAAKnomBGyoTWZLm4GYd0JmFYw7WozViRbEbQByTDShSFlx08PO
         netQ==
X-Gm-Message-State: AHPjjUjxFptHzfu9h6JwoCcNX4N5Um8UetyZAve5E48D0NYxddkkDbdP
        Fe/RhlHD8b6+kY5/hRrB2+j7a36Xwug=
X-Google-Smtp-Source: AOwi7QB1MMLI3XKl0Ydw3KEwD45vIHVzoOKYHtrxUW8xx7JY7AU1OJ1EEML+QuxWK5xTRc6zG/zJpQ==
X-Received: by 10.99.99.197 with SMTP id x188mr7702530pgb.90.1506752566493;
        Fri, 29 Sep 2017 23:22:46 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id 69sm704676pfl.5.2017.09.29.23.22.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Sep 2017 23:22:45 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 0/5] Support %(trailers) arguments in for-each-ref(1)
Date:   Fri, 29 Sep 2017 23:22:33 -0700
Message-Id: <20170930062238.87077-1-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is a patch to extend Peff's recent work of adding parsing options to
"--pretty=%(trailers)" by supporting those same options in git-for-each-ref(1).

In summary, this patch adds correct behavior for the following options, when
given to git-for-each-ref(1):

  * --format="%(trailers:only)"

  * --format="%(trailers:unfold,unfold)"

  * --format="%(contents:trailers:only)"

  * --format="%(contents:trailers:unfold,unfold)"

I have changed the syntax for specifying multiple sub-arguments in
%(contents:trailers) and %(trailers) atoms to be ","-delimited instead of
%":"-delimited. This is consistent with similar atoms, and is described in
%greater detail in "pretty.c: delimit "%(trailers)" arguments with ","".

I am also new around here: this is my first patch that I am sending to the
mailing list, so this process is entirely new to me. My current focus is helping
maintain Git LFS [1] at GitHub. If I have made any mistakes in formatting these
patches or sending them, please let me know :-).

Thank you in advance.

--
- Taylor

[1]: https://git-lfs.github.com

Taylor Blau (5):
  pretty.c: delimit "%(trailers)" arguments with ","
  t6300: refactor %(trailers) tests
  ref-filter.c: add trailer options to used_atom
  ref-filter.c: use trailer_opts to format trailers
  ref-filter.c: parse trailers arguments with %(contents) atom

 Documentation/git-for-each-ref.txt |  7 ++-
 pretty.c                           | 13 +++---
 ref-filter.c                       | 38 +++++++++++-----
 t/t4205-log-pretty-formats.sh      |  4 +-
 t/t6300-for-each-ref.sh            | 88 +++++++++++++++++++++++++++++++++++++-
 5 files changed, 129 insertions(+), 21 deletions(-)

--
2.14.1.145.gb3622a4ee


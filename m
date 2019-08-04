Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A2361F731
	for <e@80x24.org>; Sun,  4 Aug 2019 21:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfHDVPe (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Aug 2019 17:15:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37007 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfHDVPe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Aug 2019 17:15:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so38523302pfa.4
        for <git@vger.kernel.org>; Sun, 04 Aug 2019 14:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nsvLJkhzZourv4Yrn2BjUScX9fxqb8K5aONPUNUQhlw=;
        b=VNW5/uD+jTv33KBMJRji0LMqWTrT2dd3Td1PXiSEqfDsJyo/nPc6AGWecp/4Zami2p
         nL1VJ1h7yr6TdNvNjk8Sd0zUtmvDptf/eTXKGQ/KUisY3Io2ZD/++E/Y60fXo/WW3m4b
         Y+4eixJ/oobB3lieD2F19WRjIwdvAa3AbCtciC+RsGFJboeORA1CldAwBS+7V3L8Igvc
         1yCRbqdFPgWn/HxUrFm5y1yDd1HRFk2Gy26QHMR/UYU2CMTJYrM5tKnfweoq8aeVhN/c
         MAF7hgYeiPg1SeMLHWuBUfErGGx2swhxU6UC1SQE6iQkd+eNsCfh8xV4gUZohd1OSTit
         5I2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nsvLJkhzZourv4Yrn2BjUScX9fxqb8K5aONPUNUQhlw=;
        b=YmTgU75F1uxfCTF0UrysXuOQEn6TfI2T9MeVDIViz4m9urfo+XcsF4DM5M+mK3u/S6
         QtXeaC9DROq6cqA7a9i2r2o1RR91JIhdiyrucO+4VEXOcnU5Xy+PYfnBsb/OHJpx5w8i
         AC16Zs4V04SwGNc6dlenHyYe8Ef9K4zHZnzYQkdedCwfJWZuJHYyUHqXv3I1JWTMYE3O
         gY4KlIICeNVesDBZTTvriKOyL4B6CNApyISuyvwNfb0j1xs3blLVo7KnyftbfqPLJPg7
         bDDowMrIRfCXIeP5G7A+gDctQD1HKDZu4t0/Fq+bMQpttVZnrco+E/aik+VQL4o/DfBu
         hdgQ==
X-Gm-Message-State: APjAAAX51kvstiaw5fR2BxgpV0sXfX2vVphGiPoT8xytFDaV5bcUH7sf
        l7JpgkuPI1vveYUTOchUvEXLsASdbhPdHg==
X-Google-Smtp-Source: APXvYqyd/BigPK1RW/v4WWPcuO2Nrcn3wCga1lF59VmqwWm5UNBcUqEerskbkdaMHDIzl8SxkP9XoA==
X-Received: by 2002:a17:90a:1c1:: with SMTP id 1mr15012511pjd.72.1564953333091;
        Sun, 04 Aug 2019 14:15:33 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id o130sm139031138pfg.171.2019.08.04.14.15.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Aug 2019 14:15:32 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     frekui@gmail.com, michael.osipov@siemens.com,
        ibrahim.vanak@hpe.com, matheus.bernardino@usp.br,
        vleschuk@accesssoftek.com
Subject: [RFC PATCH 0/2] grep: make threading smarter
Date:   Sun,  4 Aug 2019 14:15:07 -0700
Message-Id: <20190804211509.39229-1-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

833e3df171 (pack-objects: Add runtime detection of online CPU's, 2008-02-22)
added the capability to check the number of online CPUs at runtime to do
better threading, so use that as well with grep.

Testing with a large (more than 4) number of cores and no grep.threads
configuration in real hardware encouraged, to confirm that no other
bottleneck is preventing the additional threads to improve performance.

If platform specific testing shows degradation (specially with HP-UX),
make sure that the right number of CPUs is reported by :

  $ ./t/helper/test-tool online-cpus
  4

There are additional cleanups possible in the grep code but had left it
out of this RFC to avoid confusion and make the change in patch 2 as
straight forward as possible.

There is also a chance that the online_cpus() function will be updated
as it predates POSIX and might be associated with one known performance
issue in HP-UX[1]

Lastly the performance numbers point to deficiencies in kwset and the
compat/regex code that will need to be addressed independently.

Carlo Marcelo Arenas Belón (2):
  p7810: add more grep performance relevant cases
  grep: make default number of threads reflect runtime

 Documentation/git-grep.txt |  2 +-
 builtin/grep.c             |  3 +--
 t/perf/p7810-grep.sh       | 25 +++++++++++++++++++++++--
 3 files changed, 25 insertions(+), 5 deletions(-)

[1] https://public-inbox.org/git/TU4PR8401MB121664A8A588D799803F1E84E11E0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM/
-- 
2.23.0.rc1

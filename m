Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DC8C433DF
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 23:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C23032065C
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 23:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="nYn13Csv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgHOX3e (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 19:29:34 -0400
Received: from aibo.runbox.com ([91.220.196.211]:46734 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728749AbgHOX3c (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 19:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
         s=selector2; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Subject:From:To; bh=hrEB9PVSixB267Mv0nRpvajpGqs7C3jCT5d5AxIgTfc=;
         b=nYn13CsvAmMm7e/mj9C1xiGHkqseu9DnR3bi+fPjb5ObLimLsOVEVoeXorO0AwS9dmVZ/d3L7F
        3AcIrSeq9Rrs/EopA3Ki0sjLyHD48ik44cxARpsAil2MUUkVqJWMakHQsp7DM+Fue5xsZWgWNwMBI
        8SK9RInRfYqjeRAjhI0hmxd95CqVDJP3MGkozZBsAL3ulyi3yC3Dt6xxqZlQTUfBkauh+iTTLRAZM
        uL1hwSbR4myBgEyluR1+FY17Z7rX6Ne9Sho7LhvNcSi7XYxySxWnqVrXBRsmNXPd4Bpvi8JMn/cxN
        bIlS96uPKDsJCNTzKrRbF1mjxN7bLMeelpbnQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <zuiqxejp@runbox.com>)
        id 1k6tYa-0004Iu-Hg
        for git@vger.kernel.org; Sat, 15 Aug 2020 12:37:00 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated alias (863317)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1k6tYN-0008Jj-Mp
        for git@vger.kernel.org; Sat, 15 Aug 2020 12:36:48 +0200
To:     git@vger.kernel.org
From:   Lexis <zuiqxejp@runbox.com>
Subject: Bug report: Same path printed twice when comparing two directories
 outside repo
Message-ID: <3f6ada7b-5de9-e69f-3b45-3b529862183e@runbox.com>
Date:   Sat, 15 Aug 2020 12:36:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

# Bug report: Same path printed twice when comparing two directories
outside repo

## Repro steps

```sh
#!/bin/bash
cd $(mktemp -d)
mkdir dir0
mkdir dir1
touch dir1/test
git diff --no-index dir0 dir1
```

## Expected output

diff --git a/dir0/test b/dir1/test

new file mode 100644

index 0000000..e69de29


## Actual output

diff --git a/dir1/test b/dir1/test

new file mode 100644

index 0000000..e69de29


## Difference between expected and actual output

The first output line shows the path to the compared file in the second
directory twice in the actual output. I expected it to print one path
for each directory.

[System Info]
git Version:
git version 2.28.0.297.g1956fa8f8d
cpu: x86_64
built from commit: 1956fa8f8d7168157346f0cbc0f1f9dd1fca787a
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.7.14-200.fc32.x86_64 #1 SMP Fri Aug 7 23:16:37 UTC 2020
x86_64
Compiler Info: gnuc: 10.2
libc Info: glibc: 2.31
$SHELL (typically, interactive shell): /usr/bin/zsh

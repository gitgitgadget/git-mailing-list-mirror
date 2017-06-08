Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53F901FAE5
	for <e@80x24.org>; Thu,  8 Jun 2017 12:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751092AbdFHMpx (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 08:45:53 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:35024 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750788AbdFHMpw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 08:45:52 -0400
Received: by mail-wr0-f171.google.com with SMTP id q97so18101641wrb.2
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 05:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=BgMw8kZ4WDBkO2Z+kpp1hIFGmWaQwuktiPPF/LY7BC0=;
        b=p/gD0KE27P8UTw+7q/F3r8q90wOOzcVKUTlcK5IZntM3sDfZJhJ52j92QkfJ1EX1rl
         l/fTsn2LPevkpCEgtQbE08yM3tlIaFIPQ2EBdEVET7YCesMua/2M2SyEB/ABpWoWJgVd
         iR61fDiKa74PCAE4pI14iDyhj56UQtgYNifo3ur+fVTf7ejco3nGSBSFy47e6wkA/n4f
         mbYu+n1+17jGeMbMlnttdpvbU29aqRLET1nrq2b9Cx+5VImracG8F3McEBO/nDdvVvg+
         OAsE+Y61GsbzeWl2vkEhJEkm/V9dQTFoJS9M5Yorj7zk+rjZlj+vJvH0zWr+i/xpx17T
         HugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=BgMw8kZ4WDBkO2Z+kpp1hIFGmWaQwuktiPPF/LY7BC0=;
        b=XnYrKgb8Ft2eVDMKdGEIcjNVsd9BZfxpSNOkS0HysCB1hhFfOE4ek9Of9VmkYIpeez
         fyU8L29L6FIf7NVy5TdknqilIV+L0aINxWZN4lpiDq+IZS2nO90xRI0eLlkvjQmUxAoM
         pucdXmTY9a5V4oTyTu75oHeUCV0B2uD0qOJU/C/Zv0iENjLogiFpNBBfl6dY1qaSJitB
         eJU6KJj7wtLTbRNBEUZS00Z+UyJGK3WFbDChzjd8E3sd1FsDy/qMtRHpgUHKc0GSZ3NN
         o+IRUnwni2u4bTqorgh2yQ+tE8EK5FMKndu7lriK5AKZiXXvj9xNQRzwBKIJODObdVGw
         J2RQ==
X-Gm-Message-State: AODbwcDj7m/jZjmAfs2RHPoioufbFDqDL87uPCBpHTejV7SxQ3uIYddW
        5OYoxoFAQBkpYgYP6os=
X-Received: by 10.223.139.30 with SMTP id n30mr19704146wra.105.1496925950874;
        Thu, 08 Jun 2017 05:45:50 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id p187sm7377246wmd.20.2017.06.08.05.45.49
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 05:45:50 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: "There are too many unreachable loose objects" - why don't we run 'git prune' automatically?
Message-Id: <9C2F2EA2-0C59-4EA2-8C8E-10228FB82D90@gmail.com>
Date:   Thu, 8 Jun 2017 14:45:48 +0200
To:     Git Mailing List <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I recently ran into "There are too many unreachable loose objects; run 
'git prune' to remove them." after a "Auto packing the repository in 
background for optimum performance." message.

This was introduced with a087cc9 "git-gc --auto: protect ourselves from 
accumulated cruft" but I don't understand the commit message really.

Why don't we call 'git prune' automatically? I though Git would prune
unreachable objects after 90 days by default anyways. Is the warning 
about unreachable objects that are not yet 90 days old?

Thanks,
Lars

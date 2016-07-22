Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95DDB203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 15:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbcGVPtM (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 11:49:12 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35971 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbcGVPtL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 11:49:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id x83so6675904wma.3
        for <git@vger.kernel.org>; Fri, 22 Jul 2016 08:49:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=LijrAQyd3wOM4s5t+xPDWP9io5hSyyi4ySFqb88qx9U=;
        b=qqjhHYvNVLmyKkYTyz80Uy9udcYgrzmbE+78xVEjgEWKHDBVJ0HZqPmL7hPll2shih
         mjYH1ax0MKmzitiXjICEPKHgH20rXbygOZY64hlDv8lqX98rcxi9lJi7xQOpV+nk4vRf
         dHF4/tl8YQyBLtlqqRv8V4+Du8soSGph8ggvnNBGZVXV6urRFErdOuYhfV3UxM6F+weF
         JKK+t7qw6SZFSX3kYPym2eLvPvPDVL1sB6ke5fW4uzRTWoHshRJG7EsBO4NLADHAgzX4
         5h/CUpvpGEtbJjoy0MMuYQmrf0bJHcQVOGwzyY+UqFOhkqxHlQ2OLzLMdOIedxeq1P/i
         lqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LijrAQyd3wOM4s5t+xPDWP9io5hSyyi4ySFqb88qx9U=;
        b=NlHTDxwEkbiRPlVJ5Rc3FlZxk4e5haVYuie+NVf/Lpr+xFtOpLpRqMts8a5wOeHXOT
         oYZXDRsJjw+s1WdyeLF55KxW7zGbogYx0Az8SI9+3Wzq70UAY9VV5yYW1GzgB5RJeDN6
         zKMqUZxs3x+sSWFpD7FNAedfpghEut9UOm+/Ph62/2qnVPpjgyd2f+1HnS5uryaoYGMX
         ULsuTpAlQWwZmQ3b2wu6AP3kjFtGDmTF3CegjeM51DlJk9mhrF+zfjVz8HqxuC3X9/iU
         j3erwTxAlOc0cRiYiVh7r9ZGGLlTHHMuZZL9X6ZDdsX2BFl38giZafLcIchVjvfuFF9z
         E3VQ==
X-Gm-Message-State: AEkoouvue2yCY4G/65cO6QRLxIPCWR0M0fh3tPgo4uBCp+m/cepCIjtFFFZm/IP6L6og2w==
X-Received: by 10.195.18.170 with SMTP id gn10mr1595030wjd.46.1469202549410;
        Fri, 22 Jul 2016 08:49:09 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id e10sm1507963wjc.21.2016.07.22.08.49.07
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 22 Jul 2016 08:49:08 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	peff@peff.net, jnareb@gmail.com, tboegi@web.de,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1 0/3] Git filter protocol
Date:	Fri, 22 Jul 2016 17:48:57 +0200
Message-Id: <20160722154900.19477-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

Git's clean/smudge mechanism invokes an external filter process for every
single blob that is affected by a filter. If Git filters a lot of blobs
then the startup time of the external filter processes can become a
significant part of the overall Git execution time. This patch series
addresses this problem.

The first two patches are cleanup patches which are not really necessary
for the feature. The third patch is the relevant one :-)

You will notice that I do not check the exact number of "clean" filter
invocations in the tests. The reason is that Git calls "clean" multiple
times (up to 4 times for the same blob!). I posted a patch to demonstrate
the problem and I would prefer to tackle the problem in a seperate patch
series: http://thread.gmane.org/gmane.comp.version-control.git/300028/

The main reason for this Git core patch is to speed up Git large file
extensions such as git-annex or Git LFS. I proposed an according Git LFS
patch here: https://github.com/github/git-lfs/pull/1382

In addition to the Git core tests, all Git LFS integration tests run clean
on my machine.

Thanks,
Lars


Lars Schneider (3):
  convert: quote filter names in error messages
  convert: modernize tests
  convert: add filter.<driver>.useProtocol option

 Documentation/gitattributes.txt |  41 ++++++-
 convert.c                       | 222 +++++++++++++++++++++++++++++++++++---
 t/t0021-conversion.sh           | 232 ++++++++++++++++++++++++++++++++++------
 t/t0021/rot13.pl                |  80 ++++++++++++++
 4 files changed, 531 insertions(+), 44 deletions(-)
 create mode 100755 t/t0021/rot13.pl

--
2.9.0


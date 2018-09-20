Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1914B1F453
	for <e@80x24.org>; Thu, 20 Sep 2018 18:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387877AbeITXsu (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 19:48:50 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36065 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732340AbeITXst (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 19:48:49 -0400
Received: by mail-io1-f66.google.com with SMTP id q5-v6so8686105iop.3
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 11:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4ujOaFhN4OyYhvIrAGJUguI9KfBLVDSPDGTAn9QRgU8=;
        b=iOCRShiUEa++heay5PjIn8qdfgPip8vKcD4qZtwtzY5mLwT3fONM8zHV1vHsR2uJ5l
         w8J57yvIKN11GP0Mtqo8UNOecLutW7RWtCsDUI+MrPQU244TFYlS3MmluWmmqnBrq0iP
         axelO1VR4FFyZ/A1Lgwz0YvhsCmSR7vxCp6uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4ujOaFhN4OyYhvIrAGJUguI9KfBLVDSPDGTAn9QRgU8=;
        b=G/cAPRcpoGNG8GcM59H+JPBAuHpQRdg+UaSC6h9HDx2grcZ8esbafmmoG6lD5+o+py
         8dKfE7LpCHe5eM/ucAa7/Fh5SPXmpH1niX/Vqv4C0DumClrNTnn9YBrsTlSdQHn5QM69
         gSHpeNovDlFQHKwHtZWKeAxGu93MV9mT2aApMm+1Xi3MWlFHd1R4+4vJLkAwBSVeYMP/
         oc4EOrJm8/ekN5fOeo5IQV2X1x/FarM6HmU46bHmX6y0tvR/+RnuivmUSF4km7qH8MKI
         Mp95RuBHOBENnuNf8FYVCgdO67BJ6jCVfK8XbrNKDB3RyDn2gfVoQ2JW7c5E46zt8s77
         86rg==
X-Gm-Message-State: APzg51DrX/DdNFIaLexmvNiGY8psjfvgPJsbuygRmND8BWlPHlDdxOy4
        w9zQOsQ4wQacCyLdNbiNT94xpaODn2GqwSVkFQp3tFe0LS9hgb7MlwDqiiMw7y0HZVSpZLUoE7F
        dwOD3iXAZGpUttAW4bHZIWoqTorSWXmZVRfpMg17LRgQ2s5+EqeM0nS18iWC4oA==
X-Google-Smtp-Source: ANB0Vda+2n84ap6m5oCLnoeFpDH7gAVo/Iptw4C8phaMN8VFO72EFNzHCo7EQsISP0XgmAAQaiILYA==
X-Received: by 2002:a02:910d:: with SMTP id a13-v6mr38033481jag.14.1537466647974;
        Thu, 20 Sep 2018 11:04:07 -0700 (PDT)
Received: from localhost ([173.225.52.219])
        by smtp.gmail.com with ESMTPSA id c3-v6sm1166883itd.8.2018.09.20.11.04.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 11:04:06 -0700 (PDT)
From:   Taylor Blau <ttaylorr@github.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date:   Thu, 20 Sep 2018 14:04:05 -0400
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH 0/3] Filter alternate references
Message-ID: <cover.1537466087.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This is a series to customize Git's behavior when listing references
from an alternate repository. It is motivated by the following example:

Consider an upstream repository, a fork of it, and a local copy of that
fork. Ideally, running "git pull upstream" from the local copy followed
by a "git push fork" should be a lightweight operation, ideally because
the fork already "knows" about the new objects introduced upstream.

Today, we do this by means of the special ".have" references advertised
by 'git receive-pack'. This special part of the advertisement is
designed to tell the pusher about tips that it might want to know about,
to avoid sending them again.

This optimization is a good one and works well, particularly when the
upstream repository has a relatively normal number of references. When
the upstream has a pathologically _large_ number of references, the
advertisement alone can be so time consuming, that it's faster to send
redundant objects to the fork.

To make the reference advertisement manageable even with a large number
of references, let's allow the fork to select which ones it thinks might
be "interesting", and only advertise those. This makes the advertisement
much smaller, and lets us take advantage of the ".have" references, even
when the upstream contains more references than we're advertising.

This series implements the above functionality by means of
"core.alternateRefsCommand", and "core.alternateRefsPrefixes", either a
command to run in place of "git for-each-ref", or arguments to be
appended to "git for-each-ref".

The order of precedence when listing references from an alternate is as
follows:

  1. If the fork configures "core.alternateRefsCommand", run that.

  2. If the fork configures "core.alternateRefsPrefixes", run 'git
     for-each-ref', limiting results to references that have any of the
     given values as a prefix.

  3. Otherwise, run 'git for-each-ref' in the alternate.

In a previous version of this series, I taught the configuration
property to the alternate, as in "these are the references that _I_
think _you_ will find interesting," rather than the other way around. I
ultimately decided on what is attached here so that the fork does not
have to trust the upstream to run arbitrary shell commands.

Thanks,
Taylor

Taylor Blau (3):
  transport.c: extract 'fill_alternate_refs_command'
  transport.c: introduce core.alternateRefsCommand
  transport.c: introduce core.alternateRefsPrefixes

 Documentation/config.txt | 12 +++++++++
 t/t5410-receive-pack.sh  | 58 ++++++++++++++++++++++++++++++++++++++++
 transport.c              | 34 ++++++++++++++++++-----
 3 files changed, 98 insertions(+), 6 deletions(-)
 create mode 100755 t/t5410-receive-pack.sh

--
2.19.0

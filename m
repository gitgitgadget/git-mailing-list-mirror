Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AED1E20705
	for <e@80x24.org>; Mon,  5 Sep 2016 21:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933235AbcIEVLQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 17:11:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36836 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933004AbcIEVLP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 17:11:15 -0400
Received: by mail-wm0-f65.google.com with SMTP id l65so7554060wmf.3
        for <git@vger.kernel.org>; Mon, 05 Sep 2016 14:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=YZb+5DrNEJuTLdYdveuGvChjMlimFMr3grfSDyqiD28=;
        b=ltR3qHySOhqiNhfV+r9PozivTxWMuAwjmsuhFf8HeGOkT1T7UszDS6J3VltBy+KQEj
         xuV7XUozlA/1egRkXsPn6l8QiXxwNdJvogj3hqCvP/gNk/ac8hsKV5jT78ZU7v6vX1AA
         h9o91mTwQUxUhVRfyPoax9UUvciYPz61NZP3zT0hmJYp8zNa+/vwJmqHt2VbS7UB/V35
         70MKVMSXFPqS0yv7rhsQi1oo+xCTWYrk0reI1C2ybX0LhvBGDRE+ast+OQ92TQRlpWXW
         8OUVEbGaQZwvIkS9eh53WtBmFHO4yaO3x8TD2fGzSvHtEkZDpBXPJIW+zUdwqMKICsS7
         FnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YZb+5DrNEJuTLdYdveuGvChjMlimFMr3grfSDyqiD28=;
        b=i3C97O0lAdvoYTNxQayWO7MiXHX3XiwEKISyGMsVIAaq/KOVjuS1jP0NHAsQx6dTWq
         FzVgNnQcntMm+C2Q/OZctxOxAW2rZOKaBPf7Aq6sSMSOE4xqPO8ga00/8afFdH8L1sfX
         4wqVdM6I0g31nAi5UyDSVIuIkLV0c5zzkCUC49JFyOTRDXrClh0jSydHjGERl5HA1LuJ
         A4EDOzq9IxaVz49Lg1F3ee860/yChZX15n/gcQC3IDJ40NZUk3sst5l1EHQdgTvkunu+
         wNxIxvbOSLmwKFD9WIJsIZG+DHG/mQEGkGjBMGlxakKX3T8bLeCM7bnTzYJCc09lQ4VC
         piDA==
X-Gm-Message-State: AE9vXwN/wybeTQfrNGUxq3H7/VpU1uEchELuHPGlKfsFz1dx6E4t9uK1UU4AaUci/hiplA==
X-Received: by 10.28.229.205 with SMTP id c196mr4161934wmh.35.1473109874112;
        Mon, 05 Sep 2016 14:11:14 -0700 (PDT)
Received: from far1pr3662.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id r4sm29555818wjs.13.2016.09.05.14.11.12
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 05 Sep 2016 14:11:13 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, Johannes.Schindelin@gmx.de,
        e@80x24.org, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1 0/2] Use CLOEXEC to avoid fd leaks
Date:   Mon,  5 Sep 2016 23:11:09 +0200
Message-Id: <20160905211111.72956-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Use the CLOEXEC flag similar to 05d1ed61 to fix leaked file descriptors.

Patch 1/2 was contemplated by Junio here:
http://public-inbox.org/git/xmqq37lnbbpk.fsf@gitster.mtv.corp.google.com/

I followed Torsten's advice and renamed `git_open_noatime` to
`git_open_noatime_cloexec`:
http://public-inbox.org/git/20160830145429.GA11221@tb-raspi/

Patch 2/2 was part of my "Git filter protocol" series:
http://public-inbox.org/git/20160825110752.31581-14-larsxschneider@gmail.com/
(I kept the patch as-is but changed the commit messages slightly)

Thanks,
Lars

Lars Schneider (2):
  sha1_file: open window into packfiles with CLOEXEC
  read-cache: make sure file handles are not inherited by child
    processes

 builtin/pack-objects.c |  2 +-
 cache.h                |  2 +-
 pack-bitmap.c          |  2 +-
 read-cache.c           |  2 +-
 sha1_file.c            | 14 +++++++-------
 5 files changed, 11 insertions(+), 11 deletions(-)

--
2.10.0


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 003981F461
	for <e@80x24.org>; Tue,  3 Sep 2019 15:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbfICPaO (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 11:30:14 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:42785 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfICPaO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 11:30:14 -0400
Received: by mail-oi1-f170.google.com with SMTP id o6so13058802oic.9
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 08:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daedalean.ai; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=HwbEeD4u/jNP3glJXNRim8h/vGC6ZYEAdEuoiBAlJ2M=;
        b=aB/SGGy/Szci8g5ZeQZysJNfgYNq/4vI29KWJ6wmN8sKI+AS7D28+RSb3v/TFyPKRn
         StdRfvGKAIwgoD1J1enOcEGYflFlfYA4vYixvxLCRAvh3tgeUIlhZlqwkzdVfW023mks
         ErJzW1SuRMIwvU74Qj2Dcis5HhKixbGMnDjKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=HwbEeD4u/jNP3glJXNRim8h/vGC6ZYEAdEuoiBAlJ2M=;
        b=fK72bwHsmzRJMlvkxXqNCOK8ugI+LgnVebD/RO536Gvovp4KYsTBh/NSIqBhQDdDc/
         4zcmre7fibFrbhA7CQxQV7v1ndWVPTENsxh7rjrJ57SvH89w6jcxE5kAo2cDfv6iyG49
         KcI1Q6MPt9mdzzpQwklXqTTUynJFkWuRtiQsysPXBEac0WPGYKSUAhaL6Qc3QjDmM94P
         F2QEUSPx9OnOJqGRpBJmsR7t9RCWWL0oUtLdVDvdTfKt4pClEbumIx8xjdzhWcrLYsAR
         djAtgR/uuoH0J6KdzT++dIl9g1VCbZSsMWt0H1U+EZwoeJyHjuW0ZMiKLMDxxa1V6a0E
         6WeQ==
X-Gm-Message-State: APjAAAUtSM8MIpATEs0dYptG0+WPOWhiq4Y/bqIs0xQKpBSC55OiVVYv
        8giZhkDDIID0IyEm5yT0aHW1ApUVyv6TCiFaC8qBkQiwJUT9+g==
X-Google-Smtp-Source: APXvYqy4sWeY7K2C2w7u1Ybl7zuguRaBYnd0p4x1bqnztgAWLVGWfzhGuv5EX0dDzd0PuugG5FsTjlbF0RBOTZvT7sM=
X-Received: by 2002:aca:1006:: with SMTP id 6mr477333oiq.72.1567524613160;
 Tue, 03 Sep 2019 08:30:13 -0700 (PDT)
MIME-Version: 1.0
From:   Grigory Yakushev <gy@daedalean.ai>
Date:   Tue, 3 Sep 2019 17:30:02 +0200
Message-ID: <CACfeHrrajM8_p0=N8ZPm9h7ObcvWT5EnVa-gLhtDODdG9GeyBw@mail.gmail.com>
Subject: Failure to fetch submodule with --depth=1 parameter
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$ git --version
git version 2.17.1

Repro:
$ git clone https://github.com/PX4/Firmware.git
$ cd Firmware
$ git submodule update --init --recursive --depth=1
...
error: Server does not allow request for unadvertised object
22df9475ca0d157e2db066a20f64c35906bf7f25
Fetched in submodule path 'Tools/sitl_gazebo', but it did not contain
22df9475ca0d157e2db066a20f64c35906bf7f25. Direct fetching of that
commit failed.

The same line without --depth=1 flag works fine:
$ git submodule update --init --recursive

Implication:
Docker uses the line with --depth=1, so it fails to build from remote
URLs. See https://github.com/docker/distribution/issues/2998

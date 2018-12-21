Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4F9C1F405
	for <e@80x24.org>; Fri, 21 Dec 2018 10:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389473AbeLUKgm (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 05:36:42 -0500
Received: from mail.aegee.org ([144.76.142.78]:38880 "EHLO mail.aegee.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732090AbeLUKgm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Dec 2018 05:36:42 -0500
X-Greylist: delayed 544 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Dec 2018 05:36:29 EST
Authentication-Results: mail.aegee.org/wBLARJxE032295; auth=pass (PLAIN) smtp.auth=didopalauzov
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aegee.org; s=k4096;
        t=1545388041; i=dkim+MSA-tls@aegee.org; r=y;
        bh=4o2Jurw4gWWba90eWRmecyg7NUW3eN9cAIUB7xGcXlM=;
        h=Subject:From:To:Date;
        b=QVZFDs/tBFg5B1pdgY4rmct5MQ8eqF3ea4A0Gr/kUj+6rqujaOT2jQCZAKmZfriKG
         meOWet5evuDFx5JChB3oQKxE3hC2ElFqCWIwCnhz/gXdPsdQGmjzXBD5qUUbHusfT+
         YvbTk6XpQO8BJ/ekzarIA/rGG+1rWi30cY8NTcH5yiO9qiRbx2kqLI/5w2Uo1zW+tn
         5yAOTIPtJkS9sYAd/Z5hFpgbyX0bXFLU9yuMhHdO0ZsuwliWoc9MPpBrUWHTR2P5Um
         hj02aYAvRM/J+8rtZ/MkG8rQB38QRJBLYd7kb3HU0R6Vs/wcLkuShF4txMe2QluD9F
         aUuUaOmXThpSFz0hKX6tAj5XzuhpAKoal56LFZ2cRUHwlICGmy7WElhiTTAvPNmmSv
         nVoWbooQmILDhqgbIoKqLR9lLavkx5T4G6J/hv9m6U9OXpKzWGNEhtDaq8Q90/eCqf
         gQTAXali8zcHUiotOmY2ulbFjzwLhBPADSlGCD1sBfuvrmejzlQKFDV2g8prIw5Wq8
         NY1V5W+3Vgr/ivKLQWh8hV3mLeQT0uO8bJ07UnXUVurokV5VvI8lm6Ekur4ZKxWh21
         LRssgHGOIMQkwqbjbMBpmFa+OyLdYezhP67LAIllSZPfxCX6gLQ7ehD1pdaib4dvDQ
         i0XwnjBmCETPJdHe+viLMKuM=
Authentication-Results: mail.aegee.org/wBLARJxE032295; dkim=none
Received: from Tylan (HSI-KBW-046-005-016-084.hsi8.kabel-badenwuerttemberg.de [46.5.16.84])
        (authenticated bits=0)
        by mail.aegee.org (8.15.2/8.15.2) with ESMTPSA id wBLARJxE032295
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Fri, 21 Dec 2018 10:27:21 GMT
Message-ID: <63142a981325e68cb6e90ebd485627e41321ecaa.camel@aegee.org>
Subject: Suppress reporting implicit git gc calls, when they
 =?UTF-8?Q?don=E2=80=99t?= do anything
From:   =?UTF-8?Q?=D0=94=D0=B8=D0=BB=D1=8F=D0=BD_?=
         =?UTF-8?Q?=D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2?= 
        <dilyan.palauzov@aegee.org>
To:     git@vger.kernel.org
Date:   Fri, 21 Dec 2018 10:27:19 +0000
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.31.4 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.101.0 at mail.aegee.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

With git 19.2.2 after `git pull` the output was
1. Autopacking the repository in background for optimal performance. 
See "git help gc" for manual housekeeping

2. error: Your local changes to the following files would be
overwritten by merge:
  …
Please commit your changes or stash them before you merge.
Aborting

This implies, that `git gc` runs in the background.

Then I called `git rebase --autostash` on which the output contained
again:

“Autopacking the repository in background for optimal performance.  See
"git help gc" for manual housekeeping.”

The second message means, that `git gc` is again started in the
background, before the first GC has finished.  Clearly non-sense.

In practice, the second GC does not run, or exits very fast.

* Alter `git rebase --autostash` not to write, that git gc is called,
when that GC doesn’t do anything.

Regards
  Дилян


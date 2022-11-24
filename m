Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0F4C4332F
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 09:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiKXJGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 04:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKXJFu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 04:05:50 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7F910EA37
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 01:05:49 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id z26so1124438pff.1
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 01:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKN9J/xxTtuNyAdUZM4+nR+STJyTVcO/6JItKhlSA1s=;
        b=POKOvVWAZN0MD22w8kDCTTKcMk+oYyXm1TO2zSug4KO71b+b7WdL+lpVsKqDUDR7sq
         Pm0WPccNIvitlSff702ZUyYme1kTlkCMuGNAM+Dxj0oO+yTglBJMS5QEFN1Uy8yz4lqE
         XABbPIORJqBE76x5QWDss/aHRaa9UjQBMqcfbsPLhXyF4/frDTrJPZuqwwxPWXTDXIG5
         mhJqF4iA6ditFg31w04wlkTXrX3oiERrJuW2LQ7MdyUFDBXcYqdQ+9f+VuAXyZ4DBaji
         Ujdr6lRXWBgHI5SF99mP6BU1JmkK43IHJI4d0+3t2rO3T1iBCEto3PAMfv2bY0t6VnAk
         ExWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKN9J/xxTtuNyAdUZM4+nR+STJyTVcO/6JItKhlSA1s=;
        b=bke/1+o/sP12CoN3S8tLcuj4FeAYyHElWmXw1PZqWQXY7AWMEM8cltsxXeYEZzfL/U
         OOu9PcAbAfiTUQrZoG297lwy9BRIYwP4xvTDBkFQTUX+Vl6cQH8VbrsSg3IPc2ghz8Er
         3wYHXQecsrFQx+H+EZysencLY5QApVK2p7vFPrJNKxLxCgp81SoXT0OZw8TzTsq858Xp
         MLj4pxz3iTRDUZKQ6BA7713Wt2H9vZ/IP5ytYfwHHbsPwGZPHgdzLcSU3kxGC5dNPhPF
         M6waHw2v1DR9YKZ9Tq4uhrRPK6TbMiMWx4FCe/C68hUdfw2XseAXmD3IkmpxziEv9c3J
         WSEw==
X-Gm-Message-State: ANoB5plLuhJLVzW1mdZeSOnxOwhloc2IfhrmcM4jBf6lQ3ZvQGYB3F0T
        CxlKG+lcdBUWKnBuqxiz/WHbCF+IoUg=
X-Google-Smtp-Source: AA0mqf7Ua4a2p7RlrL1PnNARSTKwl8Z91+9M0g5sJ1qDnrNE1eH8FetKrEndHdHUYOS7S2AeDkEJew==
X-Received: by 2002:a05:6a02:105:b0:477:8227:245b with SMTP id bg5-20020a056a02010500b004778227245bmr10980057pgb.510.1669280748854;
        Thu, 24 Nov 2022 01:05:48 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b001893dbd8963sm689356plg.239.2022.11.24.01.05.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Nov 2022 01:05:48 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 0/3] Fix broken CI on newer github-actions runner image
Date:   Thu, 24 Nov 2022 17:05:42 +0800
Message-Id: <20221124090545.4790-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20221123150233.13039-1-worldhello.net@gmail.com>
References: <20221123150233.13039-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

GitHub CI runner image "ubuntu-latest" will upgrade to "ubuntu-22.04"
soon, and the CI runner image of my private host repository has
already been upgraded.

Our CI will break on new runner image because there is not "gcc-8"
package in ubuntu-22.04. See log of CI#2:

 * https://github.com/jiangxin/git-ci-test/actions/runs/3537628107/jobs/5937769957

This issue is fixed in patch 1/3 by downgrade the version of the runner
image for jobs which need "gcc-8". But there are still some CI errors.
This is because p4/p4d version 16.2 cannot run on ubuntu-22.04. See this
log of CI#3:

 * https://github.com/jiangxin/git-ci-test/actions/runs/3537650146/jobs/5937813922

This issue is fixed in patch 2/3 by upgrade p4 and p4d. But all p4
related test cases failed becasue python was missing on ubuntu-22.04.
See the log of CI#4:

 * https://github.com/jiangxin/git-ci-test/actions/runs/3537695959/jobs/5937929695

This issue is fixed in patch 3/3 by install python2/python3 on ubutnu.

If install p4 version 22.2, will break several p4 related test cases,
see the log of CI#7:

 * https://github.com/jiangxin/git-ci-test/actions/runs/3538795233/jobs/5939989823

So we choose p4 21.2, and the final successful log of CI#8 is below:

 * https://github.com/jiangxin/git-ci-test/actions/runs/3538946849

--
Jiang Xin (3):
  github-actions: run gcc-8 on ubuntu-20.04 image
  ci: upgrade version of p4 to 21.2
  ci: install python on ubuntu

 .github/workflows/main.yml | 16 ++++++++++++----
 ci/install-dependencies.sh | 12 ++++++------
 ci/lib.sh                  | 10 ++++++----
 3 files changed, 24 insertions(+), 14 deletions(-)

-- 
2.39.0.rc0


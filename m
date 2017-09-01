Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2D581F4DD
	for <e@80x24.org>; Fri,  1 Sep 2017 18:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752685AbdIAS7f (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Sep 2017 14:59:35 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:34917 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752457AbdIAS7d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2017 14:59:33 -0400
Received: by mail-qt0-f177.google.com with SMTP id x36so4878917qtx.2
        for <git@vger.kernel.org>; Fri, 01 Sep 2017 11:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aerotech.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=Hdk8sW9fVLiE6om6a4TOyWX6VIDBxWV+0MqYnrFQHB4=;
        b=F3QbFluvHmt23KjmIqiBFjHIwLvjA2wtj+RibfCrBToQ5sc9XeR8somz2+7KHotyUn
         o9OuoGgDxr8N35+eyrA6YH+hQCd4tPk7TYAM+0TjsMoJxx8Lmq423jhuhYUD6Aa4blVL
         X+1aI3BfDpK2JK1T0Z1scofdp4Xet5WNuzNtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Hdk8sW9fVLiE6om6a4TOyWX6VIDBxWV+0MqYnrFQHB4=;
        b=m2m1zbfwmqW4Dri0kLOKgVIVVJXD9jov5k5VzIYPWHRIAiC1v9Sb5b2tVf/NL0V7Jz
         w4HAN+9HNkKz7LMK6t+lS+g5R4XFePHw7VIqxkRSJF+bGAqWHTJanY+Qy4rNYfezqJoc
         ONz8IcsWCTmkyrGmJ1/fj40hSBzvCesDRI1Bl9Z6ZhDWIvplFXbR0BFr5/cOnVAepRBr
         uZfxZrPuSxiRcf8y/Zu118PGF0lB/+zWisDt0msvO3g71kYZReuRkAcn+t7+NFTxDOa4
         3virDc6RAdkhTo3TLT1xD3DkSyo4Qj6xvioKPA39MgAWvZljaSIvFKjljB6210hzlPbC
         zTIA==
X-Gm-Message-State: AHPjjUgWO89ctOTa3LpHIWkjE4CaTpfuBrWDvqeYlQtYUOisavMqEEmK
        fPBCYKCy6RE33rilEGYp2j9h1DTW1wkylkjiyg==
X-Google-Smtp-Source: ADKCNb4WLxHUimgO3XCM31eug+E2WQWbgqAVM0Fqt/ak4bJf3TqgM7lIDzPB/YNR8+ZGVVzoNuDmZUOvbSvE/vn4MEE=
X-Received: by 10.237.62.113 with SMTP id m46mr302834qtf.11.1504292372408;
 Fri, 01 Sep 2017 11:59:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.147.205 with HTTP; Fri, 1 Sep 2017 11:58:52 -0700 (PDT)
From:   Ross Kabus <rkabus@aerotech.com>
Date:   Fri, 1 Sep 2017 14:58:52 -0400
Message-ID: <CAEVs+za9do_wXC12SSRznF9v9oGw3_Grq2EFDVf8nH1CRgM-Qw@mail.gmail.com>
Subject: [Bug] commit-tree shouldn't append an extra newline to commit messages
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

When doing git commit-tree to manually create a commit object, it can be seen
that the resulting commit's message has an extra appended newline (\n) that
was not present in the input for either argument -m or -F. This is both
undesirable and inconsistent with the git commit porcelain command.

In code this happens in the file "builtin\commit-tree.c" lines #80 and #105
(these lines numbers are the same for master, maint, and next branches). It
seems like the calls to "strbuf_complete_line()" should just be removed to
preserve the original input message exactly. As far as I can tell removing
this call doesn't have any unintended side-effects.

git version 2.13.1.windows.2

Thanks,
Ross

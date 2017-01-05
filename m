Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A16FD205C9
	for <e@80x24.org>; Thu,  5 Jan 2017 14:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161577AbdAEOZh (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jan 2017 09:25:37 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36778 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161573AbdAEOZg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2017 09:25:36 -0500
Received: by mail-lf0-f65.google.com with SMTP id j75so3748079lfe.3
        for <git@vger.kernel.org>; Thu, 05 Jan 2017 06:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=kZXtp269YbbRIit9PFy37JLJAxUFVTFX7BUZNgL+cOE=;
        b=If+jg7QleW8ClQfJ7BqhIqav1cXj7nfWijGNi7CEKAJzRBFd7XjgmAccMRFQmwGy5+
         TKQAzx5vZhBuGDaIAg2T9dOa6lNpYD07PTL/K/VvtHCuM/v/DJaLYRfOf6Sbnr+ls0oZ
         8HZcormOMmAetFb512TrErttKr+M5zT6mu5OLdu9kzgXyEHgNxIaNZ/AbXZhPe+x8nV3
         X3xZkdKiRXS6O56JzZwAbXjsnCMSWCIWC4qML5O3hC+e7kPW/+1hqV6MEP/jsk16Lhws
         18sSxoQ4gsnPOdrF1BOYA70GxIS4WkWS2JVwdhuv4SEowy/Rvxk9J+NGZhGls9fPtDXM
         TeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=kZXtp269YbbRIit9PFy37JLJAxUFVTFX7BUZNgL+cOE=;
        b=FN3v+qZu1wxcWv2zQG2EjFL6kr7OtiWjogfph8YqMR8pSmyBmbo2IzziWvP6qy/1TU
         WZRUzJ7rnBKGe1+7GqOYsaXJVwn4TmWgA1ShWg0wA2O5M0mDz1Tb0Rn0pbKJwwx21sKH
         MjbVq+TTHQS9KHK3jOB6v1hbHs683YwDgrs7vK3B1cGMJi7mjWffXgvMgp0V9g034SDx
         ZjMch1lw0VemA48UEJn6hAo7ZK4/Zdtg0CVbPU4GF6tdnObkqpn4W+wiqByFC+/WDOR1
         0Pk85MvmCh5HZ+jm4Xcdn6q+BgoYPRNy3udhdLUSvioNG2wCwvsnaZp51+J1gHQAXcT3
         nxGw==
X-Gm-Message-State: AIkVDXKlw84RpuKYqqyf+7LWrPHeMJXVxprI+I6KIaCnPZlfL8tKuJ7rt1qtRAraMXQ7Uw==
X-Received: by 10.25.67.12 with SMTP id q12mr26682289lfa.139.1483626333898;
        Thu, 05 Jan 2017 06:25:33 -0800 (PST)
Received: from aaberge.net (kramer.samfundet.no. [2001:67c:29f4::72])
        by smtp.gmail.com with ESMTPSA id s127sm18193293lja.31.2017.01.05.06.25.32
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jan 2017 06:25:33 -0800 (PST)
Date:   Thu, 5 Jan 2017 15:25:29 +0100
From:   Trygve Aaberge <trygveaa@gmail.com>
To:     git@vger.kernel.org
Subject: Regression: Ctrl-c from the pager in an alias exits it
Message-ID: <20170105142529.GA15009@aaberge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm experiencing an issue when using aliases for commands that open the pager.
When I press Ctrl-c from the pager, it exits. This does not happen when I
don't use an alias and did not happen before. It causes problems because
Ctrl-c is also used for other things, such as canceling a search that hasn't
completed.

To reproduce, create e.g. the alias `l = log` and run `git l`. Then press
Ctrl-c. The expected behavior is that nothing happens. The actual behavior is
that the pager exits.

I bisected the repo, and found that the commit 86d26f240 [0] introduced the
issue.

[0]: 86d26f240 (setup.c: re-fix d95138e (setup: set env $GIT_WORK_TREE
                when .. - 2015-12-20)

-- 
Trygve Aaberge

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B4661FBF4
	for <e@80x24.org>; Fri, 27 Oct 2017 23:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932513AbdJ0X1J (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 19:27:09 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:54801 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932385AbdJ0X1E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 19:27:04 -0400
Received: by mail-pg0-f67.google.com with SMTP id l24so6341920pgu.11
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 16:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=CRPG+vThFyqW4ZOdLgdpkfUC1dmEPvinlh78Yilsi4E=;
        b=BUABOw/+mdDTcxNBv1SkxYkBpRhhPUT5ITXB+3x9pBrbBufxBZQrMgftCXzPYMGb+q
         i2dxPisKIVG/Xx96jqCIozTvWc73hRmr0aUYwxwkNgKfJWOFI/CLq78FlFLOIv88nHN5
         pYau1cBcmPtmL4f+pYwt3yHHMD5AB8KSdXt9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=CRPG+vThFyqW4ZOdLgdpkfUC1dmEPvinlh78Yilsi4E=;
        b=A+rBZnsT9SwXFQAJxVmNFGg7ujCf9ljEFEwmnRXxGr/QkiPQv5rop8M46YQma5PJ8f
         9WyzOOkvo2gWm22ibElSsHkC+qfQ7GfthBNNp2DLwRsVpPshY+pxCK9rLEOVio8r7B/q
         scjEULJxnhWulfJTgcCvufF91niLR9582W4/iFXyrHPEWXRTDfDO6zLDvXH9TwxJgL7H
         LaXKxcH6vk4Vr2d8+TEQAeTIcLJs1P7B0Mf7XqNNMQtjRfVF+Ewa5iP16hFoY53RCqvI
         3mbz0WI48h4k4YfQEDjOv+b3jHfI5Ozlzh19tmOrNgSZ+EYJYIhB1PkJXmw5rvIFCZRW
         MASA==
X-Gm-Message-State: AMCzsaVL9O1E7q1MSBqDdRlUdRTRzRI/sBSDYn0QFl2ul/jNvVyC6XRu
        JOz9DiqXpyMbEBCKzYY9GXF52Az/Wjg=
X-Google-Smtp-Source: ABhQp+Rv+23eDrr8YWc/ae/+YaUWnmptfAs8valvz3MGNii34rx/OYV9YcyNNRCiqAECHY5cOf5vyg==
X-Received: by 10.99.126.5 with SMTP id z5mr1494399pgc.371.1509146823295;
        Fri, 27 Oct 2017 16:27:03 -0700 (PDT)
Received: from alexmv-linux.corp.dropbox.com (Guest-GW2.corp.dropbox.com. [205.189.0.166])
        by smtp.gmail.com with ESMTPSA id i129sm15442806pgd.21.2017.10.27.16.27.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Oct 2017 16:27:02 -0700 (PDT)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH v3 2/4] fsmonitor: Don't bother pretty-printing JSON from watchman
Date:   Fri, 27 Oct 2017 16:26:35 -0700
Message-Id: <ff7745089999ff3bb2c014d2d4f1659a9de4e859.1509146542.git.alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.0.rc1.413.g76aedb451
In-Reply-To: <20171027232637.30395-1-alexmv@dropbox.com>
References: <20171027232637.30395-1-alexmv@dropbox.com>
In-Reply-To: <4b488da5e0710e9699f92d2dabe5e3352f3eb394.1509146542.git.alexmv@dropbox.com>
References: <4b488da5e0710e9699f92d2dabe5e3352f3eb394.1509146542.git.alexmv@dropbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This provides modest performance savings.  Benchmarking with the
following program, with and without `--no-pretty`, we find savings of
23% (0.316s -> 0.242s) in the git repository, and savings of 8% (5.24s
-> 4.86s) on a large repository with 580k files in the working copy.

    #!/usr/bin/perl

    use strict;
    use warnings;
    use IPC::Open2;
    use JSON::XS;

    my $pid = open2(\*CHLD_OUT, \*CHLD_IN, "watchman -j @ARGV")
        or die "open2() failed: $!\n" .
        "Falling back to scanning...\n";

    my $query = qq|["query", "$ENV{PWD}", {}]|;

    print CHLD_IN $query;
    close CHLD_IN;
    my $response = do {local $/; <CHLD_OUT>};

    JSON::XS->new->utf8->decode($response);

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
---
 templates/hooks--fsmonitor-watchman.sample | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/templates/hooks--fsmonitor-watchman.sample b/templates/hooks--fsmonitor-watchman.sample
index 9eba8a740..9a082f278 100755
--- a/templates/hooks--fsmonitor-watchman.sample
+++ b/templates/hooks--fsmonitor-watchman.sample
@@ -49,7 +49,7 @@ launch_watchman();
 
 sub launch_watchman {
 
-	my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j')
+	my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j --no-pretty')
 	    or die "open2() failed: $!\n" .
 	    "Falling back to scanning...\n";
 
-- 
2.15.0.rc1.413.g76aedb451


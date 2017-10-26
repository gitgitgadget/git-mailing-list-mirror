Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47A682055E
	for <e@80x24.org>; Thu, 26 Oct 2017 01:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752049AbdJZBbi (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 21:31:38 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:53381 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751993AbdJZBbb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 21:31:31 -0400
Received: by mail-pf0-f195.google.com with SMTP id t188so1296423pfd.10
        for <git@vger.kernel.org>; Wed, 25 Oct 2017 18:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=1tsK+LdM0dx8zZzS6UaPZPBhbgON4r1onwf8RG08hdo=;
        b=lanwxHao8jlesku6N8q0hJYhBywW+1EKSt8cuykrKABc5xyvP4k6iJKc0Lv/1/tpYk
         vEaB8UhwMxDqaYlgs4J1h4wmcyG0+VJ3b2BDU8qXlKF1d0z7dZikEhEykYo14rnM81Dz
         xVuErNfgZGUpWeddlXraQs7sVfBcYzMhgtF6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=1tsK+LdM0dx8zZzS6UaPZPBhbgON4r1onwf8RG08hdo=;
        b=sfjP6GfTuvTAoVsCf9C2kP2YpcC6Y/2pKnf9S7XLE8dnFMDv6v+ZnluBWdqSlBvoT4
         H4BjQGrBUJy9lc0WIYc9z2hp3s6rg0iyvt+aCTCVCX+siWSyghaVjZlW0M1e5Ay/f1LU
         lDbT/Ugx0i74unNcRQmVMUmOkFwPmJqt/79wo7gCoIhEQpAxMpCJ8DjjE8oznxfh/nQt
         s4NIaF40ilLF/UX803ZWSwTep9dP6tI5jD3wmFyQ6KMfanY4hVYKR+LUSm6b+sdbiNhB
         bUD3h5tIYiIs66t8wOPwx+oZvw01uZG1O0m4QP1cdXUDtVaP8SN53H/qL0acwQYKDlSN
         Lz1w==
X-Gm-Message-State: AMCzsaVxPJaPe3m3bDRX9+bB6RQ+b0F4Cqz91QGOzg5G0nYHVnzH/T8x
        sTPiuARTIKi3syqcB1lac9pqcFmPz5w=
X-Google-Smtp-Source: ABhQp+TCHWpkh7J0OjDLFb5kVvGsrFLS0cW+2SxJTj+C3XG5tAqRNkHHbxCdEXF1/S6Ln6jyuJJmVQ==
X-Received: by 10.98.8.74 with SMTP id c71mr3788039pfd.101.1508981490828;
        Wed, 25 Oct 2017 18:31:30 -0700 (PDT)
Received: from alexmv-linux.corp.dropbox.com (v160-sfo11-br01.corp.dropbox.com. [205.189.0.163])
        by smtp.gmail.com with ESMTPSA id s3sm8159206pfk.7.2017.10.25.18.31.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Oct 2017 18:31:30 -0700 (PDT)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH v2 2/4] fsmonitor: Don't bother pretty-printing JSON from watchman
Date:   Wed, 25 Oct 2017 18:31:15 -0700
Message-Id: <42fd8bccb78992a2894e711e057230a673891628.1508981451.git.alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.0.rc1.413.g76aedb451
In-Reply-To: <20171026013117.30034-1-alexmv@dropbox.com>
References: <20171026013117.30034-1-alexmv@dropbox.com>
In-Reply-To: <9af6d28ef43edbc99a9b7a9c41990de0989bfc76.1508981451.git.alexmv@dropbox.com>
References: <9af6d28ef43edbc99a9b7a9c41990de0989bfc76.1508981451.git.alexmv@dropbox.com>
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

    my $pid = open2(\*CHLD_OUT, \*CHLD_IN, "watchman -j @ARGV")
        or die "open2() failed: $!\n" .
        "Falling back to scanning...\n";

    my $query = qq|["query", "$ENV{PWD}", {}]|;

    print CHLD_IN $query;
    close CHLD_IN;
    my $response = do {local $/; <CHLD_OUT>};

    my $json_pkg;
    eval {
        require JSON::XSomething;
        $json_pkg = "JSON::XSomething";
        1;
    } or do {
        require JSON::PP;
        $json_pkg = "JSON::PP";
    };

    my $o = $json_pkg->new->utf8->decode($response);

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
---
 t/t7519/fsmonitor-watchman                 | 2 +-
 templates/hooks--fsmonitor-watchman.sample | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
index a3e30bf54..79f24325c 100755
--- a/t/t7519/fsmonitor-watchman
+++ b/t/t7519/fsmonitor-watchman
@@ -50,7 +50,7 @@ launch_watchman();
 
 sub launch_watchman {
 
-	my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j')
+	my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j --no-pretty')
 	    or die "open2() failed: $!\n" .
 	    "Falling back to scanning...\n";
 
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


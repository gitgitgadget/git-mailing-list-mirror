Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F1361F404
	for <e@80x24.org>; Mon, 12 Feb 2018 19:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751013AbeBLToL (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 14:44:11 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40506 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbeBLToK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 14:44:10 -0500
Received: by mail-pl0-f66.google.com with SMTP id g18so5475549plo.7
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 11:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ESW9whCgnGV9p+YC2ix+ds/HrNaZY+gs4iKDXbItfc4=;
        b=WSxHm6XMr2OwH6Y5ba0oVgzy6YMCi8axonqMqtJ0y5JbWzfnyKiz7zq6GNtsILaFKe
         UJtdv+ZfXN4w49lJmI//fllD5ClzcDe2d1NCki/4ukE8vJaaPoZ+kuf9ZjWU/XWwp18x
         i7NYk8XznDwT+0wfRO8DMuIQw5I4MV+36HPrJmGRCm4qF5QPpy6XxnfPTEdfCPxG2IA0
         m9nwVV3hcKIMO0qEOHbB/HYVkoSBOWdBxm0gq14iyXVkUgqSNRTTuwi1SAmkgs9jUDiA
         s5u7fzgQjMMsCrZU0yzEaxRFSL0J2rUenYXzwUhRr8hD9Fl9dG1BXeu1EAJ69vEDXnzA
         bE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ESW9whCgnGV9p+YC2ix+ds/HrNaZY+gs4iKDXbItfc4=;
        b=fnKoYLcoxwZxYp5Z5S6laac1bS+v8tlZF+hdl7qFt5gonbGtHS0Wc9Iiratj5uBEuP
         VcHHLr0LsZHczNMdcdW+X5FascKzfhVPxHWE8D0qcBeNSjWG9TBLS1OHx+QUr/heTqGC
         nRleDm7ikqqh9jV+VE5ioTtj/0zfXkOhUjZAMWLYwmdxE6rxgiS0P+kPoe/1Za0f2pHs
         oDl4i+yExCRJ5qtp1/cc8yPz78Dka9J/Cu1mzVRXiKu42AqdW6gkhQtVUe1wt61eqhCm
         EghsVgdfr7saOsBlp6WdXsaFNfliqiP+j7U9T9eRjiru2e9t8+C8mqhrCTPOAHEY+9Y1
         GBjw==
X-Gm-Message-State: APf1xPCPdJUixFVTozKEFwzoJw8hchpb99bixbQ/Kh32etYAT3SHH03w
        vl1k1OmncPb6bsm0TXahDCu1EA==
X-Google-Smtp-Source: AH8x224yhSoJOMZJz24UGnHu1hTVXPaTxf4qZKmfhoILT42avs1kQSEUNTr+3eG3szbkZkyYzvnaJQ==
X-Received: by 2002:a17:902:f:: with SMTP id 15-v6mr11614801pla.419.1518464649042;
        Mon, 12 Feb 2018 11:44:09 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id u9sm6724288pgb.11.2018.02.12.11.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 11:44:08 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sunshine@sunshineco.com
Cc:     artagnon@gmail.com, avarab@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, mina86@mina86.com, mst@kernel.org,
        pbonzini@redhat.com, sbeller@google.com, viktorin@rehivetech.com,
        zxq_yx_007@163.com
Subject: [PATCH] send-email: error out when relogin delay is missing
Date:   Mon, 12 Feb 2018 11:44:04 -0800
Message-Id: <20180212194404.66863-1-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.73.ga2c3e9663f.dirty
In-Reply-To: <CAPig+cRyx1KHJMn97mNy_BmX1D+cGEqVUT6x3Bw+tmsUOE3J+w@mail.gmail.com>
References: <CAPig+cRyx1KHJMn97mNy_BmX1D+cGEqVUT6x3Bw+tmsUOE3J+w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the batch size is neither configured nor given on the command
line, but the relogin delay is given, then the current code ignores
the relogin delay setting.

This is unsafe as there was some intention when setting the batch size.
One workaround would be to just assume a batch size of 1 as a default.
This however may be bad UX, as then the user may wonder why it is sending
slowly without apparent batching.

Error out for now instead of potentially confusing the user.
As 5453b83bdf (send-email: --batch-size to work around some SMTP
server limit, 2017-05-21) lays out, we rather want to not have this
interface anyway and would rather want to react on the server throttling
dynamically.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-send-email.perl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 340b5c8482..f7913f7c2c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -379,6 +379,10 @@ unless ($rc) {
 die __("Cannot run git format-patch from outside a repository\n")
 	if $format_patch and not $repo;
 
+die __("`batch-size` and `relogin` must be specified together " .
+	"(via command-line or configuration option)\n")
+	if defined $relogin_delay and not defined $batch_size;
+
 # Now, let's fill any that aren't set in with defaults:
 
 sub read_config {
-- 
2.15.1.433.g936d1b9894.dirty


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4412E2023D
	for <e@80x24.org>; Wed, 17 May 2017 02:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752968AbdEQC7k (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 22:59:40 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:32918 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbdEQC73 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 22:59:29 -0400
Received: by mail-pf0-f174.google.com with SMTP id e193so89804566pfh.0
        for <git@vger.kernel.org>; Tue, 16 May 2017 19:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SYmtzKMrXgDk03xOW6PkTny80M37yG7YfSLMRsJ1oA4=;
        b=bIbQGzC9SpHc0HtXTjL1NzndhQ4t7o/Z99oXU3jo8OL8gIO8XqpzEC8bEHkmw7/IIV
         5Muo2zvjHPYLbMI5FJ0v6ZFSpQDCFVdMQTUTJqVqE4M7YyKKjGQQhS8qxuBjs8K1TlAq
         vyUDLORvHfvy0AQDSFqFwzzUgZo6HZ0i7NqPB/4Dn5eg+vq3OqB0BtZDnrtOjtI4gx6Y
         bTbf4zpOSHT6cofTqt7uZI84CnxLTwBcf083CSJoBVFw4mjKDGu5yPG70J3uB5wDVrrs
         1Fh8OfEDxyQ3O/5yjLFnClEDx0wdFbmbjcmfBMoAfnamgbZVKw4s6tHMyPV66sExrVCa
         lE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SYmtzKMrXgDk03xOW6PkTny80M37yG7YfSLMRsJ1oA4=;
        b=AtbF5FrzIKbTayC/jz0WzokFeeKpesBGTnFWfUJYxesjyAofAOTQkmSRCaVET5Jwqi
         WAAilyzjmbvlaQgwQBAqLBvqLDALNH0qKas9jtx2dSgj3Ogoe1EwblRm0CszD3NHJLkF
         75YnxbOKccJfwe1cRNWKgIpbuP8QzAnDRsbvZLAFQAPkw6LEsmtm+TTznGCwlk88nxoT
         TnfopsNeO+BYeLSHIZGYR1/IehGsl6Mjow7SOQvPhJqHAArvoC9lg0FhFAG67CteR/IN
         RIroxSq0SGF614IqcK+wAAxMYonWzF3/rIU/ORzcTPDJr0FjOEiTlF2kjzEh91Kgd1J9
         gvRQ==
X-Gm-Message-State: AODbwcAxQxaNMwNVUId7q2VeADYpqYMAIrw1g1qlrP/wbodrst2F6/K8
        70+QkYXkamk4oa+T
X-Received: by 10.84.173.195 with SMTP id p61mr1487626plb.83.1494989963411;
        Tue, 16 May 2017 19:59:23 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:b4bc:dafd:125e:c48a])
        by smtp.gmail.com with ESMTPSA id l3sm639905pfj.130.2017.05.16.19.59.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 19:59:22 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, gitster@pobox.com, jonathantanmy@google.com,
        bmwill@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 16/20] diff.c: convert diff_flush to use emit_line_*
Date:   Tue, 16 May 2017 19:58:53 -0700
Message-Id: <20170517025857.32320-17-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170517025857.32320-1-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
 <20170517025857.32320-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch, I want to propose an option to detect&color
moved lines in a diff, which cannot be done in a one-pass over
the diff. Instead we need to go over the whole diff twice,
because we cannot detect the first line of the two corresponding
lines (+ and -) that got moved.

So to prepare the diff machinery for two pass algorithms
(i.e. buffer it all up and then operate on the result),
move all emissions to places, such that the only emitting
function is emit_line_0.

This covers diff_flush.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index f1cb0b7799..4cd1b3c520 100644
--- a/diff.c
+++ b/diff.c
@@ -4868,7 +4868,9 @@ void diff_flush(struct diff_options *options)
 			emit_line(options, NULL, NULL, 1, 0, term, !!term[0]);
 			if (options->stat_sep) {
 				/* attach patch instead of inline */
-				fputs(options->stat_sep, options->file);
+				emit_line(options, NULL, NULL, 0, 0,
+					  options->stat_sep,
+					  strlen(options->stat_sep));
 			}
 		}
 
-- 
2.13.0.18.g7d86cc8ba0


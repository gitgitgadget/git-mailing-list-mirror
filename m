Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FA081F516
	for <e@80x24.org>; Thu, 28 Jun 2018 22:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966793AbeF1WFM (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 18:05:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:58934 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S966122AbeF1WFL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 18:05:11 -0400
Received: (qmail 31995 invoked by uid 109); 28 Jun 2018 22:05:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Jun 2018 22:05:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25998 invoked by uid 111); 28 Jun 2018 22:05:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Jun 2018 18:05:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jun 2018 18:05:09 -0400
Date:   Thu, 28 Jun 2018 18:05:09 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
Subject: [PATCH 2/4] config: add CONFIG_ERROR_SILENT handler
Message-ID: <20180628220509.GB5524@sigill.intra.peff.net>
References: <20180628220332.GA5128@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180628220332.GA5128@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can currently die() or error(), but there's not yet any
way for callers to ask us just to quietly return an error.
Let's give them one.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c | 3 +++
 config.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/config.c b/config.c
index b5c23369d0..0797e284f4 100644
--- a/config.c
+++ b/config.c
@@ -818,6 +818,9 @@ static int git_parse_source(config_fn_t fn, void *data,
 	case CONFIG_ERROR_ERROR:
 		error_return = error("%s", error_msg);
 		break;
+	case CONFIG_ERROR_SILENT:
+		error_return = -1;
+		break;
 	case CONFIG_ERROR_UNSET:
 		BUG("config error action unset");
 	}
diff --git a/config.h b/config.h
index ce75bf1e5c..c02809ffdc 100644
--- a/config.h
+++ b/config.h
@@ -58,6 +58,7 @@ struct config_options {
 		CONFIG_ERROR_UNSET = 0, /* use source-specific default */
 		CONFIG_ERROR_DIE, /* die() on error */
 		CONFIG_ERROR_ERROR, /* error() on error, return -1 */
+		CONFIG_ERROR_SILENT, /* return -1 */
 	} error_action;
 };
 
-- 
2.18.0.604.g8c4f59c959


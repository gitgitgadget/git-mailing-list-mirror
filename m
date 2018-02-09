Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFFE11F404
	for <e@80x24.org>; Fri,  9 Feb 2018 19:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752268AbeBITDc (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 14:03:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:47122 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752159AbeBITDc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 14:03:32 -0500
Received: (qmail 4170 invoked by uid 109); 9 Feb 2018 19:03:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 09 Feb 2018 19:03:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23923 invoked by uid 111); 9 Feb 2018 19:04:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 09 Feb 2018 14:04:15 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Feb 2018 14:03:30 -0500
Date:   Fri, 9 Feb 2018 14:03:30 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/3] t: teach 'test_must_fail' to save the command's
 stderr to a file
Message-ID: <20180209190329.GA15005@sigill.intra.peff.net>
References: <20180209024235.3431-1-szeder.dev@gmail.com>
 <20180209024235.3431-3-szeder.dev@gmail.com>
 <20180209142131.GA18701@sigill.intra.peff.net>
 <xmqqd11exb6k.fsf@gitster-ct.c.googlers.com>
 <20180209185710.GA23403@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180209185710.GA23403@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 09, 2018 at 01:57:10PM -0500, Jeff King wrote:

> Here's what it looks like as a patch.
> 
> -- >8 --
> Subject: [PATCH] t: send verbose test-helper output to fd 4

That applies on 'master'. If we go this route, we'd want this on
sg/test-i18ngrep, which is in 'next' right now:

-- >8 --
Subject: [PATCH] test_i18n_grep: send error messages to fd 4

These were newly added in 63b1a175ee (t: make
'test_i18ngrep' more informative on failure, 2018-02-08),
and so missed the conversion in commit X.

Signed-off-by: Jeff King <peff@peff.net>
---
(The X above is whatever you queue the original at).

 t/test-lib-functions.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index cddddd2082..aabee13e5d 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -742,18 +742,18 @@ test_i18ngrep () {
 		shift
 		! grep "$@" && return 0
 
-		echo >&2 "error: '! grep $@' did find a match in:"
+		echo >&4 "error: '! grep $@' did find a match in:"
 	else
 		grep "$@" && return 0
 
-		echo >&2 "error: 'grep $@' didn't find a match in:"
+		echo >&4 "error: 'grep $@' didn't find a match in:"
 	fi
 
 	if test -s "$last_arg"
 	then
-		cat >&2 "$last_arg"
+		cat >&4 "$last_arg"
 	else
-		echo >&2 "<File '$last_arg' is empty>"
+		echo >&4 "<File '$last_arg' is empty>"
 	fi
 
 	return 1
-- 
2.16.1.464.gc4bae515b7


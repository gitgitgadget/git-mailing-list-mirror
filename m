Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96284C2D0C0
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 23:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629D42075E
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 23:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1UtS8Yl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfLZXMy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 18:12:54 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:36582 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfLZXMy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 18:12:54 -0500
Received: by mail-pf1-f177.google.com with SMTP id x184so13866976pfb.3
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 15:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tAISH0l1xMDAwA0/QLgXb+GVFVCVRvSFxRsHjtMixeY=;
        b=C1UtS8Yl9tq1fY5IMg2eyjQMZghxp8tJQao5ssBfcpBnPGvInX8qGVJS/mH9kKjvDj
         Yfk8qvmZDNXklHuX/ngtXjtcallTHr/eTtFKTxqZMIiyZ9I0lOvyAlO/PcTpVpQpgMun
         GZJXAgjy/diYrOaRQDl023cRYuN9IvmlK66XvA6r3tR+4eLeQxKMhpBlrni6e149RGmU
         06F5oTTmoVWr+8WotFDRu8mqAwec7EM0uyCQQq+rtbN6q8oMPZfdFJlKxcnpCg5Bj78h
         XeW1MVeKbhheXS1bpWvyoJNv2PSy1ZQ6U2q6iCd+MiAfWTSe138mBECzsudumgqtXzUC
         wY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tAISH0l1xMDAwA0/QLgXb+GVFVCVRvSFxRsHjtMixeY=;
        b=B9IFND7FEp562swTasl4h1RWeKgdZMCFgtvlIVSvgzu0+JFlHt4fLS355Sa6fpiwuw
         QwIA75QhQJxdmclTzFquLuHCPDqCu2X4SEz0GV17YpRQyzaXCvj+HwnDJjzvwDyJzx1R
         uQ1O/tFQgMdfqaJ9WKMomCvzfCBeVBAivxZ+ZBCG77PEbXDkRoo6HVLleXRAhlOSKl3F
         RyLfxuumfRvD0SyjLlw4cRdsGL5xaRZYE5Yo9rTXzeTTnnPx4g9b9p7+dbFlLUVcqlot
         Q7TwiHGoEIzFdY48LExF3yVTiId7kHzlajqKmPQYY2d8K+b4j/VFGzfrLabgmT4NAymH
         Qcgw==
X-Gm-Message-State: APjAAAUAdWK6jzxLlW6tgyD8eMnQ4dt8egdKZ4BvUM3EMKwUxqpEyZ3B
        QAgGLhCvFy36/QFKC2G5ABE=
X-Google-Smtp-Source: APXvYqx6STWwWzxuL72wGnVbUkbC8ZXgpi8sQ+xNxhVc6ZsWaGf+JVGoDUi/Hx4DkyVAW09iNxvf+Q==
X-Received: by 2002:a63:1756:: with SMTP id 22mr52149916pgx.109.1577401973419;
        Thu, 26 Dec 2019 15:12:53 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id w123sm19449572pfb.167.2019.12.26.15.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 15:12:52 -0800 (PST)
Date:   Thu, 26 Dec 2019 15:12:51 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH jn/test-lint-one-shot-export-to-shell-function] fetch test:
 mark test of "skipping" haves as v0-only
Message-ID: <20191226231251.GC186931@google.com>
References: <20191224005816.GC38316@google.com>
 <20191224010110.GF38316@google.com>
 <xmqqfth6lwgl.fsf@gitster-ct.c.googlers.com>
 <20191226195357.GA170890@google.com>
 <20191226195747.GC170890@google.com>
 <xmqq7e2ilu1j.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7e2ilu1j.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 633a53179e (fetch test: avoid use of "VAR= cmd" with a shell
function, 2019-12-26), t5552.5 (do not send "have" with ancestors of
commits that server ACKed) fails when run with
GIT_TEST_PROTOCOL_VERSION=2.

The cause:

The progression of "have"s sent in negotiation depends on whether we
are using a stateless RPC based transport or a stateful bidirectional
one (see for example 44d8dc54e7, "Fix potential local deadlock during
fetch-pack", 2011-03-29).  In protocol v2, all transports are
stateless transports, while in protocol v0, transports such as local
access and ssh are stateful.

In stateful transports, the number of "have"s to send multiplies by
two each round until we reach PIPESAFE_FLUSH (that is, 32), and then
it increases by PIPESAFE_FLUSH each round.  In stateless transport,
the count multiplies by two each round until we reach LARGE_FLUSH
(which is 16384) and then multiplies by 1.1 each round after that.

Moreover, in stateful transports, as fetch-pack.c explains:

	We keep one window "ahead" of the other side, and will wait
	for an ACK only on the next one.

This affects t5552.5 because it looks for "have"s from the negotiator
that appear in that second window.  With protocol version 2, the
second window never arrives, and the test fails.

Until 633a53179e (2019-12-26), a previous test in the same file
contained

	GIT_TEST_PROTOCOL_VERSION= trace_fetch client origin to_fetch

In many common shells (e.g. bash when run as "sh"), the setting of
GIT_TEST_PROTOCOL_VERSION to the empty string lasts beyond the
intended duration of the trace_fetch invocation.  This causes it to
override the GIT_TEST_PROTOCOL_VERSION setting that was passed in to
the test during the remainder of the test script, so t5552.5 never got
run using protocol v2 on those shells, regardless of the
GIT_TEST_PROTOCOL_VERSION setting from the environment.  633a53179e
fixed that, revealing the failing test.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> The tip of "promote proto v2 to default" series fails at 5552.5
> with or without these two patches, though.

Here's the promised fix, against
jn/test-lint-one-shot-export-to-shell-function.  Thanks again.

 t/t5552-skipping-fetch-negotiator.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
index a452fe32fa..8f25f4b31f 100755
--- a/t/t5552-skipping-fetch-negotiator.sh
+++ b/t/t5552-skipping-fetch-negotiator.sh
@@ -173,7 +173,17 @@ test_expect_success 'do not send "have" with ancestors of commits that server AC
 	test_commit -C server commit-on-b1 &&
 
 	test_config -C client fetch.negotiationalgorithm skipping &&
-	trace_fetch client "$(pwd)/server" to_fetch &&
+
+	# NEEDSWORK: The number of "have"s sent depends on whether the transport
+	# is stateful. If the overspecification of the result were reduced, this
+	# test could be used for both stateful and stateless transports.
+	(
+		# Force protocol v0, in which local transport is stateful (in
+		# protocol v2 it is stateless).
+		GIT_TEST_PROTOCOL_VERSION=0 &&
+		export GIT_TEST_PROTOCOL_VERSION &&
+		trace_fetch client "$(pwd)/server" to_fetch
+	) &&
 	grep "  fetch" trace &&
 
 	# fetch-pack sends 2 requests each containing 16 "have" lines before
-- 
2.24.1.735.g03f4e72817


Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1172BC33CAF
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 03:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD2124655
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 03:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="X7Vlj0Kk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgAVDp5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 22:45:57 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:44126 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727141AbgAVDpz (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Jan 2020 22:45:55 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 86A35607FA;
        Wed, 22 Jan 2020 03:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579664754;
        bh=gYhMk5k1iGY92LNTDs0W9sL/pu9J0SN3ZiwwZNTHnUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=X7Vlj0Kk/5NI58Y0fLjsCCfK/L+KkVkZIw+6ySlCwk6CHMdnB29yWuzG2+p2Gk7jp
         ZV2/yVwhI0WAAbHaupKmbXIcFoWQYa4B/a1pvVt5bdd642wS7I+wqd9OPdqEQ0w7SB
         etabhHVLM5he2nrIGxYr9t3UBt2g0fhUYBkAW7U6sAB601Qvhf9Id4fZ4oYD3vbSo3
         z4+ArukexfoqOhHApK20Y+cyRiMgb9jUiZNXNLx7bBi4/cqDtyvwZOx4Q0GC71DOWP
         lP2XIJcS3GIhAs8EpBVjdnspV1vOM0Q8mSTqn65eS7Ke8byqbvEocnEvQ0676x2Oiu
         9QZLfiZvW0+rMRhwn7Eizks5HZ6XiUq9+HOt73XJbBLOyKI85euIrNmAFQAE/JEM2b
         ydfoujFvjCDzKc3VYqYAq1ft0nZPX0oGkOxYTzEwSQlMlTjqtr5K0oZxeQnZA6Yhl6
         W210th8094Mzy2HO6Ca281lJV3dHG8+kvN+5KUfv9WcQGuhkaEJ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 5/5] docs: mention when increasing http.postBuffer is valuable
Date:   Wed, 22 Jan 2020 03:45:43 +0000
Message-Id: <20200122034543.18927-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309
In-Reply-To: <20200122034543.18927-1-sandals@crustytoothpaste.net>
References: <20200122034543.18927-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Users in a wide variety of situations find themselves with HTTP push
problems.  Oftentimes these issues are due to antivirus software,
filtering proxies, or other man-in-the-middle situations; other times,
they are due to simple unreliability of the network.

However, a common solution to HTTP push problems found online is to
increase http.postBuffer.  This works for none of the aforementioned
situations and is only useful in a small, highly restricted number of
cases: essentially, when the connection does not properly support
HTTP/1.1.

Document when raising this value is appropriate and what it actually
does, and discourage people from using it as a general solution for push
problems, since it is not effective there.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/config/http.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index 5a32f5b0a5..3d1db91f05 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -199,6 +199,14 @@ http.postBuffer::
 	Transfer-Encoding: chunked is used to avoid creating a
 	massive pack file locally.  Default is 1 MiB, which is
 	sufficient for most requests.
++
+Note that raising this limit is only effective for disabling chunked
+transfer encoding and therefore should be used only where the remote
+server or a proxy only supports HTTP/1.0 or is noncompliant with the
+HTTP standard.  Raising this is not, in general, an effective solution
+for most push problems, but can increase memory consumption
+significantly since the entire buffer is allocated even for small
+pushes.
 
 http.lowSpeedLimit, http.lowSpeedTime::
 	If the HTTP transfer speed is less than 'http.lowSpeedLimit'

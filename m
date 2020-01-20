Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB38C2D0DB
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 17:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51A821835
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 17:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ENwpWyPp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgATRd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 12:33:59 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43072 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728139AbgATRd6 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Jan 2020 12:33:58 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 93B5D607FA;
        Mon, 20 Jan 2020 17:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579541637;
        bh=gYhMk5k1iGY92LNTDs0W9sL/pu9J0SN3ZiwwZNTHnUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ENwpWyPpPwxzN4kmGqkvqgyLxAatE1OFg0N1MhWbkz2Um1PVG3bGYeXfU0lOm/u1b
         Ek3Hp5nchrA6oKkgti66zBCjuqaBfmabO9SFVH1sb6X1pEOPnUWISlr2AV5fASlxSQ
         QSyJoGnwsDcFqbK+kEMQCmIvKykSNJhL8WREc2O+2ngxXNzW+XBFpkX3dIs43xqUwi
         cky5ngq5XMuKeudP33nZLHMJ64uUoboNdcdwI4KZ1EQkMD8jLSe9QyYXnmyQqeP05S
         nJ87rpnan5WmXi1/HOmWjH97KclxsR78rO7NDthsw0npL43SHQuMSV+mjY06YDesaf
         RtS+zLGTjEcyRGyjG9Guo/dEDDd35U/e2PJRDYRp1j+MVEesEisSydhlfa3c08aTX7
         hza6JQ0He0s2awsf+aSgBQgo9hicd4webDoBAznj8FtHp7h7epy5YnhG5iWm/bgUM7
         H0M0INdrOW1Zq7DgX+YsCO1+0wp1CfD73FVs//Z+x5FhkZSujl3
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH v4 5/5] docs: mention when increasing http.postBuffer is valuable
Date:   Mon, 20 Jan 2020 17:33:43 +0000
Message-Id: <20200120173343.4102954-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309
In-Reply-To: <20200120173343.4102954-1-sandals@crustytoothpaste.net>
References: <20200120173343.4102954-1-sandals@crustytoothpaste.net>
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

From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v7 2/3] t5551: make the test for extra HTTP headers more
 robust
Date: Mon, 9 May 2016 08:19:00 +0200 (CEST)
Message-ID: <f29dac327aeac23677aec955f5b46a7a4702abfe.1462774709.git.johannes.schindelin@gmx.de>
References: <cover.1462342213.git.johannes.schindelin@gmx.de> <cover.1462774709.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 09 08:20:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azeXD-0003fo-5g
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 08:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbcEIGTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 02:19:08 -0400
Received: from mout.gmx.net ([212.227.15.19]:65469 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000AbcEIGTF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 02:19:05 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M9b03-1auw743tYl-00CxbC; Mon, 09 May 2016 08:18:58
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1462774709.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:b3V9lUTix76c0P3Q0+HmLd84mIerEgYAQ9wh9xBKDsfu2TQd+tN
 hvYd7w/drJGHyIqIYHx4LrRiMXobL+PmzV/3s7rV+cEUUKRR/aihScDH8Th7/RCWgiaL471
 WM5Uns9glByQJrS2f455L6tgKEp07dD3tdmTGnjNoUAB/ruefeV3rtTWqT5w6h2hHw5x0QG
 Vk84pKEGoKwMZ0jb/yRfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IUnnQP6tKWw=:gCktlluu1BzGA1xkEwjYe0
 3KFd8itIQAHFnIX9+ZfTrF6UlfdJBBkDEBLm+rjEMocGFyG0B8Ba1u0j4v41JA6APY+oLArTu
 OZtyZb3L6HhkDOy8SRaZvelsdXwQY1t5pzHc0s+ZU5nVznVcbQJmFJrE/4lhpZbmnt41GJX5E
 YFGGH/W79RbPav6pMxUkzf60PUmdH9J/BtvVO1zKPjUoGTihuYDPjgUNpVokep4YHkhau5r0y
 5pfp4zyZZ+QqCtCuzvtbwwlkXIFTwvKKMDWO6+f2uoKrseb6HQgxkvOMG+L9o9/YCFVrFbEsw
 PfejkZ4lfnW+63hmKpRT1UFsgqj5tKl97O118hiJXMSOYCrQ1GKMu2IB0rD0zUBS/eMmAQmF4
 uji3zFzMBC973RFe9H6zEmIQPGUWWe1UUaiw7Vq6uJckP4VlM3AhywC93gqbvnSpkDmClWjKG
 +31vkjoUKev8BOqOpu9PdaccReQyskWaIXDgnyfYoxkLpM36WfHxla5F+VRJI+lqTllu6ufzN
 qdBatIY5X9VKK3h5/6Y801LhLLRDXOk5rEOZfAoG0yR/axrWWjrTCjppgLqe85whcy9Ou+OTl
 mStyz/gSUzWTMQq9e0rsXPMhPR2FgAXp50I/H/40O0hv9Z40EcfEXIzfqq+FFgognrMeAddvM
 LGHkucRGvMJDKmN59ZEK5HEV6tJqanrae8ViKW5RJCIaMG4MfT8cD4vgHQenpXBXjZPchpGTd
 hsy4FigxQ7NEQ7W39EZZSdfIakdjx0wix8mVBPUs37BU0Ra2hbmgwP9txG2x9pNLSPteKZod 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293987>

To test that extra HTTP headers are passed correctly, t5551 verifies that
a fetch succeeds when two required headers are passed, and that the fetch
does not succeed when those headers are not passed.

However, this test would also succeed if the configuration required only
one header. As Apache's configuration is notoriously tricky (this
developer frequently requires StackOverflow's help to understand Apache's
documentation), especially when still supporting the 2.2 line, let's just
really make sure that the test verifies what we want it to verify.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5551-http-fetch-smart.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index e44fe72..43b257e 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -283,7 +283,8 @@ test_expect_success EXPENSIVE 'http can handle enormous ref negotiation' '
 '
 
 test_expect_success 'custom http headers' '
-	test_must_fail git fetch "$HTTPD_URL/smart_headers/repo.git" &&
+	test_must_fail git -c http.extraheader="x-magic-two: cadabra" \
+		fetch "$HTTPD_URL/smart_headers/repo.git" &&
 	git -c http.extraheader="x-magic-one: abra" \
 	    -c http.extraheader="x-magic-two: cadabra" \
 	    fetch "$HTTPD_URL/smart_headers/repo.git"
-- 
2.8.2.463.g99156ee

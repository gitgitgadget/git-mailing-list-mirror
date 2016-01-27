From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 13/20] mingw: fix t9700's assumption about directory
 separators
Date: Wed, 27 Jan 2016 17:19:56 +0100 (CET)
Message-ID: <6a2a483a09b56ed4e06ac8a19f73cc37c7a8b0d4.1453911367.git.johannes.schindelin@gmx.de>
References: <cover.1453818789.git.johannes.schindelin@gmx.de> <cover.1453911367.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:20:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOSpo-00034K-QL
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 17:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933638AbcA0QUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 11:20:35 -0500
Received: from mout.gmx.net ([212.227.17.22]:63866 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934097AbcA0QU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 11:20:29 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MLNeQ-1aP0ms49zu-000ZAZ; Wed, 27 Jan 2016 17:19:57
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453911367.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:QNdnSpyQGhZ37oRqvP9vtWFYinjwa89hywPD5/b3vfG5tGZT8K0
 Wd2cBwarZydjVMEy8TGVbXSxFFUvmV3xwEgBtsZmPDWeiCyugilW33kyKrzINfn+eZbC5YA
 2/voL0MEhyV/nKKczhlW0avhLr7J8f0WS77ifTv5tcUHqQa6yws5palSJBvK3DxJkbwNI4s
 IlET0D3XaHDWbdpGVh21Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uy6yl/2AHwI=:57Sdq08bR4khcdy77XMrkQ
 OrgN442WbQzw6+mNeZbXdp2ZpXRfT0n/8lcVJIe3gP6mVKXE6WcS7uw9I3tbNHbfPo95hP8Hf
 tC1fnLxArHDHTWp44aKp9EmwCB8eSggi1wSvRjjtGFerULthPtLfXQqztyEEUNg3kU3nXSk/2
 fKusA69e1MPIFJA5c3dHRx1UfeZoxs/Nzd70qPpbGVElTvUihIIUeiBQfmHRRLfT5BHFD7YQ3
 Ddipf+XoqdZwHv35awPOAavMxbyVK8TlNg3thEwd5kEEIfc6kxQvBBvhKrtkSuW3dASEwl7Sj
 0kDDs5PTLr87vtOa2WLz6Ai5L36mW9+QU/iGqAh11Crel8nZyMaQnwD1zfQGzS+b+bbYX0DTm
 F4EYqxc6Qg0wZsa2VyEbd/8QPmnoqx+9kmc0fqzE5AW3+Vu7YMrx5QhYqhHjHXCS2ZuesnW+G
 xqeWV5ysYDfTDhdXV0elB6lVj4P+aT+cRHj21U5XRyD5GLdstF/Ac5Nlx5le38lul1/HNH2Me
 obfIKFnwBsEm09rDi+/2cJeLKVT5r9hBH+dm+5yBisitlWl6jIqR4XJ435PFFgSH3jX2/6Lbg
 1c9i5W/pfsQlMyr+zaV3HDGahXepPJw2dXndaWWEYcMuHyxY386TNHYKT1Vx3Z3rWigvdEhop
 YG7UJcgJb4MefklezYWfx73fh4qc+0sVoOYKVeRQhOJuJ0e8xIGpiDKd2m29PYnQLgdfdKILO
 TBvkiAnRBWN57mP/F6A/psVGd8F2tXeQ0WMVc79YiUV+vQlcPoLYHNlWGFxMLrnXIQtWwcrP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284938>

This test assumed that there is only one directory separator (the
forward slash), not two equivalent directory separators.
However, on Windows, the back slash and the forward slash *are*
equivalent.

Let's paper over this issue by converting the backward slashes to
forward ones in the test that fails with MSYS2 otherwise.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9700/test.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 1140767..7e8c40b 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -33,7 +33,7 @@ is($r->config_int("test.int"), 2048, "config_int: integer");
 is($r->config_int("test.nonexistent"), undef, "config_int: nonexistent");
 ok($r->config_bool("test.booltrue"), "config_bool: true");
 ok(!$r->config_bool("test.boolfalse"), "config_bool: false");
-is($r->config_path("test.path"), $r->config("test.pathexpanded"),
+is($r->config_path("test.path") =~ s/\\/\//gr, $r->config("test.pathexpanded"),
    "config_path: ~/foo expansion");
 is_deeply([$r->config_path("test.pathmulti")], ["foo", "bar"],
    "config_path: multiple values");
-- 
2.7.0.windows.1.7.g55a05c8

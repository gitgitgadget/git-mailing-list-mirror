From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 3/4] merge: release pack files before garbage-collecting
Date: Wed, 13 Jan 2016 18:20:21 +0100 (CET)
Message-ID: <83f7c1a7ad4f2d63733b61115b4a1dd88468e96f.1452705584.git.johannes.schindelin@gmx.de>
References: <cover.1452705584.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 18:20:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJP62-0004qx-5F
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 18:20:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753767AbcAMRU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 12:20:27 -0500
Received: from mout.gmx.net ([212.227.17.21]:56811 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932176AbcAMRUY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 12:20:24 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0ME33j-1aOgI50eyN-00HNDI; Wed, 13 Jan 2016 18:20:22
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452705584.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:xCM1xkUNzkzz37ZqUXadAjnhHkTkBtgge1hJaxlF2qbqmpJcuAS
 5U0JL9YBYmKf5WPSl+ntSrHsxOMkflZiIJWZllKuQtutv4xWcEfubHI3NuqtTyi9PrD358M
 6qn+imdN8kPwZhZyc73VKktJeu2i1mvgDJx6QPXgT1c3qJJYpakktn5CYQlJvREPqbbB1KK
 wZmXivieQEHj+MKc1YKmw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iORxvA9Q1Bg=:YDz54hVo0e/2VWh4VdOd/O
 GN4cglU48Lg6u+Xl+OcPI1etlbVYAvnquTLKFyV9ypNQhsmNLEKkIpZLQXjw5tD8n/PZ8STdr
 f6Hk38wjqnjcitW1QUV4jwCrlNDOrYB93KiBcpO62L3MvNekeGFE1cqEd54BqcspylVY1QCdX
 bEPkt5sIOy66e3uwfJtBxAAYl/3o6MYz834H31CbI5bVrYulS0KcntxCtHfseapiWfcUCw8CJ
 Cie7lOIlJmKtJBI8isfKNZESgXUOswRS8g2e+ALa1sbrdWNHXYUtX4PytHS+rMW4kI5Ojy+8c
 U0nulhgVEJLRttMuz1up1TusU11zhn+26inFlNawYVhPlrhNOP/AI9J0xvJ7Ace2mWBmMxZDf
 keMQVU6l1npifHB7AB6j97E6McrMXs0zErc8NeWGy0kOdKmVlbjSgrjGcNdnfkXUS38W+5Aa4
 Wdlfw3tYfP0z79Fbs8SyeRw0VagnkLPDZZnDFkHFw7KtfYzb2ySrQJ+clFOmx8GRC7k6uPcQB
 NkHbl7YmjNmPbOQSRg96P1qO2Z8t+Q80jw7cYJRnxLXGz/psGHt3UkstiyqYzuzNGKbiEKHS7
 peTHRZvzWpBnjdLGrNsgiU0MnZt2y7CKOD07ctsuPxxrzL+cUroIyOgcRA8l/4YPNiUrMy/ku
 y/E6QuVGQhgUlMQCn7NZDnmckPtwWJiYIaPKLsDp/CewUPiL3D8reJ44aG1Ln5demoElr3Ghe
 paMrMCyPke9ZUPo6nVFcHKiRM0DZ4KBOmjJ8+1ESXjD28py2Vrsn9hJu4DZCcEKkbgibouVm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283950>

Before auto-gc'ing, we need to make sure that the pack files are
released in case they need to be repacked and garbage-collected.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/merge.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 15bf95b..b98a348 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -404,6 +404,7 @@ static void finish(struct commit *head_commit,
 			 * We ignore errors in 'gc --auto', since the
 			 * user should see them.
 			 */
+			close_all_packs();
 			run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 		}
 	}
-- 
2.6.3.windows.1.300.g1c25e49

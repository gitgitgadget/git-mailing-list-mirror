From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] mv: prevent mismatched data when ignoring errors.
Date: Sat,  8 Mar 2014 19:21:39 +0000
Message-ID: <1394306499-50871-1-git-send-email-sandals@crustytoothpaste.net>
References: <20140308183501.GH18371@serenity.lan>
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Guillaume Gelin <contact@ramnes.eu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 20:21:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMMoj-0001Ek-GU
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 20:21:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbaCHTVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2014 14:21:48 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:52423 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751591AbaCHTVr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Mar 2014 14:21:47 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0646C28089;
	Sat,  8 Mar 2014 19:21:47 +0000 (UTC)
X-Mailer: git-send-email 1.9.0.1010.g6633b85.dirty
In-Reply-To: <20140308183501.GH18371@serenity.lan>
X-Spam-Score: -2.5 () ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243681>

We shrink the source and destination arrays, but not the modes or
submodule_gitfile arrays, resulting in potentially mismatched data.  Shrink
all the arrays at the same time to prevent this.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/mv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/mv.c b/builtin/mv.c
index f99c91e..b20cd95 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -230,6 +230,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 					memmove(destination + i,
 						destination + i + 1,
 						(argc - i) * sizeof(char *));
+					memmove(modes + i, modes + i + 1,
+						(argc - i) * sizeof(char *));
+					memmove(submodule_gitfile + i,
+						submodule_gitfile + i + 1,
+						(argc - i) * sizeof(char *));
 					i--;
 				}
 			} else
-- 
1.9.0.1010.g6633b85.dirty

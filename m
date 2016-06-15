From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH v4 1/3] MSVC: fix t0040-parse-options crash
Date: Sun, 30 Mar 2014 15:08:21 +0400
Message-ID: <cce7af835357635343f88895e8202cca149a701f.1396177208.git.marat@slonopotamus.org>
References: <cover.1396177207.git.marat@slonopotamus.org>
Cc: Marat Radchenko <marat@slonopotamus.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 13:08:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUDbm-0001wx-LP
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 13:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbaC3LIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2014 07:08:42 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:47058 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753129AbaC3LIm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 07:08:42 -0400
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WUDbT-0000Hw-2C; Sun, 30 Mar 2014 15:08:39 +0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <cover.1396177207.git.marat@slonopotamus.org>
In-Reply-To: <cover.1396177207.git.marat@slonopotamus.org>
References: <7vtxago359.fsf@alter.siamese.dyndns.org> <cover.1396177207.git.marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245461>

On 64-bit MSVC, pointers are 64 bit but `long` is only 32.
Thus, casting string to `unsigned long`, which is redundand on other
platforms, throws away important bits and when later cast to `intptr_t`
results in corrupt pointer.

This patch fixes test-parse-options by replacing harming cast with
correct one.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 test-parse-options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test-parse-options.c b/test-parse-options.c
index 434e8b8..6f6c656 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -60,7 +60,7 @@ int main(int argc, char **argv)
 		OPT_STRING('o', NULL, &string, "str", "get another string"),
 		OPT_NOOP_NOARG(0, "obsolete"),
 		OPT_SET_PTR(0, "default-string", &string,
-			"set string to default", (unsigned long)"default"),
+			"set string to default", (intptr_t)"default"),
 		OPT_STRING_LIST(0, "list", &list, "str", "add str to list"),
 		OPT_GROUP("Magic arguments"),
 		OPT_ARGUMENT("quux", "means --quux"),
-- 
1.9.0

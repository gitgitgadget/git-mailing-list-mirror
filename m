From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] checkout: reorder check_filename conditional
Date: Wed, 10 Feb 2016 16:12:34 -0500
Message-ID: <20160210211234.GA5799@sigill.intra.peff.net>
References: <20160210211206.GA5755@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 22:12:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTc43-0001Ah-CY
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 22:12:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbcBJVMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 16:12:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:39992 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751195AbcBJVMg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 16:12:36 -0500
Received: (qmail 15943 invoked by uid 102); 10 Feb 2016 21:12:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Feb 2016 16:12:36 -0500
Received: (qmail 31686 invoked by uid 107); 10 Feb 2016 21:12:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Feb 2016 16:12:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Feb 2016 16:12:34 -0500
Content-Disposition: inline
In-Reply-To: <20160210211206.GA5755@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285929>

If we have a "--" flag, we should not be doing DWIM magic
based on whether arguments can be filenames. Reorder the
conditional to avoid the check_filename() call entirely in
this case. The outcome is the same, but the short-circuit
makes the dependency more clear.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5af84a3..f6a2809 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -982,7 +982,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 		 */
 		int recover_with_dwim = dwim_new_local_branch_ok;
 
-		if (check_filename(NULL, arg) && !has_dash_dash)
+		if (!has_dash_dash && check_filename(NULL, arg))
 			recover_with_dwim = 0;
 		/*
 		 * Accept "git checkout foo" and "git checkout foo --"
-- 
2.7.1.545.gfd1d4e5

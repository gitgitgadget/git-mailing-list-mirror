From: Jeff King <peff@peff.net>
Subject: Re: Solaris test failure for git-1.5.4.4 -- t0021-conversion.sh
Date: Tue, 11 Mar 2008 13:40:45 -0400
Message-ID: <20080311174045.GB14687@sigill.intra.peff.net>
References: <8ec76080803110533m14041aebhc779d117a5bb6112@mail.gmail.com> <alpine.DEB.1.00.0803110954360.4428@alchemy.localdomain> <8ec76080803111014w209e1ceep9baf6d5c8c7f6a20@mail.gmail.com> <20080311173536.GA14687@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Whit Armstrong <armstrong.whit@gmail.com>,
	Asheesh Laroia <asheesh@asheesh.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 18:43:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ8Tf-0006cU-0T
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 18:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbYCKRks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 13:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbYCKRks
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 13:40:48 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3693 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580AbYCKRkr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 13:40:47 -0400
Received: (qmail 16751 invoked by uid 111); 11 Mar 2008 17:40:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 11 Mar 2008 13:40:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Mar 2008 13:40:45 -0400
Content-Disposition: inline
In-Reply-To: <20080311173536.GA14687@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76887>

On Tue, Mar 11, 2008 at 01:35:37PM -0400, Jeff King wrote:

> Looks like /usr/ucb/tr is OK with this, but /usr/bin/tr is not. Both
> seem to handle the more verbose:
> 
> tr \
>   'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' \
>   'nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM'

And here it is in patch form.

-- >8 --
t0021: tr portability fix for Solaris

Solaris' /usr/bin/tr doesn't seem to like multiple character
ranges in brackets (it simply prints "Bad string"). Instead,
let's just enumerate the transformation we want.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0021-conversion.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index cb86029..8fc39d7 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -5,7 +5,9 @@ test_description='blob conversion via gitattributes'
 . ./test-lib.sh
 
 cat <<\EOF >rot13.sh
-tr '[a-zA-Z]' '[n-za-mN-ZA-M]'
+tr \
+  'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' \
+  'nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM'
 EOF
 chmod +x rot13.sh
 
-- 
1.5.4.3.621.g34987

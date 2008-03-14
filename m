From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t/t6000lib.sh: tr portability fix fix
Date: Fri, 14 Mar 2008 16:26:31 -0500
Message-ID: <47DAED87.1000408@nrlssc.navy.mil>
References: <20080314205415.GA17728@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: armstrong.whit@gmail.com, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 22:37:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaHae-0003ry-3x
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 22:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755881AbYCNVgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 17:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755758AbYCNVgh
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 17:36:37 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:36917 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754133AbYCNVgg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 17:36:36 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2ELaA6d005747;
	Fri, 14 Mar 2008 16:36:12 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 14 Mar 2008 16:26:31 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <20080314205415.GA17728@coredump.intra.peff.net>
X-OriginalArrivalTime: 14 Mar 2008 21:26:32.0002 (UTC) FILETIME=[12A34220:01C8861A]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15784001
X-TM-AS-Result: : Yes--15.587700-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTcwMzc0Ny03MDAx?=
	=?us-ascii?B?NjAtNzAxMTgyLTcwMDA3NS0xMzkwMTAtMTg4MDE5LTcwMTQ1NS03?=
	=?us-ascii?B?MDAxMDQtNzAwNzAxLTcwMTgzNy03MDUzODgtODM1Nzk1LTcwMzE1?=
	=?us-ascii?B?Ny03MDMwOTYtNzA5NTg0LTcwMDc3MS03MDIzNTgtNzAwOTQyLTcw?=
	=?us-ascii?B?MDQ4MS03MDQ1NjgtMTQ4MDM5LTE0ODA1MS0yMDA0Mg==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77286>

Some versions of tr have a problem with character sets which begin with
multiple dashes and attempt to interpret them as long options. Escape
each dash to avoid this confusion and also prevent a possible
interpretation of the dashes as a range.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---

Jeff King wrote:
> On Fri, Mar 14, 2008 at 03:47:37PM -0500, Brandon Casey wrote:
> 
>> This patch fixes things. If the dashdash notation is not portable, then
>> backslashing each dash also works. i.e. '\-\-\-\-.. etc. but as you
>> mentioned something like that is less readable, but possibly not as bad
>> as a sed version.
> 
> It seems to work fine on Solaris with all versions of tr. I did just
> blindly extend the '-' without thinking, though...I wonder if there are
> systems that will get confused about it being a range. It might be
> safer to just use sed anyway.

Here's the version with escaped dashes. If you do the sed version, it's
something to compare to for readability.

-brandon


 t/t6000lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t6000lib.sh b/t/t6000lib.sh
index b69f7c4..71f2140 100755
--- a/t/t6000lib.sh
+++ b/t/t6000lib.sh
@@ -99,7 +99,7 @@ name_from_description()
 {
         tr "'" '-' |
 		tr '~`!@#$%^&*()_+={}[]|\;:"<>,/? ' \
-		   '------------------------------' |
+		   '\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-' |
 		tr -s '-' | tr '[A-Z]' '[a-z]' | sed "s/^-*//;s/-*\$//"
 }
 
-- 
1.5.4.4.481.g5075

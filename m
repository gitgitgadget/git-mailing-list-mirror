From: Thell Fowler <git@tbfowler.name>
Subject: [PATCH-v2/RFC 2/6] xutils: fix hash with whitespace on incomplete line
Date: Sat, 22 Aug 2009 22:49:13 -0500
Message-ID: <1250999357-10827-2-git-send-email-git@tbfowler.name>
References: <1250999285-10683-1-git-send-email-git@tbfowler.name>
Cc: Johannes.Schindelin@gmx.de, Thell Fowler <git@tbfowler.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 23 05:50:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mf460-0006Jw-3d
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 05:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933477AbZHWDtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 23:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933475AbZHWDtt
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 23:49:49 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:43330 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S933455AbZHWDto (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 23:49:44 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=localhost.localdomain)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1Mf45S-0004jt-09; Sat, 22 Aug 2009 22:49:46 -0500
X-Mailer: git-send-email 1.6.4.176.g556a4
In-Reply-To: <1250999285-10683-1-git-send-email-git@tbfowler.name>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps5.pyrapat.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tbfowler.name
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126837>

  - Make xdl_hash_record_with_whitespace stop hashing before the
    eof when ignoring space change or space at eol on an incomplete
    line.

  Resolves issue with a final trailing space being included in the
  hash on an incomplete line by treating the eof in the same fashion
  as a newline.

Signed-off-by: Thell Fowler <git@tbfowler.name>
---
 xdiff/xutils.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 04ad468..c6512a5 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -248,12 +248,12 @@ static unsigned long xdl_hash_record_with_whitespace(char const **data,
 			if (flags & XDF_IGNORE_WHITESPACE)
 				; /* already handled */
 			else if (flags & XDF_IGNORE_WHITESPACE_CHANGE
-					&& ptr[1] != '\n') {
+					&& ptr[1] != '\n' && ptr + 1 < top) {
 				ha += (ha << 5);
 				ha ^= (unsigned long) ' ';
 			}
 			else if (flags & XDF_IGNORE_WHITESPACE_AT_EOL
-					&& ptr[1] != '\n') {
+					&& ptr[1] != '\n' && ptr + 1 < top) {
 				while (ptr2 != ptr + 1) {
 					ha += (ha << 5);
 					ha ^= (unsigned long) *ptr2;
-- 
1.6.4.176.g556a4

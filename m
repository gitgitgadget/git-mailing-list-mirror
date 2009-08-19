From: Thell Fowler <git@tbfowler.name>
Subject: [PATCH 2/6] Make xdl_hash_record_with_whitespace ignore eof
Date: Wed, 19 Aug 2009 18:06:53 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.0908191725140.2012@GWPortableVCS>
References: <1249428804.2774.52.camel@GWPortableVCS> <cover.1250719760.git.git@tbfowler.name>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 20 01:07:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MduFb-0006BV-Nr
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 01:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415AbZHSXHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 19:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753413AbZHSXHQ
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 19:07:16 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:44591 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbZHSXHP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 19:07:15 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=GWPortableVCS.local)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1MduFR-0002Td-7n; Wed, 19 Aug 2009 18:07:17 -0500
X-X-Sender: almostautomated@GWPortableVCS
In-Reply-To: <cover.1250719760.git.git@tbfowler.name>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126591>

  - When xdl_hash_record_with_whitespace encountered an incomplete
    line the hash would be different than the identical line with
    either --ignore-space-change or --ignore-space-at-eol on an
    incomplete line because they only terminated with a check for
    a new-line.

Signed-off-by: Thell Fowler <git@tbfowler.name>
---
 xdiff/xutils.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 04ad468702209b77427e635370d41001986042ce..c6512a53b08a8c9039614738310aa2786f4fbb1c 100644
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
1.6.4.172.g5c0d0.dirty

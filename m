From: Adam Simpkins <simpkins@facebook.com>
Subject: [PATCH] graph API: display uninteresting commits as '^' instead of
	'*'
Date: Wed, 19 Aug 2009 16:06:46 -0700
Message-ID: <20090819230646.GS8147@facebook.com>
Reply-To: Adam Simpkins <simpkins@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 20 01:07:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MduFR-00066Y-VN
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 01:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412AbZHSXHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 19:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753375AbZHSXHI
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 19:07:08 -0400
Received: from mailout-snc1.facebook.com ([69.63.179.25]:43642 "EHLO
	mailout-sf2p.facebook.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753338AbZHSXHH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Aug 2009 19:07:07 -0400
Received: from mail.thefacebook.com (intlb01.snat.snc1.facebook.com [10.128.203.15] (may be forged))
	by pp02.snc1.tfbnw.net (8.14.1/8.14.1) with ESMTP id n7JN6aiZ030967
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Wed, 19 Aug 2009 16:06:36 -0700
Received: from simpkins (192.168.18.252) by mail.TheFacebook.com
 (192.168.18.104) with Microsoft SMTP Server (TLS) id 8.1.393.1; Wed, 19 Aug
 2009 16:06:47 -0700
Received: from simpkins by simpkins with local (Exim 4.69)	(envelope-from
 <simpkins@facebook.com>)	id 1MduEw-00063P-RM; Wed, 19 Aug 2009 16:06:46 -0700
Mail-Followup-To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166 definitions=2009-08-19_15:2009-08-11,2009-08-19,2009-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0907200000 definitions=main-0908190186
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126590>

Using --graph and --show-all together now displays UNINTERESTING commits
using '^' characters instead of '*'.

Something like the following command will demonstrate the change:

   git log --graph --show-all ^HEAD~2 HEAD

Signed-off-by: Adam Simpkins <simpkins@facebook.com>
---
 graph.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/graph.c b/graph.c
index 6746d42..50b68a4 100644
--- a/graph.c
+++ b/graph.c
@@ -775,6 +775,14 @@ static void graph_output_commit_char(struct git_graph *graph, struct strbuf *sb)
 	}
 
 	/*
+	 * For UNINTERESTING commits (displayed with --show-all), print '^'
+	 */
+	if (graph->commit->object.flags & UNINTERESTING) {
+		strbuf_addch(sb, '^');
+		return;
+	}
+
+	/*
 	 * If revs->left_right is set, print '<' for commits that
 	 * come from the left side, and '>' for commits from the right
 	 * side.
-- 
1.6.0.4

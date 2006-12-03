X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] [checkout-index] Give names to stages
Date: Sun, 3 Dec 2006 01:49:46 -0800 (PST)
Message-ID: <651451.91694.qm@web31813.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1836391200-1165139386=:91694"
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Sun, 3 Dec 2006 09:50:00 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=oCB4MRlrp4ha7G89uHfw+okOvBq0006I3X9mCMxVRw3Trirr0afhCx5DxurJgN7oUGFFwr5VO2Ngj/YllcxjoZl6/wlW1Wa5DVukS5e9SOR3uoJim1DGJxij7SGiLfgNJDNzC0FXlUFqei8cJP+NZBqgmg90V1ggJa4iEpKLwEk=;
X-YMail-OSG: lzDD2rwVM1mShZewRevrOX2S.mA4kAysVb_LdIQn_elB8t5MpWH411vgqFVPaON2hb18SfBVD6IMXvghtb_MfGZLeCbpruoKhLsLBTsZuV_gJh.deMGTWfDHc0aqpZMOi5JVz6Nwehilc4U-
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33102>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gqnyp-0000jR-Uh for gcvg-git@gmane.org; Sun, 03 Dec
 2006 10:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935776AbWLCJts (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 04:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936603AbWLCJts
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 04:49:48 -0500
Received: from web31813.mail.mud.yahoo.com ([68.142.207.76]:33198 "HELO
 web31813.mail.mud.yahoo.com") by vger.kernel.org with SMTP id S935776AbWLCJtr
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 04:49:47 -0500
Received: (qmail 91697 invoked by uid 60001); 3 Dec 2006 09:49:46 -0000
Received: from [68.186.59.199] by web31813.mail.mud.yahoo.com via HTTP; Sun,
 03 Dec 2006 01:49:46 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

--0-1836391200-1165139386=:91694
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

One can now say "git-checkout-index --stage=ours ..."  or
"git-checkout-index --stage=theirs ...", instead of having
to remember the corresponding number assigned to each stage.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 builtin-checkout-index.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

I find this quite helpful when resolving.


--0-1836391200-1165139386=:91694
Content-Type: text/plain; name="p1.txt"
Content-Description: 1207600725-p1.txt
Content-Disposition: inline; filename="p1.txt"

diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
index b097c88..d54a290 100644
--- a/builtin-checkout-index.c
+++ b/builtin-checkout-index.c
@@ -236,8 +236,17 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 				int ch = arg[8];
 				if ('1' <= ch && ch <= '3')
 					checkout_stage = arg[8] - '0';
+				else if (!strncmp(arg+8, "ancestor", 8))
+					checkout_stage = 1;
+				else if (!strncmp(arg+8, "ours", 4))
+					checkout_stage = 2;
+				else if (!strncmp(arg+8, "HEAD", 4))
+					checkout_stage = 2;
+				else if (!strncmp(arg+8, "theirs", 6))
+					checkout_stage = 3;
 				else
-					die("stage should be between 1 and 3 or all");
+					die("stage should be "
+					    "(1|ancestor)|(2|ours|HEAD)|(3|theirs)");
 			}
 			continue;
 		}
-- 
1.4.4.1.gc87e



From: Vlad Dogaru <vdogaru@ixiacom.com>
Subject: [PATCH] git-p4: explicitly specify that HEAD is a revision
Date: Mon, 7 Apr 2014 16:19:11 +0300
Message-ID: <20140407131911.GB17654@ixro-vdogaru.ixiacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <pw@padd.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:34:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX9gY-0008TU-3C
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754821AbaDGNdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:33:39 -0400
Received: from mail-bn1lp0140.outbound.protection.outlook.com ([207.46.163.140]:53582
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754274AbaDGNdi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 09:33:38 -0400
X-Greylist: delayed 845 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Apr 2014 09:33:38 EDT
Received: from CH1PRD0610HT003.namprd06.prod.outlook.com (10.255.151.38) by
 BLUPR06MB371.namprd06.prod.outlook.com (10.141.25.149) with Microsoft SMTP
 Server (TLS) id 15.0.913.9; Mon, 7 Apr 2014 13:19:30 +0000
Received: from localhost (205.168.23.154) by pod51011.outlook.com
 (10.255.151.38) with Microsoft SMTP Server (TLS) id 14.16.435.0; Mon, 7 Apr
 2014 13:19:29 +0000
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [205.168.23.154]
X-MS-Exchange-CrossPremises-AuthSource: CH1PRD0610HT003.namprd06.prod.outlook.com
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 06
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: CH1PRD0610HT003.namprd06.prod.outlook.com
X-Forefront-PRVS: 0174BD4BDA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019001)(6009001)(428001)(199002)(189002)(69226001)(54316002)(74706001)(94946001)(54356001)(81686001)(81816001)(53806001)(94316002)(46102001)(95666003)(19580395003)(56776001)(19580405001)(86362001)(83322001)(74876001)(85306002)(76482001)(50466002)(83072002)(23726002)(81342001)(74366001)(33656001)(47446002)(99396002)(56816005)(74662001)(93136001)(90146001)(74502001)(98676001)(97186001)(65816001)(63696002)(66066001)(92726001)(76506004)(76176001)(80022001)(46406003)(83506001)(79102001)(97336001)(87936001)(31966008)(87266001)(95416001)(85852003)(80976001)(93516002)(92566001)(47736001)(59766001)(76796001)(57986002)(47776003)(76786001)(20776003)(81542001)(77096001)(47976001)(77982001)(4396001)(97756001)(49866001)(50986001);DIR:OUT;SFP:1102;SCL:1;SRVR:B
 LUPR06MB371;H:CH1PRD0610HT003.namprd06.prod.outlook.com;FPR:E613F96A.2C96C309.FAD79887.56DA3871.20 
Received-SPF: None (: ixiacom.com does not designate permitted sender hosts)
X-OriginatorOrg: ixiacom.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245834>

'git p4 rebase' fails with the following message if there is a file
named HEAD in the current directory:

	fatal: ambiguous argument 'HEAD': both revision and filename
	Use '--' to separate paths from revisions, like this:
	'git <command> [<revision>...] -- [<file>...]'

Take the suggestion above and explicitly state that HEAD should be
treated as a revision.

Signed-off-by: Vlad Dogaru <vdogaru@ixiacom.com>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index cdfa2df..8d11b25 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3086,7 +3086,7 @@ class P4Rebase(Command):
         print "Rebasing the current branch onto %s" % upstream
         oldHead = read_pipe("git rev-parse HEAD").strip()
         system("git rebase %s" % upstream)
-        system("git diff-tree --stat --summary -M %s HEAD" % oldHead)
+        system("git diff-tree --stat --summary -M %s HEAD --" % oldHead)
         return True
 
 class P4Clone(P4Sync):
-- 
1.8.5.2

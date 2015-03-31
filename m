From: "Holloway, Blair" <Blair_Holloway@playstation.sony.com>
Subject: [PATCH] git-p4: fix filetype detection on files opened exclusively
Date: Tue, 31 Mar 2015 21:54:08 +0000
Message-ID: <2D2A7688059E344DB86768405D63DEB42D3D75FC@USCULXMSG09.am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "luke@diamand.org" <luke@diamand.org>,
	"gitster@pobox.com" <gitster@pobox.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 01 00:28:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd4dY-0000m4-A0
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 00:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090AbbCaW1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 18:27:42 -0400
Received: from mail-bn1on0083.outbound.protection.outlook.com ([157.56.110.83]:55120
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752353AbbCaW1i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2015 18:27:38 -0400
X-Greylist: delayed 1050 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Mar 2015 18:27:37 EDT
Received: from CY1PR08MB1199.namprd08.prod.outlook.com (25.163.22.156) by
 CY1PR08MB1213.namprd08.prod.outlook.com (25.163.22.158) with Microsoft SMTP
 Server (TLS) id 15.1.118.21; Tue, 31 Mar 2015 21:54:16 +0000
Received: from BN1PR08CA0052.namprd08.prod.outlook.com (10.242.217.180) by
 CY1PR08MB1199.namprd08.prod.outlook.com (25.163.22.156) with Microsoft SMTP
 Server (TLS) id 15.1.118.21; Tue, 31 Mar 2015 21:54:13 +0000
Received: from BN1BFFO11FD010.protection.gbl (2a01:111:f400:7c10::1:139) by
 BN1PR08CA0052.outlook.office365.com (2a01:111:e400:16::52) with Microsoft
 SMTP Server (TLS) id 15.1.125.19 via Frontend Transport; Tue, 31 Mar 2015
 21:54:14 +0000
Authentication-Results: spf=none (sender IP is 160.33.194.231)
 smtp.mailfrom=playstation.sony.com; vger.kernel.org; dkim=none (message not
 signed) header.d=none;
Received-SPF: None (protection.outlook.com: playstation.sony.com does not
 designate permitted sender hosts)
Received: from usculsndmail04v.am.sony.com (160.33.194.231) by
 BN1BFFO11FD010.mail.protection.outlook.com (10.58.144.73) with Microsoft SMTP
 Server (TLS) id 15.1.136.16 via Frontend Transport; Tue, 31 Mar 2015 21:54:13
 +0000
Received: from usculsndmail14v.am.sony.com (usculsndmail14v.am.sony.com [146.215.230.105])
	by usculsndmail04v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t2VLsCC6019013
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Tue, 31 Mar 2015 21:54:12 GMT
Thread-Topic: [PATCH] git-p4: fix filetype detection on files opened
 exclusively
Thread-Index: AdBr+9EPXhqFR9lVR6yxg0vl5M1a4A==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [146.215.231.6]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:160.33.194.231;CTRY:US;IPV:NLI;EFV:NLI;BMV:1;SFV:NSPM;SFS:(10009020)(6009001)(428002)(199003)(189002)(105586002)(229853001)(87936001)(92566002)(106466001)(2656002)(46406003)(2351001)(110136001)(104016003)(86362001)(55846006)(50466002)(97756001)(19580405001)(54356999)(2501003)(50986999)(33656002)(6806004)(19580395003)(66066001)(2920100001)(47776003)(77156002)(46102003)(101416001)(62966003)(102836002)(7059030)(80792004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR08MB1199;H:usculsndmail04v.am.sony.com;FPR:;SPF:None;MLV:sfv;A:0;MX:1;LANG:en;
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY1PR08MB1199;UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY1PR08MB1213;
X-Microsoft-Antispam-PRVS: <CY1PR08MB1199F937FA723860871AD9F9C2F40@CY1PR08MB1199.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5002010)(5005006);SRVR:CY1PR08MB1199;BCL:0;PCL:0;RULEID:;SRVR:CY1PR08MB1199;
X-Forefront-PRVS: 0532BF6DC2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2015 21:54:13.6244
 (UTC)
X-MS-Exchange-CrossTenant-Id: 86f99b1e-a08b-4313-8c0c-2258d53da610
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86f99b1e-a08b-4313-8c0c-2258d53da610;Ip=[160.33.194.231];Helo=[usculsndmail04v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR08MB1199
X-OriginatorOrg: playstation.sony.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266568>

If a Perforce server is configured to automatically set +l (exclusive lock) on
add of certain file types, git p4 submit will fail during getP4OpenedType, as
the regex doesn't expect the trailing '*exclusive*' from p4 opened:

//depot/file.png#1 - add default change (binary+l) *exclusive*

Signed-off-by: Blair Holloway <blair_holloway@playstation.sony.com>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index ff132b2..d43482a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -368,7 +368,7 @@ def getP4OpenedType(file):
     # Returns the perforce file type for the given file.
 
     result = p4_read_pipe(["opened", wildcard_encode(file)])
-    match = re.match(".*\((.+)\)\r?$", result)
+    match = re.match(".*\((.+)\)( \*exclusive\*)?\r?$", result)
     if match:
         return match.group(1)
     else:
-- 
1.8.3.msysgit.0

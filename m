From: Edward Thomson <ethomson@microsoft.com>
Subject: Rename conflicts in the index
Date: Wed, 13 Mar 2013 14:08:49 +0000
Message-ID: <A54CE3E330039942B33B670D971F857403995D93@TK5EX14MBXC252.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 13 15:14:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFmS9-00072R-Gd
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 15:14:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162Ab3CMOOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 10:14:23 -0400
Received: from mail-bl2lp0206.outbound.protection.outlook.com ([207.46.163.206]:42062
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755526Ab3CMOOW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Mar 2013 10:14:22 -0400
X-Greylist: delayed 307 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Mar 2013 10:14:22 EDT
Received: from BY2FFO11FD001.protection.gbl (10.1.15.203) by
 BY2FFO11HUB040.protection.gbl (10.1.14.161) with Microsoft SMTP Server (TLS)
 id 15.0.620.12; Wed, 13 Mar 2013 14:09:11 +0000
Received: from TK5EX14MLTC102.redmond.corp.microsoft.com (131.107.125.37) by
 BY2FFO11FD001.mail.protection.outlook.com (10.1.14.123) with Microsoft SMTP
 Server (TLS) id 15.0.620.12 via Frontend Transport; Wed, 13 Mar 2013 14:09:11
 +0000
Received: from TK5EX14MBXC252.redmond.corp.microsoft.com ([169.254.1.2]) by
 TK5EX14MLTC102.redmond.corp.microsoft.com ([157.54.79.180]) with mapi id
 14.02.0318.003; Wed, 13 Mar 2013 14:08:50 +0000
Thread-Topic: Rename conflicts in the index
Thread-Index: Ac4f8fcF2rzNm40zS7GBMxbrAtW2UQ==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [157.54.51.74]
X-Forefront-Antispam-Report: CIP:131.107.125.37;CTRY:US;IPV:CAL;IPV:NLI;EFV:NLI;SFV:NSPM;SFS:(189002)(199002)(53806001)(54316002)(23726001)(76482001)(51856001)(44976002)(46406002)(20776003)(59766001)(56816002)(47776003)(63696002)(50986001)(54356001)(69226001)(50466001)(77982001)(66066001)(47976001)(74662001)(47736001)(4396001)(56776001)(80022001)(561944001)(74502001)(31966008)(55846006)(79102001)(16406001)(49866001)(46102001)(47446002)(65816001)(33656001);DIR:OUT;SFP:;SCL:1;SRVR:BY2FFO11HUB040;H:TK5EX14MLTC102.redmond.corp.microsoft.com;RD:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-OriginatorOrg: microsoft.onmicrosoft.com
X-Forefront-PRVS: 0784C803FD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218054>

When a rename conflict occurs, the information about the conflict is
written to stdout and the index is updated as if the conflict were a
simpler conflict that did not involve renames.  This doesn't give a lot of
information to users after the fact - a status of "added in ours" does not
provide a lot of details about what occurred.

In reimplementations, we face a similar challenge.  Unfortunately, we can't
simply print the output to the console, we would like to provide this
information back to the caller by some mechanism.  My preference would be to
return this information in the index - so that the results of "unpack trees"
(if you will) was a single data structure (the index) and so that we could
persist this information to disk.  I've been considering the idea of an
extension that contains more detailed data about conflicts, but I certainly
wouldn't want to proceed without discussing this here further.

I would propose that we store the data about the file in conflict as it
occurred through the renames.  For example, in a rename 1->2 conflict where
A was renamed to both B and C, you would have a single conflict entry
containing the data for A, B and C.  This would allow us to provide more
detailed information to the user - and allow them to (say) choose a single
name to proceed with.

Is this something that has value to core git as well?  Alternately, is
there something particularly stupid about this proposal?

Thanks-
-ed

From: Dennis van der Wal <d.vanderwal@comparegroup.eu>
Subject: Git line ending trouble
Date: Mon, 14 Oct 2013 11:21:47 +0000
Message-ID: <CE8193B5.3913E%d.vanderwal@comparegroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 14 13:37:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVgSJ-00082j-Tp
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 13:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755750Ab3JNLgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 07:36:55 -0400
Received: from mail-db3lp0084.outbound.protection.outlook.com ([213.199.154.84]:19107
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753797Ab3JNLgy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Oct 2013 07:36:54 -0400
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Oct 2013 07:36:54 EDT
Received: from AMXPR05MB184.eurprd05.prod.outlook.com (10.242.72.151) by
 AMXPR05MB183.eurprd05.prod.outlook.com (10.242.72.149) with Microsoft SMTP
 Server (TLS) id 15.0.785.10; Mon, 14 Oct 2013 11:21:47 +0000
Received: from AMXPR05MB184.eurprd05.prod.outlook.com ([169.254.10.217]) by
 AMXPR05MB184.eurprd05.prod.outlook.com ([169.254.10.217]) with mapi id
 15.00.0785.001; Mon, 14 Oct 2013 11:21:47 +0000
Thread-Topic: Git line ending trouble
Thread-Index: AQHOyM+RT5msfcaC6USNmQRMYB20DA==
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.3.7.130812
x-originating-ip: [78.152.32.28]
x-forefront-prvs: 0999136621
x-forefront-antispam-report: SFV:NSPM;SFS:(11905935001)(53754006)(199002)(189002)(54356001)(74366001)(81342001)(53806001)(83322001)(46102001)(19580395003)(51856001)(63696002)(81542001)(80022001)(74662001)(65816001)(77096001)(74502001)(47446002)(74482001)(74706001)(56816003)(80976001)(31966008)(74876001)(83072001)(69226001)(66066001)(76796001)(76786001)(15975445006)(54316002)(76482001)(49866001)(50986001)(47736001)(47976001)(83506001)(76176001)(4396001)(59766001)(77982001)(81686001)(36756003)(85306002)(81816001)(56776001)(79102001)(140573001);DIR:OUT;SFP:;SCL:1;SRVR:AMXPR05MB183;H:AMXPR05MB184.eurprd05.prod.outlook.com;CLIP:78.152.32.28;FPR:;RD:InfoNoRecords;A:1;MX:1;LANG:en;
Content-ID: <426C47A53FB7A742ACE92BAF575FF4F6@eurprd05.prod.outlook.com>
X-OriginatorOrg: comparegroup.eu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236098>

Hello everyone,

Recently we have migrated from Subversion to Git in a multiplatform,
though mostly Windows oriented working environment. During the course of
this migration we ran into newline issues between people using Mac and
Windows. When investigating the issue we noticed that the migration
process had created many entries in the .gitattributes like "path/to/file
-text", explaining the problem.

To fix this problem we tried cleaning up the .gitattributes file and then
re-adding the files to Git so they would be stored with LF type line
endings (https://help.github.com/articles/dealing-with-line-endings). This
seemed to work until I noticed some weird behaviour, namely that whenever
I executed the aforementioned steps the number of files changed would
differ.

To verify this observation I tried the following experiment. I cloned one
of the migrated repositories 4 times, each of them cloned cleanly into a
different directory. Then for each, on master, I executed the following
commands:
  echo "* text=auto" > .gitattributes
  git add .
  git commit -m "Create basic .gitattributes file."
  git rm -r --cached .
  git reset --hard
  git add .
  git commit -m "Normalise line endings."
Note that the .gitattributes used to consist of one line "* text=auto
!eol" and many of the "path/to/file -text" entries I mentioned before, but
now has all content replaced with "* text=auto".

Each time the second commit command yielded a different result, ranging
from 0 files changed to 738 files changed and most of them hovering around
the 500+ mark. I tried with both version 1.7.12.4 and 1.8.4 on Mac OSX
Mountain Lion (10.8.5).

So my question to this mailing list is: Is this deviation in number of
files changed a known problem and if so is there a known workaround? I
tried looking for this particular observation, but I found it hard to come
up with a search query describing this issue.

Sincerely,
Dennis van der Wal
Java Developer at Compare Group

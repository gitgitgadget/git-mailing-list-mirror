From: Lianheng Tong <lianheng.tong@kcl.ac.uk>
Subject: Submodule relative URL problems
Date: Mon, 13 Jan 2014 14:02:56 +0000
Message-ID: <DAD6CF7D-49F2-4FB5-9EF2-EBAAF86881AA@kcl.ac.uk>
References: <DC691CA7-BE36-4FE7-895A-FE8E1FD0C080@kcl.ac.uk>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 13 15:03:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2i72-0002kO-DU
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jan 2014 15:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbaAMODE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jan 2014 09:03:04 -0500
Received: from mail-am1lp0017.outbound.protection.outlook.com ([213.199.154.17]:25478
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750899AbaAMODD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jan 2014 09:03:03 -0500
Received: from [10.230.152.172] (159.92.9.130) by
 DBXPR03MB527.eurprd03.prod.outlook.com (10.141.12.154) with Microsoft SMTP
 Server (TLS) id 15.0.851.15; Mon, 13 Jan 2014 14:03:00 +0000
In-Reply-To: <DC691CA7-BE36-4FE7-895A-FE8E1FD0C080@kcl.ac.uk>
X-Mailer: Apple Mail (2.1085)
X-Originating-IP: [159.92.9.130]
X-ClientProxiedBy: DB4PR01CA003.eurprd01.prod.exchangelabs.com
 (10.242.152.13) To DBXPR03MB527.eurprd03.prod.outlook.com (10.141.12.154)
X-Forefront-PRVS: 00909363D5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009001)(66654002)(52314003)(189002)(199002)(51874003)(53754006)(74366001)(77982001)(59766001)(74826001)(74876001)(47776003)(65816001)(66066001)(80022001)(79102001)(74662001)(31966008)(47446002)(74502001)(74482001)(50466002)(63696002)(74706001)(76786001)(76796001)(93136001)(23726002)(36756003)(56776001)(57306001)(92726001)(92566001)(83716003)(77156001)(85852003)(69226001)(42186004)(85306002)(76482001)(56816005)(90146001)(87976001)(88136002)(89996001)(83072002)(77096001)(81342001)(87286001)(87266001)(82746002)(33656001)(81816001)(47976001)(50986001)(54316002)(62966002)(51856001)(46102001)(80976001)(53806001)(81542001)(19580395003)(19580405001)(83322001)(50226001)(81686001)(4396001)(46406003)(49866001)(47736001);DIR:OUT;SFP:1101;SCL:1;SRVR:DBXPR03M
 B527;H:[10.230.152.172];CLIP:159.92.9.130;FPR:;RD:InfoNoRecords;MX:1;A:1;LANG:en;
X-OriginatorOrg: kcl.ac.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240361>

Hi All,

I am currently working on a project, call it A, which contains several sub-projects B, C, D.  The B, C, D are actually experimental input and outputs for simulation runs, which I need to keep track of the daily changes.  Most of these calculations are done on workstation, but I do need to occasionally clone the repositories to other machines, and then push the updates back.

I version track B, C and D with independent git repositories, and organisationally it makes sense for them to be subdirectories of A.  I would like to version control the overall project A, with B, C, D as submodules.

This is easily done on the main workstation (I will call it W1), with:

cd A
git init
for ii in B C D ; do
  git submodule ./${ii}/.git
done
git add .
git commit

Repository A/.git on W1 does not have an origin.  All seems to work fine with this step up on W1.

HOWEVER, problem starts to appear when I attempted to clone the overall repository A to another workstation W2:

git clone W1:<path to A on W1>/.git  <path to A on W2>
cd <path to A on W2>
git submodule init
git submodule update

git then produces an error indicating that:

W1:<path to A on W1>/.git/B/.git

is not a valid repository (i.e. directory not found)

The extra .git has been inserted in the URL to submodule repository B, C, and D.

This can be solved by changing the .gitmodules file, replacing ./B/.git to ../B/.git,  and then git submodule sync on W2.

However, this is far from being an optimal solution, because if .gitmodules on W1 is updated accordingly, then the submodule repository for B would point to

<path to A on W1>/../B/.git

which will be incorrect.  I could in principle define the URL for the submodule repositories as absolute paths, but keeping them relative to A has many advantages, such as I will be able to move A around, without effecting the main repositories on W1 in anyway, and I can rsync them to another disk for backup etc.

I would be very grateful if someone can offer me an solution to my problem.

Many thanks in advance!

Lianheng

================================================
Lianheng Tong                                    Tel: +44 79 1758 3822  
Room S4.02, Strand Building           Fax: +44 20 7848 2420  
Department of Physics                       lianheng.tong@kcl.ac.uk
Kings College London                                  
Strand, London WC2R 2LS, U.K.                         
================================================
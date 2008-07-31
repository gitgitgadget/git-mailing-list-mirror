From: "Blum, Robert" <rblum@pandemicstudios.com>
Subject: git-p4, msysgit, and strange behavior
Date: Thu, 31 Jul 2008 11:14:59 -0700
Message-ID: <8778C923356C6541B263428246AE9C2A4FE2966A64@NA-MAIL-2-2.rws.ad.ea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 31 20:29:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOcuE-0000Qk-RR
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 20:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572AbYGaS21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 14:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753644AbYGaS21
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 14:28:27 -0400
Received: from smtp-na3.ea.com ([159.153.6.7]:33740 "EHLO smtp-na3.ea.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753562AbYGaS20 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2008 14:28:26 -0400
X-Greylist: delayed 803 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Jul 2008 14:28:26 EDT
Received: from EAHQ-BH5.rws.ad.ea.com (eahq-bh5.rws.ad.ea.com [10.30.204.14])
	by smtp-na3.ea.com (Switch-3.3.0/Switch-3.3.0) with ESMTP id m6VIF0Oh007502
	for <git@vger.kernel.org>; Thu, 31 Jul 2008 11:15:00 -0700
Received: from na-casht4.rws.ad.ea.com ([10.30.204.161]) by EAHQ-BH5.rws.ad.ea.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 31 Jul 2008 11:14:59 -0700
Received: from NA-MAIL-2-2.rws.ad.ea.com ([10.30.204.156]) by
 na-casht4.rws.ad.ea.com ([192.168.37.22]) with mapi; Thu, 31 Jul 2008
 11:14:59 -0700
Thread-Topic: git-p4, msysgit, and strange behavior
Thread-Index: AcjzOVe5JU6fuF5ITpWKUNkx64bpQA==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-OriginalArrivalTime: 31 Jul 2008 18:14:59.0989 (UTC) FILETIME=[58487C50:01C8F339]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90958>

Hi guys!


I've recently been evaluating DVCS's for work. (Actually, who am I kidding - I love working w/ DVCS and want to convince my bosses to move forward ;)

Since we're a Perforce & Windows shop, git-p4 and msysgit are mandatory. However, I've run into a strange bug. Running git-p4 submit, I always get the message '... - file(s) not in client view'. Yes, I've checked - the files are in the client view, the view is set up properly, talking to the correct server. This only occurs if I'm in any of the directories of the git repository. If I switch to the directories where the P4 data is synced to and use --git-origin, the submit works just fine.

After a bit of digging on the ML, I found http://marc.info/?l=git&m=120437559322494&w=3 and the thread related to it. And yes, indeed, changing all p4 calls like this:

        system("p4 sync ...") --> system("p4 sync %s..." % self.clientPath)

makes the problem go away. I've spent some time debugging the issue, and as far as I can tell, the working dir is set correctly during system(), the p4 environment is set correctly - and yet p4 complains.

As far as I know, I've grabbed the latest git & git-p4 from repo.or.cz. Is this a known problem? Should I clean up & submit the patch, or has anybody investigated a bit more why this is failing? (I don't like the patch because I don't understand *why* p4 fails to behave properly)


Help appreciated,
 - Robert

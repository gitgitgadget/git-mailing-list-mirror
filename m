From: "Kevin Cagle (kcagle) [CONT - Type 2]" <kcagle@micron.com>
Subject: git subtree issue in more recent versions
Date: Tue, 29 Apr 2014 00:50:01 +0000
Message-ID: <55893188F2F68B4B9819D7F9452F981D09FCDF67@NTXBOIMBX01.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 02:50:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WewFQ-0003Vt-4b
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 02:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbaD2AuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 20:50:04 -0400
Received: from mailout.micron.com ([137.201.242.129]:28364 "EHLO
	mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbaD2AuD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2014 20:50:03 -0400
Received: from mail.micron.com (ntxboicas03.micron.com [137.201.84.59])
	by mailout.micron.com (8.14.4/8.14.6) with ESMTP id s3T0o2Sx015939
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Mon, 28 Apr 2014 18:50:02 -0600
Received: from NTXBOIMBX01.micron.com ([fe80::7520:6f5e:51e1:8d75]) by
 NTXBOICAS03.micron.com ([::1]) with mapi id 14.03.0174.001; Mon, 28 Apr 2014
 18:50:01 -0600
Thread-Topic: git subtree issue in more recent versions
Thread-Index: Ac9jRPOFDsc452iCTjCFP83Ii9m4yQ==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.201.88.182]
x-tm-as-product-ver: SMEX-10.0.0.4152-7.000.1014-20662.003
x-tm-as-result: No--28.123500-0.000000-31
x-tm-as-user-approved-sender: Yes
x-tm-as-user-blocked-sender: No
x-mt-checkinternalsenderrule: True
X-Scanned-By: MIMEDefang 2.73 on 137.201.82.105
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247503>

Hi,

I've discovered a bug in git subtree related to annotated tags. The command 'git subtree' will fail if you use an annotated tag as the <refspec>. e.g.:

$ git subtree add -P oldGit https://github.com/git/git.git tags/v1.9.2

Will produce this error:

10ff115f5c572299de4e04ade0d7adb3c75fbf1f is not a valid 'commit' object

The bug isn't found in 1.7.1 (installed subtree manually) but is found in 1.9.0 and 2.0.0.rc1. 

It's related to the git fetch putting the "wrong" SHA1 in .git/FETCH_HEAD. Thus, if you do:

$ git ls-remote https://github.com/git/git.git | grep v1.9.2

You'll see this:
10ff115f5c572299de4e04ade0d7adb3c75fbf1f        refs/tags/v1.9.2
0bc85abb7aa9b24b093253018801a0fb43d01122        refs/tags/v1.9.2^{}

An older version will put the 0bc85a in FETCH_HEAD but newer versions will put 10ff11 which will not work. I'm new to Git so I don't know when/why that was changed but somewhere along the way, that change broke git subtree add. :( A workaround is to use lightweight tags but that's not suitable for some. 

Thanks,
Kevin

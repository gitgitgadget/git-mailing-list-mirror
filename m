From: Illia Bobyr <ibobyr@blizzard.com>
Subject: [gitk] No commit diff when 'safecrlf' set to true is causing an
 error
Date: Tue, 24 Apr 2012 23:32:59 +0000
Message-ID: <B1416C005AC3CA488CB124F971A297500D0824@IRVEX008.corp.blizzard.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 25 01:42:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMpNZ-0004qn-Sy
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 01:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758021Ab2DXXmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 19:42:37 -0400
Received: from mx10.blizzard.com ([12.130.201.12]:48363 "EHLO
	mx10.blizzard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756742Ab2DXXmg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Apr 2012 19:42:36 -0400
X-Greylist: delayed 575 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Apr 2012 19:42:36 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=blizzard.com; i=ibobyr@blizzard.com; q=dns/txt;
  s=mail; t=1335310956; x=1366846956;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=iXsxhz/czz4NbZviY4YpVsEieKDLXlQbT99+0vtOBz4=;
  b=L/GkN6KjuKIAUEcUuHXJQr2Qnvt+9gwxdsYS0AyKS7ueHEE9Am8rqW2b
   +uvEbwj4ad3joJegoX3XEAN1NF5s1xWLoP7DN6L34GEQCiCrrzTaYsZPm
   YmoA6uICyeY0f4RfnTYIR5FGMT3ZUwvezt1G/8CWi835DM32rnUrbfvfp
   k=;
X-IronPort-AV: E=Sophos;i="4.75,476,1330934400"; 
   d="scan'208";a="2926434"
Received: from irvex204.corp.blizzard.net ([10.130.14.25])
  by mx10.blizzard.com with ESMTP; 24 Apr 2012 16:33:00 -0700
Received: from IRVEX022.corp.blizzard.net (10.130.1.157) by
 IRVEX204.corp.blizzard.net (10.130.14.25) with Microsoft SMTP Server (TLS) id
 14.1.289.1; Tue, 24 Apr 2012 16:33:00 -0700
Received: from IRVEX008.corp.blizzard.net ([fe80::c5f9:f4ad:53fc:4d4b]) by
 IRVEX022.corp.blizzard.net ([10.130.1.157]) with mapi id 14.01.0289.001; Tue,
 24 Apr 2012 16:33:00 -0700
Thread-Topic: [gitk] No commit diff when 'safecrlf' set to true is causing
 an error
Thread-Index: Ac0ibzF1yF0g39PaTA+bYfAQmeEVkQ==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.129.238.124]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196293>

Hi,

The idea of my complain is that if a patch may not be shown because diff-tree returns an error, that error should be visible to the user.
Right now it is silently ignored.

I hit this when I was changing between profiles with different safecrlf/autocrlf settings and some commits would not show any diffs any more in gitk.  Without any errors.

Here is a test case:

mkdir gitk-silent-error-test
cd gitk-silent-error-test

git init .

git config core.autocrlf false
git config core.safecrlf false

echo hello > test
git add test
git commit -m 1

echo there >> test
git add test
git commit -m 2

gitk

In the gitk window I now see both commits along with the commit messages, but do not see the patch for the second commit.
And as a user I do not really understand why at this point there are no error messages.

I was able to figure out that it is the git diff-tree command that gitk is using who is complaining.
It seems a little unintuitive that error in the file format in my working directory affects what gitk is showing.

I think that gitk should have provided a --no-check argument to diff-tree if there would be one.  But there is none.
And I might be wrong about the best solution.

Thank you,
Ilya Bobyr

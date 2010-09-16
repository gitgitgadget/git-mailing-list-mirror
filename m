From: Wincent Colaiuta <win@wincent.com>
Subject: v1.7.3-rc2 has t7003 breakage on Mac OS X 10.6.4
Date: Thu, 16 Sep 2010 09:18:46 +0200
Message-ID: <664FE520-CDB1-4595-867A-9AEB4790C092@wincent.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 16 10:27:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow9oP-00058Q-RP
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 10:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726Ab0IPI1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 04:27:15 -0400
Received: from outmail128142.authsmtp.net ([62.13.128.142]:62573 "EHLO
	outmail128142.authsmtp.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750695Ab0IPI1N convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 04:27:13 -0400
X-Greylist: delayed 4096 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Sep 2010 04:27:12 EDT
Received: from mail-c193.authsmtp.com (mail-c193.authsmtp.com [62.13.128.118])
	by punt10.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o8G7IsWt040018
	for <git@vger.kernel.org>; Thu, 16 Sep 2010 08:18:54 +0100 (BST)
Received: from zenyatta.unixhosts.net (ec2-184-73-234-210.compute-1.amazonaws.com [184.73.234.210])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2) with ESMTP id o8G7IoCA001270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 16 Sep 2010 08:18:51 +0100 (BST)
Received: from [192.168.1.6] (7.Red-83-59-198.dynamicIP.rima-tde.net [83.59.198.7] (may be forged))
	(authenticated bits=0)
	by zenyatta.unixhosts.net (8.14.2/8.14.2) with ESMTP id o8G7IkSD009268
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Thu, 16 Sep 2010 03:18:49 -0400
X-Mailer: Apple Mail (2.1081)
X-Server-Quench: a865e98d-c162-11df-97bb-002264978518
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha Dh4fBRVVLUBPVglL NEteaF1JP0tFGxZi ViYUWVRVUE1xUWl0 YwBUb0tcak5QWAZ0 UktNXFBTFBpqBAMA SEEWJR4LKHY3eH5x Z0FiEHVZXkQ0JE57 RxtdHTkbNmZman0e URQOagpTIlFXfh9H aFZ7XXQFZGQPKDxh WVB1ZHUrNm8XKC1O Ch1SdQpJCUwREzc/ Th8PVTIpVWgMTG0U FFQWYgdEWhhXbi0A 
X-Authentic-SMTP: 61633436303433.1014:706
X-AuthFastPath: 0 (Was 255)
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156297>

Hi,

Just noticed a new test failure in t7003 on Mac OS X 10.6.4. Wasn't present in rc1, but is in rc2.

Relevant section of "make test" output:

  https://wincent.com/snippets/7

The failing test is "30 automatic remapping to ancestor with filename filters".

Here's a segment of the output of "sh -x t7003-filter-branch.sh" from inside the "t" directory (this is just the part near test 30):

  https://wincent.com/snippets/5

And here's the entire output of "sh -x t7003-filter-branch.sh" (thousands of lines long):

  https://wincent.com/snippets/6

This is on a pretty "stock" version of Mac OS X, using Apple-supplied Bash:

  GNU bash, version 3.2.48(1)-release (x86_64-apple-darwin10.0)
  Copyright (C) 2007 Free Software Foundation, Inc.

According to "git bisect", this is the change that is responsible for the breakage:

7ec344d802970782036146e29ba2213e86d49fe1 is the first bad commit
commit 7ec344d802970782036146e29ba2213e86d49fe1
Author: Csaba Henk <csaba@gluster.com>
Date:   Fri Aug 27 20:44:56 2010 +0000

    filter-branch: retire --remap-to-ancestor
    
    We can be clever and know by ourselves when we need the behavior
    implied by "--remap-to-ancestor". No need to encumber users by having
    them exposed to it as a tunable. (Option kept for backward compatibility,
    but it's now a no-op.)
    
    Signed-off-by: Csaba Henk <csaba@gluster.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

:040000 040000 d67e263477f73a8f14528e6e7a6a84506c8febf4 3d6f1b24dc76f44e0cdb28b5d2738b46cb339f32 M	Documentation
:100755 100755 88fb0f070e5f32c62ae47f90f1f27ffeef836d8f 962a93b586571eb6fc60aae53c77f6e6b9fb281f M	git-filter-branch.sh
:040000 040000 e43459803e2662799c23a81fbe2f47abe2f9b0f9 afc5fd99e7c1ffd56adcb0dedba634463f686cc0 M	t

Please let me know if you need any further info to troubleshoot the issue.

Cheers,
Wincent

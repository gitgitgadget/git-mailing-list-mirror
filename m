From: =?ISO-8859-1?Q?=22Andr=E9s_G=2E_Aragoneses=22?= <knocte@gmail.com>
Subject: [PATCH] transport: Catch non positive --depth option value
Date: Wed, 13 Nov 2013 17:06:24 +0100
Message-ID: <5283A380.9030308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 13 17:10:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vgd19-0004RL-0R
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 17:10:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756929Ab3KMQKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 11:10:07 -0500
Received: from plane.gmane.org ([80.91.229.3]:47558 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756293Ab3KMQKF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Nov 2013 11:10:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Vgd11-0004HI-Oc
	for git@vger.kernel.org; Wed, 13 Nov 2013 17:10:03 +0100
Received: from 141.78.228.118 ([141.78.228.118])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Nov 2013 17:10:03 +0100
Received: from knocte by 141.78.228.118 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Nov 2013 17:10:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 141.78.228.118
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237790>

Instead of simply ignoring the value passed to --depth
option when it is zero or negative, now it is caught
and reported.

This will let people know that they were using the
option incorrectly (as depth<0 should be simply invalid,
and under the hood depth==0 didn't mean 'no depth' or
'no history' but 'full depth' instead).

Signed-off-by: Andres G. Aragoneses <knocte@gmail.com>
---
  transport.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/transport.c b/transport.c
index 7202b77..edd63eb 100644
--- a/transport.c
+++ b/transport.c
@@ -483,6 +483,8 @@ static int set_git_option(struct 
git_transport_options *opts,
  			opts->depth = strtol(value, &end, 0);
  			if (*end)
  				die("transport: invalid depth option '%s'", value);
+			if (opts->depth < 1)
+				die("transport: invalid depth option '%s' (non positive)", value);
  		}
  		return 0;
  	}
-- 
1.8.1.2

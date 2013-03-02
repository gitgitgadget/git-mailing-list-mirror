From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [BUG?] am --abort on null cache entries fails
Date: Fri, 01 Mar 2013 16:52:16 -0800
Message-ID: <51314D40.9030209@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 02 01:52:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBah1-00068c-J1
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 01:52:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918Ab3CBAwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 19:52:18 -0500
Received: from wolverine02.qualcomm.com ([199.106.114.251]:55753 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab3CBAwR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 19:52:17 -0500
X-IronPort-AV: E=Sophos;i="4.84,766,1355126400"; 
   d="scan'208";a="27398553"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Mar 2013 16:52:17 -0800
Received: from [10.46.166.8] (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id E7F7E10004B1;
	Fri,  1 Mar 2013 16:52:16 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217315>

Hi,

I was trying git am -3 with a patch that touched files that didn't exist
in the branch I was on. Obviously it failed badly, so I wanted to abort
out of the git am state with git am --abort. Unfortunately, it seems
that git am --abort in this scenario fails with this error:

error: cache entry has null sha1: <non-existant-file>

and then leaves the file in my working tree untracked. This didn't used
to happen, so I bisected it down to this commit

commit 4337b5856f88f18da47c176e3cbc95a35627044c
Author: Jeff King <peff@peff.net>
Date: Sat Jul 28 11:05:24 2012 -0400
do not write null sha1s to on-disk index

Which definitely introduced that error message. How do we fix this?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

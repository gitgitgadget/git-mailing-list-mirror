From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/3] stop storing trailing slash in dir-hash
Date: Fri, 13 Sep 2013 07:15:40 -0400
Message-ID: <1379070943-36595-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 13 13:16:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKRML-0000jY-Sk
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 13:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755114Ab3IMLQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 07:16:18 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:59384 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376Ab3IMLQR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 07:16:17 -0400
Received: by mail-ob0-f169.google.com with SMTP id wp4so961448obc.0
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 04:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=2erT4PEw86phnOoxKM+dulP3W8fp7erQrE41tlnaylM=;
        b=ZkJnHmekHsceGtjT98zXc6fgZGjbVc55JIEJ0aaHApfx9FPb1Li6Kw/gGkirUmq40X
         L7uznVObz2/9vmsRTu9fLi9cwV19sxo57UEETDJ9cvSPphENFkWAEc8Z22s3jlGsfngC
         qgi1vjS6w2rVaeHB4tbjdVnaARHbDN5TLw7ClyLIDh4WldB+HJjsE00XyJ5gU2IqB1ht
         sTvLdXjefS3L8nzJtj/IrzMWB8qR2EO+JjEyAYFW9id5AC9eSYW/iIBvfxYrLro4lSBG
         hDr7pZDqgaRE56/xws195g1dch/gABiaQaKHrn8gmXhlBZrXPvd6TWiHwdnfj4vqNbNF
         vwjA==
X-Received: by 10.182.80.196 with SMTP id t4mr11732157obx.1.1379070976661;
        Fri, 13 Sep 2013 04:16:16 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dr8.cable.mindspring.com. [69.81.183.104])
        by mx.google.com with ESMTPSA id it7sm13049040obb.11.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 13 Sep 2013 04:16:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.457.g424cb08
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234743>

This series alters name-hash so that it no longer stores the (redundant)
trailing slash with index_state.dir_hash entries. As an intentional
side-effect, the series fixes [1] in a cleaner way (suggested by Junio
[2]) than either [3] (680be044 in master) or [4].

As noted by Peff [5], this change is at a fairly fundamental level, so
care has been taken to ensure that all tests still pass (thus it at
least does not break anything covered by the tests).

[1]: http://thread.gmane.org/gmane.comp.version-control.git/232727
[2]: http://thread.gmane.org/gmane.comp.version-control.git/232727/focus=232813
[3]: http://thread.gmane.org/gmane.comp.version-control.git/232796
[4]: http://thread.gmane.org/gmane.comp.version-control.git/232833
[5]: http://thread.gmane.org/gmane.comp.version-control.git/232727/focus=232822

Eric Sunshine (3):
  name-hash: refactor polymorphic index_name_exists()
  name-hash: stop storing trailing '/' on paths in index_state.dir_hash
  dir: revert work-around for retired dangerous behavior

 cache.h      |  2 ++
 dir.c        | 25 +++++++------------------
 name-hash.c  | 54 ++++++++++++++++++++++++++++--------------------------
 read-cache.c |  2 +-
 4 files changed, 38 insertions(+), 45 deletions(-)

-- 
1.8.4.457.g424cb08

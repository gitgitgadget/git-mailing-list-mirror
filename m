From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH 0/7] Clarify signed push protocol documentation
Date: Wed,  1 Jul 2015 11:08:12 -0700
Message-ID: <1435774099-21260-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 20:09:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAMSE-0005AG-Vz
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 20:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635AbbGASJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 14:09:46 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:35045 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539AbbGASIq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 14:08:46 -0400
Received: by iecuq6 with SMTP id uq6so40219907iec.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 11:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Ret4IWRYsfybQpwR5MGUobi9c8t3L2+kNxyP/BlpeTY=;
        b=mt9fNJVocn2tnAKaZK8DjZLf2cxIoUGSVAe3I90sOAzwJcX9hVPV7XmGDaWyRWwq56
         JUXRManUiblOPAN9Wlgz7De312BgVN1zIXJgYCcW7UlbNbvRZA5fefuR79tFqHZGo6rB
         xnJL/ONnZO4nvL/S5xVGyQxiWwHKvbtnuIgvmkFDhZOqtHHCfBDvu0nTvZKb4dDeWSYX
         G9DLOXmC0rg8aR5OruvIiBvVukIMnWJMlXv1OLuH60YxZNosu1CStsA8Z03UVt1atEhW
         +A6aF6MgdDWW5X/vz+vt0oMxZQslZcB1PAMtZ/sBa2ERYZ2pKnmauE64YEYw+DTkAO2H
         cZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ret4IWRYsfybQpwR5MGUobi9c8t3L2+kNxyP/BlpeTY=;
        b=Je5nAaU90l8p7KVr0/QhapyfH663egigJ2C3QQL0EbZXlFaECNvLnQx63MAD9yr7EW
         HatABJCm1bmvz+3vQ9OYAWarFS6zBuMrOn6JmbT9Jp717FpyUuvjFN2eYIzaFG98X0H1
         0BIyzvjZP4591g8WMuT6Y5EI1KCQWt3lLZudeUnFHKOdF+NTQj/PWiZS8/SFNlBk0kaL
         L1H0Y+JSnCa7lK3YqSZjPV2w6DZztlFwAFzhL9aNtm0HivZkd908f/gZcNqySP76+xZz
         JqZq4u8wQ2m2EgAkdK3yvKrJLjbK8JzLt3FQFBV+2OrccNNcdLc/RZ88zL3OvcqAzbPU
         hDvg==
X-Gm-Message-State: ALoCoQlK0fTEqM36Q24Yh3wjZWWfXV0Eo0kAlJfrQZwx4YTUsdSzvjvMM4sH+tp/VRwCisX/8207
X-Received: by 10.107.37.14 with SMTP id l14mr2249286iol.12.1435774125663;
        Wed, 01 Jul 2015 11:08:45 -0700 (PDT)
Received: from serval.mtv.corp.google.com ([172.27.69.27])
        by smtp.gmail.com with ESMTPSA id k2sm2782076ige.1.2015.07.01.11.08.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Jul 2015 11:08:44 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.573.g4eafbef
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273175>

The signed push protocol documentation did not really match the reality of what
send-pack.c and receive-pack.c do, much to my chagrin as I attempted to
implement this protocol in JGit. This series covers most of the issues I found
on a first pass.

Dave Borowitz (7):
  pack-protocol.txt: Add warning about protocol inaccuracies
  pack-protocol.txt: Mark LF in command-list as optional
  pack-protocol.txt: Mark all LFs in push-cert as required
  pack-protocol.txt: Elaborate on pusher identity
  pack-protocol.txt: Be more precise about pusher-key relationship
  pack-protocol.txt: Mark pushee field as optional
  send-pack.c: Die if the nonce is empty

 Documentation/technical/pack-protocol.txt | 38 +++++++++++++++++++++++++------
 send-pack.c                               |  2 ++
 2 files changed, 33 insertions(+), 7 deletions(-)

-- 
2.4.3.573.g4eafbef

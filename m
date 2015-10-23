From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/3] expose parallelism for submodule {update, clone}
Date: Fri, 23 Oct 2015 11:44:36 -0700
Message-ID: <1445625879-30330-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Oct 23 21:11:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZphkI-00017I-RL
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 21:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342AbbJWTLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2015 15:11:19 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33974 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754302AbbJWSon (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2015 14:44:43 -0400
Received: by padhk11 with SMTP id hk11so125228256pad.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2015 11:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=eYhKktUFfMtpbN7tWK8hFsgU74tAod5318WMbBikw7c=;
        b=MMDNXmJs9GSSQRhNtNHF6kCMTg0pyvXEkCtnAdUnN4LLW1ywI/TMlVbe2i0vhoIOYr
         ktPLg5JJ1I7Uo6PBblNc9I+NP+db0lINfd3PAXBCsak5blT5MMDfpiwO5738kvRykNYh
         TEBr9N1Q50B2BEJesvI2uJ10iWDNggR2d4CpJGdNksw3ji//GbVswzbksEgmPkVrWeDd
         OWvQi7dGj8naIqRJXJiKI9eA1jDk8dph1K2jlWG6ea3QDAYr5zfRydbsLpg5jPswqpPe
         CkyppSbJ2RBIAdfo/vlGB5BaMkwdjXPe8D5uHtf77nTPfykm7Wq+YkMo0y3Qm0uRGr7O
         Km2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eYhKktUFfMtpbN7tWK8hFsgU74tAod5318WMbBikw7c=;
        b=aveCClFZYXyDn3btoRYy3IqTPEdWkBF/XVY3rXyfsg08o2NcNoLa5d5GJsjTU76HFn
         9CUVaUUDuq62cxwoO7cMeLWi/kxde95c76p+VdseaA4n4am/BuWeWCbpysVTJ7j7EuMF
         t0znt3GkBBkzXz8oMR/mW4Oyi9BBMyXLbGWhhKNe0DKUioCyfJnyzZsvjyV5RZErClLB
         IHtCCaSMcp4Zm6ORB0NDgaqeO5C5nLlDasxnV0Yy53OKpLYG2YfsI8bpwbB+yH3s7NIH
         u3vFfaJmFPXdZSvIaPTqIILeFY5VPsInRzSJRAeH70EnmUWufGJxCYlcOoni+BwqhpYM
         itSQ==
X-Gm-Message-State: ALoCoQnXffGMTaWzFg3lKPOxG7Yrop10YgkzJCl5uiQ37tEEUtQTR2c3hlBDlDAqCoeYVabA9218
X-Received: by 10.68.252.194 with SMTP id zu2mr6664494pbc.58.1445625882458;
        Fri, 23 Oct 2015 11:44:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:7d77:bdba:3237:8a09])
        by smtp.gmail.com with ESMTPSA id qb7sm20285260pab.47.2015.10.23.11.44.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 23 Oct 2015 11:44:41 -0700 (PDT)
X-Mailer: git-send-email 2.6.2.280.g74301d6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280106>

This goes on top of origin/sb/submodule-parallel-fetch^
The first patch replaces the last patch of origin/sb/submodule-parallel-fetch
using clearer names for the callback functions.

The patches 2 and 3 introduce CLI options for {submodule update, clone} to instruct Git
to be parallel for cloning submodule operations.

Additionally `git submodule update` respects the config option "submodule.jobs".

I also want to make "git fetch --recurse-submodules" and "git clone --recursive"
respect the same "submodule.jobs" config option, but that code change would collide
with origin/sb/submodule-config-parse, so I will put the patches on top of that.

Stefan Beller (3):
  git submodule update: have a dedicated helper for cloning
  submodule update: Expose parallelism to the user
  clone: Allow an explicit argument for parallel submodule clones

 Documentation/git-clone.txt     |   5 +-
 Documentation/git-submodule.txt |   6 +-
 builtin/clone.c                 |  23 ++--
 builtin/submodule--helper.c     | 234 ++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh                |  54 ++++------
 t/t7400-submodule-basic.sh      |   4 +-
 6 files changed, 282 insertions(+), 44 deletions(-)

-- 
2.6.2.280.g74301d6

From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2 0/6] Rewrite `git_config()` using config-set API
Date: Fri, 25 Jul 2014 05:58:09 -0700
Message-ID: <1406293095-15920-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 14:59:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAf5R-0002sc-QA
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 14:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760400AbaGYM65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 08:58:57 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:46713 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760395AbaGYM64 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 08:58:56 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa1so5944625pad.41
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 05:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=DKK3QF4J+Vo7++rd0ZJu7kzMnipWKsSglHey7AYmCsU=;
        b=SGF7DCVTKHeQVSNd+GqrSOkz3xHY+zvTMyBuye+pzDS9m9uHS08+H2hnKAjeLJiWWz
         GAu4KqCIePgrSnBCMnyF8vssiy9aEIG6RJd0WyJZ89NJKrh+ZGzlTZy9nE7ua4wzu3S7
         abIxPEIvmPRx6rMxzQuyUNCJ2XV06BGJkHxX+e0rKb4SPXIl9JzlGAoq681vQww1z5i0
         QgTtUuDIummTSBV3M8Lvdong7ojWGkiqmXYfwoU2WJJZHaTGDxIJ9BpKnL0Ryi+11COa
         LX5Honl+R+0+s3PEzAOYXkrXKf3haTj0OWmQXmef9r0Sl0g7dYD8BBYiKMT23T0pc1Ay
         dn/g==
X-Received: by 10.69.3.67 with SMTP id bu3mr18620974pbd.34.1406293136365;
        Fri, 25 Jul 2014 05:58:56 -0700 (PDT)
Received: from localhost.localdomain ([223.176.246.45])
        by mx.google.com with ESMTPSA id tg9sm8798900pbc.29.2014.07.25.05.58.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Jul 2014 05:58:55 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254211>

[PATCH V2]: All the suggestions in [2] incorporated. git_config() now follows
	correct parsing order. Reordered the patches. Removed xfuncname patch
	as it was unnecssary.

This series builds on the top of 1d2856f (ta/config-set) in pu or topic[1]
in the mailing list with name "git config cache & special querying API utilizing
the cache".

This series aims to do these three things,

* Use the config-set API to rewrite git_config().

* Solve any legacy bugs in the previous system while at it.

* To be feature complete compared to the previous git_config() implementation,
  which I think it is now. (added the line number and file name info just for
  completeness)

Also, I haven't yet checked the exact improvements but still as a teaser,
git status now only rereads the configuration files twice instead of four
times.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/253862
[2]: http://thread.gmane.org/gmane.comp.version-control.git/254101

Tanay Abhra (6):
  config.c: fix accuracy of line number in errors
  add line number and file name info to `config_set`
  rewrite git_config() to use the config-set API
  add a test for semantic errors in config files
  config: add `git_die_config()` to the config-set API
  Add tests for `git_config_get_string()`

 Documentation/technical/api-config.txt |   5 ++
 cache.h                                |  26 +++++++
 config.c                               | 135 ++++++++++++++++++++++++++++-----
 t/t1308-config-set.sh                  |  20 +++++
 test-config.c                          |  10 +++
 5 files changed, 175 insertions(+), 21 deletions(-)

-- 
1.9.0.GIT

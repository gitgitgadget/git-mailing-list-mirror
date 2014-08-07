From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v9 0/8] Rewrite `git_config()` using config-set API
Date: Thu,  7 Aug 2014 04:59:11 -0700
Message-ID: <1407412759-13833-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 14:00:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFMMe-0004eH-FW
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 14:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbaHGMAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 08:00:06 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36737 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597AbaHGMAF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 08:00:05 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so5130616pdj.12
        for <git@vger.kernel.org>; Thu, 07 Aug 2014 05:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=7DvdfXFCOqiQnGX/LG4oiPNciWA9opS0C/y/wKMntr0=;
        b=y1UUUEUOb6gXrvkFtOb8X44FobUTQtQquizYvzQnGhwuZ9e0zkkvddCh2/aFobC5GB
         Bn+tvHFX3yO1U/sUAb/kr+GsAgc75aqp6L/dbPgO+DflEOfI/faJmjyAMA8nTuEsa1Fr
         oKUnMTJl33NqJf1SvxCU/pYM1TBQ3ZD8OAof4COoWGzBPNKqLH4wLvEvRlRos/WbvqL+
         1FBiXJCdH/r2l/gQ1vixDCjuDBfeWRWzMVoKSOG/PAUREg+dugZws8YgRQBVEZGjx++X
         frwtIkDtdxspErM81c/H/LMHi6ZFPqfMwv9kSVHGKSrYMSgGo00piPefvGEvuraFwefa
         nVtQ==
X-Received: by 10.70.38.203 with SMTP id i11mr1320898pdk.162.1407412803768;
        Thu, 07 Aug 2014 05:00:03 -0700 (PDT)
Received: from localhost.localdomain ([223.176.226.83])
        by mx.google.com with ESMTPSA id cb8sm13997212pad.8.2014.08.07.05.00.00
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Aug 2014 05:00:02 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254949>

[Patch v9]: Changed the grep statements in patch 7/8 and 8/8.

[Patch v8]: git_die_config now allows custom error messages.
	new tests are now not too reliant on specific strings.

[Patch v7]: style nit corrected. (1/8) is Matthieu's translation patch.
	git_die_config_linenr() helper function added. Diff between v6
	and v7 appended for review.

[Patch v6]: Added _(....) to error messages.
	Diff between v6 and v4 at the bottom.

[PATCH v5]: New patch added (3/7). git_config() now returns void.

[PATCH v4]: One style nit corrected, also added key to error messages.

[PATCH V3]:All the suggestions in [3] applied. Built on top of [1].

[PATCH V2]: All the suggestions in [2] incorporated. git_config() now follows
	correct parsing order. Reordered the patches. Removed xfuncname patch
	as it was unnecssary.

This series builds on the top of topic[1] in the mailing list with name
"git config cache & special querying API utilizing the cache" or (ta/config-set in pu).

This series aims to do these three things,

* Use the config-set API to rewrite git_config().

* Solve any legacy bugs in the previous system while at it.

* To be feature complete compared to the previous git_config() implementation,
	which I think it is now. (added the line number and file name info just for
	completeness)

Also, I haven't yet checked the exact improvements but still as a teaser,
git status now only rereads the configuration files twice instead of four
times.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/254286
[2]: http://thread.gmane.org/gmane.comp.version-control.git/254101
[3]: http://thread.gmane.org/gmane.comp.version-control.git/254211


Matthieu Moy (1):
  config.c: mark error and warnings strings for translation

Tanay Abhra (7):
  config.c: fix accuracy of line number in errors
  add line number and file name info to `config_set`
  change `git_config()` return value to void
  config: add `git_die_config()` to the config-set API
  rewrite git_config() to use the config-set API
  add a test for semantic errors in config files
  add tests for `git_config_get_string_const()`

 Documentation/technical/api-config.txt |  13 +++
 branch.c                               |   5 +-
 cache.h                                |  34 +++++++-
 config.c                               | 152 +++++++++++++++++++++++++++------
 t/t1308-config-set.sh                  |  21 +++++
 t/t4055-diff-context.sh                |   2 +-
 test-config.c                          |  10 +++
 7 files changed, 207 insertions(+), 30 deletions(-)

-- 
1.9.0.GIT

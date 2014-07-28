From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v3 0/6] Rewrite `git_config()` using config-set API
Date: Mon, 28 Jul 2014 03:33:49 -0700
Message-ID: <1406543635-19281-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 12:34:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBiGK-0008Fh-9y
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 12:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbaG1Kec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 06:34:32 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33613 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbaG1Kec (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 06:34:32 -0400
Received: by mail-pa0-f53.google.com with SMTP id kq14so10267256pab.12
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 03:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ljIBb80u7oesYpG3SSnH7cXkWKCw2mnhG7eDjzl2wg8=;
        b=EEM+fupryzB+qf9CkfEZkyCCNWzx4aPkaRqCyYNBK3QZKCgtknm3kY/VKwekeplKXS
         8io8yKHi13Nml7HIIkJSmuYUo8RC2PehG2DikFDm9H4kYqQo8Rors9ZLnunZwUQl7rIu
         LBmvSIoadkJ/C2SYzjRTFFA42Z1eplJMJttbsRNQuV74qnLum1nVVKexi/XG3jOlQ1+9
         zmaavKnGnQZPBSCMg2auswwSQ9mMhkkQuVt2/YOO0jWGjybNZo7nMsk+r0vXrGxlb4Xz
         1tsIZckgP6xYFb8CKtxn7DVmJPjCSO05iddJGWBXrV7Pye/VoUtaH8t2o+kPUmoydzJB
         c23w==
X-Received: by 10.70.35.169 with SMTP id i9mr34375061pdj.36.1406543671581;
        Mon, 28 Jul 2014 03:34:31 -0700 (PDT)
Received: from localhost.localdomain ([106.211.56.253])
        by mx.google.com with ESMTPSA id v8sm23639483pdr.45.2014.07.28.03.34.28
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Jul 2014 03:34:31 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254290>

[PATCH V3]:All the suggestions in [3] applied. Built on top of [1].

[PATCH V2]: All the suggestions in [2] incorporated. git_config() now follows
	correct parsing order. Reordered the patches. Removed xfuncname patch
	as it was unnecssary.

This series builds on the top of topic[1] in the mailing list with name
"git config cache & special querying API utilizing the cache".

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

Tanay Abhra (6):
  config.c: fix accuracy of line number in errors
  add line number and file name info to `config_set`
  rewrite git_config() to use the config-set API
  add a test for semantic errors in config files
  config: add `git_die_config()` to the config-set API
  add tests for `git_config_get_string()`

 Documentation/technical/api-config.txt |   5 ++
 cache.h                                |  25 ++++++++
 config.c                               | 114 +++++++++++++++++++++++++++++----
 t/t1308-config-set.sh                  |  20 ++++++
 test-config.c                          |  10 +++
 5 files changed, 161 insertions(+), 13 deletions(-)

-- 
1.9.0.GIT

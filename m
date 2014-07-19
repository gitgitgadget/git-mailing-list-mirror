From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v11 0/4] git config cache & special querying api utilizing the cache
Date: Fri, 18 Jul 2014 22:46:14 -0700
Message-ID: <1405748778-3755-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 19 07:47:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8NUr-0001xM-I7
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 07:47:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328AbaGSFrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 01:47:45 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:40430 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbaGSFro (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 01:47:44 -0400
Received: by mail-pd0-f172.google.com with SMTP id ft15so6175656pdb.31
        for <git@vger.kernel.org>; Fri, 18 Jul 2014 22:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Z4kKNzGv1XbXkQ7C9hpzD1u+qUg9gAn8BkmCkMgBr0k=;
        b=FC87vZCLLOhtDFrGaSawLxYGS9+diZzoYG2BS0b2ivKMuxEMgYXJbIV7KKjdPP6qTw
         wE7Wg8B+Qegfmlvq/yM5rYJBX2ygvrP3kCHBF31T9YTAijixdCq8na0qG41js3XzjVJK
         z0AGqbU41v4nuA1gDyMI9BndRB6JrJZ0WAOnWPcNYneNc+GsJfloTVReCZK59NVqTtMn
         MyD+2t+k/BHycldny36vDPpJrkJucfLzlrLHr8ay00HY3l17ba/0qTGLXI66C4W9e1TK
         ycJXsTAojmtBJCAgDiOZWWSNY/MLJ5C6Ngdy1cU7wMKBlRYZj0vjO+9P+GRisFRk8uiv
         GMvQ==
X-Received: by 10.68.203.132 with SMTP id kq4mr10617762pbc.12.1405748864084;
        Fri, 18 Jul 2014 22:47:44 -0700 (PDT)
Received: from localhost.localdomain ([223.176.228.151])
        by mx.google.com with ESMTPSA id mz8sm9919087pdb.62.2014.07.18.22.47.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 18 Jul 2014 22:47:43 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253862>

Hi,

[PATCH V11]: very minor fixes. check [13] for discussion.

[PATCH v10]: Minor fixes according to [12]. Re added string_list initializer function.
	Thanks to Junio and Matthieu for their suggestions.

[PATCH v9]: Applied most of the review comments mentioned in [11]. Mostly asthetic changes.
	test-config now clears the config_set before exiting. Most of the tests now use the
	check-config function. check_config_init() now handles return values correctly.
	Diff between v8 and v9 is at the bottom. Thanks to Junio and Matthieu for the review.

[PATCH V8]: Moved the contents of config-set.c to config.c for future convenience. Reverted
	test 'find value with misspelled key' to the one in v5. See [10] for the discussion.

[PATCH V7]: Style nits and a broken && chain corrected in `t/t1308-config-set.sh`. See
	[9] for the nits.

[PATCH V6]: Style nits and mistakes corrected. Diff between v6 and v5[8] is at the bottom.
		Thanks to Matthieu, Ramsay and Ram for their suggestions.

[PATCH V5]: `config_set` now uses a single hashmap. Corrected style nits raised in
			the thread[7]. Thanks to Junio and Matthieu for their suggestions.

[PATCH v4]: Introduced `config_set` construct which points to a ordered set of
	config-files cached as hashmaps. Added relevant API functions. For more
	details see the documentation. Rewrote the git_config_get* family to use
	`config_set` internally. Added tests for both config_set API and git_config_get
	family. Added type specific API functions which parses the found value and
	converts it into a specific type.
	Most of the changes implemented are the result of discussion in [6].
	Thanks to Eric, Ramsay, Junio, Matthieu & Karsten for their suggestions
	and review.

[PATCH v3]: Added flag for NULL values that were causing segfaults in some cases.
	Added test-config for usage examples.
	Minor changes and corrections. Refer to discussion thread[5] for more details.
	Thanks to Matthieu, Jeff and Junio for their valuable suggestions.

[PATCH v2]:Changed the string_list to a struct instead of pointer to a struct.
	Added string-list initilization functions.
	Minor mistakes corrected acoording to review comments[4]. Thanks to
	Eric and Matthieu for their review.

[PATCH V1]:Most of the invaluable suggestions by Eric Sunshine, Torsten Bogershausen and
	Jeff King has been implemented[1]. Complete rewrite of config_cache*() family
	using git_config() as hook as suggested by Jeff. Thanks for the review.

[RFC V2]: Improved according to the suggestions by Eric Sunshine and Torsten Bogershausen.
	Added cache invalidation when config file is changed.[2]
	I am using git_config_set_multivar_in_file() as an update hook.

This is patch is for this year's GSoC. My project is
"Git Config API improvements". The link of my proposal is appended below [3].

The aim of this patch series is to generate a cache for querying values from
the config files in a non-callback manner as the current method reads and
parses the config files every time a value is queried for.

The cache is generated from hooking the update_cache function to the current
parsing and callback mechanism in config.c. It is implemented as an hashmap
using the hashmap-api with variables and its corresponding values list as
its members. The values in the list are sorted in order of increasing priority.
The cache is initialised the first time when any of the new query functions is
called. It is invalidated by using git_config_set_multivar_in_file() as an
update hook.

We add two new functions to the config-api, git_config_get_string() and
git_config_get_string_multi() for querying in a non callback manner from
the cache.

[1] http://marc.info/?t=140172066200006&r=1&w=2
[2] http://git.661346.n2.nabble.com/RFC-PATCH-0-2-Git-config-cache-amp-special-querying-api-utilizing-the-cache-td7611691.html
[3] https://drive.google.com/file/d/0B4suZ-aHqDcnSUZJRXVTTnZUN1E/edit?usp=sharing
[4] http://thread.gmane.org/gmane.comp.version-control.git/251073/focus=251369
[5] http://thread.gmane.org/gmane.comp.version-control.git/251704/
[6] http://thread.gmane.org/gmane.comp.version-control.git/252329/
[7] http://marc.info/?t=140428115200001&r=1&w=2
[8] http://article.gmane.org/gmane.comp.version-control.git/252942/
[9] http://thread.gmane.org/gmane.comp.version-control.git/252959/
[10] http://article.gmane.org/gmane.comp.version-control.git/253113
[11] http://thread.gmane.org/gmane.comp.version-control.git/253248
[12] http://thread.gmane.org/gmane.comp.version-control.git/253562
[13] http://thread.gmane.org/gmane.comp.version-control.git/253799

Tanay Abhra (4):
  string-list: add string_list initialiser helper functions
  Use string-list initializaer functions to rewrite
  config set
  test-config

 .gitignore                                  |   1 +
 Documentation/technical/api-config.txt      | 137 +++++++++++++++
 Documentation/technical/api-string-list.txt |   5 +
 Makefile                                    |   1 +
 builtin/commit.c                            |   3 +-
 cache.h                                     |  30 ++++
 config.c                                    | 263 ++++++++++++++++++++++++++++
 merge-recursive.c                           |   9 +-
 setup.c                                     |   9 +
 string-list.c                               |   6 +
 string-list.h                               |   2 +
 submodule.c                                 |   5 +-
 t/t1308-config-set.sh                       | 200 +++++++++++++++++++++
 test-config.c                               | 142 +++++++++++++++
 transport.c                                 |   4 +-
 15 files changed, 802 insertions(+), 15 deletions(-)
 create mode 100755 t/t1308-config-set.sh
 create mode 100644 test-config.c

-- 
1.9.0.GIT

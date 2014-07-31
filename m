From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v5 0/7] Rewrite `git_config()` using config-set API
Date: Thu, 31 Jul 2014 02:44:10 -0700
Message-ID: <1406799857-28048-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 11:45:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCmvY-0004Yn-Ug
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 11:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbaGaJpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 05:45:33 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:43572 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932265AbaGaJpc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 05:45:32 -0400
Received: by mail-pd0-f179.google.com with SMTP id ft15so3165405pdb.24
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 02:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=JjdpKoDhh9dIF3v28Qt/yaJ6TmbqJUEFYwUhPl+WRPo=;
        b=tpVsfZcrGEdvV9szb/Yc9aWPXc8JENtPw1je3A1YbfsJXum2zH7RaMcxAn5do3/2cD
         fuemwlNwFICwnPkE++sWuhcUWyEo+ThrR5sQZaFKO60XabAjaN9VHHdK38AkcoC2245g
         tJFCSXkzPhdjn+d3CD8atotoFh/ndZVK3q54Np4WcG5s0nU6ga1lrJAIIVKErcyRGhgV
         FHJi+AqRPPHpYDjZ7JG1BaAGURk5XkMPUa1uxlNMo9AH0vn3vLUIflZQ4aMl1NngmdWj
         cOznpCT5MUfg4ZqBoGazGyjHzq/0rRbG6OfWKQbfECQ/zgfGgW1eACj6PuPMvxTSuwS+
         auIg==
X-Received: by 10.70.38.4 with SMTP id c4mr11057546pdk.108.1406799931745;
        Thu, 31 Jul 2014 02:45:31 -0700 (PDT)
Received: from localhost.localdomain ([106.201.156.106])
        by mx.google.com with ESMTPSA id zq5sm4933551pbb.37.2014.07.31.02.45.28
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jul 2014 02:45:30 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254541>

[PATCH v5]: New patch added (3/7). git_config() now returns void.

[PATCH v4]: One style nit corrected, also added key to error messages.
	Diff with v3 at the bottom for easy review.

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

Tanay Abhra (7):
  config.c: fix accuracy of line number in errors
  add line number and file name info to `config_set`
  change `git_config()` return value to void
  rewrite git_config() to use the config-set API
  add a test for semantic errors in config files
  config: add `git_die_config()` to the config-set API
  add tests for `git_config_get_string_const()`

 Documentation/technical/api-config.txt |   5 ++
 branch.c                               |   5 +-
 cache.h                                |  27 ++++++-
 config.c                               | 131 +++++++++++++++++++++++++++++----
 t/t1308-config-set.sh                  |  21 ++++++
 t/t4055-diff-context.sh                |   2 +-
 test-config.c                          |  10 +++
 7 files changed, 181 insertions(+), 20 deletions(-)

-- 
1.9.0.GIT

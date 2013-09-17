From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/4] stop storing trailing slash in dir-hash
Date: Tue, 17 Sep 2013 03:06:13 -0400
Message-ID: <1379401577-36799-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 17 09:06:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLpMz-0001y6-3k
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 09:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853Ab3IQHGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 03:06:42 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:38342 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434Ab3IQHGk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 03:06:40 -0400
Received: by mail-ob0-f175.google.com with SMTP id uz6so4654259obc.20
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 00:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=bBlzioIQ9iBENc8raEJ04zjRZvx/NswjjIsnvGxJyds=;
        b=OO1y0ydBgZv+PpdXjbgAOoTMADefmgiVQw9VPzG8yj9lyYpxhXZE9Xh9G9swOoPr4g
         NbV1QiP70eK7pW6IUGUSm+3gyGDgiZWFoYxY8VZgstqJr5NvwDMCisXSTAkknNsypBVF
         x8jVdt3FxNoSqb7YCPqRWHjIzHgUTwvT/BCDSKAheZ15vq/o2lt+GC+1XiGtmbL7iMu5
         MLOWyXcFAMHeqVLshX/gLe/ohbWUlACTXQMFc9C64uJSAtEuOOdi4z14H2YTUeY+09GE
         fRL+S4WBc+eemIcPJY4wzeQXzo22zXqG9dufnW2OzKjlnnrHpByb47LRxOa/DKNvJ8Yg
         IfnQ==
X-Received: by 10.182.233.137 with SMTP id tw9mr12413obc.87.1379401600186;
        Tue, 17 Sep 2013 00:06:40 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dr8.cable.mindspring.com. [69.81.183.104])
        by mx.google.com with ESMTPSA id d8sm37304079oeu.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 17 Sep 2013 00:06:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.535.g7b94f8e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234852>

This series changes name-hash to stop storing the (redundant) trailing
slash with index_state.dir_hash entries. As an intentional side-effect,
the series fixes [1] in a cleaner way (suggested by Junio [2]) than
either [3] (680be044 in master) or [4].

Changes since v1 [5]:

* Add index_file_exists() as complement of index_dir_exists() introduced
  in v1 rather than changing the behavior of index_name_exists() to
  check only for files. To avoid disturbing current or future in-flight
  topics, index_name_exists() is retained (suggested by Junio [6]) as a
  thin wrapper dispatching either to index_file_exists() or
  index_dir_exists().

* Split v1 patch 1 into v2 patches 1 & 2 to ease review. (This is
  possible now that index_name_exists() retains its original behavior.)

[1]: http://thread.gmane.org/gmane.comp.version-control.git/232727
[2]: http://thread.gmane.org/gmane.comp.version-control.git/232727/focus=232813
[3]: http://thread.gmane.org/gmane.comp.version-control.git/232796
[4]: http://thread.gmane.org/gmane.comp.version-control.git/232833
[5]: http://thread.gmane.org/gmane.comp.version-control.git/234743
[6]: http://article.gmane.org/gmane.comp.version-control.git/234761

Eric Sunshine (4):
  name-hash: refactor polymorphic index_name_exists()
  employ new explicit "exists in index?" API
  name-hash: stop storing trailing '/' on paths in index_state.dir_hash
  dir: revert work-around for retired dangerous behavior

 cache.h        |  4 ++++
 dir.c          | 28 ++++++++-------------------
 name-hash.c    | 61 ++++++++++++++++++++++++++++++++--------------------------
 read-cache.c   |  4 ++--
 unpack-trees.c |  4 ++--
 5 files changed, 50 insertions(+), 51 deletions(-)

-- 
1.8.4.535.g7b94f8e

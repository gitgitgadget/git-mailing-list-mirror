From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v2 00/14] Improve git-status --ignored
Date: Mon, 15 Apr 2013 21:04:07 +0200
Message-ID: <516C4F27.30203@gmail.com>
References: <514778E4.1040607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Adam Spiers <git@adamspiers.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 15 21:04:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URohM-0003eE-3U
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 21:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755098Ab3DOTEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 15:04:12 -0400
Received: from mail-ea0-f179.google.com ([209.85.215.179]:49417 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754939Ab3DOTEK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 15:04:10 -0400
Received: by mail-ea0-f179.google.com with SMTP id f15so2318489eak.38
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 12:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=pIa0/ZhwU1CUwzR0C1vUmNPFZhdBRmSK9fHF62VvX4k=;
        b=Xqt4E74SGfifG/WAegpJ5Qpr4xFblGguYYPaUtq44L+qRXars7U4AeYjAQC+bDYFcC
         m8GulMiE7OW0snb4IdFgTWIO1fecLOL9eHWe2zVK1oc3UV4SGUO8k1dCzJ0Opb28Dkk2
         Q+XQIlrD7Arj3LNbvRwIKz0Qq1fpBoMwnX1wv9M3f+PP7zvi+uW1e/Yu+h7VXq2y4QdP
         la681Y6g64p8UkMLk8CPneeoKN5fYgja9V2OS/glaZdQ8Zbw73CoAM4QhOlTXKmif6Mr
         89o2zpw25h8VJ8J02P1PwyQyjLRpo9QAO+HaUsyNYnm18OqPawuWZqvBMe2lTOGomjZq
         oFCw==
X-Received: by 10.15.94.200 with SMTP id bb48mr65513568eeb.21.1366052649058;
        Mon, 15 Apr 2013 12:04:09 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id u44sm28334207eel.7.2013.04.15.12.04.06
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 12:04:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <514778E4.1040607@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221289>

This patch series addresses several bugs and performance issues in
.gitignore processing.

Patches #1 - #6 fix bugs and add appropriate test cases.

Patch #7 changes handling of "ignored tracked" directories, as I discovered
that with the current bahavior git-clean can delete tracked content.

Patches #8 - #14 are performance optimizations.


Also available here:
https://github.com/kblees/git/tree/kb/improve-git-status-ignored-v2
git pull git://github.com/kblees/git.git kb/improve-git-status-ignored-v2


Changes since v1 (old#->new#: description):

1->1: dir.c: git-status --ignored: don't drop ignored directories
2->2: dir.c: git-status --ignored: don't list files in ignored directories
3->3: dir.c: git-status --ignored: don't list empty ignored directories

*->4: dir.c: git-ls-files --directories: don't hide empty directories
      - new bugfix

4->5: dir.c: git-status --ignored: don't list empty directories as ignored
      - fixed typo in commit message thanks to Eric Sunshine
      - patch is reduced to a one-liner (the DIR_HIDE_EMPTY_DIRECTORIES
        flag has already been fixed in patch 4, renaming the variable and
	tweaking DIR_SHOW_OTHER_DIRECTORIES is not strictly necessary)

*->6: dir.c: make 'git-status --ignored' work within leading directories
      - new bugfix

*->7: dir.c: git-clean -d -X: don't delete tracked directories
      - changes handling of "ignored tracked" directories

5->8: dir.c: factor out parts of last_exclude_matching for later reuse
5->9: dir.c: move prep_exclude
      - split in two patches for cleaner diff
      - removed unnecessary ';' after '}'

6->10: dir.c: unify is_excluded and is_path_excluded APIs
       - fixed another typo in commit message

7->11: dir.c: replace is_path_excluded with now equivalent is_excluded API
8->12: dir.c: git-status: avoid is_excluded checks for tracked files

*->13: dir.c: git-status --ignored: don't scan the work tree three times
       - new optimization

*->14: dir.c: git-status --ignored: don't scan the work tree twice
       - new optimization

Karsten Blees (14):
  dir.c: git-status --ignored: don't drop ignored directories
  dir.c: git-status --ignored: don't list files in ignored directories
  dir.c: git-status --ignored: don't list empty ignored directories
  dir.c: git-ls-files --directories: don't hide empty directories
  dir.c: git-status --ignored: don't list empty directories as ignored
  dir.c: make 'git-status --ignored' work within leading directories
  dir.c: git-clean -d -X: don't delete tracked directories
  dir.c: factor out parts of last_exclude_matching for later reuse
  dir.c: move prep_exclude
  dir.c: unify is_excluded and is_path_excluded APIs
  dir.c: replace is_path_excluded with now equivalent is_excluded API
  dir.c: git-status: avoid is_excluded checks for tracked files
  dir.c: git-status --ignored: don't scan the work tree three times
  dir.c: git-status --ignored: don't scan the work tree twice

 Documentation/technical/api-directory-listing.txt |  25 +-
 builtin/add.c                                     |   5 +-
 builtin/check-ignore.c                            |   7 +-
 builtin/ls-files.c                                |  15 +-
 dir.c                                             | 499 +++++++++-------------
 dir.h                                             |  25 +-
 t/t3001-ls-files-others-exclude.sh                |  49 +++
 t/t7061-wtstatus-ignore.sh                        | 125 +++++-
 t/t7300-clean.sh                                  |  34 ++
 unpack-trees.c                                    |  10 +-
 unpack-trees.h                                    |   1 -
 wt-status.c                                       |  24 +-
 12 files changed, 455 insertions(+), 364 deletions(-)

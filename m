From: Victor Leschuk <vleschuk@gmail.com>
Subject: [PATCH v8 0/2] Add git-grep threads param
Date: Tue, 15 Dec 2015 18:31:38 +0300
Message-ID: <1450193500-22468-1-git-send-email-vleschuk@accesssoftek.com>
Cc: vleschuk@accesssoftek.com, gitster@pobox.com, john@keeping.me.uk,
	peff@peff.net, pclouds@gmail.com, sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 15 16:31:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8rZu-0000rf-5a
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 16:31:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965210AbbLOPbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 10:31:46 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:33785 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964829AbbLOPbp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 10:31:45 -0500
Received: by mail-lb0-f180.google.com with SMTP id kw15so8037846lbb.0
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 07:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=6fMO1iTA/LszG3Dw2XH+B45OtBNd2sbTc0K3ZjxVkyo=;
        b=i7b/0fc9zxR2sfSkvzeO4hTg2CKL3giPkqUIHdr13j2OyGpU52i2/LkbjpDCRa1I/H
         J4GhqDezfxZcjk8zKaCt9K+P+fAiKliuoCEbZJLTuiddRJ8Cz7IFYzghGt3XFxhBbz6h
         VTUFgLDX6A54jdwJbVIGKZDWsCGLe+4m3jFEox7U6i6N2JBw+7OLC4vuPYXDZWJ0FoKz
         Wjppseb71WhHzZew0mOVf77qJRDKjedrHAg5Wd5fXS/3TvvWVtKmX8VsdmALL1OqGxrP
         hMHqZo8o2upGnppvJ4JTmwyM7f6uH1/DtAjVzLoa8Q0c9NoU2/WTvgleFwk0iIsSR+Wi
         egDA==
X-Received: by 10.112.63.100 with SMTP id f4mr16138622lbs.85.1450193503660;
        Tue, 15 Dec 2015 07:31:43 -0800 (PST)
Received: from del-debian (93-80-35-229.broadband.corbina.ru. [93.80.35.229])
        by smtp.gmail.com with ESMTPSA id d196sm285830lfd.38.2015.12.15.07.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Dec 2015 07:31:42 -0800 (PST)
X-Google-Original-From: Victor Leschuk <vleschuk@accesssoftek.com>
Received: from del by del-debian with local (Exim 4.86)
	(envelope-from <vleschuk@gmail.com>)
	id 1a8rZm-0005r4-2V; Tue, 15 Dec 2015 18:31:42 +0300
X-Mailer: git-send-email 2.6.3.369.g3e7f205.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282478>

Introducing v8 of git-grep threads param patch.
Patch is now split in 2 parts - 1/2 is actually renewed v6 version (see list of changes below),
2/2 removes dependency on online_cpus() - as we discussed with Eric this is rather 
significant change in default behavior and should be placed into separate patch.

Here is list of changes since v6 ($gmane/281160):

  * Fixed broken t7811: moved all threads_num setup to 1 place (for -O option it was in wrong place)
  * Fixed 'invalid number of threads' message so that it could be translated
  * Got rid of grep_threads_config() - its too trivial to be separate function
  * Fixed xcalloc() args (sizeof(pthread_t) -> sizeof(*threads)) to correspond to general git style
  * Improved commit message (in 2/2) to explain why online_cpus() is now not used in threads_num setup
  * The full param documentation was moved into single place (grep.threads description in git-grep.txt) and is referenced from other places. Also made few language improvements in documentation.
  * Style improvements: splitted too long lines

Victor Leschuk (2):
  "git grep" can now be configured (or told from the command line)    
    how many threads to use when searching in the working tree files.
  Number of threads now doesn't depend on online_cpus(),     e.g. if
    specific number is not configured GREP_NUM_THREADS_DEFAULT (8)    
    threads will be used even on 1-core CPU.

 Documentation/config.txt               |  4 +++
 Documentation/git-grep.txt             | 12 +++++++++
 builtin/grep.c                         | 49 +++++++++++++++++++++++-----------
 contrib/completion/git-completion.bash |  1 +
 4 files changed, 51 insertions(+), 15 deletions(-)

-- 
2.6.3.369.g3e7f205.dirty

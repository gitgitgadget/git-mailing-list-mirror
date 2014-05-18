From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v4 00/33] Teach guilt import-commit how to create legal patch names, and more
Date: Sun, 18 May 2014 23:59:36 +0200
Message-ID: <1400450409-30998-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon May 19 00:03:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm9Aa-0004ML-7t
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 00:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbaERWBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 18:01:06 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:40167 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbaERWBF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 18:01:05 -0400
Received: by mail-la0-f46.google.com with SMTP id ec20so3448386lab.5
        for <git@vger.kernel.org>; Sun, 18 May 2014 15:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GPSdNilDqAG5/Cp+BM2aXB8n8+tHne4osHh8DgojIxo=;
        b=hJmXatzdl1g/04lwB1jQACr0iIV2q21bi+AGxRAPD1mp1nu+Y40uoxvG9syQsBP/Sc
         BMYiCC/Ccd1IzdqmFuE6WJxKlAIr+Xgb8AzM8AF6Xx3rYT3tuJEM3T2rLOrlA2JE3UZe
         IaQaJMTC+/zoreJqh6B6/YetMNhDcEyYHKS2QKtqOALvOy253Zkz0C3+XRqDDJXHEtRQ
         Ys7gu08P46z1LUhdEyxDmbs66xWZg+80YWnSbgJAOw36CZHffnAA0OwfNuEZdwt0YztI
         eI5k0EASbXcIFy8y2KnOvRvF946uWjUAC8Hk36MkSCWCcjB18Qm4QgXUIWPhlR3JwNOv
         OwPA==
X-Gm-Message-State: ALoCoQl7eumXIEgeeidXqRqgwel9uvGJmJgo1wHmyuBRYqoaM7bNXh2jTVgfflphKcf4ZZlp6GDk
X-Received: by 10.152.6.3 with SMTP id w3mr7935282law.34.1400450462912;
        Sun, 18 May 2014 15:01:02 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id d8sm17593818lah.12.2014.05.18.15.01.01
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 18 May 2014 15:01:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249515>

This is version 4 of the patch series I sent back on 21 Mar 2014.  I
have addressed all feedback to date, update the documentation where
needed, improved the error handling in the "cmd" and "shouldfail"
functions in the test suite, fixed compatibility with older Git
versions, and added signed-off-by lines from Jeff Sipek for those
commits that I have received an explicit approval from him (but only
if I have not made any other change to that particular commit).

I have added two new patches:

* Patch 32/33 adds documentation and test cases for the new regexp
functionality of "guilt header".  This could be folded into patch 12.

* Patch 33/33 adds documentation for the exit value of "guilt push"
and "guilt pop".  This could be folded into patches 25-26.

To see how the patches have evolved, you might find
http://www.lysator.liu.se/~ceder/guilt-oslo-2014-v4/ useful.  It
displays diffs of all the patches between v3 and v4, in pdiffdiff
output format.

Here is the original blurb for the series, slightly edited:

I recently found myself sitting on a train with a computer in front of
me.  I tried to use "guilt import-commit", which seemed to work, but
when I tried to "guilt push" the commits I had just imported I got
some errors.  It turned out that "guilt import-commit" had generated
invalid patch names.

I decided to fix the issue, and write a test case that demonstrated
the problem.

One thing led to another, and here I am, a few late nights at a hotel
and a return trip on the train later, submitting a patch series in 28
parts.  Sorry about the number of patches, but this is what happens
when you uncover a bug while writing a test case for the bug you
uncovered while writing a test case for your original problem.

The patch series consists of:

 - A number of fixes to the test suite.

 - A number of bug fixes which I hope are non-controversial.  Most of
   the fixes have test cases.

 - Changed behavior: "guilt push" when there is nothing more to push
   now uses exit status 1.  This makes it possible to write shell
   loops such as "while guilt push; do make test||break; done".  Also,
   "guilt pop" when no patches are applied also uses exit status 1.
   (This aligns "guilt push" and "guilt pop" with how "hg qpush" and
   "hg qpop" has worked for several years.)

 - Changed behavior: by default, guilt no longer changes branch when
   you push a patch.  You need to do "git config guilt.reusebranch
   false" to re-enable that.  This patch sets the default value of
   guilt.reusebranch to true; it should in my opinion change to false
   a year or two after the next release.

 - The humble beginnings of a coding style guide.

A more detailed overview of the patches:

1. Some tests fail if "git config guilt.diffstat true" is in effect.

2-4. Some commands fail if run from a directory with spaces in its
     name.

5. "guilt new" had an overly restrictive argument parser.

6-8. guilt.diffstat could break "guilt fold" and "guilt new".

9-10. The test suite did not test exit status properly.

11. Remove pointless redirections in the test suite.

12-13. "guilt header" tried to check if a patch existed, but the check
        was broken.

14-16. Various parts of guilt tried to ensure that patch names were
       legal git branch names, but failed.

17-20. "guilt graph" failed when no patch was applied, and when a
       branch name contained a comma or a quote.

21-23. "git config log.decorate short" caused "guilt import-commit",
       "guilt patchbomb" and "guilt rebase" to fail in various ways.

24. Patches may contain backslashes, but various informative messages
    from guilt did backslash processing.

25-26. "guilt push" and "guilt pop" should fail when there is nothing
       to do.

28. Fix coding style problems in a test case.

27, 29. These two commits were things I intended to contribute a while
       back, when contributing the "Change git branch when patches are
       applied" change (commit 67d3af63f422).  These commits makes
       that behavior optional, and it defaults to being disabled, so
       that you can use both Guilt v0.35 (and earlier) and the current
       Guilt code against the same repo.  These commits add some code
       complexity, and you might want to skip them if you think the
       current behavior is better.

30. A coding style guide, with Emacs support.

31. Avoid using "git log -p".

32. Test case + doc for "guilt header".

33. Doc for "guilt push" and "guilt pop."

This patch series is also available on
http://repo.or.cz/w/guilt/ceder.git in the "oslo-2014-v4" branch.  If
you already have a copy of guilt, you should be able to fetch that
branch with something like:

    git remote add ceder http://repo.or.cz/r/guilt/ceder.git
    git fetch ceder refs/heads/oslo-2014-v4:refs/remotes/ceder/oslo-2014-v4

A few of the regression/t-*.out files contain non-ASCII characters.  I
hope they survive the mail transfer; if not, please use the repo above
to fetch the commits.

Per Cederqvist (33):
  The tests should not fail if guilt.diffstat is set.
  Allow "guilt delete -f" to run from a dir which contains spaces.
  Added test case for "guilt delete -f".
  Allow "guilt import-commit" to run from a dir which contains spaces.
  "guilt new": Accept more than 4 arguments.
  Fix the do_get_patch function.
  Added test cases for "guilt fold".
  Added more test cases for "guilt new": empty patches.
  Test suite: properly check the exit status of commands.
  Run test_failed if the exit status of a test script is bad.
  test suite: remove pointless redirection.
  "guilt header": more robust header selection.
  Check that "guilt header '.*'" fails.
  Use "git check-ref-format" to validate patch names.
  Produce legal patch names in guilt-import-commit.
  Fix backslash handling when creating names of imported patches.
  "guilt graph" no longer loops when no patches are applied.
  guilt-graph: Handle commas in branch names.
  Check that "guilt graph" works when working on a branch with a comma.
  "guilt graph": Handle patch names containing quotes.
  The log.decorate setting should not influence import-commit.
  The log.decorate setting should not influence patchbomb.
  The log.decorate setting should not influence guilt rebase.
  disp no longer processes backslashes.
  "guilt push" now fails when there are no more patches to push.
  "guilt pop" now fails when there are no more patches to pop.
  Minor testsuite fix.
  Fix coding style errors in t-061.sh.
  Added guilt.reusebranch configuration option.
  Added a short style guide, and Emacs settings.
  Don't use "git log -p" in the test suite.
  Improved doc and tests for guilt header.
  Document the exit status of guilt push and guilt pop.

 .dir-locals.el                 |   3 +
 Documentation/Contributing     |  15 +
 Documentation/guilt-header.txt |   5 +-
 Documentation/guilt-pop.txt    |   3 +
 Documentation/guilt-push.txt   |   3 +
 guilt                          |  89 +++-
 guilt-delete                   |   2 +-
 guilt-fork                     |   2 +-
 guilt-graph                    |  13 +-
 guilt-header                   |  29 +-
 guilt-import                   |   2 +-
 guilt-import-commit            |  30 +-
 guilt-new                      |   9 +-
 guilt-patchbomb                |   2 +-
 guilt-pop                      |  17 +-
 guilt-push                     |  19 +-
 guilt-rebase                   |   2 +-
 regression/run-tests           |  10 +-
 regression/scaffold            |  25 +-
 regression/t-020.out           | 924 +++++++----------------------------------
 regression/t-020.sh            |  73 +++-
 regression/t-021.out           | 901 +---------------------------------------
 regression/t-021.sh            |  18 +-
 regression/t-025.out           | 426 ++++++++++++++++++-
 regression/t-025.sh            |  14 +-
 regression/t-026.out           |  15 +
 regression/t-026.sh            |   5 +-
 regression/t-028.out           |  16 +
 regression/t-028.sh            |   9 +-
 regression/t-032.out           |   4 +-
 regression/t-032.sh            |   2 +-
 regression/t-033.out           |  90 ++++
 regression/t-033.sh            |  61 +++
 regression/t-034.out           | 569 +++++++++++++++++++++++++
 regression/t-034.sh            |  73 ++++
 regression/t-035.out           | 467 +++++++++++++++++++++
 regression/t-035.sh            |  61 +++
 regression/t-061.out           |   1 -
 regression/t-061.sh            |  12 +-
 regression/t-062.out           | 420 +++++++++++++++++++
 regression/t-062.sh            | 130 ++++++
 41 files changed, 2800 insertions(+), 1771 deletions(-)
 create mode 100644 .dir-locals.el
 create mode 100644 regression/t-033.out
 create mode 100755 regression/t-033.sh
 create mode 100644 regression/t-034.out
 create mode 100755 regression/t-034.sh
 create mode 100644 regression/t-035.out
 create mode 100755 regression/t-035.sh
 create mode 100644 regression/t-062.out
 create mode 100755 regression/t-062.sh

-- 
1.8.3.1

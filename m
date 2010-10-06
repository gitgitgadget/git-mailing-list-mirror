From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv5 00/17] gitweb: Simple file based output caching
Date: Thu,  7 Oct 2010 00:01:45 +0200
Message-ID: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 00:04:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3c5i-0002Gb-NG
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756901Ab0JFWCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 18:02:30 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35042 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399Ab0JFWC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 18:02:29 -0400
Received: by bwz11 with SMTP id 11so49424bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=iZflPE5eMX9mLDpF4zxudahP1FL0f5Bf1eq1GmBj2tE=;
        b=d4A/lLiJ8yFVlLf0H+8jBXV40NEckaddzLmAM9MYA4afEbXps4vznwHfBXdde6MD0z
         f+oRijbrlu+kEl18pNoaOYq3dgyUcWuW4KnU/SNaA07XaCRax6c2yJ7uSqHYFNxiVNOP
         43eBSPZeWrI2jA/KUnVnQLK2MktXCt1+Gz0a8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=EU8wvPiPPSR6zwvgzPlp9JdpPxXH4BeCC9zMIr4D3Hd+3MbHOmw2eRMGoeRUHjAJPx
         WKc688jswOA7ejrWKmCB9ukA3f3TAjRCuH97EmeeXmzRvNzJ3CqscuskqLTmXvKUzhWD
         iRTQ34n0HQSwpTFf3YHbHsC9Jq+3ple0juiW8=
Received: by 10.204.160.90 with SMTP id m26mr10420075bkx.45.1286402544002;
        Wed, 06 Oct 2010 15:02:24 -0700 (PDT)
Received: from localhost.localdomain (abwe253.neoplus.adsl.tpnet.pl [83.8.228.253])
        by mx.google.com with ESMTPS id 24sm1044480bkr.19.2010.10.06.15.02.19
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 15:02:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158313>

This 17+ patches long patch series is intended as a replacement for
large 'gitweb: File based caching layer (from git.kernel.org)'
mega-patch by John 'Warthog9' Hawley aka J.H., by starting small and
adding features piece by piece.

This is fourthfifth version (5th release) of this series, and is
available on http://repo.or.cz/w/git/jnareb-git.git as
'gitweb/cache-kernel-v5' branch.  Earlier versions are available there
as branches 'gitweb/cache-kernel', 'gitweb/cache-kernel-v2',
'gitweb/cache-kernel-v3' and 'gitweb/cache-kernel-v4'.  Previous version
of this series was sent to git mailing list as:

* [RFC PATCHv4 00/17] gitweb: Simple file based output caching
  Message-Id: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
  http://thread.gmane.org/gmane.comp.version-control.git/149101

This version is based on top of aad24ad (gitweb: Move call to
evaluate_git_version after evaluate_gitweb_config, 2010-10-05) in
'gitweb/web' branch of http://repo.or.cz/w/git/jnareb-git.git
repository.

The 'gitweb/web' branch consist of the following commits on top of
1e63341 (Merge branch 'maint', 2010-09-30) in 'master' branch of main
git repository:
  gitweb/Makefile: Include gitweb/config.mak
  t/gitweb-lib.sh: Add support for GITWEB_TEST_INSTALLED
  gitweb/Makefile: Add 'test' and 'test-installed' targets
  gitweb: Move call to evaluate_git_version after evaluate_gitweb_config

The first three patches were send as 3-part series:
* [PATCHv2 0/3] Testing installed gitweb
  Message-Id: <1285506146-8009-1-git-send-email-jnareb@gmail.com>
  http://thread.gmane.org/gmane.comp.version-control.git/157222

Those are required to be able to test installed version of gitweb and
modules, to check if there are any problems with process of installing
gitweb.

The last patch in 'gitweb/web' branch was send as:
* [PATCH] gitweb: Move call to evaluate_git_version after evaluate_gitweb_config 
  Message-ID: <20100926113431.28918.53550.stgit@localhost.localdomain>
  http://article.gmane.org/gmane.comp.version-control.git/157220

This was needed during development of this series, to avoid spurious
output of gitweb tests when using `--debug' option.


The MAIN DIFFERENCE from previous version is that it is based on never
version of gitweb; in particular putting all code in subroutines: gitweb
calls run() subroutine on startup, and run_request() subroutine on each
request (per connection) from the 'jn/gitweb-fastcgi' branch.

The patches
  gitweb: Return or exit after done serving request
  gitweb: Fix typo in hash key name in %opts in git_header_html

present at beginning of previous (fourth) version of this series are
already merged in.

The patches
  gitweb/lib - Benchmarking GitwebCache::SimpleFileCache (in t/9603/)
  gitweb/lib - Alternate ways of capturing output

which were interleaved with other patches in previous version of this
series got moved to the end of series, and marked proof of concept
("PoC").


The following changes are available in the git repository at:

  git://repo.or.cz/git/jnareb-git.git gitweb/cache-kernel-v5


All comments welcome!

J.H., could you comment on how this series relates to the gitweb code
*currently* running on git.kernel.org wrt. code?  If possible, could you
try to compare performance of those two implementations, the one
presented here in this series, and the one used by git.kernel.org.

Pasky or other repo.or.cz admins, could you tell us if and what kind of
caching gitweb used by repo.or.cz uses, and how it compares (wrt code
and if possible also performance) to solution implemented in this
series?


TODO list and areas of possible improvements would be send in separate
email.


Jakub Narebski (21):
  t/test-lib.sh: Export also GIT_BUILD_DIR in test_external
  gitweb: Prepare for splitting gitweb
  gitweb/lib - Very simple file based cache
  gitweb/lib - Stat-based cache expiration
  gitweb/lib - Regenerate entry if the cache file has size of 0
  gitweb/lib - Simple select(FH) based output capture
  gitweb/lib - Cache captured output (using get/set)
  gitweb: Add optional output caching (from gitweb/cache.pm)
  gitweb/lib - Adaptive cache expiration time
  gitweb/lib - Use CHI compatibile (compute method) caching interface
  gitweb/lib - Use locking to avoid 'cache miss stampede' problem
  gitweb/lib - No need for File::Temp when locking
  gitweb/lib - Serve stale data when waiting for filling cache
  gitweb/lib - Regenerate (refresh) cache in background
  gitweb: Introduce %actions_info, gathering information about actions
  gitweb: Show appropriate "Generating..." page when regenerating cache
  gitweb: Add startup delay to activity indicator for cache
  gitweb/lib - Add clear() and size() methods to caching interface
  gitweb: Add beginnings of cache administration page
  gitweb/lib - Benchmarking GitwebCache::SimpleFileCache (in t/9603/)
  gitweb/lib - Alternate ways of capturing output

 gitweb/Makefile                                |   24 ++-
 gitweb/README                                  |   61 +++
 gitweb/gitweb.perl                             |  459 ++++++++++++++++++++++--
 gitweb/lib/GitwebCache/CacheOutput.pm          |   95 +++++
 gitweb/lib/GitwebCache/Capture.pm              |   66 ++++
 gitweb/lib/GitwebCache/Capture/PerlIO.pm       |   79 ++++
 gitweb/lib/GitwebCache/Capture/SelectFH.pm     |   82 ++++
 gitweb/lib/GitwebCache/Capture/TiedCapture.pm  |   76 ++++
 gitweb/lib/GitwebCache/FileCacheWithLocking.pm |  280 ++++++++++++++
 gitweb/lib/GitwebCache/SimpleFileCache.pm      |  472 ++++++++++++++++++++++++
 gitweb/lib/Tie/Restore.pm                      |   24 ++
 gitweb/lib/TiedCapture/PerlIO.pm               |   56 +++
 gitweb/lib/TiedCapture/String.pm               |   53 +++
 t/t9500-gitweb-standalone-no-errors.sh         |   20 +
 t/t9503-gitweb-caching-interface.sh            |   34 ++
 t/t9503/benchmark_caching_interface.pl         |  209 +++++++++++
 t/t9503/test_cache_interface.pl                |  407 ++++++++++++++++++++
 t/t9504-gitweb-capture-interface.sh            |   34 ++
 t/t9504/benchmark_capture_implementations.pl   |  226 +++++++++++
 t/t9504/test_capture_implementations.pl        |   85 +++++
 t/t9504/test_capture_interface.pl              |   76 ++++
 t/t9505-gitweb-cache.sh                        |   34 ++
 t/t9505/test_cache_output.pl                   |   70 ++++
 t/test-lib.sh                                  |    4 +-
 24 files changed, 2997 insertions(+), 29 deletions(-)
 create mode 100644 gitweb/lib/GitwebCache/CacheOutput.pm
 create mode 100644 gitweb/lib/GitwebCache/Capture.pm
 create mode 100644 gitweb/lib/GitwebCache/Capture/PerlIO.pm
 create mode 100644 gitweb/lib/GitwebCache/Capture/SelectFH.pm
 create mode 100644 gitweb/lib/GitwebCache/Capture/TiedCapture.pm
 create mode 100644 gitweb/lib/GitwebCache/FileCacheWithLocking.pm
 create mode 100644 gitweb/lib/GitwebCache/SimpleFileCache.pm
 create mode 100644 gitweb/lib/Tie/Restore.pm
 create mode 100644 gitweb/lib/TiedCapture/PerlIO.pm
 create mode 100644 gitweb/lib/TiedCapture/String.pm
 create mode 100755 t/t9503-gitweb-caching-interface.sh
 create mode 100755 t/t9503/benchmark_caching_interface.pl
 create mode 100755 t/t9503/test_cache_interface.pl
 create mode 100755 t/t9504-gitweb-capture-interface.sh
 create mode 100755 t/t9504/benchmark_capture_implementations.pl
 create mode 100755 t/t9504/test_capture_implementations.pl
 create mode 100755 t/t9504/test_capture_interface.pl
 create mode 100755 t/t9505-gitweb-cache.sh
 create mode 100755 t/t9505/test_cache_output.pl

-- 
1.7.3

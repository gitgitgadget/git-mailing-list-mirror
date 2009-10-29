From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] Provide a build time default-pager setting
Date: Thu, 29 Oct 2009 02:45:33 -0500
Message-ID: <20091029074532.GB15403@progeny.tock>
References: <1256742357-sup-3798@ntdws12.chass.utoronto.ca>
 <7vskd3o11t.fsf@alter.siamese.dyndns.org>
 <20091029073224.GA15403@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 08:36:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3PY8-0003at-L0
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 08:36:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756641AbZJ2Hfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 03:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755067AbZJ2Hfb
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 03:35:31 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:59594 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870AbZJ2Hfb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 03:35:31 -0400
Received: by yxe17 with SMTP id 17so1437543yxe.33
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 00:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Uk6iw9i1cfb9GWc59FzmprWQB0cC21NU+cA1P0uWOp4=;
        b=jORurkPco9f+DEf2W137gFliFmFF1b0w4LSyzfgExk2MpwclOoqOvqM5LcQtLJT+Ss
         h4XzCmWXHxvLRZKy5pgx/dGPnPMTlNFHeOuDDk/kgHJOE7Pj7vuBaAPMq4xs27+rHu/D
         DTXVtuwM9bFNDoQhBYnSbg+QckE8jAbsvPur8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=s3ZcXZ+vvbnYPMxcdlJDc03sFtYsS0/EkhEp+KEORLMe8RQz88sVKlbqpoNJKS5sE8
         D08lRKBpcc+1+l8/sKxSELtT4PT4OG73SJ7Qrm0+2WtOe/y7qwiHQZyeGNLLH4jp6Hge
         lYcYhnDHp3HL7SEMXw9DUlzJVVLh1tgDT9wgc=
Received: by 10.90.121.17 with SMTP id t17mr2887086agc.57.1256801735473;
        Thu, 29 Oct 2009 00:35:35 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 4sm789122yxd.52.2009.10.29.00.35.34
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 00:35:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091029073224.GA15403@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131569>

From: Junio C Hamano <gitster@pobox.com>

On (old) solaris systems, /usr/bin/less (typically the first less
found) doesn't understand the default arguments (FXRS), which
forces users to alter their environment (PATH, GIT_PAGER, LESS,
etc) or have a local or global gitconfig before paging works as
expected.

On Debian systems, by policy packages must fall back to the
'pager' command, so that changing the target of the
/usr/bin/pager symlink changes the default pager for all packages
at once.

Provide a DEFAULT_PAGER knob so packagers can set the fallback
pager to something appropriate during the build.

This puts the "less" default in the Makefile instead of pager.c,
since it is needed for git-svn, too.  This means that the
DEFAULT_PAGER preprocessor token _has_ to be defined on the
command line for git to build.  I was worried about this for a
moment, but GIT_VERSION already works this way without trouble.

Probably the DEFAULT_PAGER setting should be added to something
like TRACK_CFLAGS as well.  Actually, some other settings that
can change without forcing files to be rebuilt (e.g. SHELL_PATH),
too.  This should be probably be addressed separately.

Reported-by: Ben Walton <bwalton@artsci.utoronto.ca>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile     |    8 ++++++++
 git-svn.perl |    5 +++--
 pager.c      |    2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 268aede..fc1a461 100644
--- a/Makefile
+++ b/Makefile
@@ -200,6 +200,9 @@ all::
 # memory allocators with the nedmalloc allocator written by Niall Douglas.
 #
 # Define NO_REGEX if you have no or inferior regex support in your C library.
+#
+# Define DEFAULT_PAGER to the path of a sensible pager (defaults to "less") if
+# you want to use something different.
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1294,6 +1297,10 @@ ifdef NO_REGEX
 	COMPAT_CFLAGS += -Icompat/regex
 	COMPAT_OBJS += compat/regex/regex.o
 endif
+ifndef DEFAULT_PAGER
+	DEFAULT_PAGER = less
+endif
+BASIC_CFLAGS += -DDEFAULT_PAGER='"$(DEFAULT_PAGER)"'
 
 ifdef USE_NED_ALLOCATOR
        COMPAT_CFLAGS += -DUSE_NED_ALLOCATOR -DOVERRIDE_STRDUP -DNDEBUG -DREPLACE_SYSTEM_ALLOCATOR -Icompat/nedmalloc
@@ -1451,6 +1458,7 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	    -e '}' \
 	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
+	    -e 's/@@DEFAULT_PAGER@@/$(DEFAULT_PAGER)/g' \
 	    $@.perl >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
diff --git a/git-svn.perl b/git-svn.perl
index 6a3b501..c270b23 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3,11 +3,12 @@
 # License: GPL v2 or later
 use warnings;
 use strict;
-use vars qw/	$AUTHOR $VERSION
+use vars qw/	$AUTHOR $VERSION $DEFAULT_PAGER
 		$sha1 $sha1_short $_revision $_repository
 		$_q $_authors $_authors_prog %users/;
 $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
 $VERSION = '@@GIT_VERSION@@';
+$DEFAULT_PAGER = '@@DEFAULT_PAGER@@';
 
 # From which subdir have we been invoked?
 my $cmd_dir_prefix = eval {
@@ -5174,7 +5175,7 @@ sub git_svn_log_cmd {
 sub config_pager {
 	$pager ||= $ENV{GIT_PAGER} || $ENV{PAGER};
 	if (!defined $pager) {
-		$pager = 'less';
+		$pager = $DEFAULT_PAGER;
 	} elsif (length $pager == 0 || $pager eq 'cat') {
 		$pager = undef;
 	}
diff --git a/pager.c b/pager.c
index 86facec..416a796 100644
--- a/pager.c
+++ b/pager.c
@@ -58,7 +58,7 @@ void setup_pager(void)
 	if (!pager)
 		pager = getenv("PAGER");
 	if (!pager)
-		pager = "less";
+		pager = DEFAULT_PAGER;
 	else if (!*pager || !strcmp(pager, "cat"))
 		return;
 
-- 
1.6.5.2

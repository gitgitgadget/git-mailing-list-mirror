From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/6] cvsimport: allow setting a custom cvsps (2.x) program
 name
Date: Sun, 13 Jan 2013 23:25:47 -0800
Message-ID: <1358148351-31552-3-git-send-email-gitster@pobox.com>
References: <7v8v7wiv3a.fsf@alter.siamese.dyndns.org>
 <1358148351-31552-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 08:26:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TueR6-0002WZ-5Y
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 08:26:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755600Ab3ANH0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 02:26:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61257 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752804Ab3ANHZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 02:25:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCFADB8AE
	for <git@vger.kernel.org>; Mon, 14 Jan 2013 02:25:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=hjDJ
	1z31CKO/btKc/NNzYlcwZ1E=; b=HYQrXdvyp8yuFxXseY8GgKNY6QBkHM/d28Rs
	daQDhqTbbZrnri/vEdodQPnSMfb95nhSTByJT/JUyDWosnGMuHeHsg/OGXXAtFjo
	GpbjEKk1UUdWI1vpgqz9AheBHI0wmALBNj5tmYBLa4igveP+iMBldJlnRRBkS6Mf
	4QoMmB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=abWKPZ
	waTGPbnr54TJd+GmjzOtJh3YcOYfbbats6ffF93KV2maPiGUkXnq+JOF9Yp8BsNk
	wbOeqkNSng7UGxXCPAyDA3QpEGe+Wi6mwvI+soOgHJsyM30cBwCTHacI/jW+EJ1H
	vyv3tZWgGuuE06FYwE49yPTEfNtWPLDbeNMxQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2194B8AD
	for <git@vger.kernel.org>; Mon, 14 Jan 2013 02:25:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 312FAB8AC for
 <git@vger.kernel.org>; Mon, 14 Jan 2013 02:25:57 -0500 (EST)
X-Mailer: git-send-email 1.8.1.421.g6236851
In-Reply-To: <1358148351-31552-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A3577050-5E1B-11E2-A8E0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213463>

Distros may ship old cvsps under a different name, or the user may
install it outside the normal $PATH.  Allow setting CVSPS2_PATH from
the build environment.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile           | 9 +++++++--
 git-cvsimport.perl | 4 +++-
 t/lib-cvs.sh       | 4 +++-
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 1695075..dd2a024 100644
--- a/Makefile
+++ b/Makefile
@@ -576,9 +576,11 @@ endif
 ifndef PYTHON_PATH
 	PYTHON_PATH = /usr/bin/python
 endif
+ifndef CVSPS2_PATH
+	CVSPS2_PATH = cvsps
+endif
 
-export PERL_PATH
-export PYTHON_PATH
+export PERL_PATH PYTHON_PATH CVSPS2_PATH
 
 LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
@@ -1516,6 +1518,7 @@ SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
 PYTHON_PATH_SQ = $(subst ','\'',$(PYTHON_PATH))
 TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
+CVSPS2_PATH_SQ = $(subst ','\'',$(CVSPS2_PATH))
 DIFF_SQ = $(subst ','\'',$(DIFF))
 
 LIBS = $(GITLIBS) $(EXTLIBS)
@@ -1729,6 +1732,7 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl GIT-VERSION-FILE
 	    -e '	H' \
 	    -e '	x' \
 	    -e '}' \
+	    -e 's|@@CVSPS2_PATH@@|$(CVSPS2_PATH_SQ)|g' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    $@.perl >$@+ && \
 	chmod +x $@+ && \
@@ -2107,6 +2111,7 @@ GIT-LDFLAGS: FORCE
 GIT-BUILD-OPTIONS: FORCE
 	@echo SHELL_PATH=\''$(subst ','\'',$(SHELL_PATH_SQ))'\' >$@
 	@echo PERL_PATH=\''$(subst ','\'',$(PERL_PATH_SQ))'\' >>$@
+	@echo CVSPS2_PATH=\''$(subst ','\'',$(CVSPS2_PATH_SQ))'\' >>$@
 	@echo DIFF=\''$(subst ','\'',$(subst ','\'',$(DIFF)))'\' >>$@
 	@echo PYTHON_PATH=\''$(subst ','\'',$(PYTHON_PATH_SQ))'\' >>$@
 	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 0a31ebd..ad460a5 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -33,6 +33,8 @@
 our ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P, $opt_s,$opt_m,@opt_M,$opt_A,$opt_S,$opt_L, $opt_a, $opt_r, $opt_R);
 my (%conv_author_name, %conv_author_email, %conv_author_tz);
 
+my $cvsps2 = "@@CVSPS2_PATH@@";
+
 sub usage(;$) {
 	my $msg = shift;
 	print(STDERR "Error: $msg\n") if $msg;
@@ -751,7 +753,7 @@ sub munge_user_filename {
 		unless (defined($opt_p) && $opt_p =~ m/--no-cvs-direct/) {
 			push @opt, '--cvs-direct';
 		}
-		exec("cvsps","--norc",@opt,"-u","-A",'--root',$opt_d,$cvs_tree);
+		exec($cvsps2,"--norc",@opt,"-u","-A",'--root',$opt_d,$cvs_tree);
 		die "Could not start cvsps: $!\n";
 	}
 	($cvspsfh, $cvspsfile) = tempfile('gitXXXXXX', SUFFIX => '.cvsps',
diff --git a/t/lib-cvs.sh b/t/lib-cvs.sh
index 44263ad..bdab63c 100644
--- a/t/lib-cvs.sh
+++ b/t/lib-cvs.sh
@@ -13,7 +13,9 @@ fi
 CVS="cvs -f"
 export CVS
 
-cvsps_version=`cvsps -h 2>&1 | sed -ne 's/cvsps version //p'`
+CVSPS="$CVSPS2_PATH"
+
+cvsps_version=`$CVSPS -h 2>&1 | sed -ne 's/cvsps version //p'`
 case "$cvsps_version" in
 2.1 | 2.2*)
 	;;
-- 
1.8.1.421.g6236851

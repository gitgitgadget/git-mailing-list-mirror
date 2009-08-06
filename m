From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v7] mailinfo: allow e-mail files as input
Date: Thu,  6 Aug 2009 19:07:50 +0200
Message-ID: <538521a8fef8b898717e52e4d1913fdf24593679.1249577595.git.nicolas.s.dev@gmx.fr>
References: <20090717220424.GA12968@vidovic>
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	<git@vger.kernel.org>, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 19:08:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ6Rn-0002CJ-01
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 19:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756263AbZHFRIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 13:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756228AbZHFRIA
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 13:08:00 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:26729 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503AbZHFRH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 13:07:59 -0400
Received: by ey-out-2122.google.com with SMTP id 9so382815eyd.37
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 10:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=VwHQHqjVy+Y6/Td68Pe3Vd6C2tiCwpuNet+Eol2K0rE=;
        b=FUesDkHSfHnaQGsISWShUO+103zOGrXqe1I9BeXhL+rhtKOUqLRnNd/pICN2x+nV7M
         pzaFSWILuApEndDn1xyFIBmXzu274x2CBdp3YK3tb/AqxnGfREv3C+pLtG1BnKYDoUzd
         BNCoIt6SFC8aDLCVTScl4YQiFadVer9g29XAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=hxekPtuFm0dtCaxgAWgXECxGCaNXbQ4RhxwkfK76dDVvHviYS7tXcch67iD/DhlM/q
         rorvLBminAsmakeQLTjEccsXWKz72jyJgZgEfXNzFYMr5X2o5JwgxM4Ta+buBjL9ynjk
         nhDsg/uivZoVWOKsvvUQi4uYeYJ9z1X4BlsT8=
Received: by 10.210.82.18 with SMTP id f18mr140742ebb.38.1249578479333;
        Thu, 06 Aug 2009 10:07:59 -0700 (PDT)
Received: from localhost (91-164-149-117.rev.libertysurf.net [91.164.149.117])
        by mx.google.com with ESMTPS id 7sm723046eyg.15.2009.08.06.10.07.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 10:07:57 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.124.gf10b
In-Reply-To: <20090717220424.GA12968@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125092>

We traditionally allowed a mbox file or a directory name of a maildir to be
given to "git am".  Even though an individual file in a maildir (or more
generally, a piece of RFC2822 e-mail) is not a mbox file, it contains enough
information to create a commit out of it, so there is no reason to reject one.
It allows to run 'git am' with an email list argument, something like:

 $ git am dir/*
 $ git am email1 email2

This builds on top of a5a6755 (git-am foreign patch support: introduce
patch_format, 2009-05-27) that introduced mailbox format detection.  The
codepath to deal with a mbox requires it to begin with "From " line and
also allows it to begin with "From: ", but a random piece of e-mail can
and often do begin with any valid RFC2822 header lines.

Instead of checking the first line, we extract all the lines up to the
first empty line, and make sure they look like e-mail headers.

Credit on most of how this has been written goes to Junio.

Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
---

This round after v1.6.4 release and includes last comments pointed out in

	Subject: Re: [PATCH v6] mailinfo: allow e-mail files as input
	From: Junio C Hamano <gitster@pobox.com>
	Date: Thu, 16 Jul 2009 18:05:10 -0700
	Message-ID: <7v1vog6rw9.fsf@alter.siamese.dyndns.org>

	Subject: [PATCH v6] Re: mailinfo: allow e-mail files as input
	From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
	Date: Sat, 18 Jul 2009 00:04:24 +0200
	Message-ID: <20090717220424.GA12968@vidovic>


 Documentation/git-am.txt |   13 ++++++++-----
 git-am.sh                |   14 ++++++++++++++
 t/t4150-am.sh            |   30 ++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 32e689b..a19a82d 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	 [--ignore-date]
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
 	 [--reject] [-q | --quiet]
-	 [<mbox> | <Maildir>...]
+	 [<mbox> | <Maildir>... | <email>... ]
 'git am' (--skip | --resolved | --abort)
 
 DESCRIPTION
@@ -25,10 +25,13 @@ current branch.
 
 OPTIONS
 -------
-<mbox>|<Maildir>...::
-	The list of mailbox files to read patches from. If you do not
-	supply this argument, the command reads from the standard input.
-	If you supply directories, they will be treated as Maildirs.
+<mbox>|<Maildir>|<stgit>|<email>::
+	One or more of the same type of mail source to read e-mails
+	from.  A directory is taken as a mailbox in the maildir
+	format.  A file is taken as UNIX mbox, StGit patch file,
+	or a single piece of e-mail in RFC2822 format.  StGit
+	patches series are also supported but only one series at
+	a time.
 
 -s::
 --signoff::
diff --git a/git-am.sh b/git-am.sh
index d64d997..617ca2f 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -191,6 +191,20 @@ check_patch_format () {
 			esac
 			;;
 		esac
+		if test -z "$patch_format" &&
+			test -n "$l1" &&
+			test -n "$l2" &&
+			test -n "$l3"
+		then
+			# This begins with three non-empty lines.  Is this a
+			# piece of e-mail a-la RFC2822?  Grab all the headers,
+			# discarding the indented remainder of folded lines,
+			# and see if it looks like that they all begin with the
+			# header field names...
+			sed -n -e '/^$/q' -e '/^[ 	]/d' -e p "$1" |
+			grep -v -E -e '^[A-Za-z]+(-[A-Za-z]+)*:' >/dev/null ||
+			patch_format=mbox
+		fi
 	} < "$1" || clean_abort
 }
 
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index a12bf84..46adbc3 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -63,6 +63,29 @@ with the data reset to initial values.
 
 EOF
 
+cat >rfc2822_email <<\EOF
+Return-Path: <user@domain.name>
+X-Flags: 0000
+	999
+Delivered-To: delivery to user@domain.name
+Received: (qmail invoked by alias); 16 Jul 2009 05:25:49 -0000
+Received: from vger.knl.xyz (EHLO vger.knl.xyz) [4.3.2.1]
+  by mx0.gmx.com (mx-us004) with SMTP; 16 Jul 2009 01:25:49 -0400
+Received: (majordomo@vger.knl.xyz) by vger.knl.xyz via listexpand
+	id S1757506AbZGPFZp (ORCPT <rfc822;user@domain.name>);
+	Thu, 16 Jul 2009 01:25:45 -0400
+Date:	Wed, 15 Jul 2009 23:19:05 -0600
+From:	sender <user@domain.name>
+Subject: [PATCH] apply patch from rfc2822 formated email
+Content-Type: text/plain; charset=ISO-8859-1; format=flowed
+
+This text is part of the internal format of your mail folder, and is not
+a real message.  It is created automatically by the mail system software.
+If deleted, important folder data will be lost, and it will be re-created
+with the data reset to initial values.
+
+EOF
+
 echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >expected
 
 test_expect_success setup '
@@ -222,6 +245,13 @@ test_expect_success 'am takes patches from a Pine mailbox' '
 	test -z "$(git diff master^..HEAD)"
 '
 
+test_expect_success 'am takes patches from a RFC2822 formated email' '
+	git checkout first &&
+	cat rfc2822_email patch1 | git am &&
+	! test -d .git/rebase-apply &&
+	git diff --exit-code master^ HEAD
+'
+
 test_expect_success 'am fails on mail without patch' '
 	test_must_fail git am <failmail &&
 	rm -r .git/rebase-apply/
-- 
1.6.4.124.gf10b

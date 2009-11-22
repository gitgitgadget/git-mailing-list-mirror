From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 1/4] Clarify and correct -z
Date: Sun, 22 Nov 2009 20:43:20 +0100
Message-ID: <4B099458.6000909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 22 20:43:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCILL-0005q2-Fh
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 20:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778AbZKVTnS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Nov 2009 14:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753565AbZKVTnR
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 14:43:17 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:52054 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753486AbZKVTnR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 14:43:17 -0500
Received: by ewy19 with SMTP id 19so1206009ewy.21
        for <git@vger.kernel.org>; Sun, 22 Nov 2009 11:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=QT7qspC/Rp969oamTi44aveYfkBFGp7oKMh3cnjlAfM=;
        b=SV+5DGLx3YDPMoQkyKL+nMmzPArVfDlIQa1J4p43ge5H4KSCcx12XkORVHWmq9Aoq0
         8hjNb1YTtRNtpOEPTPNwpNj/NF1T/VH5hfmE7THyHESc01bqOxGO68YuDukYyawCu598
         xIGHEW984yOBCbSIgPXbKbmaC2IeNaCyNORMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=DG655UWlBxIrLtjVOXTttsy1yKFhPYA6oOQgdxrmKzQTaDzc8P1uMAi8xhZa2p28ZM
         sJW0mBXXKj49GtcqnuUcwr1SwBDyNh4SQLHRvOneNXwUBCJlsQAHTtwbXd0pp3CFxIlw
         oPbxLHYGIgVurzpejdmQMqGlsFfU0RWPzPkV4=
Received: by 10.216.90.131 with SMTP id e3mr1227440wef.69.1258919002239;
        Sun, 22 Nov 2009 11:43:22 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 28sm483725eye.11.2009.11.22.11.43.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Nov 2009 11:43:21 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133451>

The description for -z is too vague and general for the
apply, diff*, and log commands.

Change the description of -z for 'git log' to note that
commits will be separated by NULs.

Change the description of -z for 'git diff*' and 'git apply'
to note that it applies to the --numstat option, and for
'git diff*' also for --raw option.

Also correct the description of the "munging" of pathanmes that
takes place in the absence of -z for the 'git diff*' and
'git apply' commands, namely that apart from the characters mentioned,
double quotes will also be escaped and that the pathname will be
enclosed in double quotes if any characters are escaped.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
The original documentation for -z in diff-options.txt says:

"Also output from commands such as `git-log` will be delimited
with NUL between commits."

I am not sure about "such as git-log". What other command would
that be? In my patch, I have assumed that only 'git log' behaves
in that way (i.e. that it is the only command -z will change
the behavior of even when no other options are given).


 Documentation/diff-options.txt |   17 ++++++++++++++---
 Documentation/git-apply.txt    |   12 +++++++-----
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
index 2b37193..18366b1 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -85,10 +85,21 @@ ifndef::git-format-patch[]
 endif::git-format-patch[]
=20
 ifndef::git-format-patch[]
+
 -z::
-	NUL-line termination on output.  This affects the `--raw`
-	output field terminator.  Also output from commands such
-	as `git-log` will be delimited with NUL between commits.
+ifndef::git-log[]
+	When `--raw` or `--numstat` has been given, do not munge
+	pathnames and use NULs as output field terminators.
++
+Without this option, each pathname output will have TAB, LF, double qu=
otes,
+and backslash characters replaced with `\t`, `\n`, `\"`, and `\\`,
+respectively, and the pathname will be enclosed in double quotes if
+any of those replacements occurred.
+endif::git-log[]
+
+ifdef::git-log[]
+	Separate the commits with NULs instead of with new newlines.
+endif::git-log[]
=20
 --name-only::
 	Show only names of changed files.
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 5ee8c91..0156ca9 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -87,11 +87,13 @@ the information is read from the current index inst=
ead.
 	rejected hunks in corresponding *.rej files.
=20
 -z::
-	When showing the index information, do not munge paths,
-	but use NUL terminated machine readable format.  Without
-	this flag, the pathnames output will have TAB, LF, and
-	backslash characters replaced with `\t`, `\n`, and `\\`,
-	respectively.
+	When `--numstat` has been given, do not munge pathnames,
+	but use a NUL-terminated machine-readable format.
++
+Without this option, each pathname output will have TAB, LF, double qu=
otes,
+and backslash characters replaced with `\t`, `\n`, `\"`, and `\\`,
+respectively, and the pathname will be enclosed in double quotes if
+any of those replacements occurred.
=20
 -p<n>::
 	Remove <n> leading slashes from traditional diff paths. The
--=20
1.6.5.3.298.g39add

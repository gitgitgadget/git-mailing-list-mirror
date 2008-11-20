From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: [PATCH/gitweb-caching] perl/: fix optional argument handling in _load methods
Date: Thu, 20 Nov 2008 13:41:36 +0100
Message-ID: <38041638267157ade226b396cbd960890bc4efd3.1227185278.git.christian@jaeger.mine.nu>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 20 13:57:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L396A-0002AO-4e
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 13:57:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbYKTM4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 07:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754388AbYKTM4D
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 07:56:03 -0500
Received: from ethlife-a.ethz.ch ([129.132.49.178]:37923 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753087AbYKTM4B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 07:56:01 -0500
Received: (qmail 17758 invoked by uid 1000); 20 Nov 2008 12:55:58 -0000
MBOX-Line: From 38041638267157ade226b396cbd960890bc4efd3 Mon Sep 17 00:00:00 2001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101417>

Perl's 'shift' only ever delivers the first of all subroutine/method
arguments, meaning that $self would be assigned a value but $raw_text
would always remain undef even if an argument would have been passed
to the method.

Signed-off-by: Christian Jaeger <christian@jaeger.mine.nu>
---
 This is a fix for the code in git://repo.or.cz/git/gitweb-caching.git

 perl/Git/Commit.pm |    3 ++-
 perl/Git/Tag.pm    |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/perl/Git/Commit.pm b/perl/Git/Commit.pm
index ee87e11..6ed076b 100644
--- a/perl/Git/Commit.pm
+++ b/perl/Git/Commit.pm
@@ -141,7 +141,8 @@ sub encoding {
 # The raw contents of the commit object; the commit object will be
 # retrieved from the repository if that parameter is not given.
 sub _load {
-	my ($self, $raw_text) = shift;
+	my $self = shift;
+	my ($raw_text)=@_;
 	return if exists $self->{message};  # already loaded
 
 	my $sha1 = $self->sha1;
diff --git a/perl/Git/Tag.pm b/perl/Git/Tag.pm
index 5622431..e1f1201 100644
--- a/perl/Git/Tag.pm
+++ b/perl/Git/Tag.pm
@@ -132,7 +132,8 @@ sub encoding {
 # The raw contents of the tag object; the tag object will be retrieved
 # from the repository if that parameter is not given.
 sub _load {
-	my ($self, $raw_text) = shift;
+	my $self = shift;
+	my ($raw_text)=@_;
 	return if exists $self->{message};  # already loaded
 
 	my $sha1 = $self->sha1;
-- 
1.6.0.4

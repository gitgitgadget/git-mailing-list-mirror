X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-cvsimport feature request
Date: Tue, 12 Dec 2006 23:05:47 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612122305060.2807@wbgn013.biozentrum.uni-wuerzburg.de>
References: <fcaeb9bf0612120442v4cd03a5fq44625fafed4217b7@mail.gmail.com> 
 <Pine.LNX.4.63.0612121535290.2807@wbgn013.biozentrum.uni-wuerzburg.de>
 <fcaeb9bf0612121334t454ec67av2c319382d1f61cce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 12 Dec 2006 22:06:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <fcaeb9bf0612121334t454ec67av2c319382d1f61cce@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34150>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuFlj-0000rJ-Vu for gcvg-git@gmane.org; Tue, 12 Dec
 2006 23:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932465AbWLLWFy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 17:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWLLWFy
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 17:05:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:57756 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932465AbWLLWFv
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 17:05:51 -0500
Received: (qmail invoked by alias); 12 Dec 2006 22:05:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp028) with SMTP; 12 Dec 2006 23:05:49 +0100
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

[readding list...]

On Wed, 13 Dec 2006, Nguyen Thai Ngoc Duy wrote:

> Hi,
> 
> On 12/12/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > It could be done easily, but it is almost as easy to edit the command line
> > to substitute "git " with "git repo-config alias.cvsup '" (note the
> > single apostrophe at the end) and append and apostrophe at the end of the
> > line.
> 
> Thanks. I know that (and am doing that). Just think that it may be
> more convenient typing the command once.

Something like this?

-- snip --
[PATCH] cvsimport: save the last successful command line as alias "cvsup"

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 git-cvsimport.perl |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index c5bf2d1..48fd55b 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -85,6 +85,12 @@ sub write_author_info($) {
 	close ($f);
 }
 
+my $alias = "cvsimport";
+foreach my $arg (@ARGV) {
+	$arg =~ s/[ \"]/\\&/g;
+	$alias .= ' ' . $arg;
+}
+
 getopts("hivmkuo:d:p:C:z:s:M:P:A:S:L:") or usage();
 usage if $opt_h;
 
@@ -946,6 +952,9 @@ if (defined $orig_git_index) {
 if ($orig_branch) {
 	print "DONE.\n" if $opt_v;
 	if ($opt_i) {
+		# uncomment this line, if the alias "cvsup" should be
+		# created/updated even with -i
+		#system("git-repo-config", "alias.cvsup", $alias);
 		exit 0;
 	}
 	my $tip_at_end = `git-rev-parse --verify HEAD`;
@@ -971,3 +980,7 @@ if ($orig_branch) {
 		die "checkout failed: $?\n" if $?;
 	}
 }
+
+# so far, so good. store it as alias cvsup
+system("git-repo-config", "alias.cvsup", $alias);

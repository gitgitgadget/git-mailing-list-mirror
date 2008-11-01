From: Ian Hilt <ian.hilt@gmx.com>
Subject: Re: [PATCH 2/3] git send-email: do not ask questions when
	--compose is used.
Date: Fri, 31 Oct 2008 22:26:49 -0400
Message-ID: <20081101022649.GB17961@sys-0.hiltweb.site>
References: <1225456609-694-3-git-send-email-madcoder@debian.org> <20081031213338.GB21345@maintenance05.msc.mcgregor-surmount.com> <20081031213803.GB21799@artemis.corp> <20081031220149.GD21345@maintenance05.msc.mcgregor-surmount.com> <1225450632-7230-1-git-send-email-madcoder@debian.org> <1225456609-694-1-git-send-email-madcoder@debian.org> <1225456609-694-2-git-send-email-madcoder@debian.org> <1225456609-694-3-git-send-email-madcoder@debian.org> <20081031213338.GB21345@maintenance05.msc.mcgregor-surmount.com> <20081031213803.GB21799@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 03:29:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw6F7-0001Oc-3N
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 03:29:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbYKAC0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 22:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbYKAC0z
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 22:26:55 -0400
Received: from mail.gmx.com ([74.208.5.67]:51282 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751170AbYKAC0z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 22:26:55 -0400
Received: (qmail invoked by alias); 01 Nov 2008 02:26:52 -0000
Received: from cpe-75-185-223-130.woh.res.rr.com (EHLO sys-0.hiltweb.site) [75.185.223.130]
  by mail.gmx.com (mp-us005) with SMTP; 31 Oct 2008 22:26:52 -0400
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX1/lStoYOxrl5vXC6vLqmcKwh2CrZxqS9KckkypRN9
	HggziXvae4jJlX
Content-Disposition: inline
In-Reply-To: <20081031220149.GD21345@maintenance05.msc.mcgregor-surmount.com> <20081031213803.GB21799@artemis.corp>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99715>

On Fri, Oct 31, 2008 at 06:01:49PM -0400, Ian Hilt wrote:
> I've thought something like this would be a good thing.  An editor makes
> things easier to fix than the command-line.

Speaking of which, maybe let's add the To field to the list.

--->8---
From: Ian Hilt <ian.hilt@gmx.com>
Date: Fri, 31 Oct 2008 22:15:46 -0400
Subject: [PATCH] git-send-email.perl: add To field in editor

This allows the compose mode to add the To field in the editor.  However
it currently will not remove an address.

Signed-off-by: Ian Hilt <ian.hilt@gmx.com>
---

This is on top of the previous patch I sent.

 git-send-email.perl |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 0944be7..ed95402 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -450,6 +450,12 @@ if ($compose) {
 
 
 	my $tpl_sender = $sender || $repoauthor || $repocommitter || '';
+	my @tpl_to;
+	if (@to) {
+		foreach my $i (0..$#to) {
+			$tpl_to[$i] = $to[$i];
+		}
+	}
 	my $tpl_subject = $initial_subject || '';
 	my $tpl_reply_to = $initial_reply_to || '';
 
@@ -459,6 +465,7 @@ From $tpl_sender # This line is ignored.
 # Consider including an overall diffstat or table of contents
 # for the patch you are writing.
 From: $tpl_sender
+To: @tpl_to
 Subject: $tpl_subject
 In-Reply-To: $tpl_reply_to
 
@@ -514,6 +521,9 @@ EOT
 		} elsif (/^From:\s*(.+)\s*$/i) {
 			$sender = $1;
 			next;
+		} elsif (/^To:\s*(.+)\s*$/i) {
+			push @to, $1;
+			next;
 		}
 		$summary_empty = 0;
 		print C2 $_;
@@ -522,7 +532,7 @@ EOT
 	close(C2);
 
 	if ($summary_empty) {
-		print "Summary email is empty, skpping it\n";
+		print "Summary email is empty, skipping it\n";
 		$compose = -1;
 	}
 } elsif ($annotate) {
-- 
1.6.0.3.523.g304d0

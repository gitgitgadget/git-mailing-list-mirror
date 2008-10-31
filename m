From: Ian Hilt <ihilt@mcgregor-surmount.com>
Subject: Re: [PATCH 2/3] git send-email: do not ask questions when
	--compose is used.
Date: Fri, 31 Oct 2008 18:01:49 -0400
Message-ID: <20081031220149.GD21345@maintenance05.msc.mcgregor-surmount.com>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org> <1225456609-694-1-git-send-email-madcoder@debian.org> <1225456609-694-2-git-send-email-madcoder@debian.org> <1225456609-694-3-git-send-email-madcoder@debian.org> <20081031213338.GB21345@maintenance05.msc.mcgregor-surmount.com> <20081031213803.GB21799@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 23:03:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw25A-0007kk-30
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 23:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450AbYJaWBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 18:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753431AbYJaWBw
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 18:01:52 -0400
Received: from mail.mcgregor-surmount.com ([70.61.40.162]:59418 "EHLO
	mcgregor-surmount.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752776AbYJaWBv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 18:01:51 -0400
Received: from maintenance05.msc.mcgregor-surmount.com ([70.61.40.162]) by mcgregor-surmount.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 31 Oct 2008 18:01:49 -0400
Content-Disposition: inline
In-Reply-To: <20081031213803.GB21799@artemis.corp>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 31 Oct 2008 22:01:49.0978 (UTC) FILETIME=[4678FFA0:01C93BA4]
X-TM-AS-Product-Ver: SMEX-8.1.0.1092-5.500.1027-16252.002
X-TM-AS-Result: No--9.135200-0.000000-31
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99657>

On Fri, Oct 31, 2008 at 10:38:03PM +0100, Pierre Habouzit wrote:
> On Fri, Oct 31, 2008 at 09:33:38PM +0000, Ian Hilt wrote:
> > On Fri, Oct 31, 2008 at 01:36:48PM +0100, Pierre Habouzit wrote:
> > > +GIT: Please enter your email below this line.
> > 
> > At first glance I thought this meant to enter my email address here.
> > So, instead of "email" would "message" be better?  Although on second
> > glance I realized this is where the body of the message went.  Not sure
> > if this is worth changing.
> 
> Well, this line sounds kind of awkward actually, so I was even thinking
> about removing it.
> 
> Decent editors should probably have a plugin to put the cursor here and
> be done with it.
> 
> 
> In fact what looks odd is the GIT: stuff. a line looking like:
> 
>     --- write your message below this line ---
> 
> Looks 10x better, though need some code to strip it out if the user kept
> it, and I'm lazy, GIT: stuff is automatically removed...

Or, to follow the convention of git-status and git-commit, you could do
this with "# ".

So something like,

--->8---
From: Ian Hilt <ihilt@mcgregor-surmount.com>
Date: Fri, 31 Oct 2008 17:55:46 -0400
Subject: [PATCH] Use a hash instead of GIT: for line removal

Signed-off-by: Ian Hilt <ihilt@mcgregor-surmount.com>
---
 git-send-email.perl |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5cebb40..c6e21a8 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -427,7 +427,7 @@ sub get_patch_subject($) {
 	while (my $line = <$fh>) {
 		next unless ($line =~ /^Subject: (.*)$/);
 		close $fh;
-		return "GIT: $1\n";
+		return "# $1\n";
 	}
 	close $fh;
 	die "No subject line in $fn ?";
@@ -446,14 +446,14 @@ if ($compose) {
 
 	print C <<EOT;
 From $tpl_sender # This line is ignored.
-GIT: Lines beginning in "GIT: " will be removed.
-GIT: Consider including an overall diffstat or table of contents
-GIT: for the patch you are writing.
+# Lines beginning in "# " will be removed.
+# Consider including an overall diffstat or table of contents
+# for the patch you are writing.
 From: $tpl_sender
 Subject: $tpl_subject
 In-Reply-To: $tpl_reply_to
 
-GIT: Please enter your email below this line.
+# --- write your message below this line ---
 
 EOT
 	for my $f (@files) {
@@ -479,7 +479,7 @@ EOT
 	my $in_body = 0;
 	my $summary_empty = 1;
 	while(<C>) {
-		next if m/^GIT: /;
+		next if m/^# /;
 		if ($in_body) {
 		} elsif (/^\n$/) {
 			$in_body = 1;
--->8---

> But if that's the only thing that you don't like in the series, I'm
> glad, this is quite a minor issue ;)

I've thought something like this would be a good thing.  An editor makes
things easier to fix than the command-line.

	Ian

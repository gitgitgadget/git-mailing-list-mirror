X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Allow subcommand.color and color.subcommand color configuration
Date: Wed, 13 Dec 2006 15:42:56 -0800
Message-ID: <20061213234256.GA10423@soma>
References: <200612130913.28917.andyparkins@gmail.com> <7vodq7e90z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 23:43:14 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vodq7e90z.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34260>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gudkh-0002uP-Ky for gcvg-git@gmane.org; Thu, 14 Dec
 2006 00:43:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751803AbWLMXnF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 18:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbWLMXnD
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 18:43:03 -0500
Received: from hand.yhbt.net ([66.150.188.102]:55689 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751804AbWLMXnB
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 18:43:01 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id E03C42DC034; Wed, 13 Dec 2006 15:42:56 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 13 Dec 2006
 15:42:56 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Andy Parkins <andyparkins@gmail.com> writes:
> 
> > While adding colour to the branch command it was pointed out that a
> > config option like "branch.color" conflicts with the pre-existing
> > "branch.something" namespace used for specifying default merge urls and
> > branches.  The suggested solution was to flip the order of the
> > components to "color.branch", which I did for colourising branch.
> > ...
> > Unfortunately git-svn reads "diff.color" and "pager.color"; which I
> > don't like to change unilaterally.
> 
> I think doing the same makes sense.  Something like this?

It works great for me after I fixed some syntax errors (patch below).

> -- >8 --
> git-svn: allow both diff.color and color.diff
> 
> The list concensus is to group color related configuration under
> "color.*" so let's be consistent.
> 
> Inspired by Andy Parkins's patch to do the same for diff/log
> family.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

Signed-off-by: Eric Wong <normalperson@yhbt.net> (with the following
fixes of course :)

diff --git a/git-svn.perl b/git-svn.perl
index 2893e3b..73ab8d8 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -926,7 +926,7 @@ sub cmt_showable {
 sub log_use_color {
 	return 1 if $_color;
 	my ($dc, $dcvar);
-	$dcvar = 'color.diff'
+	$dcvar = 'color.diff';
 	$dc = `git-repo-config --get $dcvar`;
 	if ($dc eq '') {
 		# nothing at all; fallback to "diff.color"
@@ -948,7 +948,7 @@ sub log_use_color {
 			}
 		}
 		chomp($pc);
-		if (-t *STDOUT || (defined $_pager && $pc eq 'true') {
+		if (-t *STDOUT || (defined $_pager && $pc eq 'true')) {
 			return ($ENV{TERM} && $ENV{TERM} ne 'dumb');
 		}
 		return 0;

-- 

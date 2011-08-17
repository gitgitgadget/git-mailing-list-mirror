From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC] git-svn: remove auto_abbrev (Getopt::Long option)
Date: Wed, 17 Aug 2011 01:02:10 +0000
Message-ID: <20110817010210.GA1189@dcvr.yhbt.net>
References: <4E46DF9C.8040900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 03:02:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtUWO-0008TO-Sw
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 03:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160Ab1HQBCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 21:02:12 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45807 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001Ab1HQBCL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 21:02:11 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id E16BF21191;
	Wed, 17 Aug 2011 01:02:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4E46DF9C.8040900@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179491>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> wrote:
> RFC because this changes user interface (no option abbreviation),
> but I know no other good way to fix the --author problem.
> 
> The --author option would be useful, because I usually use
>   git svn log --oneline
> and paste the changes with svn revision numbers to bugzilla etc.
> 
> All tests pass with this change.

How about minimizing the impact and potential breakage with this?

(I'm not sure if "blame" benefits/hurts from this, I almost never
use any form of it)

diff --git a/git-svn.perl b/git-svn.perl
index 96f373f..ba382eb 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -298,6 +298,9 @@ my %opts = %{$cmd{$cmd}->[2]} if (defined $cmd);
 read_git_config(\%opts);
 if ($cmd && ($cmd eq 'log' || $cmd eq 'blame')) {
 	Getopt::Long::Configure('pass_through');
+	if ($cmd eq 'log') {
+		Getopt::Long::Configure('no_auto_abbrev');
+	}
 }
 my $rv = GetOptions(%opts, 'help|H|h' => \$_help, 'version|V' => \$_version,
                     'minimize-connections' => \$Git::SVN::Migration::_minimize,
-- 
Eric Wong

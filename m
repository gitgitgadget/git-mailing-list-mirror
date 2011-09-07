From: Bryan Jacobs <bjacobs@woti.com>
Subject: Re: [PATCH] git-svn: teach git-svn to populate svn:mergeinfo
Date: Wed, 7 Sep 2011 10:14:34 -0400
Organization: White Oak Technologies
Message-ID: <20110907101434.281d037f@robyn.woti.com>
References: <20110902140702.066a4668@robyn.woti.com>
	<20110906205750.GB12574@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Sep 07 18:43:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1LDe-0008EZ-C2
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 18:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808Ab1IGQm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 12:42:59 -0400
Received: from mail02.woti.us ([66.92.158.6]:48460 "EHLO roscoe.woti.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752314Ab1IGQmY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 12:42:24 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by roscoe.woti.com (Postfix) with ESMTP id 0329C504D37EC;
	Wed,  7 Sep 2011 10:14:40 -0400 (EDT)
X-Virus-Scanned: amavisd-new at woti.com
Received: from roscoe.woti.com ([127.0.0.1])
	by localhost (roscoe.woti.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K8n9D-vMcUbv; Wed,  7 Sep 2011 10:14:35 -0400 (EDT)
Received: from robyn.woti.com (robyn.woti.com [192.168.168.187])
	by roscoe.woti.com (Postfix) with ESMTPSA id 1D947504D37EA;
	Wed,  7 Sep 2011 10:14:35 -0400 (EDT)
In-Reply-To: <20110906205750.GB12574@dcvr.yhbt.net>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180867>

On Tue, 6 Sep 2011 13:57:50 -0700
Eric Wong <normalperson@yhbt.net> wrote:

> Bryan Jacobs <bjacobs@woti.com> wrote:
> > +sub split_merge_info_range {
> > +	my ($range) = @_;
> > +	if ($range =~ /(\d+)-(\d+)/o) {
> 
> No need for "/o" in regexps unless you have a (constant) variable
> expansion in there.

Okay, I'll take that out. I got into the habit of putting "optimize" on
all regexes without an explicitly dynamic variable on some earlier Perl
version.

> > +sub merge_commit_fail {
> > +	my ($gs, $linear_refs, $d) = @_;
> > +	#while (1) {
> > +	#	my $cs = shift @$linear_refs or last;
> > +	#	command_noisy(qw/cherry-pick/, $cs);
> > +	#}
> > +	#command_noisy(qw/cherry-pick -m/, '1', $d);
> 
> Huh?  If there's commented-out code, it must be explained or removed.

I think I did explain that in my earlier comments. I'm still not happy
with the recovery-from-aborted-commit-series handling. That commented
bit was my attempt.

The best suggestion so far is to prescan the commits to fail-fast. I
will do that in the next revision of the patch, just give me some time
to put it together.

> > +	fatal "Aborted after failed dcommit of merge revision";
> > +}
> 
> > +++ b/t/t9160-git-svn-mergeinfo-push.sh
> > @@ -0,0 +1,97 @@
> > +#!/bin/sh
> > +#
> > +# Copyright (c) 2007, 2009 Sam Vilain
> 
> That should be: "Copyright (c) 2011 Brian Jacobs", correct?

Well, the file was copied from one bearing the Vilain copyright bit.
I'm not sure I entirely understand why it matters who holds the
individual copyrights if you have a collective license which is going to
be changed, but I can't just stick my own name on derived work - as the
setup code for that unit is.

> > +test_expect_success 'check svn:mergeinfo' '
> > +	mergeinfo=$(svn_cmd propget svn:mergeinfo
> > "$svnrepo"/branches/svnb1)
> > +	echo "$mergeinfo"
> 
> No need to echo unless you're debugging a test, right?
> 

Correct, leftover test-debugging cruft, will remove.

I will submit another revision shortly.

Bryan Jacobs

From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 0/3] Fix $((...)) coding style
Date: Thu, 4 Feb 2016 15:53:16 +0000
Message-ID: <20160204155316.GI29880@serenity.lan>
References: <cover.1454587284.git.johannes.schindelin@gmx.de>
 <20160204121437.GF29880@serenity.lan>
 <alpine.DEB.2.20.1602041334450.2964@virtualbox>
 <20160204130111.GG29880@serenity.lan>
 <alpine.DEB.2.20.1602041411520.2964@virtualbox>
 <20160204140609.GH29880@serenity.lan>
 <alpine.DEB.2.20.1602041619430.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Elia Pinto <gitter.spiros@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 04 16:53:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRMDw-0004fN-Po
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 16:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933909AbcBDPxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 10:53:33 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:49215 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933893AbcBDPxc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 10:53:32 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id E20CDCDA587;
	Thu,  4 Feb 2016 15:53:31 +0000 (GMT)
X-Quarantine-ID: <HeNwV8noz9e8>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HeNwV8noz9e8; Thu,  4 Feb 2016 15:53:29 +0000 (GMT)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 6792ECDA595;
	Thu,  4 Feb 2016 15:53:18 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1602041619430.2964@virtualbox>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285467>

On Thu, Feb 04, 2016 at 04:27:49PM +0100, Johannes Schindelin wrote:
> On Thu, 4 Feb 2016, John Keeping wrote:
> 
> > On Thu, Feb 04, 2016 at 02:13:47PM +0100, Johannes Schindelin wrote:
> > > Whatever the outcome, the inconsistency must be fixed.
> > 
> > I disagree.  Unless there are other changes in the same area, the noise
> > isn't worth it.
> > 
> > However, I do think we need to agree on a policy so that new code can be
> > consistent.  This should then be documented in CodingGuidelines.
> 
> If you want to enforce it in the future, how can you possibly be against
> fixing the inconsistency in the existing code? Sorry, I am really unable
> to understand this.

I avoided quoting CodingGuidelines in my previous message, but it says:

 - Fixing style violations while working on a real change as a
   preparatory clean-up step is good, but otherwise avoid useless code
   churn for the sake of conforming to the style.

   "Once it _is_ in the tree, it's not really worth the patch noise to
   go and fix it up."
   Cf. http://article.gmane.org/gmane.linux.kernel/943020

> Also, we *did* document the policy in the CodingGuidelines:
> 
> 	As for more concrete guidelines, just imitate the existing code
> 
> So. There you are. By that token, my patch series was the correct thing to
> do because the first arithmetic expression introduced into a shell script
> in Git's source code had no spaces.

This is the first point I made.  To take one example, in
git-filter-branch.sh there are five occurrences of the sequence "$((";
your patch changes four of them to remove spaces.  If we standardise on
having spaces only one needs to change:

$ git grep -F '$((' origin/master -- git-filter-branch.sh
origin/master:git-filter-branch.sh:             elapsed=$(($now - $start_timestamp))
origin/master:git-filter-branch.sh:             remaining=$(( ($commits - $count) * $elapsed / $count ))
origin/master:git-filter-branch.sh:                     next_sample_at=$(( ($elapsed + 1) * $count / $elapsed ))
origin/master:git-filter-branch.sh:                     next_sample_at=$(($next_sample_at + 1))
origin/master:git-filter-branch.sh:     git_filter_branch__commit_count=$(($git_filter_branch__commit_count+1))

I chose git-filter-branch.sh simply because it was touched by this patch
set but it is not an outlier in this regard.  Some crude statistics
across all of git.git:

# No space after plus
$ git grep -F '$((' | grep '\+[\$0-9]' | wc -l
34

# With space after plus
$ git grep -F '$((' | grep '\+ [\$0-9]' | wc -l
96

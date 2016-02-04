From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 0/3] Fix $((...)) coding style
Date: Thu, 4 Feb 2016 12:14:37 +0000
Message-ID: <20160204121437.GF29880@serenity.lan>
References: <cover.1454587284.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Elia Pinto <gitter.spiros@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 04 13:15:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRIoN-0005Kj-UQ
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 13:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbcBDMOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 07:14:53 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:44602 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964837AbcBDMOw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 07:14:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 83809CDA54F;
	Thu,  4 Feb 2016 12:14:51 +0000 (GMT)
X-Quarantine-ID: <Mt2hjgA5zr7T>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Mt2hjgA5zr7T; Thu,  4 Feb 2016 12:14:50 +0000 (GMT)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 0F1CECDA586;
	Thu,  4 Feb 2016 12:14:39 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <cover.1454587284.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285459>

On Thu, Feb 04, 2016 at 01:01:39PM +0100, Johannes Schindelin wrote:
> I noticed through a nearby patch series that was submitted by Elia that
> some of the $((...)) expressions introduced in scripts that I introduced
> to Git's source code did not match the existing code's convention:
> previously these expressions did not contain any spaces, now *some* do.
> 
> This patch series tries to clean that up quickly before even more code
> has to decide which one of the disagreeing coding conventions to use.
> 
> Note: For the sake of getting this patch series out, I skipped t/ and
> contrib/. I do not care much about the latter, but t/ should probably be
> fixed, too.

Should this be going this other way (i.e. standardising on having the
spaces)?

The current state (excluding contrib/ and t/) seems to favour spaces:

$ git grep '\$((' -- ':/' ':!t/' ':!contrib/'
Documentation/CodingGuidelines: - We use Arithmetic Expansion $(( ... )).
Documentation/CodingGuidelines:   of them, as some shells do not grok $((x)) while accepting $(($x))
generate-cmdlist.sh:    n=$(($n+1))
git-filter-branch.sh:           elapsed=$(($now - $start_timestamp))
git-filter-branch.sh:           remaining=$(( ($commits - $count) * $elapsed / $count ))
git-filter-branch.sh:                   next_sample_at=$(( ($elapsed + 1) * $count / $elapsed ))
git-filter-branch.sh:                   next_sample_at=$(($next_sample_at + 1))
git-filter-branch.sh:   git_filter_branch__commit_count=$(($git_filter_branch__commit_count+1))
git-rebase--interactive.sh:     total=$(($new_count + $(git stripspace --strip-comments <"$todo" | wc -l)))
git-rebase--interactive.sh:             count=$(($(sed -n \
git-rebase--interactive.sh:             lineno=$(( $lineno + 1 ))
git-rebase--merge.sh:   msgnum=$(($msgnum + 1))
git-rebase--merge.sh:   eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
git-rebase--merge.sh:   msgnum=$(($msgnum + 1))
git-rebase--merge.sh:   msgnum=$(($msgnum + 1))
git-submodule.sh:       n=$(($1 + 0)) 2>/dev/null && test "$n" = "$1"
git-submodule.sh:                       total_commits=" ($(($total_commits + 0)))"

I make that 3 without spaces (including the git-rebase--interactive.sh
case that wraps) and 12 that do have spaces around operators.  Using
spaces around operators also matches our C coding style.

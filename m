From: Dun Peal <dunpealer@gmail.com>
Subject: Re: Is there a way to add a default `--squash` flag for all merges
 into a head?
Date: Wed, 9 Mar 2011 10:38:17 -0800 (PST)
Message-ID: <5aad866e-38e6-4f0e-a942-97cc174651bb@o14g2000prb.googlegroups.com>
References: <9f02bed0-fa18-46b1-a3d3-346e1cc7dc01@k15g2000prk.googlegroups.com>
 <m2r5aibpsl.fsf@igel.home> <b98e837f-a0ae-4061-aa09-b4d30e3b0522@b13g2000prf.googlegroups.com>
 <7vr5ahe7jc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 19:49:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxORm-0008PO-Hu
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 19:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529Ab1CIStM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 13:49:12 -0500
Received: from mail-yw0-f56.google.com ([209.85.213.56]:46655 "EHLO
	mail-yw0-f56.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab1CIStL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 13:49:11 -0500
X-Greylist: delayed 652 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Mar 2011 13:49:11 EST
Received: by ywc21 with SMTP id 21so758756ywc.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 10:49:10 -0800 (PST)
Received: by 10.100.114.11 with SMTP id m11mr418695anc.25.1299695897707; Wed,
 09 Mar 2011 10:38:17 -0800 (PST)
Received: by o14g2000prb.googlegroups.com with HTTP; Wed, 9 Mar 2011 10:38:17
 -0800 (PST)
In-Reply-To: <7vr5ahe7jc.fsf@alter.siamese.dyndns.org>
X-IP: 66.250.141.150
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US;
 rv:1.9.2.15) Gecko/20110303 Firefox/3.6.15,gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168743>

On Mar 8, 1:28pm, Junio C Hamano <gits...@pobox.com> wrote:
> The solution to whatever problem you are trying to solve should not be to
> discard one of the most valuable information git keeps track of to avoid
> the CVS/(old)SVN mess when performing repeated merges with a branch.

Junio, this seems viable precisely because we generally don't perform
repeated merges between the same heads.

All of our branches right now are feature branches of master, whose
short lives end with a single merge back. Thus, merging back as a
single patch implementing that single feature is ideal: the branch was
only created to implement the feature, so by definition all of its
individual commits are intermediary, and once the final feature state
is achieved, the incremental steps leading to it are not interesting
at all - they're just noise!

Why would John care that while implementing feature X, Jill committed
her half-state Y so she can go home, or made and fixed typo Z ?  In
fact, why would Jill care a day, let a lone a couple of months, after
X was completed and merged to master?

The noisy, needless nature of these commits is further emphasized by
the default behavior of commit graph visualizers to display them in
full rather than collapse them. We have over 80 developers working on
all major operating systems, and using a variety of tools on each.
`log --first-parent` is nice, but my developers also use gitk, gitg,
gitx, GitExtensions, and TortoiseGit.

Finally, we are planning to integrate a few key long-lived branches,
for example a 'bleeding_edge' branch that everyone commits to, and
gets periodically merged into master by a technical lead. The
collapsing behavior a-la `--first-parent` may not always be desirable
once we start doing that, but if you turn it off without mandating
squashes, master's history becomes a mess of numerous feature-branch
merges, with all of their non-informative intermediary commits.

Hope that makes sense, .D

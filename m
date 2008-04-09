From: Bryan Donlan <bdonlan@fushizen.net>
Subject: Re: [PATCH 1/8] git-rebase.sh: Fix --merge --abort failures when
	path contains whitespace
Date: Wed, 9 Apr 2008 10:37:02 -0400
Message-ID: <20080409143702.GD24402@shion.is.fushizen.net>
References: <cover.1207702130.git.bdonlan@fushizen.net> <1207704604-30393-1-git-send-email-bdonlan@fushizen.net> <47FC6863.8070704@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>,
	gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 09 16:37:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjbQt-0008Dq-9u
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 16:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbYDIOhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 10:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752819AbYDIOhG
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 10:37:06 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:40526 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535AbYDIOhF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 10:37:05 -0400
Received: from hillmannl2.umeres.maine.edu ([130.111.243.252] helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bdonlan@fushizen.net>)
	id 1JjbQ6-0001HY-6F; Wed, 09 Apr 2008 14:37:02 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bdonlan@fushizen.net>)
	id 1JjbQ6-00077S-ES; Wed, 09 Apr 2008 10:37:02 -0400
Content-Disposition: inline
In-Reply-To: <47FC6863.8070704@viscovery.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79110>

On Wed, Apr 09, 2008 at 08:55:31AM +0200, Johannes Sixt wrote:
> Bryan Donlan schrieb:
> > -dotest=$GIT_DIR/.dotest-merge
> > +dotest="$GIT_DIR/.dotest-merge"
> 
> This is not strictly necessary: The RHS expression of an assignment does
> not undergo IFS splitting; but better safe than sorry. (But note that
> 'export foo=$bar', which is not POSIX, is *not* an assignment, and
> different shells that support this construct treat it differently.)

Since Junio asked(?) that it be removed, I'll drop it from the next rev
of the patchset.

> > +### Test that we handle strange characters properly
> > +work_dir="$(pwd)/test \" ' \$ \\ dir"
> 
> In effect, you modify only this test to stress-test strange characters,
> but other tests in the test suite still run in a "sane" environment. IOW,
> I don't think you should go to this extreme for this one test only. The
> better approach would be to rename 'trash' in test-lib.sh to this strange
> name so that all tests suffer from a challenging environment.

I can do that, but it'd have to come as the last patch in the patchset,
or it would obviously cause test failures. My goal here was to ensure
that the bug I fixed in the patch would be tested in an isolated manner.

If you like I can add a change to the trash directory to the next rev of
the patchset.

> 
> > -		git reset --hard pre-rebase
> > -		test_must_fail git rebase'"$type"' master &&
> > -		test -d '$dotest' &&
> > +		git reset --hard pre-rebase &&
> > +		test_must_fail git rebase$type master &&
> > +		test -d \"\$dotest\" &&
> 
> I could imagine that the missing && after the git reset is deliberate. Mike?

I assumed that if git reset failed here we'd probably want to know :)

Thanks,

Bryan

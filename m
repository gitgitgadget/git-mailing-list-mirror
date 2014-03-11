From: Jun Hao <achilles.hao@gmail.com>
Subject: Re: [PATCH 4/7] commit: fix patch hunk editing with "commit -p -m"
Date: Mon, 10 Mar 2014 20:45:00 -0400
Message-ID: <m2mwgx7ecz.fsf@jh.home>
References: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
	<1394477377-10994-5-git-send-email-benoit.pierre@gmail.com>
	<20140310200756.GC24568@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 01:50:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNAta-000091-0a
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 01:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874AbaCKAuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 20:50:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:41237 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753234AbaCKAuG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 20:50:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WNAtP-0008OP-LX
	for git@vger.kernel.org; Tue, 11 Mar 2014 01:50:03 +0100
Received: from pool-72-76-190-214.nwrknj.fios.verizon.net ([72.76.190.214])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 01:50:03 +0100
Received: from achilles.hao by pool-72-76-190-214.nwrknj.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 01:50:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pool-72-76-190-214.nwrknj.fios.verizon.net
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (darwin)
Cancel-Lock: sha1:0GMS1Rnt3unzJIfKANsZwgPfgv8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243828>

Jeff King <peff@peff.net> writes:

> On Mon, Mar 10, 2014 at 07:49:34PM +0100, Benoit Pierre wrote:
>
>> Don't change git environment: move the GIT_EDITOR=":" override to the
>> hook command subprocess, like it's already done for GIT_INDEX_FILE.
>> 
>> Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
>> ---
>>  builtin/checkout.c                |  8 +++----
>>  builtin/clone.c                   |  4 ++--
>>  builtin/commit.c                  | 35 ++++++++++++++++++++++++-------
>>  builtin/gc.c                      |  2 +-
>>  builtin/merge.c                   |  6 +++---
>>  commit.h                          |  3 +++
>>  run-command.c                     | 44 ++++++++++++++++++++++++++++-----------
>>  run-command.h                     |  6 +++++-
>>  t/t7513-commit_-p_-m_hunk_edit.sh |  2 +-
>>  9 files changed, 79 insertions(+), 31 deletions(-)
>
> This is a lot of change, and in some ways I think it is making things
> better overall. However, the simplest fix for this is basically to move
> the setting of GIT_EDITOR down to after we prepare the index.
>
> Jun Hao (cc'd) has been preparing a series for this based on the
> Bloomberg git hackday a few weeks ago, but it hasn't been sent to the
> list yet.
>
> Commits are here:
>
>   https://github.com/bloomberg/git/compare/commit-patch-allow-hunk-editing
>
> if you care to look. I'm not sure which solution is technically
> superior, but it's worth considering both.
>
> I regret not encouraging Jun to post to the list sooner, as we might
> have avoided some duplicated effort. But that's a sunk cost, and we
> should pick up whichever is the best for the project.
>
> -Peff

I like the idea that the environment setting should be done in one
place. Just not sure run_hook is the right place tho. If user doesn't have
any hook setup, will this kick in? 
One more question, will this work for dry run? Or dry run doesn't matter
in this case?

Thanks - Jun

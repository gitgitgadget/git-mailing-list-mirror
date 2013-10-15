From: Keshav Kini <keshav.kini@gmail.com>
Subject: Re: [BUG?] inconsistent `git reflog show` output, possibly `git fsck` output
Date: Tue, 15 Oct 2013 17:43:24 -0500
Message-ID: <87a9iayx2r.fsf@gmail.com>
References: <871u4hzusr.fsf@gmail.com> <523F749E.5030306@gmail.com>
	<xmqqtxgib1qm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 16 00:43:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWDL3-0000Sg-Rz
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 00:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933952Ab3JOWni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 18:43:38 -0400
Received: from plane.gmane.org ([80.91.229.3]:38375 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933522Ab3JOWnh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 18:43:37 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VWDKx-0000OI-KD
	for git@vger.kernel.org; Wed, 16 Oct 2013 00:43:35 +0200
Received: from nat-128-62-43-188.public.utexas.edu ([128.62.43.188])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Oct 2013 00:43:35 +0200
Received: from keshav.kini by nat-128-62-43-188.public.utexas.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Oct 2013 00:43:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: nat-128-62-43-188.public.utexas.edu
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Cancel-Lock: sha1:tn56ATKhXZIwd6yKdI8Hfp04kOk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236210>

Junio C Hamano <gitster@pobox.com> writes:

> Roberto Tyley <roberto.tyley@gmail.com> writes:
>
>> On 21/09/2013 23:16, Keshav Kini wrote:
>>> [SNIP]
>>> This situation came about because the BFG Repo-Cleaner doesn't write new
>>> reflog entries after creating its new objects and moving refs around.
>>
>> True enough - I don't think the BFG does write new entires to the
>> reflog when it does the final ref-update, and it would be nicer if it
>> did. I'll get that fixed.
>
> (sorry for replying late)
>
> So this can be closed as "BFG not writing reflog in a consistent
> way, and 'git reflog show' is acting GIGO way"?  Or was there
> something the core side needs to do?

Hi Junio,

Thanks for your reply. In my original mail, immediately after the
snippet Roberto quoted above, I said, "But that aside, I think how git
handles the situation might be a bug." To wit:

> It seems to me that one of two things should be the case. Either 1) it
> should be considered impossible to have a reflog for a ref X which
> doesn't contain a chain of commits leading up to the current location of
> X; or 2) if reflogs are allowed not to form an unbroken chain of commits
> leading to X, then `git reflog show` should at least make sure to
> actually display a commit ID corresponding to the second field of each
> reflog entry it reads, and not some other commit ID.
> 
> In the first case, the bug is that `git fsck` doesn't catch the
> supposedly impossible situation that exists in the repository I've
> described in this email. In the second case, the bug is that `git reflog
> show` has bad output.

Before this is closed, I would appreciate it if I could get some
feedback from git developers on the above two paragraphs.

Thanks,
    Keshav

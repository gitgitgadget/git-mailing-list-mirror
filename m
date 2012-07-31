From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] rebase -i: handle fixup of root commit correctly
Date: Tue, 31 Jul 2012 22:04:28 +0200
Message-ID: <50183A4C.9080706@kdbg.org>
References: <20120724121703.GG26014@arachsys.com> <5017A1E4.1070800@kdbg.org> <20120731111938.GD19416@arachsys.com> <20120731124824.GC14028@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 22:04:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwIgU-0005Kg-8r
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 22:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756073Ab2GaUEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 16:04:45 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:58914 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752271Ab2GaUEp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 16:04:45 -0400
Received: from [10.65.87.9] (178.115.251.9.wireless.dyn.drei.com [178.115.251.9])
	by bsmtp.bon.at (Postfix) with ESMTP id B2D5B13004C;
	Tue, 31 Jul 2012 22:04:37 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <20120731124824.GC14028@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202679>

Am 31.07.2012 14:48, schrieb Chris Webb:
> Chris Webb<chris@arachsys.com>  writes:
>
>> If we have a conflict in the middle of a chain of fixup/squashes, as far as
>> I can see, we have a HEAD with all the previous successful fixups applied,
>> conflict markers for the current failed pick, and when the conflict has been
>> resolved, git rebase --continue will commit --amend the resolution and
>> continue? Isn't that the correct behaviour here?
>
> As an explicit test, I've just tried a chain of four squashed commits, each
> of which deliberately resulted in a conflict to manually resolve. For each
> squash, I was left with conflict markers on top of what had already been
> squashed in the expected way, and when I continued after resolving these,
> the resolution was 'commit --amend'ed in the expected way, with the same
> behaviour and resulting commit at the end of the rebase -i as I get with a
> copy of git without this patch.

OK, good. One subtlety to watch out for is when commit messages are 
edited. That is, if you edit the proposed message at 'rebase --continue' 
after the first squash failed, is the new text preserved until the last 
squash? I *think* that previously that was the case.

That said, I do appreciate the new modus operandi. The state when a rebase 
is interrupted is much clearer than earlier: now HEAD contains everything 
that was successfully replayed so far, and the index anything that failed.

-- Hannes

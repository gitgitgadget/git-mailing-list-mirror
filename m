From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Small rerere in rebase regression
Date: Tue, 24 May 2016 22:46:15 +0200
Message-ID: <5744BD97.4070902@kdbg.org>
References: <57434572.6030306@kdbg.org>
 <xmqqy4708ss0.fsf@gitster.mtv.corp.google.com> <57437693.3030106@kdbg.org>
 <xmqqk2ik77cr.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 22:46:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5JDb-0005Xn-E8
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 22:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755236AbcEXUqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 16:46:19 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:64409 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753601AbcEXUqS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 16:46:18 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3rDnWC5VjTz5tlF;
	Tue, 24 May 2016 22:46:15 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 19C8D523B;
	Tue, 24 May 2016 22:46:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <xmqqk2ik77cr.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295531>

Am 24.05.2016 um 00:11 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>> However, calling "git rerere" after a failed "git commit" may be
>> destructive: it would record a resolution even though the commit has
>> not be completed. Think of an squash commit being aborted because the
>> user notices an error in the last minute. If that error is in a
>> conflict resolution, that wrong resolution would be recorded.
>
> So, the behaviour change you observed uncovered a small bug in
> "rebase -i" that was covered by the old limitation of "rerere" that
> refrained from creating preimage when there already is one?

I had a closer look, and found that the failure mode I described does 
not occur: after having resolved a commit, the user can call "git rebase 
--continue", but the "git commit" invocation that occurs there is 
guarded with a mere 'die', not 'die_with_patch'.

All other "git commit" guarded with 'die_with_patch' are either not 
interactive or are after a non-conflicting merge or cherry-pick (and so 
there was no opportunity to resolve a conflict).

-- Hannes

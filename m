From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git revert" feature suggestion: revert the last commit to a
 file
Date: Thu, 05 Feb 2009 16:15:33 -0800
Message-ID: <7vhc38a09m.fsf@gitster.siamese.dyndns.org>
References: <20090205202104.GA11267@elte.hu>
 <7vvdrobobc.fsf@gitster.siamese.dyndns.org> <20090205210018.GB21500@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Fri Feb 06 01:17:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVEPG-0003j5-PQ
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 01:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369AbZBFAPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 19:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753994AbZBFAPl
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 19:15:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58445 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754919AbZBFAPk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 19:15:40 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 781B52A84D;
	Thu,  5 Feb 2009 19:15:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A2B6C2A84C; Thu, 
 5 Feb 2009 19:15:35 -0500 (EST)
In-Reply-To: <20090205210018.GB21500@elte.hu> (Ingo Molnar's message of "Thu,
 5 Feb 2009 22:00:18 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 48C1A38C-F3E3-11DD-AFC8-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108637>

Ingo Molnar <mingo@elte.hu> writes:

> * Junio C Hamano <gitster@pobox.com> wrote:
>
>> Ingo Molnar <mingo@elte.hu> writes:
>> 
>> > So i have to do something like:
>> >
>> >    git revert $(git log -1 --pretty=format:"%h" kernel/softlockup.c)
>> >
>> > (tucked away in a tip-revert-file helper script.)
>> >
>> > But it would be so much nicer if i could do the intuitive:
>> >
>> >    git revert kernel/softlockup.c
>> >
>> > Or at least, to separate it from revision names cleanly, something like:
>> >
>> >    git revert -- kernel/softlockup.c
>> 
>> All three shares one issue.  Does the syntax offer you a way to give
>> enough information so that you can confidently say that it will find the
>> commit that touched the path most recently?  How is the "most recently"
>> defined?
>> 
>> At least you can restate the first one to:
>> 
>>     git revert $(git log -1 --pretty=format:"%h" core/softlockup -- kernel/softlockup.c)
>> 
>> to limit to "the one that touched this file _on this topic_".
>
> All in the current scope of the integration branch, sure. I.e. the same 
> scope of commits that "git log kernel/softlockup.c" uses.

But that is not how ":/syntax" works, at least right now.  It traverses
from tips of all refs and finds the newest one.  It might make sense to
make the discovery start from the current branch not from all tips.

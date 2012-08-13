From: Marc Branchaud <mbranchaud@xiplink.com>
Subject: Re: git repack vs git gc --aggressive
Date: Mon, 13 Aug 2012 10:20:15 -0400
Message-ID: <50290D1F.20007@xiplink.com>
References: <87zk66r28y.fsf@bitburger.home.felix> <20120807184405.GA440@sigill.intra.peff.net> <7vvcguv7y2.fsf@alter.siamese.dyndns.org> <87ehnewolp.fsf@bitburger.home.felix> <7v393ujypq.fsf@alter.siamese.dyndns.org>
Reply-To: marcnarc@xiplink.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Felix Natter <fnatter@gmx.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 16:19:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0vUe-0007ZM-VO
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 16:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561Ab2HMOTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 10:19:39 -0400
Received: from smtp130.ord.emailsrvr.com ([173.203.6.130]:55106 "EHLO
	smtp130.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227Ab2HMOTi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 10:19:38 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp17.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 990D0380473;
	Mon, 13 Aug 2012 10:19:37 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp17.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 5853D380472;
	Mon, 13 Aug 2012 10:19:37 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <7v393ujypq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203337>

On 12-08-10 04:09 PM, Junio C Hamano wrote:
> Felix Natter <fnatter@gmx.net> writes:
> 
>> I have a few questions about this:
>>
>>> As I am coming from "large depth is harmful" school, I would
>>> recommend
>>>
>>>  - "git repack -a -d -f" with large "--window" with reasonably short
>>>    "--depth" once, 
>>
>> So something like --depth=250 and --window=500? 
> 
> I would use more like --depth=16 or 32 in my local repositories.
> 
>>> and mark the result with .keep;
>>
>> I guess you refer to a toplevel '.keep' file.
> 
> Not at all.  And it is not documented, it seems X-<.
> 
> Typically you have a pair of files in .git/objects/pack, e.g.
> 
>   .git/objects/pack/pack-2e3e3b332b446278f9ff91c4f497bc6ed2626d00.idx
>   .git/objects/pack/pack-2e3e3b332b446278f9ff91c4f497bc6ed2626d00.pack
> 
> And you can add another file next to them
> 
>   .git/objects/pack/pack-2e3e3b332b446278f9ff91c4f497bc6ed2626d00.keep
> 
> to prevent the pack from getting repacked.  I think "git clone" does
> this for you after an initial import.

1.7.12.rc1 does not.

I even cloned from a repo with a few .keep files, but ended up with only one
big .pack file.

Maybe clone should preserve the packs it gets from the upstream repo?  For
example, our main repo has a 690MB pack file that's marked .keep, but the
clone just ends up with a single 725MB pack file.  Would our clones see
performance improvements if they that big 690MB pack separate from the others?

Perhaps the fact that clone creates a single pack file makes it impossible to
preserve the .keep packs from the upstream?

(I figure it's probably not a good idea for clone to .keep the single pack
file it creates.)

		M.

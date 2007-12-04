From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 4 Dec 2007 21:03:42 +0100
Message-ID: <74B7E58D-E4C2-40AC-ABC8-9B8E4BE154B7@zib.de>
References: <20071022063222.GS14735@spearce.org>	<7vzly84qwf.fsf@gitster.siamese.dyndns.org>	<7vmytycykt.fsf@gitster.siamese.dyndns.org>	<7vr6j6ve90.fsf@gitster.siamese.dyndns.org>	<7vir4d40sw.fsf@gitster.siamese.dyndns.org>	<7vwsso3poo.fsf@gitster.siamese.dyndns.org>	<7vfxz89x9q.fsf@gitster.siamese.dyndns.org>	<7vabpctx3b.fsf@gitster.siamese.dyndns.org>	<7vsl30eyuk.fsf@gitster.siamese.dyndns.org>	<7vve7tuz3a.fsf@gitster.siamese.dyndns.org>	<7v4pfakr4j.fsf@gitster.siamese.dyndns.org>	<7vzlwv6sxr.fsf@gitster.siamese.dyndns.org> <7vy7ca6ea9.fsf@gitster.siamese.dyndns.org> <47552084.3070601@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Dec 04 21:06:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ize1n-0002JE-V4
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 21:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbXLDUFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 15:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbXLDUFj
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 15:05:39 -0500
Received: from mailer.zib.de ([130.73.108.11]:54083 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbXLDUFi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 15:05:38 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lB4K4RKK012517;
	Tue, 4 Dec 2007 21:04:28 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lB4K4NxJ009956
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 4 Dec 2007 21:04:27 +0100 (MET)
In-Reply-To: <47552084.3070601@viscovery.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67078>


On Dec 4, 2007, at 10:40 AM, Johannes Sixt wrote:

> Junio C Hamano schrieb:
>> * sp/refspec-match (Sun Nov 11 15:01:48 2007 +0100) 4 commits
>>  + refactor fetch's ref matching to use refname_match()
>>  + push: use same rules as git-rev-parse to resolve refspecs
>>  + add refname_match()
>>  + push: support pushing HEAD to real branch name
>> The last one changes the semantics to somewhat less safe:
>>     * We did not allow fetching outside refs/ (except HEAD), but  
>> now we
>>       allow any random string.
>>     * We used to restrict fetching names that do not begin with  
>> refs/ to
>>       heads, tags and remotes, but now the code grabs anything  
>> underneath
>>       refs/.
>> which could invite mistakes by letting typos slip through, but I  
>> won't
>> be a good judge, as I probably "fetch" much less often than other  
>> people
>> do and these may be non issues in the real-world usecases.  It  
>> could be
>> that I am worried too much needlessly.  If anybody who is following
>> 'next' has been bitten by the change, please speak up.  Otherwise  
>> this
>> will go in soon.
>
> Forks on repo.or.cz use the namespace refs/forkee that lists  
> everything that the forkee has below refs/. So this change might  
> indeed be annoying. (But I'm not using next, so I can't tell, yet.)

But only if you accidentally wrote

    git fetch forkee/heads/something

instead of

    git fetch heads/something

which I don't think is a very likely typo.

With the last change, fetch still requires a match of the full
refspec created by prefixing a short refspec with "refs/".
Different from the old behaviour, it does no longer verify
that the short refspec from the command line starts with
heads, tags, or remotes.  However, it does _not_ recurse
into "sub-directories" to find a matching ref.  It won't
recurse into forkee, unless you explicitly tell fetch to look
in forkee.  With the old implementation you'd have to say
"refs/forkee/heads/something", while the new implementation
would also accept "forkee/heads/something".

	Steffen

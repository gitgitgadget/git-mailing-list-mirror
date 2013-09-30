From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Local tag killer
Date: Mon, 30 Sep 2013 15:16:07 -0400
Message-ID: <5249CDF7.4050904@xiplink.com>
References: <52327E62.2040301@alum.mit.edu> <CAPc5daXvCf90WYoUWC+DxRyZEQhXGL7Bd_ZJKwfoqxeKt8TADQ@mail.gmail.com> <xmqqd2o3p0nk.fsf@gitster.dls.corp.google.com> <523D3FD2.4090002@alum.mit.edu> <20130924075119.GD7257@sigill.intra.peff.net> <alpine.LFD.2.03.1309251834210.312@syhkavp.arg> <5246C975.1050504@alum.mit.edu> <CALKQrgeJn1J4ntE_2Lr7Et+Oao=vB1FE6nLfaFJOvLHJLzG9tA@mail.gmail.com> <5247ACB9.40208@alum.mit.edu> <52499797.9030100@xiplink.com> <alpine.LFD.2.03.1309301138200.6331@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Sep 30 21:17:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQiyB-0005pb-Q1
	for gcvg-git-2@plane.gmane.org; Mon, 30 Sep 2013 21:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756150Ab3I3TRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Sep 2013 15:17:19 -0400
Received: from smtp112.dfw.emailsrvr.com ([67.192.241.112]:56016 "EHLO
	smtp112.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755272Ab3I3TRS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Sep 2013 15:17:18 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp21.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id 5093A241989
	for <git@vger.kernel.org>; Mon, 30 Sep 2013 15:17:18 -0400 (EDT)
X-Virus-Scanned: OK
Received: from smtp106.ord1c.emailsrvr.com (smtp106.ord1c.emailsrvr.com [108.166.43.106])
	by smtp21.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTPS id 1E59B24194C
	for <git@vger.kernel.org>; Mon, 30 Sep 2013 15:17:18 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp6.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 8615298093;
	Mon, 30 Sep 2013 15:16:07 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp6.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 16B739815B;
	Mon, 30 Sep 2013 15:16:07 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <alpine.LFD.2.03.1309301138200.6331@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235621>

On 13-09-30 11:52 AM, Nicolas Pitre wrote:
> On Mon, 30 Sep 2013, Marc Branchaud wrote:
> 
>> Why would there be ambiguity warnings?  The fetch command shouldn't issue any
>> warnings, since all the remotes' names get safely tucked away in distinct
>> namespaces.
>>
>> Are we talking about DWIM warnings?  Aside from git-describe I don't see why
>> such warnings would be a problem.  To DWIM-resolve a tag name look in
>> refs/tags/* and refs/remotes/*/tags/* -- much like it's done for branches
>> already.  If a tag name has multiple matches then it's ambiguous.  Git could
>> be clever and check for matching SHA1 values, but why bother?  It almost
>> seems like a disservice to silently disambiguate such names.  I would think a
>> user would prefer to know about any possible ambiguities, rather than have
>> some suddenly appear (and maybe also disappear).
> 
> Consider that I have in my Linux kernel tree:
> 
> - a remote branch corresponding to Linus' master tree
> 
> - multiple remote branches corresponding to Linux stable branches
> 
> - a remote for linux-next which is a repo constantly being rebased
> 
> Now all those repositories share the mainline tags from Linus' repo and 
> they add some more of they own which are not shared.  So if they all 
> have a v3.11 tag that resolve to the same SHA1, then there is 
> effectively no ambiguity at all and git should not warn at all.

Thanks, this example helps very much.

> *However* if one of those v3.11 tags does not agree with the others 
> _then_ I want to be warned about it.

Hmmm.  What behaviour would you like if you also had some non-Linux remote,
say for some driver code or something, that also had a v3.11 tag?  I presume
you want commands like
	git checkout -b my-topic v3.11
to do the Right Thing, but what's the right thing for you here?

> So having multiple matching tags that do resolve to the same SHA1 across 
> different remote repositories _is_ the norm and should work 
> transparently.

My suggestion for your example is that if some remote's tags are so
important/useful then you're better off importing them into your local tag
namespace (e.g. "git fetch Linus refs/tags/*:refs/tags/*").  By making the
remote's tags local, you're expressly telling git that they should be
considered for DWIMery, git-describe, etc.

I feel this approach lets us avoid having to somehow teach git which remote's
"v3.11" tags are important enough to merit an ambiguity warning and which
aren't.  Plus you get what I think you want, which is the current behaviour.

If this works for you, maybe it gives us a way forward:  All the DWIM
machinery should only consider the local namespace, perhaps with options to
explicitly ask it to expand its search, and we leave it up to the user to
specify which remotes' namespaces should be imported into the local namespace?

		M.

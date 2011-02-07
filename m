From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 07 Feb 2011 11:10:43 -0500
Message-ID: <4D501983.5060508@xiplink.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com> <20110201181428.GA6579@sigill.intra.peff.net> <AANLkTimtU56BAnWU-2pY1npdkPdKEBq_CMCGwXUK+E=H@mail.gmail.com> <201102020322.00171.johan@herland.net> <7vpqr7xw4z.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1102051330270.12104@xanadu.home> <20110205193708.GA2192@sigill.intra.peff.net> <alpine.LFD.2.00.1102051449420.12104@xanadu.home> <7vvd0xvsjc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 17:10:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmTfN-0007Rh-8N
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 17:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913Ab1BGQJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 11:09:50 -0500
Received: from smtp132.iad.emailsrvr.com ([207.97.245.132]:33579 "EHLO
	smtp132.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879Ab1BGQJt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 11:09:49 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp53.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id BDEB45852F;
	Mon,  7 Feb 2011 11:09:47 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp53.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 7424758240;
	Mon,  7 Feb 2011 11:09:47 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <7vvd0xvsjc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166266>

On 11-02-06 03:04 PM, Junio C Hamano wrote:
> Nicolas Pitre <nico@fluxnic.net> writes:
> 
>>> The latter seems like a regression for the common case of fetching from
>>> two upstreams. E.g., I usually pull from Junio, getting
>>> remotes/origin/v1.7.0.  One day Shawn is the interim maintainer, and I
>>> pull from him, getting remotes/spearce/v1.7.0, which he previously
>>> fetched from Junio. Under the current code, I can still do "git show
>>> v1.7.0"; under the scheme described above I now have to say
>>> "origin/v1.7.0" to disambiguate.
>>
>> Let's suppose that both tags are identical, as in your scenario above 
>> they would be, then there is no need to call for any ambiguity in that 
>> case.
> 
> I agree that we do not want refs/remotes/tags/*/that-tag-people-agree-on
> in that case.  We want to store a single copy and find it there, and that
> single copy has traditionally been found in refs/tags hierarchy.
> 
> I think the real issue is not necessarily that the location is shared with
> local tag namespace, but is the lack of a convenient way (or just BCP) to
> segregate what are local and what are official when transferring tags out
> of your repository.  That is what discourages people from using tags for
> their personal and ephemeral use, marking some points in their own work
> with personal tags that are never intended to be published.

That may be an issue, but I don't think it's the issue in this thread.
Recall what Nicolas said:

	The extraordinary misfeature of the tag namespace at the
	moment comes from the fact that whenever you add a remote
	repo to fetch, and do fetch it, then your flat tag
	namespace gets polluted with all the tags the remote might
	have.  If you decide to delete some of those remote branches,
	the tags that came with it are still there and indistinguishable
	from other tags making it a real pain to sort out.

Those tags can all be properly "official" and still the problem exists.

In the "interim maintainer" case, I suggest it's not really a question of
private-vs-official tags.  Folks who clone directly from the maintainer
should understand that some tags are works-in-progress.  As the maintainer
role gets passed from person to person (and repo to repo), it seems more
useful to be able to distinguish work-in-progress tag vX.Y.Z as coming from
maintainer A or B, i.e. tags A/vX.Y.Z and B/vX.Y.Z.  If the tags point to the
same commit then just "vX.Y.Z" resolves fine.  But if the two maintainers
have different ideas of what vX.Y.Z should be, then the fully-qualified names
help to identify the differences.

Tags don't become "official" until they're published according to the
project's process.  For us git users, that means the tag appears in
git.kernel.org/pub/scm/git/git.git.  A tag that appears somewhere else can
have all sorts of meanings, but I don't think "official" could be one of them.

		M.

From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [1.8.0] Remote tag namespace
Date: Tue, 01 Feb 2011 10:07:09 -0500
Message-ID: <4D48219D.8060603@xiplink.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 16:07:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkHp1-000076-4J
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 16:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756852Ab1BAPHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 10:07:04 -0500
Received: from smtp132.iad.emailsrvr.com ([207.97.245.132]:47432 "EHLO
	smtp132.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949Ab1BAPHD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 10:07:03 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp53.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 01D5758669;
	Tue,  1 Feb 2011 10:07:02 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp53.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id C1EDA582B0;
	Tue,  1 Feb 2011 10:07:01 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165815>

On 11-02-01 05:44 AM, Nguyen Thai Ngoc Duy wrote:
> On Tue, Feb 1, 2011 at 11:16 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> On Tue, 1 Feb 2011, Nguyen Thai Ngoc Duy wrote:
>>> Another random wish, which does not come with a proposal. How about
>>> tag namespace (ie. tags from a remote stay in remote namespace)?
>>
>> Please make this into a proper proposal.  this would be indeed a huge
>> improvement.
> 
> OK I'm not familiar with tag code, but I can try.

OK, that teaches me to read through _all_ the unread messages before posting!

Needless to say, I support this proposal.

> Proposal:
> 
> Reserve refs/remote-tags namespace to store tags from remotes. Its
> structure is the same as in refs/remotes. When pulling tags, put them
> in refs/remote-tags/<remote> instead of refs/tags.
> Tag dereference code will be taught about refs/remote-tags with
> similar deref order as in remote branches.

I suggested a different home for the tags, but I don't have any insight into
what makes the most sense.  I'll defer to wiser folk on this.

> Config branch.*.globalTags (perhaps takes a pattern?) may be defined
> to create refs/tags/* in addition to refs/remote-tags/<remote>/* when
> fetching tags.

I may be getting into the weeds prematurely here, but why put the config item
under branch.* ?  Or did you mean remote.*.globalTags?  Personally, I don't
see a need for this.  I'd rather have the rev-parse machinery search in
remote tag namespaces if it can't find anything local.

> Migration plan:
> 
> refs/remote-tags will be used to store new tags unconditionally, which
> means there will be duplicates with the already-fetched tags in global
> namespace. Perhaps we can check if they point to the same sha-1, then
> choose not to annoy users with ambiguous tag messages?

(Again with the weeds...)  I don't think we could do that.  I'd want to be
able to have my own (local) tags that refer to the same commits as one or
more remote tags, and I'd want to see them all.

Better for "git tag" to learn scoping options like "git branch": -a and -r.
(Hmm, maybe git-tag's current -a could become -A...)

> I suggest to add config compatibility.remoteTagNamespace, default to
> false, which retains current behavior (i.e. also create tags in global
> namespace in addition to refs/remote-tags). After 1.8.0 (or a few more
> cycles) the default value becomes true. Users who wish to keep old
> behavior can put "false" in their ~/.gitconfig.
> 
> After a few years, remove support for the config key. Unrecognized
> compatibility.* keys will abort program. Users are forced to new
> behavior. I don't know, we may want to start annoy users that have the
> config key set a few cycles before we drop support.

Sounds good.  I'd vote for a faster transition, but that's just me.  :)

		M.

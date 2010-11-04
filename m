From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Tag refspecs (was Re: [PATCH] Remove restriction on notes ref base)
Date: Thu, 04 Nov 2010 10:35:06 -0400
Message-ID: <4CD2C49A.8010309@xiplink.com>
References: <1288657003-17802-1-git-send-email-kroot@google.com> <7vsjzixty5.fsf@alter.siamese.dyndns.org> <AANLkTin_NuzQocOab+w=B3Ka+n22j2-OXQu8=J6uzByS@mail.gmail.com> <201011040149.47968.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Kenny Root <kroot@google.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Nov 04 15:34:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE0tJ-000121-ID
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 15:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820Ab0KDOeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 10:34:07 -0400
Received: from smtp142.iad.emailsrvr.com ([207.97.245.142]:51548 "EHLO
	smtp142.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695Ab0KDOeG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 10:34:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp34.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id C8AB13806B8;
	Thu,  4 Nov 2010 10:34:04 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp34.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 641C53800EF;
	Thu,  4 Nov 2010 10:34:04 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <201011040149.47968.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160724>

On 10-11-03 08:49 PM, Johan Herland wrote:
> On Wednesday 03 November 2010, Sverre Rabbelier wrote:
>> On Wed, Nov 3, 2010 at 17:17, Junio C Hamano <gitster@pobox.com> wrote:
>>> I was actually thinking more along the lines of "not keeping track of
>>> remote state at all".  We don't do that for tags either.
>>
>> I would rather see us go the other way (and make the tags refspec put
>> tags under refs/tags/remotes/.../). I can understand not scoping tags
>> (since they're supposed to be immutable, and are usually global), but
>> I don't think the same holds for notes. Notes _are_ versioned, and
>> it's expected that users will collaborate.
> 
> Agreed. I don't see how you can easily share and manipulate notes between 
> repos _without_ keeping the remote state separate from the local state.
> 
> 
> I'm probably gonna be flamed for this, but I'd like to go even further, and 
> - for a future major version of Git - reconsider Git's default refspecs. 
> Currently we have:
> 
>   Remote repo    ->   Local repo
>   ------------------------------------------------
>   refs/heads/*        refs/remotes/$remote/*
>   refs/tags/*         refs/tags/*
>   refs/notes/*        ???
> 
> Of these, the first is specified in the config, the second is 
> implicit/magic, and the third would be specified in the config.
> 
> I'd probably suggest a more straightforward (and hopefully less confusing) 
> setup like this:
> 
>   Remote repo    ->   Local repo
>   ------------------------------------------------
>   refs/heads/*        refs/remotes/$remote/heads/*
>   refs/tags/*         refs/remotes/$remote/tags/*
>   refs/notes/*        refs/remotes/$remote/notes/*
> 
> ...and these would all be set in the config, i.e. no implicit/magic 
> refspecs.

I'll second this proposal, at least as far as tags go.  I can offer two
reasons to support this.


First, I think the assumption that tags are immutable is too strong.  In our
repo, we try to keep our topic branches mergeable into both the "master" and
"maintenance-of-the-latest-release" branches.

This means the topic branches need to be based at the point where the
maintenance and master branches diverged.  Making this rule easy to follow is
best accomplished with a tag, e.g. "topic-base", but that tag will move when
we create a new maintenance branch for a new release.  With the current tag
semantics, when that happens everyone has to delete their local topic-base
tags and get the new one from the common/shared repo.  People who forget to
do this end up basing their topics on outdated code, with predictable results.

It would be much easier to be able to just use an "origin/topic-base" tag
instead, one that that tracks the topic-base tag in the origin repo.


Second, I agree with Johan that the current semantics are confusing.  I'm
basically the git guru here at work, so it falls to me to teach people how
git works and how to use it.  I find that once people wrap their minds around
the concept of remote and local branches, they get tripped up by the way tags
work.

IMHO it would be more intuitive if tags used the same local/remote semantics
as branches.

		M.

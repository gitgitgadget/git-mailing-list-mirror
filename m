From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Added guilt.reusebranch configuration option.
Date: Thu, 23 May 2013 12:01:02 -0700
Message-ID: <7vtxlted1t.fsf@alter.siamese.dyndns.org>
References: <1369224677-16404-1-git-send-email-tytso@mit.edu>
	<x2ip2b6udr.fsf@bacon.lysator.liu.se>
	<20130522134212.GB13731@poseidon.cudanet.local>
	<20130522144531.GB2777@thunk.org>
	<7v8v36kiau.fsf@alter.siamese.dyndns.org>
	<20130522180403.GB20848@thunk.org>
	<7vvc6aj14r.fsf@alter.siamese.dyndns.org>
	<20130523021123.GA23155@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>,
	Per Cederqvist <ceder@lysator.liu.se>, git@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu May 23 21:01:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfalC-0004Fb-3o
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 21:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758860Ab3EWTBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 15:01:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34803 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758810Ab3EWTBG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 15:01:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 752EC2085F;
	Thu, 23 May 2013 19:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6P9BqLD2j/1ijDhiRwcdhwNBTVo=; b=Ls9JsF
	vUTznnLE3K6WipCOQDpTqYcfKzjjKBPnH5P63JKuGPmZxeeqnVCVJULFJ220zWY2
	7hv2cFnPQo61IDbSTQOd8nmSEx1V+BR4+/D+rkQ/ZwJGVcvPociuDTIlulGI1VG+
	LtERPpiuVaBkOmRrIHJXWkHDB2zZ1H8CkwQCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M+JbDQrSzJenVh/xbRN1QjSXravpsy1/
	HyKbo1B+5VTpY6EL9TFKqS/NzmQaDFuf3pW5IHZo56PtQMAf5DIkjtL6BY1Yailp
	9P5o0pwTUxts4aYdJzNDVbNTl7LvSFyqxh/VVMBGIiY7y2fibiqT6fzIKEo4bWsD
	K5OQKC3PU0s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67BE22085E;
	Thu, 23 May 2013 19:01:05 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80F152085D;
	Thu, 23 May 2013 19:01:04 +0000 (UTC)
In-Reply-To: <20130523021123.GA23155@thunk.org> (Theodore Ts'o's message of
	"Wed, 22 May 2013 22:11:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E233588-C3DB-11E2-BC15-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225282>

Theodore Ts'o <tytso@mit.edu> writes:

> On Wed, May 22, 2013 at 11:55:00AM -0700, Junio C Hamano wrote:
>> But in a triangular workflow, the way to make the result reach the
>> "upstream" is *not* by pushing there yourself.  For developers at
>> the leaf level, it is to push to their own repository (often on
>> GitHub), which is different from where they (initially) clone from
>> in order to bootstrap themselves, and (subsequently) pull from in
>> order to keep them up-to-date.  And then they request the published
>> work to be pulled by the "upstream".
>
> Yep, what I do personally is to call the destination of this "publish", i.e.:
>
> [remote "publish"]
> 	url = ssh://gitolite@ra.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.g
> 	push = +master:master
> 	push = +origin:origin
> 	push = +dev:dev
>
> So my typical work flow when I am ready to submit to Linus is:
>
>    git tag -s ext4_for_linus
>    git push publish
>     <wait for this to propagate from ra.kernel.org to git.kernel.org,
>      typically ~5 minutes>

And at this point I presume that you wish this "push" automatically
pushed out ext4_for_linus, just like "fetch" by default grabs tags
that point into the history being fetched?

I think "push --follow-tags" in the upcoming 1.8.3 would work for
you if that is the case.

>    git request-pull git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git origin > /tmp/pull
>     <use /tmp/pull as the e-mail body to send to Linus, cc'ing
>      LKML and linux-ext4@vger.kernel.org>
>
> But actually, it's much more common that I am doing a "git push
> publish" so that (a) it can get picked up by the daily linux-next tree
> (for integration testing even before Linus pulls it into his tree),
> and (b) so other ext4 developers so they can either test or develop
> against the ext4 tree in progress.
>
> I suppose it would be convenient for "git push" to push to the
> "publish" target, but I don't get confused about pushing to origin,
> since semantically what I am doing is publishing the current state of
> the ext4 tree so other people can see it.  So "git push publish" makes
> a lot of sense to me.

Noted.

>> Even in a triangular workflow, @{u} should still refer to the place
>> you integrate with, i.e. your "upstream", not to the place you push
>> to publish the result of your work.
>> 
>> This branch.<branch>.rewindable safety however cannot be tied to
>> @{u}.  The bottom boundary you want to be warned when you cross is
>> the change you pushed out to your publishing repository, and it may
>> not have reached remotes.origin.<branch> yet.
>
> Indeed, and in fact for my use case what I promise people is that all
> of the commits between origin..master are non-rewindable.  It's the
> commits betewen master..dev which are rewindable.  So for me, I'd
> still use the safety feature even for my rewindable branch, but
> instead of using remotes/publish/dev the "no-rewind" point, I'd want
> to use remotes/publish/master as the "no-rewind" point.

Sounds sensible.

> Right now I do this just by being careful, but if there was an
> automatic safety mechanism, it would save me a bit of work, since
> otherwise I might not catch my mistake until I do the "git push
> publish", at which point I curse and then start consulting the reflog
> to back the state of my tree out, and then reapplying the work I had
> to the right tree.

Yes, exactly.

> Yes, that would be convenient.  BTW, one of the other things which I
> do for e2fsprogs is that I use multiple publishing points, which is
> mostly for historical reasons --- it used to be that repo.or.cz wasn't
> all that reliable, and the 10-15 minute replication time from
> ra.kernel.org to git.kernel.org got really old.
>
> So what I do is something like this:
>
> git push publish ; git push repo ; git push code
>
> where....
>
> [remote "publish"]
> 	url = ssh://gitolite@ra.kernel.org/pub/scm/fs/ext2/e2fsprogs.git
> ...
> [remote "repo"]
> ...
> I don't know if this is something you'd want git to encourage, or
> support explicitly, but I thought I'd mention it.

I think you can have more than one destination URLs to a single
remote you are pushing as long as what are pushed and how are common
to them, that is, something like this:

[remote "publish"]
	; where do we fetch/pull from and how?
	url = ssh://gitolite@ra.kernel.org/pub/scm/fs/ext2/e2fsprogs.git
	fetch = +refs/heads/*:refs/heads/*
	; where do we push to and how?
	pushurl = ssh://gitolite@ra.kernel.org/pub/scm/fs/ext2/e2fsprogs.git
	pushurl = https://code.google.com/p/e2fsprogs/
	pushurl = ssh://repo.or.cz/srv/git/e2fsprogs.git
	push = next
	push = master
	push = maint
	push = debian
	push = +pu

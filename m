From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] patch-ids.c: cache patch IDs in a notes tree
Date: Sat, 11 May 2013 20:00:44 -0700
Message-ID: <7v1u9cx5pf.fsf@alter.siamese.dyndns.org>
References: <9d9e56d323b40fe9ea2a6484e35f0afcd3a3a85b.1368301939.git.john@keeping.me.uk>
	<CA+55aFyn0+Q4CA6yQZipaCRB0w9cW4YpuL3XuxU2JR5QPp98XQ@mail.gmail.com>
	<20130511214900.GF2299@serenity.lan>
	<CA+55aFzinmXA2HtA3hmN1VVOcLPWedfqJRws0RJMEc1By1VLLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun May 12 05:01:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbMX3-0000TW-6l
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 05:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754503Ab3ELDAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 23:00:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37604 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754111Ab3ELDAs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 23:00:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B5D112BEA;
	Sun, 12 May 2013 03:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xz0R2yO/Kow/UoLctso+YpnqCLU=; b=Y3Jb5r
	InxRcCeFg3B8M8Uf14YFxq7I5lTnBzK2LDY8cQHZyJ5NEL9BEJPhVG+48NXzqbw5
	/JP0Hrm2IsRKaXjD+g3Kk+a9YPQjt1JEToAuUZEoFof5GwrP0cP1yatIhpwaYcim
	in2YZS4y2RdA7ws6N9044lt/JstO9M9zQMqIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kALv8T+1z+yY5UjVHCbrtXI9nkQJ+C51
	EyD6+jz5fTkqMOun+cLz1upMwczbEENauieTB5P1BlBugyAuOoI4vxcJi4FtNnYD
	oUtEHHeSJwZ56JKeVbXNYgU63B/iS82J593+P2HMaYr4QZ+pS2Ipkj/lGTpAkwTJ
	ABgDEQnVLC8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3932412BE9;
	Sun, 12 May 2013 03:00:47 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8DB3912BE8;
	Sun, 12 May 2013 03:00:46 +0000 (UTC)
In-Reply-To: <CA+55aFzinmXA2HtA3hmN1VVOcLPWedfqJRws0RJMEc1By1VLLg@mail.gmail.com>
	(Linus Torvalds's message of "Sat, 11 May 2013 15:41:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 249E8536-BAB0-11E2-AF8E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224023>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, May 11, 2013 at 2:49 PM, John Keeping <john@keeping.me.uk> wrote:
>>
>> Hmm... I hadn't realised that.  Looking a bit closer, it looks like
>> init_patch_ids sets up its own diffopts so its not affected by the
>> command line (except for pathspecs which would be easy to check for).
>> Of course that still means it can be affected by settings in the user's
>> configuration.
>
> .. and in the actual diff algorithm.

As to the "objection" side of the argument, I already said
essentially the same thing several months ago:

  http://thread.gmane.org/gmane.comp.version-control.git/202654/focus=202898

and do not have much to add [*1*].

However.

The use of patch-id in cherry and rebase is to facilitate avoiding
to replay commits that are obviously identical to the ones you have
in your history.  The cached patch id for an existing old commit may
differ from a patch id you freshly compute for a new commit you are
trying to see if it truly new, even though they may represent the
same change.  So we may incorrectly think such a new commit is not
yet in your history and attempt to replay it.

But it is not a big problem.  Either 3-way merge notices that there
is nothing new, or you get a conflict and have chance to inspect
what is going on.

A conceptually much larger and more problematic issue is that we may
discard a truly new change that you still need as an old one you
already have due to a hash collision and discard it.  Because the
hash space of SHA-1 is so large, however, it is not a problem in
practice, and more importantly, that hash space is just as large as
the hash space used by Git to reduce a patch to a patch id, the
filtering done with patch-id in cherry and rebase _already_ have
that exact problem with or without this additional cache layer. A
stale cache may make the possibility of lost change due to such a
hash collision merely twice as likely.

> ... it's a "the patch ID actually ignores a lot of data in order
> to give the same ID even if lins have been added above it, and the
> patch is at different line numbers etc".

Yes.

> So maybe it doesn't matter. But at the same time, I really think
> caching patch ID's should be something people should be aware of is
> fundamentally wrong, even if it might work.

I do not think it is "caching patch ID" that people should be aware
of is fundamentally wrong.  What is fundamentally wrong, even if it
might work, is "using patch ID" itself.

> And quite frankly, if you do rebases etc so much that you think patch
> ID's are so important that they need to be cached, you may be doing
> odd/wrong things.

And that, too ;-)


[Footnote]

*1* For people listening from the sidelines, the fact that Git
algorithm can improve over time is a real issue, and and has caused
one issue that still hasn't been solved in the k.org upload process.
Somebody who has a repository there could *theoretically*:

 - push her v1.1 release via Git ("git push origin v1.1");
 - create a tarball ("git archive -o v1.1.tar v1.1") and diff since the
   last release ("git diff v1.0 v1.1 >v1.0-v1.1.diff") locally;
 - GPG sign them ("gpg -b v1.1.tar", "gpg -b v1.0-v1.1.diff"); and
 - upload only the signature files

and have k.org create the tarballs and diff to save bandwidth of
uploading logically derivable stuff over and over again.  But that
can be done only when output from "git archive" and "git diff" are
stable, which is not the case.  We changed how extended header fields
are used in the tar archive for a long pathname recently, and also
we changed use of XDF_NEED_MINIMAL a couple of years ago in "git diff";
both of these affect the output.

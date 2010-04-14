From: Junio C Hamano <gitster@pobox.com>
Subject: Re: TODO: git should be able to init a remote repo
Date: Wed, 14 Apr 2010 06:28:54 -0700
Message-ID: <7viq7urwmh.fsf@alter.siamese.dyndns.org>
References: <i2i76718491004131030sc2f8ffa3u97a91aa9a57923b5@mail.gmail.com>
 <20100414094048.GA19344@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 14 15:29:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O22eb-0004E3-55
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 15:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755198Ab0DNN3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 09:29:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62087 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab0DNN3K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 09:29:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C6C2AA79F;
	Wed, 14 Apr 2010 09:29:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BOMYvZXZpuL4IiZFfQm2/vYNh1A=; b=RiKitM
	TxlDTYzvsjDOnscCQ1hXCJMQ7vVlcuUM81zbuAthKH26hhAjaESvYIDHQGLYA/cc
	DC2N0aV3+rQAKddSf4AL2Tn11a9ThuGq4V5B1FMLkrXKQ7db0p+hrQN0fPYWVeh7
	uYBa6D57Pr+wZhyoaUeJmYU5L1iAWB5s4hrKs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XuR1UeYJc/zi+6c8GjDSJPqkHDBMvfTu
	Ljm8whLx4k5jM6Pexsla+l89ZLjINNFXcprYu0OA6ZB5rCh+CcaNmF3+lrGmd/7p
	p9CAzwRhy78RYA3KFeddE8b/exJQ7in4XNQM36n54TIn4dgKgB/K6E1ZG2uFr4C4
	3/m7ZPNAy4g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 80DDAAA799;
	Wed, 14 Apr 2010 09:29:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1215DAA793; Wed, 14 Apr
 2010 09:28:59 -0400 (EDT)
In-Reply-To: <20100414094048.GA19344@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 14 Apr 2010 05\:40\:49 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B1E13338-47C9-11DF-8E8A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144870>

Jeff King <peff@peff.net> writes:

> On Tue, Apr 13, 2010 at 01:30:44PM -0400, Jay Soffian wrote:
>
>> $ ssh remote git init --bare myproject.git
>> $ git remote add -m master origin remote:myproject.git
>> $ git push -u origin master
>> 
>> But we can do better. I was thinking something like:
>> 
>> $ git remote init [--push] [--mirror] <name> <ssh_url>
>
> I just reviewed the giant thread from last time this came up:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/111799

Thanks for a pointer to an amusing read.

> A few things I noticed were:
>
>   1. People seemed to want "git push --create". I think integrating it
>      with git-remote would be more convenient for most of my use cases,
>      but I can also see people wanting a one-off push-create without
>      worrying about configured remotes (e.g., because it is just a drop
>      point that they are going to delete later). So any code could
>      hopefully be used for both cases.

I think it is fine to have all of the following, triggering the same
underlying mechanism:

	git init over.there.com:myproject.git
        git remote add --create another over.there.com:myproject.git
        git push --create over.there.com:myproject.git master

Even though I'll say that we probably shouldn't have the second one in the
later part of this message.

>   2. We talked about an "init-serve" program back then. These days, "git
>      init $dir" works, so I don't see the need for one.

I don't get this; the primary point of init-serve was _not_ about the lack
of an internal mkdir in "git init", but was about having an interface to
trigger "git init" in a transport agnostic way.  The implementation of the
remote side mechanism could use "git init $dir" instead of "mkdir $dir &&
cd $dir && git init" these days, but I think that is a very minor point.

> Two questions/reservations looking at your prototype:
>
>   1. Should it push just master, or perhaps --all? Should it actually be
>      two separate options to "git remote add" (--push and --init?).

I would say "git remote add --create ..." shouldn't even have push option;
rather, don't put --create in "git remote".

"git push --create" would behave just like normal "push", and the above
question does not even come into the picture.  "push" will push whatever
it would normally push if the repository existed, period.

Also, wouldn't this sequence be more natural?

	git remote add another over.there.com:myproject.git
        git push another

That is, (1) "git remote add" would happily allow creating a local
description for a remote repository to be created; and optionally (2) "git
push" into a configured remote may not need an explicit "--create" (we may
still want to insist on --create to avoid a mistyped URL---I dunno).

>   2. The "git init $dir" syntax is what makes it reasonably transport
>      agnostic.

I am not sure what you are getting at here.  Are you suggesting that $dir
could be a URL (i.e. "git init over.there.com:myproject.git")?  Or are you
still thinking in terms of how "init-serve" (or its equivalent that is
either run directly via ssh or from transports supported by git) is
implemented using "git init"?  It seems the latter judging from this,...

>      ... But that syntax was not introduced until 1.6.5, so you
>      will run into problems with remotes running older versions of git.

... but then I don't see what it has to do with the "transport agnostic"
part of your comment.

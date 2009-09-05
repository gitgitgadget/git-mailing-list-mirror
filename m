From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] 'add -u' doesn't work from untracked subdir
Date: Sat, 05 Sep 2009 10:28:08 -0700
Message-ID: <7veiql1etz.fsf@alter.siamese.dyndns.org>
References: <20090902080305.GA11549@neumann>
 <20090902081917.GA5447@coredump.intra.peff.net>
 <20090904070216.GA3996@darc.dnsalias.org>
 <20090905061804.GB29863@coredump.intra.peff.net>
 <7v8wgt98ms.fsf@alter.siamese.dyndns.org>
 <20090905084641.GA24865@darc.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Sep 05 19:28:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjz3s-0000GH-CF
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 19:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbZIER2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 13:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752576AbZIER2T
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 13:28:19 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37147 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbZIER2S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 13:28:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ECB2F27E69;
	Sat,  5 Sep 2009 13:28:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uBjnw6TSyE2zJ/37Od3UfQbIfLk=; b=VHACsn
	ul7aPPiuMixDxSpdMko5QUAlwv4MquWaRnuNV96KL+jjhrE9A2nQ89ecuUKJi8An
	y/I46TLnNxKIV0k97by0ZPDOuwa+Vxn60Wxafe0W4W8Pc7di8kA6hA4cpuXKrJI3
	vyZgk8UZaoekIubSkT/VG2oNaFE2u8eK1gMfA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZhdBxEzg32Ivz1DB5R/G5ofKMsje/7u9
	7S3r7sQE/shC5kDZM58hmKSpOkut+g9Th4pv5QhRoqetEMO9fcMt6V7aAMJTvFJa
	Oz7K2iBtN8GpYL6bMeNwODo+e7d6616exrqMmdaiibmzFQfo1DpHXTQbYsBB43dV
	pRzIU7un/5Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B341D27E68;
	Sat,  5 Sep 2009 13:28:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD71027E67; Sat,  5 Sep
 2009 13:28:09 -0400 (EDT)
In-Reply-To: <20090905084641.GA24865@darc.dnsalias.org> (Clemens Buchacher's
 message of "Sat\, 5 Sep 2009 10\:46\:41 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7F4E05DA-9A41-11DE-AC56-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127822>

Clemens Buchacher <drizzd@aon.at> writes:

> "git add -u ." is friendly enough. Just like "git commit ." versus "git
> commit -a", which is exactly the same concept and should therefore have the
> same behavior.
>
> You are assuming that people are in a subdirectory because they want to
> limit the scope. But I am usually in a subdirectory for totally
> versioning-unrelated reasons.

Limit the scope of what you see in "ls" (no argument) output, shorten the
paths you must type to non-git commands.  They are the kind of "limit the
scope" I meant, and they are totally versioning-unrelated.  In other
words, cwd-centric default helps the users (especially the new ones) by
making git behave consistently with other commands.

So if anything, I personally think it would be much less surprising if all
git commands worked relative to the cwd (not whole tree root) when run
without path argument, at least from the newbie's point of view [*1*].

But notice that the above is qualified with "personally".  An alternative
would be to declare that in 1.8.0, all commands run without path argument
will work on the whole tree and you have to give an explicit '.' when you
want to limit their effect to the cwd.

This may be slightly less intuitive to newbies than the "relative to cwd",
but nevertheless that is the course I would suggest us taking, because of
the following observations:

 (1) if the commands work on the whole tree when run without paths, it is
     easy to limit to the cwd with "git frotz ." when you want to.

 (2) if the commands work on the cwd when run without paths, you have to
     always be aware how deep you are, and say "git frotz ../../.." when
     you want to extend their effects to the whole tree.

The latter is much more irritating.

Please also see:

    Message-ID: <7vy6ot4x61.fsf@alter.siamese.dyndns.org> ($gmane/127795)

think about the three questions there, and help us move the discussion
forward.

The first part of the message has some comments related to your patch, by
the way.

[Footnote]

*1* Except for the ones that cannot make any sense to limit their
operation to a subdirectory you happen to be in (e.g. it would be insane
if "git am" run to accept somebody's patch ignored paths outside your
cwd).

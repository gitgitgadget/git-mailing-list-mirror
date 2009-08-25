From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Add script for importing bits-and-pieces to Git.
Date: Tue, 25 Aug 2009 13:42:54 -0700
Message-ID: <7v3a7foca9.fsf@alter.siamese.dyndns.org>
References: <20090824171110.DA9202FC20@perkele>
 <7vy6p9do4k.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.0908251953480.19406@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Aug 25 22:43:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mg2rI-0008GY-HA
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 22:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119AbZHYUnC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 16:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756047AbZHYUnB
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 16:43:01 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49345 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755168AbZHYUnB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 16:43:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 95ACB36C05;
	Tue, 25 Aug 2009 16:43:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=diGVz1M/yOZTIdJT3mxQq1vkCeA=; b=xxYHi/ImuATvuW4CutuXS/x
	aIAUu54tIhcRsE3W9gGZnF6DyPSY8uaGmBE3raIC106x2bmXWa+2bz7FFmqEa+oe
	zeyG9+pCk0wShHX77RpYOdrp+La5QkHCOtGdWEDkjzW7clBd6LuVMkWGUKmlUYT3
	OwS7DGQNVnS7SYKboXAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=VnsSNpXU5OBcH7hyGLeZUX3QxSQVHKoA2KABSZ/Xb7IxSfXqP
	skOCnjSASldaPKxrkkjzXFnuAz0qi4Guw6Hz9JpzGmTmTRhxHsbwdLZpE+lIO7AG
	xeDOFNfAyxFPliaKi6C5/sGYVFPghtfOaKTQdaFGNEUsJ5PNRRx7QTR0as=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7583636BFF;
	Tue, 25 Aug 2009 16:42:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 496D736BFC; Tue, 25 Aug 2009
 16:42:55 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E0358306-91B7-11DE-AA9D-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127049>

Peter Krefting <peter@softwolves.pp.se> writes:

>> You might want to mention that this format is different from what
>> git uses for its .git/config and .gitmodules files, and none of the
>> rules apply to them (namely, two/three-level names, case
>> sensitivity, allowed letters in variable names, stripping of
>> whitespaces around values, and value quoting) described in 'git help
>> config' apply to this file.
>
> A quick question on that: Is it possible to use the git-config parser
> stand-alone from a script like this? Then that note wouldn't need to
> apply.

Yes, but then you have to update your data language, because some of the
section names and variables names you would want to use in your script are
illegal in "git config" configuration language.  Values and the second
level name in two level section names are more-or-less free form (they
need to be quoted as appropriately), but the first-level section names and
the variable names are case insensitive, do not allow SPs and funnies, and
there is no escaping.  You cannot have "source.c" as the variable name,
for example.

I'd recommend against re-using the git config format for that reason.

Another possibility would be to use something that does not even resemble
the git config format, say, YAML as your data language.  There is no risk
of confusion from the end users if you did so, and we wouldn't need the
note either.

>> As you seem to be supporting merges, you might want to say
>> topologically instead of chronologically---this is minor, as you
>> give more precise definition "all parents must come before a child"
>> in that sentence later.
>
> I'm not sure I get the distinction here. Could you be a bit more
> specific (or point me to what I have missed in the Git manual)?

Your history could be in this shape (numbers are timestamps recorded in
commit): 

             1--4
            /    \
	0--3--6---9--12

when somebody with a skewed clock forked the project at commit 3, worked
on a side branch to create two commits 1 and 4, which are pulled back to
the mainline at commit 9.

Chronological listing would mean 0 1 3 4 6 9 12.  Topological listing
would be either 0 3 1 4 6 9 12 or 0 3 6 1 4 9 12 or 0 3 1 6 4 9 12.

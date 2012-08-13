From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Let submodule command exit with error status if path
 does not exist
Date: Mon, 13 Aug 2012 10:11:31 -0700
Message-ID: <7vvcgmemyk.fsf@alter.siamese.dyndns.org>
References: <1340872080.2103.92.camel@athena.dnet>
 <20120809200302.GA93203@book.hvoigt.net>
 <7vboijol03.fsf@alter.siamese.dyndns.org>
 <20120811064912.GA83365@book.hvoigt.net>
 <7vy5lkfyx1.fsf@alter.siamese.dyndns.org>
 <20120813163911.GA6418@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Milde <daniel@milde.cz>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Aug 13 19:11:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0yB2-000692-Is
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 19:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752887Ab2HMRLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 13:11:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50181 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752690Ab2HMRLe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 13:11:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC4008A6C;
	Mon, 13 Aug 2012 13:11:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4FkY2UX+J5ySxCGib00sRcD7Oyg=; b=C7JrKn
	3U7+kFSzPmXyfKk1LsGBdvtoSznSk4a7Ndt0e9dSvKmOtadzusQz56Su3cjRx5oA
	6OdR5VxhNnvwI6AvFpfuE2FS9Bo0yoZAPJ30W29Pus/ACJRNzxTfrNAeR51Gi4yd
	aIJ1hXh1g1aVONcCC2d7c/NnK8NkoYm8SHcNA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nSLBerKc47Tso+dD963PgCkz3n40SXFH
	ZzEs/7ui3K7Qennb4PIZseZX36Vqhr6sHiQOAfORfpZm9GUJ5IkFpVwSdkpFWBHB
	Q0hKi1bGPSzftgZb52nxYBh8LCIz+GLAeWYKLThsgfrJCYGkK6U1uQERQ2LKdPTV
	2gFWU0coZqk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA6368A6B;
	Mon, 13 Aug 2012 13:11:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1BC538A69; Mon, 13 Aug 2012
 13:11:33 -0400 (EDT)
In-Reply-To: <20120813163911.GA6418@book.hvoigt.net> (Heiko Voigt's message
 of "Mon, 13 Aug 2012 18:39:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EE5CDC50-E569-11E1-AE02-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203345>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> How about I update CodingGuidelines according to the rules you
> suggested? Then other people know how we prefer bash functions and if
> statements to look like.

OK.  I was hoping that "imitate surrounding code" was sufficient,
but it seems many parts of the codebase have deteriorated enough to
make that rule no longer easy to follow.

>> Style:
>> 
>> 	if test -z "$sm_path"
>> 	then
>> 		exit 1
>
> See above. If you agree I would add this style to the guidelines.

Likewise.

>> I know module_list would have said "error: pathspec 'no-such' did
>> not match any file(s) known to git.  Did you forget to git add"
>> already, but because that comes at the very end of the input to the
>> filter written in perl (and with the way the filter is coded, it
>> will stay at the end), I am not sure if the user would notice it if
>> we exit like this.  By the time we hit this exit, we would have seen
>> "Entering $sm_path..." followed by whatever message given while in
>> the submodule for all the submodules that comes out of module_list,
>> no?
>> 
>> How about doing it this way to avoid that issue, to make sure we die
>> immediately after the typo is diagnosed without touching anything?
>
> I like it, your approach combines the atomicity of my first patch with
> the efficiency of not calling ls-files twice. I was hesitant to change
> to much code just to get the exit code right, but your approach looks
> good to me.
>
> Should I send an updated patch? Or do you just want to squash this in.
> Since now only the tests are from me what should we do with the
> ownership?

That is your itch and the idea and the bulk of the changes remains
to be yours in any case, methinks.

By the way, there is no reason for my patch to be unshifting the "#unmatch"
token into the array and spewing the array out, if the readers are always
going to stop upon seeing "#unmatch" without touching any submodule
that is named correctly on the command line.  In other words, the
following should suffice:

	while (<>) {
		... accumulate in @out ...
	}
	if ($unmatched) {
		print "#unmatched\n";
	} else {
		print for (@out);
	}

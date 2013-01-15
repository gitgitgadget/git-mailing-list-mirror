From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-hg: store converted URL
Date: Tue, 15 Jan 2013 08:05:16 -0800
Message-ID: <7vzk0a4ekj.fsf@alter.siamese.dyndns.org>
References: <1357760618-81222-1-git-send-email-max@quendi.de>
 <7vmwwbd43o.fsf@alter.siamese.dyndns.org>
 <64C81CD0-960A-47F2-89FC-8D3126B1F4D5@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Tue Jan 15 17:05:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv91C-0007di-8H
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 17:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756994Ab3AOQFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 11:05:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38974 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756150Ab3AOQFT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 11:05:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D9F8BAE5;
	Tue, 15 Jan 2013 11:05:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SWkN5Fa7Sm2s0s27F+dTX5xlii4=; b=cwOaIZ
	PgVwdmYwVve9mfDepMW/knmKRL3iDqdhqzT/v5JY8yoDRU8eFmE4PHhrLScKX7rz
	bTPk1Qnzx9k5d50R1D224HvQg750AEmLMEuCIn/xm8zFiH1faCDFmXmiHHHsZZOb
	LnTmmXncjwTMidLtGVlEKiRPJaTyaoY9kZe10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DjSYWr81E7v95zrmCcZOS+kGps80d1Tw
	pI2IxkNUm23S7uqUzdSWg35v+TvRL+R2Clt624snGxtR7JfNDp3aMeLmZIQ1us01
	JfKoB6HwJevkMVINhW150S9HfkqQtuVHt8S1MaROY1QrQILPFRskywcP8Ny22zQv
	lfntsyHirV0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 327A0BAE3;
	Tue, 15 Jan 2013 11:05:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 73FB1BADC; Tue, 15 Jan 2013
 11:05:18 -0500 (EST)
In-Reply-To: <64C81CD0-960A-47F2-89FC-8D3126B1F4D5@quendi.de> (Max Horn's
 message of "Tue, 15 Jan 2013 12:41:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B526AE0-5F2D-11E2-9B61-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213644>

Max Horn <max@quendi.de> writes:

> On 14.01.2013, at 19:14, Junio C Hamano wrote:
>
>> What is lacking from this description is why it even needs to work
>> from a different working directory....

In your rewrite below, this is still lacking, I think.

> Fully agreed. How about this commit message:
>
> -- >8 --
> remote-hg: store converted URL of hg repo in git config
>
> When remote-hg is invoked, read the remote repository URL from the git config,
> give Mercurial a chance to expand it, and if changed, store it back into
> the git config.
>
> This fixes the following problem: Suppose you clone a local hg repository
> using a relative path, e.g.
>   git clone hg::hgrepo gitrepo
> This stores "hg::hgrepo" in gitrepo/.git/config. However, no information
> about the PWD is stored, making it impossible to correctly interpret the
> relative path later on.

Here, you say "correctly interpret relative path later on", but it
is not made clear why it is even necessary.  And that makes ...

> Thus when latter attempting to, say, "git pull"
> from inside gitrepo, remote-hg cannot resolve the relative path correctly,
> and the user sees an unexpected error.

... "cannot resolve the relative path correctly" above sound like a
bug in remote-hg.  Something like:

    Cloning a local hg repository using a relative path, e.g.

      git clone hg::hgrepo gitrepo

    stores "hg::hgrepo" in gitrepo/.git/config as its URL.  When
    remote-hg is invoked by "git fetch", it chdirs to X (which is
    different from the "gitrepo" directory) and uses the URL (which
    is not correct, as it is a relative path but the cwd is
    different when it is used) to interact with the original
    "hgrepo", which will fail.

is needed, but you didn't explain what that X is.  Perhaps it is a
temporary directory.  Perhaps it is a hidden Hg repository somewhere
in gitrepo/.git directory.  Or something else.

With that explained ...

> With this commit, the URL "hg::hgrepo" gets expanded (during cloning,
> but also during any other remote operation) and the resulting absolute
> URL (e.g. "hg::/abspath/hgrepo") is stored in gitrepo/.git/config.
> Thus the git clone of hgrepo becomes usable.

... the description of the fix start making sense, but not without.

>> Was this work done outside the list?  I just want to make sure this
>> patch is not something Felipe did not want to sign off for whatever
>> reason but you are passing it to the list as a patch signed off by
>> him.
>
> The work was done by Felipe's and published in his github repository:
>   https://github.com/felipec/git/commit/605bad5b52d2fcf3d8f5fd782a87d7c97d1b040a
> See also the discussion (yeah, this time a real one ;-) leading to this:
>   https://github.com/felipec/git/issues/2
>
> I took his sign-off from there and interpreted it as saying that
> Felipe was OK with this being pushed to git.git. But perhaps this
> is not what I should have done?

You did nothing wrong, other than not having given the necessary
context to understand how the change flowed here and it is kosher.

Which you now have, so it is OK.

Thanks.

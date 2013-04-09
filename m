From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] rev-parse: add --filename-prefix option
Date: Tue, 09 Apr 2013 13:57:21 -0700
Message-ID: <7vtxnfpglq.fsf@alter.siamese.dyndns.org>
References: <cover.1365364193.git.john@keeping.me.uk>
 <cover.1365539059.git.john@keeping.me.uk>
 <0d570e110dbf714310f9cbc4fa47e711630707f2.1365539059.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Apr 09 22:57:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPfbd-0002cz-Jy
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 22:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936326Ab3DIU5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 16:57:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55867 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936281Ab3DIU5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 16:57:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0574B15EC7;
	Tue,  9 Apr 2013 20:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O32pkIC7+rdGzRe6qEWRim2ke9M=; b=YsL8lB
	ETzqxP6uC6mDxFRKlTrS0pRZTXkDW5TReaEkkdg0gxA1c29dm+SPElc4Rvp4r+6+
	UteEmfKGeutQLAC4DKcylpJP6svojxp9KX8fyMOONlDaOmjSXqPHEd0xOycSM9Te
	hnIDHNKZRhlBbaA3i0WDx+ohBBHCTzMmEzMfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ef5wjaB/7IaOdIUVIQpmSv3Puz68lCVY
	cjEHk1dI9VV3YXoIWaiQ5rzEAb9iTW85rBkPExm2q0jXHZeKtbckBAAMShHliS24
	Wgec5bCOLat+5sH9I/zAoUArmEt2Ar44UfxQVDKYvGOOdL7P5zPXZpYT4kILzSmn
	th1ctwauGgk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB8DA15EC6;
	Tue,  9 Apr 2013 20:57:23 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B46815EC5; Tue,  9 Apr
 2013 20:57:22 +0000 (UTC)
In-Reply-To: <0d570e110dbf714310f9cbc4fa47e711630707f2.1365539059.git.john@keeping.me.uk>
 (John Keeping's message of "Tue, 9 Apr 2013 21:29:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 137AC420-A158-11E2-9AEC-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220633>

John Keeping <john@keeping.me.uk> writes:

> This adds a prefix string to any filename arguments encountered after it
> has been specified.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---

Stale subject?

> +--prefix <arg>::
> +	Behave as if 'git rev-parse' was invoked from the `<arg>`
> +	subdirectory of the working tree.  Any relative filenames are
> +	resolved as if they are prefixed by `<arg>` and will be printed
> +	in that form.
> ++
> +This can be used to convert arguments to a command run in a subdirectory
> +so that they can still be used after moving to the top-level of the
> +repository.  For example:
> ++
> +----
> +prefix=$(git rev-parse --show-prefix)
> +cd "$(git rev-parse --show-toplevel)"
> +eval "set -- $(git rev-parse --sq --prefix "$prefix" "$@")"

I think you should tighten rev-parse parameter to reject options and
revisions, especially as an example to teach how to use it.  When
the user said

	git mylog -U20 master..next -- README

inside Documentation/ directory,  "git-mylog" script would want to
see README prefixed with Documentation/ but want to see -U20 or
master..next untouched.  Historically, rev-parse was a way to sift
options and args meant for rev-list from those mant for diff-tree
so that a variant of

	git rev-list $(git rev-parse --revs) "$@" |
        git diff-tree --stdin $(git rev-parse --no-revs)

can be used to implement such "git mylog" script.

I think "--no-revs --no-flags" is how you ask it to give you only
the paths, but I am writing from memory so please double check.

Having said all that.

Existing scripts (e.g. "git am") do this kind of things without such
an option added to rev-parse.  They first do:

    prefix=$(git rev-parse --show-prefix)

and refer to "$prefix/$1", "$prefix/$2", etc., I think.

Is this option really necessary to update "git submodule"?  Don't we
have a much better idea which parameter holds user-supplied path in the
script than having rev-parse make a guess on the entire "$@"?

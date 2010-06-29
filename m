From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add test for correct coloring of git log --decoration
Date: Mon, 28 Jun 2010 22:43:07 -0700
Message-ID: <7vbpaucs2c.fsf@alter.siamese.dyndns.org>
References: <7v6314fd6q.fsf@alter.siamese.dyndns.org>
 <1277710240-11378-1-git-send-email-ayiehere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 07:43:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTTbN-0007vY-ET
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 07:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472Ab0F2FnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 01:43:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40412 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932Ab0F2FnO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 01:43:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 16553BFAD6;
	Tue, 29 Jun 2010 01:43:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=VRahbWUidtHhjvFzG5rQnNHXf/Q=; b=SdJOxL/YqJDfwZDIKyWUgDe
	yyd9Ew8gxmyR8sKEH3G93wE5rmGegRCGLcpXcF9MiMfiW4EEjGpJoOfjl3ajDOAy
	6y87Sa/levV5xp3iMrjpIaEGNO0EMz2vavzbaGxr8FhwqZGJ+52bhLo1/FJ88TxC
	hEGDk0RfnQR/gCx2y4Q4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=BVTZotdtPf0yQLTxQV2Lsq8AkBn9Xi4RvnR650KihD4hDKt9U
	LPvTjLLopOU3j9dO7m9WXMAcMlkVRZlIPiHNW5KKnIPmqcUKuBopZn/lkr2VgpuS
	GLneDTECoifFyuk6Pe+JiPPLRkd8C4aTWmOQTZJMALdJDDLXmjc8BBWeLc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E48BABFAD5;
	Tue, 29 Jun 2010 01:43:11 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 02B77BFAD4; Tue, 29 Jun
 2010 01:43:08 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 345DF028-8341-11DF-AE26-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149884>

Nazri Ramliy <ayiehere@gmail.com> writes:

> I've tried adding 
>
> 	log --decorate --all --oneline --color=always
>
> to t4013-diff-various.sh but it seems a bit out of place because my test only
> test for colors, while no other test in that file test for colors, hence the
> new test file (t4207-log-decoration-colors.sh).

It sounds fine to have these in a separate file.

> diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
> new file mode 100755
> index 0000000..260e71f
> --- /dev/null
> +++ b/t/t4207-log-decoration-colors.sh
> @@ -0,0 +1,70 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2010 Nazri Ramliy
> +#
> +
> +test_description='Test for "git log --decorate" colors
> +'

Let's not expand a single-line description needlessly into a multi-line
one.

> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +  echo foo > foo.txt &&

Indent these with <TAB>, like:

	echo foo >foo.txt &&

> +  git add foo.txt &&
> +  test_tick &&
> +  git commit -m first &&
> +
> +  echo bar > bar.txt &&
> +  git add bar.txt &&
> +  test_tick &&
> +  git commit -m second &&
> +
> +  test_tick &&
> +  EDITOR=cat git tag v1.0 &&

I think "EDITOR=cat" is doubly wrong.  You are not annotating the tag
anyway, so it won't get called, but if you were, you will get something
like this:

	$ EDITOR=cat git tag -a v1.0

	#
        # Write a tag message
        #
        fatal: no tag message?

> +  git clone . local_clone &&
> +  cd local_clone &&

Do not chdir around inside test scripts without having that in a subshell,
as people typically write "cd .." at the very end of a && chain, which may
not be called when anything in between fails, throwing the later tests
into chaos.

In this case your excuse will be that you will run everything after this
point in that local-clone subdirectory, but still this is not a good style
we would want to keep around, risking to be copied by other people who do
not think carefully.

I think the set-up sequence for this test script should probably be
structured like this:

	get_color()
        {
        	git config ...
	}

	test_expect_success setup '
		git config diff.color.commit yellow &&
                ...
                git config color.decorate.HEAD cyan &&

                c_reset=$(get_color reset) &&
                ...
		c_HEAD=$(get_color cyan) &&

        	test_commit A &&
		git clone . other &&
                (
                	cd other &&
                        test_commit A1
		) &&
		git remote add -f other ./other &&
                test_commit B &&
		git tag v1.0 &&
                echo >>A &&
                git stash save Changes to A &&
	'

so that the main test is done inside the top-level directory (you wanted
the clone only because you wanted to have remote tracking branches, not
because you didn't want to touch the top-level directory).

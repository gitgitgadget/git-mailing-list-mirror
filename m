From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote.<name>.pushurl does not consider aliases when
 pushing
Date: Sun, 17 Mar 2013 15:14:32 -0700
Message-ID: <7vppyxptbr.fsf@alter.siamese.dyndns.org>
References: <20130317224002.366f54f7@hoelz.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, josh@joshtriplett.org
To: Rob Hoelz <rob@hoelz.ro>
X-From: git-owner@vger.kernel.org Sun Mar 17 23:15:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHLr4-0007eQ-Sw
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 23:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756608Ab3CQWOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 18:14:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55651 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755698Ab3CQWOf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 18:14:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2CFFB7B7;
	Sun, 17 Mar 2013 18:14:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=noxtbnSburFwYoBzCd5DIHAzJdc=; b=UxqSV0
	ExElUsjmCV3tubV4e30xTpIsqYlh5jExHxj+5IEy5h66DeFPwHBRg9NK3lc8xwVb
	UFEwXspixdytF+6Kr4PIv4rNycASL0HTNLLP3viuJILXSV9/XfAb/bATA4t0DDjy
	I4SBnkgXu5mBrqLi4nTtdlnZsNSk6vYyTetvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EXa/JvnOb63qClBqi6veXZSh/kmJN93o
	1Raadpta+vqgJXFwJWD/qQMgnB2DwYhSM9ucWx7Z8Jlgymn1JXGkL152kXa7jx1r
	G7sdvGF+sr9LZYqgAmoJK4n/TeZTH5HJyF87NF8b0Gt5VkBL45Gy39jCwI6y/xZA
	Unp8zS25AAU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6304B7B6;
	Sun, 17 Mar 2013 18:14:34 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E6144B7B3; Sun, 17 Mar 2013
 18:14:33 -0400 (EDT)
In-Reply-To: <20130317224002.366f54f7@hoelz.ro> (Rob Hoelz's message of "Sun,
 17 Mar 2013 22:40:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0C3A2A30-8F50-11E2-A02F-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218378>

Rob Hoelz <rob@hoelz.ro> writes:

> Hi everyone!  I found a bug in Git today and wrote up a fix; I did my best to conform to the rules layed out in Documentation/SubmittingPatches, but please let me know if I need to change anything to get my work merged. =)  I have CC'ed Josh Triplet, as
> he was the last one to touch the line I modified.  I hope my commit messages explain the problem I encountered well enough; if not,
> I can always go back and amend them.
>
> Patches follow.
>
> -Rob


Please read Documentation/SubmittingPatches and follow it.  The
above is most likely to be the cover letter of a two-patch series
(meaning you will be sending three pieces of e-mail messages), or
perhaps out of band comment below the three-dash line of a single
patch (you will send only one piece of e-mail message).

See recent patches on the list from list regulars for good examples,
e.g.

    http://thread.gmane.org/gmane.comp.version-control.git/218350
    http://thread.gmane.org/gmane.comp.version-control.git/218177/focus=218361

> From 5007b11e86c0835807632cb41e6cfa75ce9a1aa1 Mon Sep 17 00:00:00 2001
> From: Rob Hoelz <rob@hoelz.ro>
> Date: Sun, 17 Mar 2013 21:49:20 +0100
> Subject: [PATCH 1/2] Add test for pushInsteadOf + pushurl
>
> git push currently doesn't consider pushInsteadOf when
> using pushurl; this test tests that.
>
> Signed-off-by: Rob Hoelz <rob@hoelz.ro>
> ---
>  t/t5500-push-pushurl.sh | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 t/t5500-push-pushurl.sh

The number 5500 is already taken.  Please do not add a duplicate.

I also wonder if we need to waste a new test number for this;
perhaps adding new tests to 5516 that already tests insteadOf might
be a better fit, but I didn't carefully read it.

> diff --git a/t/t5500-push-pushurl.sh b/t/t5500-push-pushurl.sh
> new file mode 100644

Test scripts are supposed to be executable.

> +test_expect_success 'test commit and push' '
> +	test_commit one &&
> +	git push origin master:master
> +'
> +
> +test_expect_success 'check for commits in rw repo' '
> +	cd ../rw/repo &&
> +	git log --pretty=oneline | grep -q .
> +'

Are both expected to succeed in patch 1/2 without any code change?

If you were doing a large code change, it is a good series structure
to have tests first that are marked as "expect_failure" in an early
patch, and then in a later patch that changes the code to fix it,
update the tests that start to pass to "expect_success".

I personally do not think you need such a two-step approach for
something small like this; instead you can just have a single patch
that adds a set of tests that expect success and code change.

Thanks.

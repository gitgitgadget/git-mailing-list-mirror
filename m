From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] t5521 (pull-options): use test_commit() where
 appropriate
Date: Fri, 22 Mar 2013 09:51:38 -0700
Message-ID: <7vy5df74yt.fsf@alter.siamese.dyndns.org>
References: <1363955399-13153-1-git-send-email-artagnon@gmail.com>
 <1363955399-13153-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 17:52:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ5CL-0004Du-C0
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 17:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161035Ab3CVQvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 12:51:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34500 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1160998Ab3CVQvl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 12:51:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BB09B2BF;
	Fri, 22 Mar 2013 12:51:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UnU2BIJaC2CUr+dp0tkcL0ESyUk=; b=aIQURe
	gc1gCsVhUEt8NBPvbSrRhVG06uhuKrUsYGyqjlVHQ8R0P+rAo/gBSckuQMGH/TAt
	W0+LpbeAobpa6kcsjClzPLfJoqIPDucSGUQ5o5eUHA5BHeywbBZzI2nvj/TTKd3G
	MRIkNOonBwKWwAgKb9NQE5NM5VtGI+GGJbyJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NPQYtutQG0kleGRnpvjzxQWx5irzE3uE
	eKfAMAsvSXgnqGZ7RwmhZMcCEeEdN/hcKrZV7LjxRnezoGrw8wFF9ghOeUssPmYz
	qNkPBag44+HB0GRBbg/9CF4zk6XJDoGzxGvhPL9Mf7NSY8Sil/VRnp+hEhyrJqTc
	ieCNhSzIres=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F716B2BD;
	Fri, 22 Mar 2013 12:51:40 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5F15B2BC; Fri, 22 Mar 2013
 12:51:39 -0400 (EDT)
In-Reply-To: <1363955399-13153-3-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Fri, 22 Mar 2013 17:59:58 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C46E05D6-9310-11E2-A8DA-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218821>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> test_commit() is a well-defined function in test-lib-functions.sh that
> allows you to create commits with a terse syntax.  Prefer using it
> over creating commits by hand.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t5521-pull-options.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
> index 1b06691..4a804f0 100755
> --- a/t/t5521-pull-options.sh
> +++ b/t/t5521-pull-options.sh
> @@ -7,8 +7,8 @@ test_description='pull options'
>  test_expect_success 'setup' '
>  	mkdir parent &&
>  	(cd parent && git init &&
> -	 echo one >file && git add file &&
> -	 git commit -m one)
> +	 test_commit "one" file "one"
> +	)
>  '

In this test script perhaps it is OK, but I'd prefer people being
careful *not* to use test_commit in tests that involve refs (i.e.
pushing, pulling, ls-remote, for-each-ref, describe...) and paths
(i.e.  ls-files, diff, ...).

There is one good point in the helper: it creates a commit with a
predictable timestamp.

But it does a lot other *bad* things than that single good thing.
It adds a new path, and adds a new tag; neither of which is not
desirable in many circumstances.

A better future direction would be to first make these "frill"
features into options to test_commit helper, fix the users that
depend on these additional tags and stuff to explicitly ask for
them, and then start advocating it for wider use, I think.

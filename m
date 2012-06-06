From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1304: improve setfacl prerequisite setup
Date: Wed, 06 Jun 2012 09:58:53 -0700
Message-ID: <7vvcj4ml6a.fsf@alter.siamese.dyndns.org>
References: <vpq4nqqj8ss.fsf@bauges.imag.fr>
 <CALbm-EbGoaxkvBXphAPF8rRkS=VFeeFHXQSFdWVrZUJJ8DYovw@mail.gmail.com>
 <vpqk3zlhorc.fsf@bauges.imag.fr>
 <20120605140449.GA15640@sigill.intra.peff.net>
 <20120605141039.GB15640@sigill.intra.peff.net>
 <20120605142813.GA17238@sigill.intra.peff.net>
 <20120605150550.GA19843@sigill.intra.peff.net>
 <7vpq9dpvnp.fsf@alter.siamese.dyndns.org>
 <20120605164439.GA2694@sigill.intra.peff.net>
 <7v62b5pt2s.fsf@alter.siamese.dyndns.org>
 <20120606132824.GA2597@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <stefanbeller@googlemail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 06 18:59:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScJZV-0005SE-9V
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 18:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756836Ab2FFQ65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 12:58:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55356 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754073Ab2FFQ64 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 12:58:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAA2E8989;
	Wed,  6 Jun 2012 12:58:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3qL7VZ+XQZU4PlIv695QrsXN7vY=; b=ZZbPWf
	Tms5NSmoIRxBH6etOEGVL+DPxW+Xd4O+aS/rTOVmhOdxyROf1AQUdie2QtXqoeqI
	vBHB4MGs/tkd4jeCr/YMZVWVzYS5OYarOTRo6fddwH7yQfNnkH6YvvKa8/9xcqg3
	TPr1Tv8kWzH4d/XdTeJXiZWRtECJzbiNvF7BQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j+UCAhV2y+EkYJctRfFrDEICDq536Gof
	cUQapSJsYDKnX3KJTR3eY9pKYIlIwNilvNd6GwskkEPGuz8ql6KMbiF12TvXmA29
	Oob5LsF8losHfvYMLhJoj4Mr8a7d9qAfNI1JSPdI7aMuKJKsdI9N2oiWOmYyICxb
	9dGG+aPQUoM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A12DC8986;
	Wed,  6 Jun 2012 12:58:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 091058983; Wed,  6 Jun 2012
 12:58:54 -0400 (EDT)
In-Reply-To: <20120606132824.GA2597@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 6 Jun 2012 09:28:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E66D1C9A-AFF8-11E1-81E5-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199337>

Jeff King <peff@peff.net> writes:

> t1304 first runs setfacl as an experiment to see whether the
> filesystem supports ACLs, and skips the remaining tests if
> it does not. However, our setfacl run did not exercise the
> ACLs very well, and some filesystems may support our initial
> setfacl, but not the rest of the test.
>
> In particular, some versions of ecryptfs will erroneously
> apply the umask on top of an inherited directory ACL,
> causing our tests to fail. Let's be more careful and make
> sure both that we can read back the user ACL we set, and
> that the inherited ACL is propagated correctly. The latter
> catches the ecryptfs bug, but may also catch other bugs
> (e.g., an implementation which does not handle inherited
> ACLs at all).
>
> Since we're making the setup more complex, let's move it
> into its own test. This will hide the output for us unless
> the user wants to run "-v" to see it (and we don't need to
> bother printing anything about setfacl failing; the
> remaining tests will properly print "skip" due to the
> missing prerequisite).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> The ecryptfs response was that it is probably a bug, so I think we
> should go with this (especially because it is general enough to
> potentially catch other weird errors).
>
>  t/t1304-default-acl.sh | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
> index 2b962cf..79045ab 100755
> --- a/t/t1304-default-acl.sh
> +++ b/t/t1304-default-acl.sh
> @@ -14,16 +14,15 @@ umask 077
>  # We need an arbitrary other user give permission to using ACLs. root
>  # is a good candidate: exists on all unices, and it has permission
>  # anyway, so we don't create a security hole running the testsuite.
> -
> -setfacl_out="$(setfacl -m u:root:rwx . 2>&1)"
> -setfacl_ret=$?
> -
> -if test $setfacl_ret != 0
> -then
> -	say "Unable to use setfacl (output: '$setfacl_out'; return code: '$setfacl_ret')"
> -else
> -	test_set_prereq SETFACL
> -fi
> +test_expect_success 'checking for a working acl setup' '
> +	if setfacl -m d:m:rwx -m u:root:rwx . &&
> +	   getfacl . | grep user:root:rwx &&
> +	   touch should-have-readable-acl &&
> +	   getfacl should-have-readable-acl | egrep "mask::?rw-"

At this point of the test, I do not think there is anything that can
cause this check to be fooled by a user whose name is 'mask', but
please make it a habit to anchor the pattern at the left.  The tests
done in check_perms_and_acl do risk getting fooled by a user whose
name is 'mask', and need to be updated, I think, but that is a
separate issue.

> +	then
> +		test_set_prereq SETFACL
> +	fi
> +'
>  
>  if test -z "$LOGNAME"
>  then

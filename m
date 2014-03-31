From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 15/27] update-ref --stdin -z: Deprecate interpreting the empty string as zeros
Date: Mon, 31 Mar 2014 14:49:42 -0700
Message-ID: <xmqq7g7a3uo9.fsf@gitster.dls.corp.google.com>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
	<1395683820-17304-16-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 31 23:49:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUk5X-0005oY-Jd
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 23:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbaCaVtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 17:49:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65502 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977AbaCaVtp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 17:49:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B02F079E73;
	Mon, 31 Mar 2014 17:49:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NQffB36Ep0MP34p7YmH6wPlrGOo=; b=eGOlz0
	P1vv/hHWi6MIOfndjSfnjLREHqZV+/HM5OvOgSPE/O/pztcNVUf8stHD+KSWNta9
	dpyZT2Wu5gaojfV4Bzpn+shbf48DBpvhZT9/olEv0VYXtgiy383tqq/qh62EAdyk
	JcLxzlz7cYKZFXtkHwouk8lEzbhitVh8am3aQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kv/edmOGhdWqaQNFeYL2IRvWzTQenL7D
	X+i6mCuS7XgNk+6fkUKV9y9uqDo3k8iB//l/4p3lbjevC2fBYJABrjw6WEuMIqMZ
	+4HSk0Fifhb2/mX/YqCvTjlVNPG2PduIf9mWzduxrALBTOmfWWPZA810tH3PDdmK
	zC3SwEIsEDA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BFC879E71;
	Mon, 31 Mar 2014 17:49:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC45279E6E;
	Mon, 31 Mar 2014 17:49:43 -0400 (EDT)
In-Reply-To: <1395683820-17304-16-git-send-email-mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 24 Mar 2014 18:56:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5EAD123E-B91E-11E3-9D9F-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245542>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> In the original version of this command, for the single case of the
> "update" command's <newvalue>, the empty string was interpreted as
> being equivalent to 40 "0"s.  This shorthand is unnecessary (binary
> input will usually be generated programmatically anyway), and it
> complicates the parser and the documentation.

Nice.

>
> So gently deprecate this usage: remove its description from the
> documentation and emit a warning if it is found.  But for reasons of
> backwards compatibility, continue to accept it.
>
> Helped-by: Brad King <brad.king@kitware.com>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  Documentation/git-update-ref.txt | 18 ++++++++++++------
>  builtin/update-ref.c             |  2 ++
>  t/t1400-update-ref.sh            |  5 +++--
>  3 files changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
> index 0a0a551..c8f5ae5 100644
> --- a/Documentation/git-update-ref.txt
> +++ b/Documentation/git-update-ref.txt
> @@ -68,7 +68,12 @@ performs all modifications together.  Specify commands of the form:
>  	option SP <opt> LF
>  
>  Quote fields containing whitespace as if they were strings in C source
> -code.  Alternatively, use `-z` to specify commands without quoting:
> +code; i.e., surrounded by double-quotes and with backslash escapes.
> +Use 40 "0" characters or the empty string to specify a zero value.  To
> +specify a missing value, omit the value and its preceding SP entirely.
> +
> +Alternatively, use `-z` to specify in NUL-terminated format, without
> +quoting:
>  
>  	update SP <ref> NUL <newvalue> NUL [<oldvalue>] NUL
>  	create SP <ref> NUL <newvalue> NUL
> @@ -76,8 +81,12 @@ code.  Alternatively, use `-z` to specify commands without quoting:
>  	verify SP <ref> NUL [<oldvalue>] NUL
>  	option SP <opt> NUL
>  
> -Lines of any other format or a repeated <ref> produce an error.
> -Command meanings are:
> +In this format, use 40 "0" to specify a zero value, and use the empty
> +string to specify a missing value.
> +
> +In either format, values can be specified in any form that Git
> +recognizes as an object name.  Commands in any other format or a
> +repeated <ref> produce an error.  Command meanings are:
>  
>  update::
>  	Set <ref> to <newvalue> after verifying <oldvalue>, if given.
> @@ -102,9 +111,6 @@ option::
>  	The only valid option is `no-deref` to avoid dereferencing
>  	a symbolic ref.
>  
> -Use 40 "0" or the empty string to specify a zero value, except that
> -with `-z` an empty <oldvalue> is considered missing.
> -
>  If all <ref>s can be locked with matching <oldvalue>s
>  simultaneously, all modifications are performed.  Otherwise, no
>  modifications are performed.  Note that while each individual
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 6462b2f..eef7537 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -154,6 +154,8 @@ static int parse_next_sha1(struct strbuf *input, const char **next,
>  				goto invalid;
>  		} else if (flags & PARSE_SHA1_ALLOW_EMPTY) {
>  			/* With -z, treat an empty value as all zeros: */
> +			warning("%s %s: missing <newvalue>, treating as zero",
> +				command, refname);
>  			hashclr(sha1);
>  		} else {
>  			/*
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 15f5bfd..2d61cce 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -730,10 +730,11 @@ test_expect_success 'stdin -z fails update with bad ref name' '
>  	grep "fatal: invalid ref format: ~a" err
>  '
>  
> -test_expect_success 'stdin -z treats empty new value as zeros' '
> +test_expect_success 'stdin -z emits warning with empty new value' '
>  	git update-ref $a $m &&
>  	printf $F "update $a" "" "" >stdin &&
> -	git update-ref -z --stdin <stdin &&
> +	git update-ref -z --stdin <stdin 2>err &&
> +	grep "warning: update $a: missing <newvalue>, treating as zero" err &&
>  	test_must_fail git rev-parse --verify -q $a
>  '

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] interpret-trailers: add option for in-place editing
Date: Thu, 14 Jan 2016 12:45:01 -0800
Message-ID: <xmqqio2vki0i.fsf@gitster.mtv.corp.google.com>
References: <1452790676-11937-1-git-send-email-tklauser@distanz.ch>
	<1452790676-11937-3-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 14 21:45:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJom2-0007Gt-D2
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 21:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbcANUpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 15:45:08 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63575 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750964AbcANUpG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 15:45:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8EF0E3A110;
	Thu, 14 Jan 2016 15:45:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6cOOZ7lo8AytX9shLw1xn4yLwjQ=; b=xzkjg/
	3FgXdkPM1g85Df9lLSsiSVf2hePt5hnfgcutchCj/S8hXZqohiQ254xVTf/wB/im
	IYbMitDruP59WiGpfyOj1io1dyiEJ+oO8XO8Ozni3Z/MP8vAeLQF1vT62HTCSDWr
	ZREOWJi6QfyHg5EtbC5ljouqlmv/1F/dkbIQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jvn6FsZwdC62A0g3PXaHnM9fQM1pkPwg
	haeFH3wbCYaDz44WYUlx+zGyPAexG5OzQt/6Shd5Uh+NnvCab+IN8ehjzShGP9Na
	CytKxP/n5cv/se/mW/932jMQgtisxdR4PUruDkMhPFTFO8kvutapcY3CjucvFtKH
	lsdQd3aWL9Q=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 837C63A10F;
	Thu, 14 Jan 2016 15:45:04 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DAEDC3A10D;
	Thu, 14 Jan 2016 15:45:02 -0500 (EST)
In-Reply-To: <1452790676-11937-3-git-send-email-tklauser@distanz.ch> (Tobias
	Klauser's message of "Thu, 14 Jan 2016 17:57:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AF941F3C-BAFF-11E5-A32F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284088>

Tobias Klauser <tklauser@distanz.ch> writes:

> Add a command line option --in-place to support in-place editing akin to
> sed -i.  This allows to write commands like the following:
>
>   git interpret-trailers --trailer "X: Y" a.txt > b.txt && mv b.txt a.txt
>
> in a more concise way:
>
>   git interpret-trailers --trailer "X: Y" --in-place a.txt
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---

Thanks, will replace.  I found some micronits, none of which I think
is big enough to require another reroll, but since I found them
already, I'll just point them out.

> diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
> index 322c436a494c..aee785cffa8d 100755
> --- a/t/t7513-interpret-trailers.sh
> +++ b/t/t7513-interpret-trailers.sh
> @@ -326,6 +326,46 @@ test_expect_success 'with complex patch, args and --trim-empty' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'in-place editing with basic patch' '
> +	cat basic_message >message &&
> +	cat basic_patch >>message &&
> +	cat basic_message >expected &&
> +	echo >>expected &&
> +	cat basic_patch >>expected &&
> +	git interpret-trailers --in-place message &&
> +	test_cmp expected message
> +'
> +
> +test_expect_success 'in-place editing with additional trailer' '
> +	cat basic_message >message &&
> +	cat basic_patch >>message &&
> +	cat basic_message >expected &&
> +	echo >>expected &&
> +	cat >>expected <<-\EOF &&
> +		Reviewed-by: Alice
> +	EOF

The "echo" is not needed, if you just include a leading blank line
in the here-document you use with this "cat".

> +test_expect_success POSIXPERM,SANITY "in-place editing doesn't clobber original file on error" '
> +	cat basic_message >message &&
> +	chmod -r message &&
> +	test_must_fail git interpret-trailers --trailer "Reviewed-by: Alice" --in-place message &&
> +	chmod +r message &&
> +	test_cmp message basic_message
> +'

If for some reason interpret-trailers fails to fail, this would
leave an unreadable 'message' in the trash directory.  Maybe no
other tests that come after this one want to be able to read the
contents of the file right now, but this is an accident waiting to
happen:

	cat basic_message >message &&
+       test_when_finished "chmod +r message" &&
        chmod -r message &&
        test_must_fail ... &&
	chmod +r message &&
        test_cmp ...

> +	if (!S_ISREG(st.st_mode))
> +		die(_("file %s is not a regular file"), file);
> +	if (!(st.st_mode & S_IWUSR))
> +		die(_("file %s is not writable by user"), file);

Hmph, are these two necessary, and do they make sense?

When doing an in-place thing, the primary thing you care about is
that you can read from the file and you can deposit the result of
the rewrite under the original name.  If for some reason a system
allowed you to read from a non-regular file and interpret-trailers
can do a sensible thing to the contents you read from there, do you
have to insist that original must be S_ISREG()?  Also, a funny file
(e.g. "interpret-trailers -i .") is likely to fail on the input
side.

For the latter,

    $ chmod a-w COPYING
    $ sed -i -e 's/a/b/' COPYING

seems to succeed _and_ leave the permission bits intact, i.e.
I get this before and after "sed -i"

    $ ls -l COPYING
    -r--r----- 1 jch eng 18765 Jan 14 12:34 COPYING

which hints at two points:

 - The users (of "sed -i") may have demanded that in-place update of
   read-only file must be allowed, and there may have been a good
   reason for wanting to do so.  That reason may apply equally to us
   here.

 - If we were to follow suit, then we should not forget to restore
   the permission bits on the new file.

In any case, these are something we could loosen after people gain
experience with the feature, so I think it is OK as-is, at least for
now.

> +	if (in_place)
> +		if (rename_tempfile(&trailers_tempfile, file))
> +			die_errno(_("could not rename temporary file to %s"), file);
> +

I briefly wondered if this should be

	if (in_place && rename_tempfile(...))
		die_errno(...);

to save one indentation level, but I think it is a bad idea,
i.e. the above code should stay as-is.

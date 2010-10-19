From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-send-email.perl: fix In-Reply-To for second and
 subsequent patches
Date: Tue, 19 Oct 2010 11:26:33 -0700
Message-ID: <7v4oci11k6.fsf@alter.siamese.dyndns.org>
References: <20101015095651.b75c4b54.ospite@studenti.unina.it>
 <1287481964-8883-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Antonio Ospite <ospite@studenti.unina.it>
X-From: git-owner@vger.kernel.org Tue Oct 19 20:26:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8Gtm-0007J9-7Q
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 20:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754101Ab0JSS0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 14:26:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720Ab0JSS0v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 14:26:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E3B5CE02E6;
	Tue, 19 Oct 2010 14:26:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=smgZBr5O4rPaNh1To45H86S7luQ=; b=ZOpkHV
	Dz92bWOxxyYo6Qy1j0UGJFDzC/+g+1VpyUnDzMWzWvgqtW8aXOCUHb0yOcGAJjuN
	Qoq1cXxOJZFJVjxIcUazR+fsflg5cdnWGyKRvFzv3WDuIs0neT2VE0L02NE40lN+
	uCeLHUHmHW9OOHVOdKp2QRiIhZ0f2l2F/tp4A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lhy37U+stoNAxBj5estT0SJNwUfjIhb4
	uxhxH3RvPHvPtIL+4+R/DdDjTFjuT73cxXH9RpcAaV+PKJFeUzUXkfiLd61zF6+s
	594/jqIq+y1Hen1Bx4d/xFXVekvfmLAF9flJOeJoBhPsUYL3w8vSQ7iD788CDxZT
	zRDShRVCbRU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 750BDE02E3;
	Tue, 19 Oct 2010 14:26:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D78AE02E1; Tue, 19 Oct
 2010 14:26:35 -0400 (EDT)
In-Reply-To: <1287481964-8883-1-git-send-email-ospite@studenti.unina.it>
 (Antonio Ospite's message of "Tue\, 19 Oct 2010 11\:52\:44 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6BD7D5EE-DBAE-11DF-8A33-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159347>

Antonio Ospite <ospite@studenti.unina.it> writes:

> Make second and subsequent patches appear as replies to the first patch,
> even when an initial In-Reply-To is supplied; this is the typical
> behaviour we want when we send a series with cover letter in reply to
> some discussion, and this is also what the man page says about
> the --in-reply-to option.

I am not so sure if that is what the documentation says.

 1. When --in-reply-to gives $reply_to, the first one becomes a reply to
    that message, with or without --chain-reply-to.

 2. When --chain-reply-to is in effect, all the messages are strung
    together to form a single chain.  The first message may be in reply to
    the $reply_to given by --in-reply-to command line option (see
    previous), or the root of the discussion thread.  The second one is a
    response to the first one, and the third one is a response to the
    second one, etc.

 3. When --chain-reply-to is not in effect:

    a. When --in-reply-to is used, too, the second and the subsequent ones
       become replies to $reply_to.  Together with the first rule, all
       messages become replies to $reply_to given by --in-reply-to.

    b. When --in-reply-to is not used, presumably the second and
       subsequent ones become replies to the first one, which would be the
       root.

The documentation is reasonably clear about the 1., 2. and 3a. above, I
think, even though I do not think 3b. is clearly specified.

If you are changing 3a. above so that the first message becomes a response
to $reply_to, and the second one becomes a response to the first message
(and the third and subsequent ones too when --chain-reply-to is not in
effect), you would need to update the documentation as well.  Even if it
might be of good kind, it would be a change of the established behaviour.

> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index a298eb0..410b85f 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -295,6 +295,20 @@ test_expect_success $PREREQ 'Valid In-Reply-To when prompting' '
>  	! grep "^In-Reply-To: < *>" msgtxt1
>  '
>  
> +test_expect_success $PREREQ 'In-Reply-To in second patch with --thread' '
> +	clean_fake_sendmail &&
> +	git send-email \
> +		--from="Example <nobody@example.com>" \
> +		--to=nobody@example.com \
> +		--thread \
> +		--in-reply-to="<unique-message-id@example.com>" \
> +		--smtp-server="$(pwd)/fake.sendmail" \
> +		$patches $patches \
> +		2>errors

You are breaking the && chain here.

> +        # The second patch should be seen as reply to the first one
> +        test $(sed -n -e "s/^In-Reply-To:\(.*\)/\1/p" msgtxt2) = $(sed -n -e "s/^Message-Id:\(.*\)/\1/p" msgtxt1)
> +'

You would need to test the interaction with --chain-reply-to as well, so
there should be another test, and you would probably need three messages
fed to send-email not just two to see the effect of the interaction.

Thanks.

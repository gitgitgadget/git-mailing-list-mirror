From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Push not writing to standard error
Date: Wed, 13 Oct 2010 10:33:22 -0700
Message-ID: <7vzkuim1zx.fsf@alter.siamese.dyndns.org>
References: <AANLkTim6j7cXj2-1JnKdNLb8KFJK86F02tzeByDBskEa@mail.gmail.com>
 <20101012192117.GD16237@burratino>
 <20101012193204.GA8620@sigill.intra.peff.net>
 <20101012193830.GB8620@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Chase Brammer <cbrammer@gmail.com>, git@vger.kernel.org,
	Tay Ray Chuan <rctay89@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 13 19:33:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P65D1-0001Sc-96
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 19:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935Ab0JMRdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 13:33:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55317 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440Ab0JMRdj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 13:33:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D589DE663;
	Wed, 13 Oct 2010 13:33:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FKJseaDrKvWWHvDu53tTRZZIS4U=; b=m+1Kmx
	zBwpnqpKlxuhyVJobsap4z0xNYTUw7TbfUBMiV+YNm77qnZw/rQ+R/IUSV1CLTDd
	O7+6250dzjtW1xOGpSqaCe6ZUhtWSk3+UMN22zd7vohMdU+ffb9sB2yNcYJjP5yR
	iI/63jYovWttIIq2oZGDis8Q7kXZ9PJllXeOA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rJT2YBDXcdVQIGlMfBqs/Zg1YYNWFUcz
	kAFZpz5KGg/+UL8j815sjgAmlYLc/F/UUx56eF4gAlhJ9AWnAqcr9fG5RaBWl2yM
	furoV4u7Qr67Oy4d2G41Sc25vw9f+vFcfwD/h08fw5LDu2DaEkmMfjHcQjWdrbED
	ssvfkU+6RwQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DE06DDE65C;
	Wed, 13 Oct 2010 13:33:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD933DE657; Wed, 13 Oct
 2010 13:33:23 -0400 (EDT)
In-Reply-To: <20101012193830.GB8620@sigill.intra.peff.net> (Jeff King's
 message of "Tue\, 12 Oct 2010 15\:38\:30 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FE7221B6-D6EF-11DF-86E9-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158946>

Jeff King <peff@peff.net> writes:

> On Tue, Oct 12, 2010 at 03:32:04PM -0400, Jeff King wrote:
>
>> It looks like transport_set_verbosity gets called correctly, and then
>> sets the "progress" flag for the transport. But for the push side, I
>> don't see any transports actually looking at that flag. I think there
>> needs to be code in git_transport_push to handle the progress flag, and
>> it just isn't there.
>
> Here's a quick 5-minute patch. It works on my test case:
>
>   rm -rf parent child
>   git init parent &&
>   git clone parent child &&
>   cd child &&
>   echo content >file && git add file && git commit -m one &&
>   git push --progress origin master:foo >foo.out 2>&1 &&
>   cat foo.out

Does it still work with "git push" without --progress?  I didn't apply nor
test, but just wondering as the manpage description suggests progress is
implicitly set when standard error is terminal even when there is no
command line --progress is given, and also interaction with -q option, but
the patch does not seem to show such subtleties...

>
> but I didn't even run the test suite. Maybe somebody more clueful in the
> area can pick it up?
>
> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index 481602d..efd9be6 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -48,6 +48,7 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
>  		NULL,
>  		NULL,
>  		NULL,
> +		NULL,
>  	};
>  	struct child_process po;
>  	int i;
> @@ -59,6 +60,8 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
>  		argv[i++] = "--delta-base-offset";
>  	if (args->quiet)
>  		argv[i++] = "-q";
> +	if (args->progress)
> +		argv[i++] = "--progress";
>  	memset(&po, 0, sizeof(po));
>  	po.argv = argv;
>  	po.in = -1;
> diff --git a/send-pack.h b/send-pack.h
> index 60b4ba6..fcf4707 100644
> --- a/send-pack.h
> +++ b/send-pack.h
> @@ -4,6 +4,7 @@
>  struct send_pack_args {
>  	unsigned verbose:1,
>  		quiet:1,
> +		progress:1,
>  		porcelain:1,
>  		send_mirror:1,
>  		force_update:1,
> diff --git a/transport.c b/transport.c
> index 4dba6f8..0078660 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -789,6 +789,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
>  	args.use_thin_pack = data->options.thin;
>  	args.verbose = (transport->verbose > 0);
>  	args.quiet = (transport->verbose < 0);
> +	args.progress = transport->progress;
>  	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
>  	args.porcelain = !!(flags & TRANSPORT_PUSH_PORCELAIN);
>  

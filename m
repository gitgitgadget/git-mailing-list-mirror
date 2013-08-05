From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 6/9] hash-object: Replace stdin parsing OPT_BOOLEAN by OPT_COUNTUP
Date: Mon, 05 Aug 2013 11:50:35 -0700
Message-ID: <7vob9cj7k4.fsf@alter.siamese.dyndns.org>
References: <1375530686-2309-1-git-send-email-stefanbeller@googlemail.com>
	<1375530686-2309-7-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 20:50:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6Prf-0004WO-VR
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 20:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172Ab3HESuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 14:50:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63157 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753738Ab3HESuj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 14:50:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C28D36D75;
	Mon,  5 Aug 2013 18:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2YfASubdvwzBwHtTW6b8/PgcPcI=; b=c28h9U
	z6ajzLGO+UWFGE308WMZAKMpp9UrU6LwBXJOZIdBg7lZc9+o5ob+13iSjMALE8q+
	FIJq59v37qehtCasrGgTjNvSMLBm3rrf26Asfk0MKxs1TtUsmOqv59zY3ZeufFGN
	27uRJA7Z9USTX56BbJbLOmS8hnvE4zqpGBMns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tzGwvagel/Kk4g+S2T9G7lSQyuq3QAZM
	RMp0PrZMus7t2v2t9uqeSuplhE+uVrTmf/gwaj/24ojSeARUvtnE/UnAOv6AaO+H
	NXeF/AGCrxfFcZ0ub0FjoXDS62zeafiytlzQxOrLyfBpVItoVMTbMCGVSkcEZxDg
	3Lp4vf0SpDs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E9A136D74;
	Mon,  5 Aug 2013 18:50:38 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B98EE36D6F;
	Mon,  5 Aug 2013 18:50:36 +0000 (UTC)
In-Reply-To: <1375530686-2309-7-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Sat, 3 Aug 2013 13:51:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EA99AA3A-FDFF-11E2-9B73-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231689>

Stefan Beller <stefanbeller@googlemail.com> writes:

> This task emerged from b04ba2bb (parse-options: deprecate OPT_BOOLEAN,
> 2011-09-27). hash-object is a plumbing layer command, so better
> not change the input/output behavior for now.
>
> Unfortunately we have these lines relying on the count up mechanism of
> OPT_BOOLEAN:
>
> 	if (hashstdin > 1)
> 		errstr = "Multiple --stdin arguments are not supported";
>
> Maybe later, when the plumbing is refined (git 2.0?), we can drop that
> error message and replace the OPT_COUNTUP by OPT_BOOL.

I am of two minds about that as a future direction.

The original motivation of this is that it was too easy to see

	git hash-object Makefile COPYING

to work as expected, and extend that knowledge to expect this

	git hash-objects --stdin --stdin

to somehow work without thinking things through.

So it is not about refining plumbing, but is about educating users.
Because a popular system will always have influx of users yet to be
educated, I do not think it makes sense to drop this safety.

The patch itself, and others so far except 1 and 2 which are too big
for me to carefully review right now, seem to make sense.

Thanks.

> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> ---
>  builtin/hash-object.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/hash-object.c b/builtin/hash-object.c
> index 4aea5bb..d7fcf4c 100644
> --- a/builtin/hash-object.c
> +++ b/builtin/hash-object.c
> @@ -71,7 +71,7 @@ static const char *vpath;
>  static const struct option hash_object_options[] = {
>  	OPT_STRING('t', NULL, &type, N_("type"), N_("object type")),
>  	OPT_BOOL('w', NULL, &write_object, N_("write the object into the object database")),
> -	OPT_BOOLEAN( 0 , "stdin", &hashstdin, N_("read the object from stdin")),
> +	OPT_COUNTUP( 0 , "stdin", &hashstdin, N_("read the object from stdin")),
>  	OPT_BOOL( 0 , "stdin-paths", &stdin_paths, N_("read file names from stdin")),
>  	OPT_BOOL( 0 , "no-filters", &no_filters, N_("store file as is without filters")),
>  	OPT_STRING( 0 , "path", &vpath, N_("file"), N_("process file as it were from this path")),

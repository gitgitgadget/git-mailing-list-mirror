From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] upload-pack: Optionally allow fetching reachable sha1
Date: Sun, 03 May 2015 10:40:21 -0700
Message-ID: <xmqqy4l5v9tm.fsf@gitster.dls.corp.google.com>
References: <1430604075-5951-1-git-send-email-fredrik.medley@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Fredrik Medley <fredrik.medley@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 03 19:40:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yoxsa-0002Wh-Vs
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 19:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbbECRk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 13:40:27 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54382 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750970AbbECRkY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 13:40:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 746D44DCE6;
	Sun,  3 May 2015 13:40:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LMD8GpNmq1lpJ4GepEgEvtjl0Sc=; b=LwbPQs
	VuRIDdd7e9jrjCPQMkMThUM0pu95brDnMu7qvcbsqprMGOPNsoGYrYcSPQBlMqh5
	WvHdiuBXJUrit6XILhx7aYzR1TY0Wpn+fHGR9pRgBYbLrw6drJd+YuJP/ENJLoCV
	7geADUflgflgHSO1QM/ZAqUj7IRrzjDUEASzA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UGpszkSxfCFhTvskrdcqRfF0y6yWKZ5Y
	1tpEsT1iPKV7IyvvHCCg6t03Y51s3PZ3vERsOilM4/D2KfSDSu9oFAoEFBH6S98p
	ubGvmpMuwImxOqxbIwtqri8RvX/PeA9b2nw6IGZTYsFzZBmnu26qOzCxnkmrERsE
	fIREJBctuxw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CCDE4DCE5;
	Sun,  3 May 2015 13:40:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D35364DCE3;
	Sun,  3 May 2015 13:40:22 -0400 (EDT)
In-Reply-To: <1430604075-5951-1-git-send-email-fredrik.medley@gmail.com>
	(Fredrik Medley's message of "Sun, 3 May 2015 00:01:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 799D31E2-F1BB-11E4-9C79-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268276>

Fredrik Medley <fredrik.medley@gmail.com> writes:

> For you who don't remember the email discussion, look through the references.

Please don't do this.  Always describe the background yourself in
the log message so that "git log" can be read offline.  "describe
yourself" can be done by summarizing earlier discussion, borrowing
others' words, of course.  And it is a very good idea to give
references like you did after your summary to optionally allow
people to verify your summary is correct.

I do not quite understand the early part of the following:

> Since before, it is allowed to ask for a sha1, but most git servers refuse
> the request[1].

That makes it sound like "then talk to the server operator to
reconfigure and your problem is solved", no?  I do not think the
exchange [2] and [3] are about that---your wish will not be granted,
even if we extended the system to allow non-tip to be fetched, if
the server is configured not use that feature.

> This patch is based on a suggested location for
> implementation[2] which has been updated according to ideas in the reply[3].

I quite am not sure what the suggested "location" for implemenation
is.

> [1] http://thread.gmane.org/gmane.comp.version-control.git/257809
> [2] http://thread.gmane.org/gmane.comp.version-control.git/258002
> [3] http://thread.gmane.org/gmane.comp.version-control.git/258080
>
> With uploadpack.allowreachablesha1inwant configuration option set,

"option set" on the server side, I presume?

> "git fetch" can make a request with a "want" line that names an object
> that has not been advertised (likely to have been obtained out of band or
> from a submodule pointer). Only objects reachable from the branch tips,
> hidden by transfer.hiderefs or not, will be processed.

I am not sure if I am reading the last sentence correctly.  If there
are two branches, 'master' (exposed) and 'occult' (hidden),

    ---o---o---2---1---x master
        \
         o---2---1---y occult

you can ask for the 40-hex object name of occult~2, but you cannot
ask for the 40-hex object name of master~2?  Why such a restriction?

 ... wait for an answer that justfies the restriction ...

Does that justification applies for allowing occult~4 but not master~4?

> @@ -456,8 +457,11 @@ static void check_non_tip(void)
>  	char namebuf[42]; /* ^ + SHA-1 + LF */
>  	int i;
>  
> -	/* In the normal in-process case non-tip request can never happen */
> -	if (!stateless_rpc)
> +	/*
> +	 * In the normal in-process case without
> +	 * uploadpack.allowreachablesha1inwant, non-tip requests can never happen.
> +	 */

That's quite an overlong line; if you switched it to multi-line,
then fold the line once more, perhaps before "non-tip"?

> @@ -728,6 +732,7 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
>  			     sha1_to_hex(sha1), refname_nons,
>  			     0, capabilities,
>  			     allow_tip_sha1_in_want ? " allow-tip-sha1-in-want" : "",
> +			     allow_reachable_sha1_in_want ? " allow-reachable-sha1-in-want" : "",

Which printf format specifier does this new element correspond to?

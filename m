From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/16] merge: simplify ff-only option
Date: Thu, 31 Oct 2013 11:04:19 -0700
Message-ID: <xmqqhabx8ggs.fsf@gitster.dls.corp.google.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
	<1383211547-9145-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 19:04:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbwbe-0001qt-OT
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 19:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754554Ab3JaSE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 14:04:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35835 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752300Ab3JaSE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 14:04:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE44F4E187;
	Thu, 31 Oct 2013 14:04:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VTgaCYwQ+yQmH+X9iBhMte2JevI=; b=b4EXWT
	bH77omUwGmgUIO4Mc2S8Y15Vhtc9Mwp5JPWBh5pOZfbCFk67T6DCgGWMYEgM7id3
	1qqf6pNApH9aP3KXGuhmTk1RsAmf8a7zerTcXjEUdqarTEQxDgqX40wTT/EXlRPX
	YeFhM13M301y/Twqq8P713jt639OJdI15rDIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ykFYrQIPzdyKRIiHe32OXPqAjIRgSN8i
	wTi7dsfqRgnJciaUzLwoEXcprrkwQIBwXs3mesyNATyZn2zL052cJ2n8c1YwI6ue
	dFBObTXfpaww654rDJ0nGn4QpAwJnQLnbwuPckF6cAhshUS4q0JuU+G5ybDny0ZP
	s/xk5elXc9U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C01854E185;
	Thu, 31 Oct 2013 14:04:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E9F84E180;
	Thu, 31 Oct 2013 14:04:23 -0400 (EDT)
In-Reply-To: <1383211547-9145-2-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 31 Oct 2013 03:25:32 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DF40805A-4256-11E3-8E4C-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237136>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> No functional changes.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/merge.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 02a69c1..41fb66d 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -186,13 +186,6 @@ static int option_parse_n(const struct option *opt,
>  	return 0;
>  }
>  
> -static int option_parse_ff_only(const struct option *opt,
> -			  const char *arg, int unset)
> -{
> -	fast_forward = FF_ONLY;
> -	return 0;
> -}
> -
>  static struct option builtin_merge_options[] = {
>  	{ OPTION_CALLBACK, 'n', NULL, NULL, NULL,
>  		N_("do not show a diffstat at the end of the merge"),
> @@ -210,9 +203,9 @@ static struct option builtin_merge_options[] = {
>  	OPT_BOOL('e', "edit", &option_edit,
>  		N_("edit message before committing")),
>  	OPT_SET_INT(0, "ff", &fast_forward, N_("allow fast-forward (default)"), FF_ALLOW),
> -	{ OPTION_CALLBACK, 0, "ff-only", NULL, NULL,
> +	{ OPTION_SET_INT, 0, "ff-only", &fast_forward, NULL,
>  		N_("abort if fast-forward is not possible"),
> -		PARSE_OPT_NOARG | PARSE_OPT_NONEG, option_parse_ff_only },
> +		PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, FF_ONLY },
>  	OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
>  	OPT_BOOL(0, "verify-signatures", &verify_signatures,
>  		N_("Verify that the named commit has a valid GPG signature")),

Looks good; thanks.

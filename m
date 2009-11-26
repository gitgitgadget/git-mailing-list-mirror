From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] Teach git-merge to pass -X<option> to the backend
 strategy module
Date: Wed, 25 Nov 2009 22:16:07 -0800
Message-ID: <7vk4xderq0.fsf@alter.siamese.dyndns.org>
References: <cover.1259201377.git.apenwarr@gmail.com>
 <d243a513ffb8da4272f7a0e13a711f9b65195c25.1259201377.git.apenwarr@gmail.com>
 <905749faf5ccb2c7c54d3318dbc662d69daf8d0e.1259201377.git.apenwarr@gmail.com>
 <7e1f1179fc5fe2f568e2c75f75366fa40d7bbbfb.1259201377.git.apenwarr@gmail.com>
 <cover.1259201377.git.apenwarr@gmail.com>
 <73a42e99b4a083c74b017caf2970d1bbf5886b96.1259201377.git.apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 07:16:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDXef-00082r-8A
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 07:16:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754649AbZKZGQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 01:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754648AbZKZGQN
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 01:16:13 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53636 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637AbZKZGQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 01:16:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0C307A1BB5;
	Thu, 26 Nov 2009 01:16:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=HJr775kDDVO6jH29NwM6+P1I6B8=; b=sKk+4hiACbrHc2MC3SHqLBq
	Sbe3gPIbNTfLE5UCON3XV6XjSHjCCBGL3vRDGBcMGMI5jcXqv0Apnx3+mQXQTs/u
	y9xkv1Qr3N41uRqNK4ZKZNdLuBUKp71nz0JBtnL+161/8co9SI4YfLX2rPzehiil
	KTg6hIF5hGNlMJaoY2+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=U3GamLQfHrLqaXJozNSUV2kbXZzPbDKeH5DzHoe03V20SqRPE
	EB+hymOSFFMY0AK36r+RHzcoOH2F7wDOmr/vH23arqFdLtZZK7koBOMaBDkTDL3t
	Pgoz7v55+vyDc++yYP+1STqem2CcvGA50PpYHRuU7iiHWZK3mLh7m62WUI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DFFAFA1BB4;
	Thu, 26 Nov 2009 01:16:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 95773A1BB3; Thu, 26 Nov 2009
 01:16:08 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 324D0298-DA53-11DE-8946-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133766>

Avery Pennarun <apenwarr@gmail.com> writes:

> Distinguishing slight variation of modes of operation between the vanilla
> merge-recursive and merge-recursive-ours by the command name may have been
> an easy way to experiment, but we should bite the bullet and allow backend
> specific options to be given by the end user.
>
> (Patch originally by Junio Hamano <gitster@pobox.com>.)
>
> Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
> ---
>  Makefile                     |    3 ---
>  builtin-merge-recursive.c    |   21 +++++++++++++++------
>  builtin-merge.c              |   40 ++++++++++++++++++++++++++++++++++++----
>  t/t6034-merge-ours-theirs.sh |    4 ++--
>  4 files changed, 53 insertions(+), 15 deletions(-)

You added .gitignore entries for the two programs previously, and are
removing them in this patch, but forgot to remove them from .gitignore in
this patch.

As I already suggested you to, if you squash this to the previous one, it
is not a big deal, though.

> diff --git a/builtin-merge.c b/builtin-merge.c
> index df089bb..9a95bc8 100644
> --- a/builtin-merge.c
> +++ b/builtin-merge.c
> @@ -148,6 +148,17 @@ static int option_parse_strategy(const struct option *opt,
>  	return 0;
>  }
>  
> +static int option_parse_x(const struct option *opt,
> +			  const char *arg, int unset)
> +{
> +	if (unset)
> +		return 0;

Should "merge --no-extended" silently be ignored, or be diagnosed as an
error?

> @@ -174,6 +185,8 @@ static struct option builtin_merge_options[] = {
>  		"abort if fast-forward is not possible"),
>  	OPT_CALLBACK('s', "strategy", &use_strategies, "strategy",
>  		"merge strategy to use", option_parse_strategy),
> +	OPT_CALLBACK('X', "extended", &xopts, "option=value",
> +		"option for selected merge strategy", option_parse_x),

I actually didn't name X for "extended" but more for "external" (to the
merge program proper).  "--strategy-option" perhaps?

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 7/7] git grep: honor textconv by default
Date: Tue, 23 Apr 2013 08:20:10 -0700
Message-ID: <7vwqrtjmtx.fsf@alter.siamese.dyndns.org>
References: <517298D4.3030802@drmicha.warpmail.net>
	<043047afd2915dd8f3a68cf164dc516d4c0bb5c2.1366718624.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	jeremy.rosen@openwide.fr, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 23 17:20:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUf14-0005dz-3z
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 17:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756051Ab3DWPUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 11:20:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51843 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755589Ab3DWPUN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 11:20:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 364E619568;
	Tue, 23 Apr 2013 15:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sqOkSSix1B8zdfhp9qgGwEqtyco=; b=rofTqn
	b3L0+5kJOnFc+2O1csAVRuADmOMyoaFQfsEsE8C9/E1OEFBLYLYJces0mtlr7811
	Bh0tRDy/Z4i+VzBQwaYpDftON7B04BIggg/Ugkq8+Xnd9qiP6SyxA00Ma+WZ0IEy
	KahALHAv4hfnxoEAzsZuLMAzs2dcLexWmXz2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F0r1llNQ7bIJbfpQEoX0DbRlk5CbyyeV
	Z1piCkxzDF/59127Ns3t+9ExHv8Otq/Cluzg3+R0QvY4eCV7KOpHP7s/BB1AyiBh
	9XJKLyP21ihx12R7HndYAc27cn4UYCxfd5PADAC0P434tO9POAcWkCsLeIohgRsI
	qj1QBTGHu70=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D31719567;
	Tue, 23 Apr 2013 15:20:12 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7518719565;
	Tue, 23 Apr 2013 15:20:11 +0000 (UTC)
In-Reply-To: <043047afd2915dd8f3a68cf164dc516d4c0bb5c2.1366718624.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Tue, 23 Apr 2013 14:11:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4A4FC5DC-AC29-11E2-8A9F-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222178>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Currently, "git grep" does not honor textconv settings by default.
> Make it honor them by default just like "git log --grep" does.

"git log --grep" looks for strings in the log message which never
goes through textconv filters.

Puzzled....

If you meant -S/-G, it justifies use of textconv because we are
generating diff and the user defines textconv to get a reasonable
output for otherwise undiffable contents.

I do not know if it is sensible to apply textconv by default for
"grep" (or for that matter "git show" that gives blob contents).

>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  Documentation/git-grep.txt | 2 +-
>  grep.c                     | 2 ++
>  t/t7008-grep-binary.sh     | 4 ++--
>  3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index a5c5a27..f54ac0c 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -82,10 +82,10 @@ OPTIONS
>  
>  --textconv::
>  	Honor textconv filter settings.
> +	This is the default.
>  
>  --no-textconv::
>  	Do not honor textconv filter settings.
> -	This is the default.
>  
>  -i::
>  --ignore-case::
> diff --git a/grep.c b/grep.c
> index c668034..161d3f0 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -31,6 +31,7 @@ void init_grep_defaults(void)
>  	opt->max_depth = -1;
>  	opt->pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED;
>  	opt->extended_regexp_option = 0;
> +	opt->allow_textconv = 1;
>  	strcpy(opt->color_context, "");
>  	strcpy(opt->color_filename, "");
>  	strcpy(opt->color_function, "");
> @@ -134,6 +135,7 @@ void grep_init(struct grep_opt *opt, const char *prefix)
>  	opt->pathname = def->pathname;
>  	opt->regflags = def->regflags;
>  	opt->relative = def->relative;
> +	opt->allow_textconv = def->allow_textconv;
>  
>  	strcpy(opt->color_context, def->color_context);
>  	strcpy(opt->color_filename, def->color_filename);
> diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
> index 10b2c8b..2fc9d9c 100755
> --- a/t/t7008-grep-binary.sh
> +++ b/t/t7008-grep-binary.sh
> @@ -156,7 +156,7 @@ test_expect_success 'setup textconv filters' '
>  	git config diff.foo.textconv "\"$(pwd)\""/nul_to_q_textconv
>  '
>  
> -test_expect_failure 'grep does not honor textconv' '
> +test_expect_success 'grep does honor textconv' '
>  	echo "a:binaryQfile" >expect &&
>  	git grep Qfile >actual &&
>  	test_cmp expect actual
> @@ -172,7 +172,7 @@ test_expect_success 'grep --no-textconv does not honor textconv' '
>  	test_must_fail git grep --no-textconv Qfile
>  '
>  
> -test_expect_failure 'grep blob does not honor textconv' '
> +test_expect_success 'grep blob does honor textconv' '
>  	echo "HEAD:a:binaryQfile" >expect &&
>  	git grep Qfile HEAD:a >actual &&
>  	test_cmp expect actual

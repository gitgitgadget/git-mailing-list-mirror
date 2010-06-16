From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] add --recode-patch option to git-mailinfo
Date: Wed, 16 Jun 2010 12:27:39 -0700
Message-ID: <7vhbl2eq1g.fsf@alter.siamese.dyndns.org>
References: <1276664983-5693-1-git-send-email-r0bertz@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Zhang Le <r0bertz@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Jun 16 21:28:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOyHH-0001vF-P4
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 21:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759458Ab0FPT1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 15:27:47 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46051 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756644Ab0FPT1q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 15:27:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C940BCE74;
	Wed, 16 Jun 2010 15:27:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jvPwtV0gxAFQJozEARmBvHfha2o=; b=EQ4iQy
	hMeZNyvHo/0DBC66IIDl+qcQzJ/GGaEANfFnA4wfLzPWXwARyxB5l/zZpwzUZQuW
	O6V4o4PPuRPDhMu8wfrI3yPt8A6UcchiaVxudDiGQX+ZJi0wCPdKjHi1mygj5a/0
	ixy3KHo6Ekwqf+j93L2ttzSxECjZtk7jIKikI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rfiPR1geS/lRLlHnmd/IGPH/BgTgLeQa
	ocYVzW0xKk8gqZJBOKe0TEQu609/R2Bsr02UKHZ2z2F7OYiwrysKDkzsZFQdp2hB
	yOW684yhClIToKbjN8rY3eLrK+nj4r3oGhciqkiJJtGsGRJD6JupqH0vTWXbqLzZ
	xtUMzUWW/OA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DA432BCE73;
	Wed, 16 Jun 2010 15:27:43 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DC0FBCE6D; Wed, 16 Jun
 2010 15:27:40 -0400 (EDT)
In-Reply-To: <1276664983-5693-1-git-send-email-r0bertz@gentoo.org> (Zhang
 Le's message of "Wed\, 16 Jun 2010 13\:09\:42 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3C93DE06-797D-11DF-8D75-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149272>

Zhang Le <r0bertz@gentoo.org> writes:

> diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
> index 3ea5aad..24d5bd7 100644
> --- a/Documentation/git-mailinfo.txt
> +++ b/Documentation/git-mailinfo.txt
> @@ -45,7 +45,7 @@ OPTIONS
>  	them.  This used to be optional but now it is the default.
>  +
>  Note that the patch is always used as-is without charset
> -conversion, even with this flag.
> +conversion, even with this flag.  Unless --recode-patch is used.

Somehow this doesn't rhyme well.  Perhaps

    Note that the patch is used as-with without charset conversion; use
    `--recode-patch` for that.

would be better?

> @@ -54,6 +54,10 @@ conversion, even with this flag.
>  -n::
>  	Disable all charset re-coding of the metadata.
>  
> +--recode-patch::
> +	Similar to -u.  But what is re-coded is the patch instead of the
> +	metainfo.  The default is off.

Ditto.

	Convert the patch from the e-mail to UTF-8 (or the value of the
	configuration variable `i18n.commitencoding`, if it is set).

By the way, what happens when somebody runs the following command?

	git mailinfo -n --recode-patch

Is it desirable?  If not, what _should_ happen instead?

> diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
> index 4a9729b..bb87b32 100644
> --- a/builtin/mailinfo.c
> +++ b/builtin/mailinfo.c
> @@ -12,6 +12,7 @@ static FILE *cmitmsg, *patchfile, *fin, *fout;
>  static int keep_subject;
>  static int keep_non_patch_brackets_in_subject;
>  static const char *metainfo_charset;
> +static int recode_patch;
>  static struct strbuf line = STRBUF_INIT;
>  static struct strbuf name = STRBUF_INIT;
>  static struct strbuf email = STRBUF_INIT;
> @@ -828,8 +829,10 @@ static int handle_commit_msg(struct strbuf *line)
>  	return 0;
>  }
>  
> -static void handle_patch(const struct strbuf *line)
> +static void handle_patch(struct strbuf *line)
>  {
> +	if (recode_patch)
> +		convert_to_utf8(line, charset.buf);
>  	fwrite(line->buf, 1, line->len, patchfile);
>  	patch_lines++;
>  }
> @@ -1021,7 +1024,7 @@ static int git_mailinfo_config(const char *var, const char *value, void *unused)
>  }
>  
>  static const char mailinfo_usage[] =
> -	"git mailinfo [-k|-b] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] msg patch < mail >info";
> +	"git mailinfo [-k|-b] [-u | --encoding=<encoding> | -n] [--recode-patch] [--scissors | --no-scissors] msg patch < mail >info";
>  
>  int cmd_mailinfo(int argc, const char **argv, const char *prefix)
>  {
> @@ -1034,6 +1037,7 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
>  
>  	def_charset = (git_commit_encoding ? git_commit_encoding : "UTF-8");
>  	metainfo_charset = def_charset;
> +	recode_patch = 0;

Do you need this assignment?

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] teach git-archive to auto detect the output format
Date: Sun, 13 Sep 2009 11:52:56 -0700
Message-ID: <7vzl8yr81j.fsf@alter.siamese.dyndns.org>
References: <7v3a6r5znq.fsf@alter.siamese.dyndns.org>
 <1252863407-2598-1-git-send-email-dpotapov@gmail.com>
 <1252863407-2598-2-git-send-email-dpotapov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 20:53:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmuCI-00059o-05
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 20:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754745AbZIMSxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 14:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754738AbZIMSxE
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 14:53:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40111 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240AbZIMSxC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 14:53:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BE79031291;
	Sun, 13 Sep 2009 14:53:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xzy+TuNWV0+f1ylM8E/eBjeQVe0=; b=PSwLww
	eQTuLQ2XWLbusvwfFa+niUQvaAmZJxfeO5C8cZmNDW6c2O1t1jbpA0SXy3d1ZCSf
	p8AhiZ/OKQq7TiAPVgR1goDk5rpCCMCNPhYUAlvSSOK9F0fusi2pemr74z75edBx
	+7AYf+p+XTSVYzr3zo+iinTmXwhcBTSHYfnjE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BvRJibGjTXaro10P1Dlh0G4W/zg0ms2d
	HBK0a+dNpOim8R34tAZ3XemofwqVnEspJUlQyWmuJYzY3BWtCann7TCgt0w6krFU
	EVP8ArHLp+jsZFsoGp3lHbnSxSQFQK/1IvixnAB9bAxjOhLC3VQKFl5zP22GxPRQ
	HMDY+KjHzV8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E30731290;
	Sun, 13 Sep 2009 14:53:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 516133128B; Sun, 13 Sep
 2009 14:52:58 -0400 (EDT)
In-Reply-To: <1252863407-2598-2-git-send-email-dpotapov@gmail.com> (Dmitry
 Potapov's message of "Sun\, 13 Sep 2009 21\:36\:47 +0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A9CBA924-A096-11DE-AA0A-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128402>

Dmitry Potapov <dpotapov@gmail.com> writes:

> diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
> index f7a3b95..c6fb21c 100644
> --- a/Documentation/git-archive.txt
> +++ b/Documentation/git-archive.txt
> @@ -35,7 +35,9 @@ OPTIONS
>  
>  --format=<fmt>::
>  	Format of the resulting archive: 'tar' or 'zip'.  The default
> -	is 'tar'.
> +	is 'tar', unless the output file is specified, and it has a known
> +	extension (such as '.zip') then the default for the output format
> +	will be determined by this extension.

Once it is _determined_, then it is not the default anymore.

	If this option is not given, and the output file is specified, the
	format is inferred from the filename if possible (e.g. writing to
	"foo.zip" makes the output to be in the zip format).  Otherwise
	the output format is `tar`.

> @@ -130,6 +132,12 @@ git archive --format=zip
>  	Put everything in the current head's Documentation/ directory
>  	into 'git-1.4.0-docs.zip', with the prefix 'git-docs/'.
>  
> +git archive -o latest.zip HEAD::
> +
> +	Create a Zip archive that contains the contents of the latest
> +	commit on the current branch. Note that the output format is
> +	specified implicitly by the extension of the output file.
> +

Perhaps "s/specified implicitly/inferred/" but that is a minor point.

> diff --git a/builtin-archive.c b/builtin-archive.c
> index 565314b..878c6b2 100644
> --- a/builtin-archive.c
> +++ b/builtin-archive.c
> @@ -77,14 +89,27 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
>  			"retrieve the archive from remote repository <repo>"),
>  		OPT_STRING(0, "exec", &exec, "cmd",
>  			"path to the remote git-upload-archive command"),
> +		OPT_STRING(0, "format", &format, "fmt", "archive format"),
>  		OPT_END()
>  	};
> +	char fmt_opt[32];
>  
>  	argc = parse_options(argc, argv, prefix, local_opts, NULL,
>  			     PARSE_OPT_KEEP_ALL);
>  
>  	if (output)
> +	{

On the same line, i.e. "if (output) {".

>  		create_output_file(output);
> +		if (!format)
> +			format = format_from_name(output);
> +	}
> +
> +	if (format)
> +	{

On the same line, i.e. "if (format) {".

> +		sprintf(fmt_opt, "--format=%s", format);
> +		argv[argc++] = fmt_opt;
> +		argv[argc] = NULL;

Did you make sure you are allowed to write into argv[] and the array is
large enough?  You probably need to make a copy of the array.

Otherwise, the idea feels sound.

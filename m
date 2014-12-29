From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] send-email: Improve format of smtp initialization error message
Date: Mon, 29 Dec 2014 10:50:46 -0800
Message-ID: <xmqqppb2z3w9.fsf@gitster.dls.corp.google.com>
References: <1419875601-20836-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 29 19:54:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5fSb-000406-E2
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 19:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbaL2Suu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 13:50:50 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64407 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751529AbaL2Suu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 13:50:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EFB0B29303;
	Mon, 29 Dec 2014 13:50:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e2cV44x7urNFH7cfuDCLGEZ0uHE=; b=k26wHe
	vWc+iAK6/PFCWVhZ9HI/yKSTnOJQZH+lbVYDtumSqG/JgLpSU7oFhd+r4EiBY1UA
	B+Nno4yV6KJBaHCmPveYWpfRqK/Ng9eQy241sCMw1nS1biQXiseHbZe8smZzlBv8
	s9vZcMslsMRXAWa+rddzHM+Jk9x4Gb9mTxYeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BtfnpCcoxOxRx2MFBasmZDD0AxUDLhM/
	xNtz/Ja76uZsRV888S+D4CaTdk3+zjsWEJ02QqXBWjJ+DJ/T2SvUmjAad1H8W+te
	1O4/NNqPFMJ+EqX59d4K6Xy9BNxYbNRRcVAFn5xr6ldvrmLKuqHUKxuqt0hIjBwB
	yfH6Fa4E77k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E6FBC29301;
	Mon, 29 Dec 2014 13:50:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 399DD29300;
	Mon, 29 Dec 2014 13:50:48 -0500 (EST)
In-Reply-To: <1419875601-20836-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Mon, 29 Dec 2014 23:53:21 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9A7D64F0-8F8B-11E4-B2E5-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261872>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>  git-send-email.perl | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 82c6fea..60dcd8d 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1275,10 +1275,10 @@ X-Mailer: git-send-email $gitversion
>  
>  		if (!$smtp) {
>  			die "Unable to initialize SMTP properly. Check config and use --smtp-debug. ",
> -			    "VALUES: server=$smtp_server ",
> -			    "encryption=$smtp_encryption ",
> -			    "hello=$smtp_domain",
> -			    defined $smtp_server_port ? " port=$smtp_server_port" : "";
> +			    "\nVALUES: \n\tserver=$smtp_server ",
> +			    "\n\tencryption=$smtp_encryption ",
> +			    "\n\thello=$smtp_domain",
> +			    defined $smtp_server_port ? " \n\tport=$smtp_server_port" : "";

It may be a good convention to have LF at the beginning of a new
string (i.e. we terminate the old line only when we have something
more to say), but that is true only when we want to end the sentence
without the final newline.  I wonder if that is true in this case;
do we want perl to say "at line # in file X" at the end?

In any case, you have two output lines that ends with a trailing SP
just before LF, which is probably not what you wanted.

If we want to see all lines end with LF, it may be far easier to
read this way:

	die "msg\n",
            "\tvar1=val1\n",
            "\tvar2=val2\n",
            defined $var3 ? "\tvar3=val3\n" : "";

I dunno.

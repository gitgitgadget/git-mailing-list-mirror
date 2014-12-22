From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: add --irreversible-delete for format-patch
Date: Mon, 22 Dec 2014 10:39:54 -0800
Message-ID: <xmqq3887a5qd.fsf@gitster.dls.corp.google.com>
References: <20141221115007.GA23500@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Dec 22 19:40:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y37ti-0005HJ-DB
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 19:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754924AbaLVSj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 13:39:58 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52411 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754378AbaLVSj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 13:39:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E14A52710C;
	Mon, 22 Dec 2014 13:39:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A4ynu2p5EGQxhlYH5ebrZuq66hE=; b=djQ+BJ
	UtgItphwQTPCFsKzHuovSohAHCOE72ZRvmurgWb1CrF9VGZ4KveEjTxpj04TREDK
	jHmzMiAcWLYEqeFxSXmU9wE73DvF5xaNvZ/meDXk9uDdtmWcg/0qiSMJxkSQqRlb
	EisiwVXm6+J8D1lgDzlcgXF5XrgDfgskAzKjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SHUwYWVWDOI/0w8sib4KQTJwx9OLDGjL
	szmNj0tSHUfaYcfuF0Gf+Dd9bCgiKp8fcNRb6bMKLL9BUKDGobz4tZzRdsgUjw4e
	+bd+Tn0GJoLOVXlpwsdOusnW2BZR5GemgLOsqB4ITP/ixhrKMKa/RbPWzkmKHJP8
	tmEHZ4TTB5s=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D8A552710B;
	Mon, 22 Dec 2014 13:39:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 652602710A;
	Mon, 22 Dec 2014 13:39:56 -0500 (EST)
In-Reply-To: <20141221115007.GA23500@dcvr.yhbt.net> (Eric Wong's message of
	"Sun, 21 Dec 2014 11:50:07 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ED0B80F8-8A09-11E4-94B9-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261665>

Eric Wong <normalperson@yhbt.net> writes:

> Normally I would use "-D", but send-email (which normally passes options
> to format-patch) interprets the "-D" as a case-insensitive abbreviation
> for "--dry-run", preventing format-patch from seeing "-D".

Is this nonstandard option that is designed to produce an
inapplicable patch so widely used to warrant a completion?

I'd actually understand it if this were to complete "git show" and
friends, but not for format-patch.  I'd actually think we might be
better off forbidding its use for the format-patch command (but not
for other commands in the "git log" family), not just at the
completion level but at the command line argument parser level.

Hmph...

> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>  Case-insensitivity strikes again! :<
>  What a wacky default for Getopt::Long...  And it's probably too late
>  for us to disable case-insensitivity in CLI parsing for send-email.
>
>  contrib/completion/git-completion.bash | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 2fece98..41d8ff8 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1257,6 +1257,7 @@ __git_format_patch_options="
>  	--not --all --cover-letter --no-prefix --src-prefix= --dst-prefix=
>  	--inline --suffix= --ignore-if-in-upstream --subject-prefix=
>  	--output-directory --reroll-count --to= --quiet --notes
> +	--irreversible-delete
>  "
>  
>  _git_format_patch ()

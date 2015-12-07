From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] format-patch: add an option to suppress commit hash
Date: Mon, 07 Dec 2015 11:34:59 -0800
Message-ID: <xmqqr3iym4rg.fsf@gitster.mtv.corp.google.com>
References: <1449440196-991107-1-git-send-email-sandals@crustytoothpaste.net>
	<1449440196-991107-3-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Dec 07 20:35:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a61Z1-0004m7-LR
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 20:35:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932775AbbLGTfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 14:35:04 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56833 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932380AbbLGTfD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 14:35:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8236430C06;
	Mon,  7 Dec 2015 14:35:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RsS8aaI9qDtmsAv2icaqDaUOZHw=; b=cPNLtF
	C/+OJ2L9oxbTUJtumWSg4V18g6piBozOrW75Kg8P0FI4TomlUqXtN9VHbJPCwpm6
	sh8F8glkmNs4Ss/5ZmnhEOkZSI4GeQRaIW5QbwEEmivk1Gnq0HAPnx3HH9MJg5wq
	cn1dl6SSh9/qzWPLkZK6wlxCwELoHPi3VhsJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GlnYwtxsKcvWTJPxmluuYYHkdkeiVhuu
	ZlRB6SNJD9DomLC5a53Hd69QmnqtrSIRuOQwtHFkgKgOcHQk8IcA0SwGDyc16b6h
	uV2jDZSTicOfzdAaGgLeGWulfwgczlD08Lyn9DlxglU9ColpRIVtqCp76uBwYzq1
	MutXIrwwlAo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 42BEA30C03;
	Mon,  7 Dec 2015 14:35:01 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1DE9B30C02;
	Mon,  7 Dec 2015 14:35:00 -0500 (EST)
In-Reply-To: <1449440196-991107-3-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Sun, 6 Dec 2015 22:16:36 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9ACA41F2-9D19-11E5-83F4-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282108>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Oftentimes, patches created by git format-patch will be stored in
> version control or compared with diff.  In these cases, two otherwise
> identical patches can have different commit hashes, leading to diff
> noise.  Teach git format-patch a --no-hash option that instead produces
> an all-zero hash to avoid this diff noise.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Documentation/git-format-patch.txt | 4 ++++
>  builtin/log.c                      | 5 +++++
>  log-tree.c                         | 3 ++-
>  revision.h                         | 1 +
>  t/t4014-format-patch.sh            | 6 ++++++
>  5 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 40356491..1266f135 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -256,6 +256,10 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
>  	using this option cannot be applied properly, but they are
>  	still useful for code review.
>  
> +--no-hash::
> +  Output an all-zero hash in each patch's From header instead
> +  of the hash of the commit.
> +

Two (big) problems with the option name.

 - "--no-something" would mislead people to think you are removing
   something, not replacing it with something else.  This option
   does the latter (i.e. the first line of your output still has
   40-hex; it's just it no longer has a useful 40-hex).

 - There are many places we use hexadecimal strings in format-patch
   output and you are not removing or replacing all of them, only
   the commit object name on the fake "From " line.  Saying "hash"
   would mislead readers.

> +test_expect_success 'format-patch --no-hash' '
> +	git format-patch --no-hash --stdout v2..v1 >patch2 &&
> +	cnt=$(egrep "^From 0+ Mon Sep 17 00:00:00 2001" patch2 | wc -l) &&

Don't test "any number of '0'"; test 40 '0's.  This is because the
line format was designed to be usable by things like /etc/magic to
detect format-patch output, and we want to notice if/when we break
that aspect of our output format.

> +	test $cnt = 3
> +'
> +
>  test_done

Thanks.

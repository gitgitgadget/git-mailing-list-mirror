From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t1700: make test pass with index-v4
Date: Fri, 20 Mar 2015 12:38:37 -0700
Message-ID: <xmqqd243e9xe.fsf@gitster.dls.corp.google.com>
References: <xmqqtwxfee6a.fsf@gitster.dls.corp.google.com>
	<1426875630-17481-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 20:38:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ2kp-0002AR-RM
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 20:38:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbbCTTim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 15:38:42 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59978 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750994AbbCTTik (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 15:38:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BCFD940659;
	Fri, 20 Mar 2015 15:38:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pfpkMOGuhr2p0Eo7MRcNidV3uzA=; b=NaVM4N
	7emlAMHf36eobvr0qhSZhufU7AyB17itBNHaVSib5nrHGFYqCcTA0HL011my0fmK
	Cuo+69dVHjEDiTonC2S5eBPTlKf/ew/9J1hPtbsRr2zWfGPnOEeAIvc0M/kQFGRp
	xjaZig/QEw8Ph5IsSwt/F44kcYkbkzxP1KAVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CVZwFCuV6gANJ923BQwroCuuVdEzywil
	00sMNTQltpqbiaBJ/3q4mLGZ9fd++mQrthBNWCNN1FOcBIFuWOSeU6SXYzAvYEjE
	BFqUeIQJUyqADzzIJ4Oe6sY4dLA9juB0lUq+lKjS+c2rSB9D5N78HNAOu5Bfwg82
	dH47D3TxsJ4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B30A540658;
	Fri, 20 Mar 2015 15:38:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1521840653;
	Fri, 20 Mar 2015 15:38:38 -0400 (EDT)
In-Reply-To: <1426875630-17481-1-git-send-email-t.gummerer@gmail.com> (Thomas
	Gummerer's message of "Fri, 20 Mar 2015 19:20:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B5146006-CF38-11E4-85D9-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265957>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> The different index versions have different sha-1 checksums.  Those
> checksums are checked in t1700, which makes it fail when the test suite
> is run with TEST_GIT_INDEX_VERSION=4.  Fix it.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>> An updated patch to mention "when run with TEST_GIT_INDEX_VERSION=4"
>> in the log message was what I was asking for ;-)
>
> Sorry I didn't catch that.  Here it is.

Thanks.  Is this the only one that fails with v4?

> 					      
>
>  t/t1700-split-index.sh | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> index 94fb473..92f7298 100755
> --- a/t/t1700-split-index.sh
> +++ b/t/t1700-split-index.sh
> @@ -10,9 +10,18 @@ sane_unset GIT_TEST_SPLIT_INDEX
>  test_expect_success 'enable split index' '
>  	git update-index --split-index &&
>  	test-dump-split-index .git/index >actual &&
> +	indexversion=$(test-index-version <.git/index) &&
> +	if test "$indexversion" = "4"
> +	then
> +		own=432ef4b63f32193984f339431fd50ca796493569
> +		base=508851a7f0dfa8691e9f69c7f055865389012491
> +	else
> +		own=8299b0bcd1ac364e5f1d7768efb62fa2da79a339
> +		base=39d890139ee5356c7ef572216cebcd27aa41f9df
> +	fi &&
>  	cat >expect <<EOF &&
> -own 8299b0bcd1ac364e5f1d7768efb62fa2da79a339
> -base 39d890139ee5356c7ef572216cebcd27aa41f9df
> +own $own
> +base $base
>  replacements:
>  deletions:
>  EOF
> @@ -30,7 +39,7 @@ EOF
>  
>  	test-dump-split-index .git/index | sed "/^own/d" >actual &&
>  	cat >expect <<EOF &&
> -base 39d890139ee5356c7ef572216cebcd27aa41f9df
> +base $base
>  100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
>  replacements:
>  deletions:

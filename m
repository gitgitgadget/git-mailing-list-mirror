From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 18/22] tests: use test_i18n* functions to suppress false positives
Date: Fri, 27 May 2016 10:08:03 -0700
Message-ID: <xmqqd1o7sa30.fsf@gitster.mtv.corp.google.com>
References: <1464031661-18988-1-git-send-email-vascomalmeida@sapo.pt>
	<1464031661-18988-19-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Fri May 27 19:08:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6LF7-0006D0-4e
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 19:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756325AbcE0RII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 13:08:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56697 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751502AbcE0RIH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 13:08:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B1381F9CF;
	Fri, 27 May 2016 13:08:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jat1f/UooqE4vGFsMbhNRs9g4ZA=; b=AXfzPK
	vGVdk9ljPYxvbTgvu7ejS2/9j2ABF46kcz6avvYCN/FVhGuvEj6dvyeq/G1lrxPC
	nVvn73loE0wCyzMUX5iSK8vgE/yvQRJiPV+WM58zQMWwqaVQL9aGYuGu12mN+Fem
	oNXwTHkH8FFAjZeFyMdh0hIRl2DpG1z3hZ81Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OmpItDAFRs8INVS/4Qn9501HBbcLO1S+
	JiNssWdAfXhGpnL1BW+Lzkg5SoHEc6zbugcNhHN0t9hvBBZZebfIt4J7wW7ZkzwO
	b9rcKMU7WDXT1MBdx/1Zgiqr7P+ZLAJBct1wC/QnJyJIg2wfS0BBCp/vQzCqpFj1
	cow+HepIWhM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 411471F9CE;
	Fri, 27 May 2016 13:08:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B04771F9CD;
	Fri, 27 May 2016 13:08:05 -0400 (EDT)
In-Reply-To: <1464031661-18988-19-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Mon, 23 May 2016 19:27:37 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 941217A4-242D-11E6-8998-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295770>

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> diff --git a/t/t1307-config-blob.sh b/t/t1307-config-blob.sh
> index 3c6791e..4079fef 100755
> --- a/t/t1307-config-blob.sh
> +++ b/t/t1307-config-blob.sh
> @@ -64,7 +64,7 @@ test_expect_success 'parse errors in blobs are properly attributed' '
>  
>  	# just grep for our token as the exact error message is likely to
>  	# change or be internationalized
> -	grep "HEAD:config" err
> +	test_i18ngrep "HEAD:config" err
>  '

It is unfortunate that the gettext-poison mechanism is too dumb to
notice that it is clobbering a format string with placeholders and
leave them intact, which is what the comment above this change is
wishing for.  I do not think we will be granting that wish any time
soon, so perhaps remove the two lines while we are at it?

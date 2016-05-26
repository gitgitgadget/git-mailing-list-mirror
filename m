From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 13/22] i18n: git-sh-setup.sh: mark strings for translation
Date: Thu, 26 May 2016 15:46:49 -0700
Message-ID: <xmqqk2igtp2e.fsf@gitster.mtv.corp.google.com>
References: <1464031661-18988-1-git-send-email-vascomalmeida@sapo.pt>
	<1464031661-18988-14-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Fri May 27 00:46:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b643O-0004LG-9o
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 00:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412AbcEZWqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 18:46:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59501 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755099AbcEZWqx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 18:46:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 67A891F5CB;
	Thu, 26 May 2016 18:46:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CSURx+M61oKI2/3FwwmLlr0T7eI=; b=hic7ti
	GVlcO6uR/BqYpoIYsTC0bvCiIqA+koqvBpMfmq6t09v9/FhuDYZPB4yvSkM6KqiZ
	Ox2+/hHarp1xXCmfGPZENLdF5QQTxNfzvnSNWV1zsemmJRQMqUC+YgSt8/VzdSum
	cypBgG0IkcOI+ujdAX8ewcnJ6Y63bBPQU7Jh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fwRkxxDwcXnuA/+0slGszU+fjXTiG01l
	tKUkDcXpJ6w1WR3Rb3V6WB0subYMVwFzXLiLHZk17Jm6zxSKtHUk7bTXcBFnlFXu
	w6s0s0Xfde7oJUyEEBJYP/b3EIqcsy6u10lDs0Es40mfui1rtc+eYwrSh4sMSz1z
	1mu2hYSgH+Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5EABE1F5CA;
	Thu, 26 May 2016 18:46:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DEE2A1F5C9;
	Thu, 26 May 2016 18:46:51 -0400 (EDT)
In-Reply-To: <1464031661-18988-14-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Mon, 23 May 2016 19:27:32 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BCFD3E18-2393-11E6-A65B-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295702>

Vasco Almeida <vascomalmeida@sapo.pt> writes:

>  require_work_tree_exists () {
> +	program_name=$0
>  	if test "z$(git rev-parse --is-bare-repository)" != zfalse
>  	then
> -		die "fatal: $0 cannot be used without a working tree."
> +		die "$(gettext "fatal: \$program_name cannot be used without a working tree.")"
>  	fi
>  }

This is probably quite a minor point, but I'd prefer if clobbering
the variable program_name is done between "then" and "fi", i.e. when
we know we are going to die, so the caller would not care.  Because
we are not in control of the caller's namespace use, and we do not
want bash-ism "local" here, that is the best we could do to make it
safer.

>  require_work_tree () {
> +	program_name=$0

Same here.

>  	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = true ||
> -	die "fatal: $0 cannot be used without a working tree."
> +		die "$(gettext "fatal: \$program_name cannot be used without a working tree.")"
>  }
>  
>  require_clean_work_tree () {
> +	action=$1
> +	hint=$2

Likewise.

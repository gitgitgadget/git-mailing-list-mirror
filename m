From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] for_each_reflog_ent_reverse: turn leftover check into assertion
Date: Fri, 05 Dec 2014 11:15:24 -0800
Message-ID: <xmqqsigtq56b.fsf@gitster.dls.corp.google.com>
References: <547C8610.8080301@cs.uni-saarland.de>
	<20141201233515.GV6527@google.com>
	<xmqqvblrrwxu.fsf@gitster.dls.corp.google.com>
	<5480C60E.3070903@cs.uni-saarland.de>
	<20141204215805.GD19953@peff.net>
	<xmqq388vrrj9.fsf@gitster.dls.corp.google.com>
	<20141205012854.GA16590@peff.net> <20141205013244.GA16642@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christoph Mallon <mallon@cs.uni-saarland.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 05 20:15:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwyLm-0000cC-St
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 20:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbaLETPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 14:15:30 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52788 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751468AbaLETP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 14:15:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D770C234AD;
	Fri,  5 Dec 2014 14:15:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6r0zWcFICu+u7Ev+J+4lteck8rI=; b=XU8TZH
	N2BN7m6RRHNh7E1xYcvEZyB9Ldf++9Kp0R0ryU5yxGAwACifaddfr/vNNn9QLGRX
	4AodmIQETnZaGZgNH2R9zZ0qh0Qs+gSZ6/GfzTVaobWp6wKM8hQLc/sVC49kS8fG
	jcyPg98Y/OL/dNaySYUFmUqiXT5tnemIEpf3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IE0B2gtq/hRBanvrDZoMDf0pjXGnte5m
	BORUV8ktE25mbtrnoSJR2vlhokypbTO5H44QlxKa2EpGnNtD1EU0EXGHRsZ7UTVF
	lIqPw/lQc64DDlAnuHrgfrKHqwlSnp0ATy3sgZfR7ClUXAbJ4wH1pO4OgI7W55uc
	dZarR9VCTMA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CD97A234AC;
	Fri,  5 Dec 2014 14:15:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A1C3234A8;
	Fri,  5 Dec 2014 14:15:25 -0500 (EST)
In-Reply-To: <20141205013244.GA16642@peff.net> (Jeff King's message of "Thu, 4
	Dec 2014 20:32:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 10FC2DB4-7CB3-11E4-A464-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260883>

Jeff King <peff@peff.net> writes:

> I _think_ the patch below is also applicable to the code before my
> boundary-fixing patch. But the rearranging also made me more confident
> in it.

Yeah, thanks for a fix.

> -- >8 --
> Subject: for_each_reflog_ent_reverse: turn leftover check into assertion
>
> Our loop should always process all lines, even if we hit the
> beginning of the file. We have a conditional after the loop
> ends to double-check that there is nothing left and to
> process it. But this should never happen, and is a sign of a
> logic bug in the loop. Let's turn it into a BUG assertion.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Of course I cannot say something like "this can never happen; the old
> code was wrong to handle this case" without a nagging feeling that I am
> missing something, so extra careful eyes are appreciated (and are why I
> would rather have an assert here than removing the code and silently
> dropping lines if I am wrong).
>
>  refs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index ccb8834..1f77fa6 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3451,7 +3451,7 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void
>  
>  	}
>  	if (!ret && sb.len)
> -		ret = show_one_reflog_ent(&sb, fn, cb_data);
> +		die("BUG: reverse reflog parser had leftover data");
>  
>  	fclose(logfp);
>  	strbuf_release(&sb);

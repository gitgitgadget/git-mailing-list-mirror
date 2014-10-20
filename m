From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Copy mergetool "bc3" as "bc4"
Date: Mon, 20 Oct 2014 09:40:05 -0700
Message-ID: <xmqq7fzu4rve.fsf@gitster.dls.corp.google.com>
References: <1413803017-30489-1-git-send-email-ocroquette@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Olivier Croquette <ocroquette@free.fr>
X-From: git-owner@vger.kernel.org Mon Oct 20 18:40:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgG0H-0008Ha-9r
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 18:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbaJTQkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 12:40:13 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65370 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751493AbaJTQkL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 12:40:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BD56D1555C;
	Mon, 20 Oct 2014 12:40:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Xhahv2/cBbxWip/NEFpZqYHoab8=; b=aTom6X
	/4lWGytTaoK+1AcRCqxWibXZbBWQ6f0CK0zPbGYNa1D32Vbv5RFlFUracdI5fq5k
	KSzff6S5oMz5/mj5CMVrLvkmUv3mqc9NaPNoVVeHLZlUi9YbSRseD7oOEfvyEyCb
	5AOw0Row+6IoHai0qlej/bQTCxn3EVyihLBHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z9exfep+qeDqjMYPrdbKuqtXxagEQmjp
	kzaRAAJM8DiUAS5o1MYQZIpXRXssZ9RLL784BSqWeONxm1wdc9ozc3bSWX0Yb9Jc
	AoC3BvY2XdYBnf97/V5Fd3lLD8E+3Ol5k1XKSgnxJSzjkRs+hHxu0Ml7lrvVzncD
	v3E56u6q+GY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B494A1555B;
	Mon, 20 Oct 2014 12:40:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D90F15559;
	Mon, 20 Oct 2014 12:40:06 -0400 (EDT)
In-Reply-To: <1413803017-30489-1-git-send-email-ocroquette@free.fr> (Olivier
	Croquette's message of "Mon, 20 Oct 2014 13:03:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BFD3D428-5877-11E4-9CCC-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olivier Croquette <ocroquette@free.fr> writes:

> Beyond compare 4 is out since september 2014. The CLI interface
> doesn't seem to have changed compared to the version 3.

Hmph, if this is identical to mergetools/bc3, why is the patch even
needed?  Do we auto-detect something and try to use bc4 which does
not exist and fail, and we must supply a copy as bc4 to prevent it?

It may feel somewhat strange to have to say "mergetool --tool=bc3"
when you know what you have is version 4 and not version 3, but in
that case, I wonder if there are reasons why calling both versions
just "bc" is a bad idea.  And assuming that version 5 and later
would keep the same interface, we will not have to worry about that
"I have version 7 why do I have to say 3?" if we can go that route.

Perhaps version 2 and before are unusable as a mergetool backend or
something?

>
> Signed-off-by: Olivier Croquette <ocroquette@free.fr>
> ---
>  mergetools/bc4 |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
>  create mode 100644 mergetools/bc4
>
> diff --git a/mergetools/bc4 b/mergetools/bc4
> new file mode 100644
> index 0000000..b6319d2
> --- /dev/null
> +++ b/mergetools/bc4
> @@ -0,0 +1,25 @@
> +diff_cmd () {
> +	"$merge_tool_path" "$LOCAL" "$REMOTE"
> +}
> +
> +merge_cmd () {
> +	touch "$BACKUP"
> +	if $base_present
> +	then
> +		"$merge_tool_path" "$LOCAL" "$REMOTE" "$BASE" \
> +			-mergeoutput="$MERGED"
> +	else
> +		"$merge_tool_path" "$LOCAL" "$REMOTE" \
> +			-mergeoutput="$MERGED"
> +	fi
> +	check_unchanged
> +}
> +
> +translate_merge_tool_path() {
> +	if type bcomp >/dev/null 2>/dev/null
> +	then
> +		echo bcomp
> +	else
> +		echo bcompare
> +	fi
> +}

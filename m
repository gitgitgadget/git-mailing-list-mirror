From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase-i: print abbreviated hash when stop for editing
Date: Thu, 24 Mar 2016 12:56:24 -0700
Message-ID: <xmqqfuvf8xav.fsf@gitster.mtv.corp.google.com>
References: <1458844281-13107-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 20:56:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajBMu-0005ww-51
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 20:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbcCXT43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 15:56:29 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:56437 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750752AbcCXT41 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 15:56:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 966E14D3D5;
	Thu, 24 Mar 2016 15:56:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xAtSgPbmWJ5V9UrlKQoZ5fAJ6JA=; b=QG5vNu
	vIhJ7fZbhnTo71ldKgT+xiRTwk5SW64HHqYc3HlRMbFvwiuIDXvigloO17u1neRS
	IC1uv0WRHpjOZkCHlnyGKOvgsYBRSyBensgv+WUldS83GAvdHPcVPgV26xFIl3+3
	ejIqtxCHeGZqEIwvXjl+YH869QLREmaPsk1C0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fiRsyHjKkIIOs+k7RWIKMuz16Xhi/BxZ
	QjLGNVaPmGLujTFTkUdfquGwqF1ABilcms04TlPKyZg81uTJAmriRxtsrmlUUnxJ
	NnX1sqNN1hj2z/EbIfmU3FC76De0sXEKQCffYg1xzwqInp96X1DagPaVmG+JBLsR
	kUEHDQm6yu0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8ECE24D3D4;
	Thu, 24 Mar 2016 15:56:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 147BA4D3D3;
	Thu, 24 Mar 2016 15:56:26 -0400 (EDT)
In-Reply-To: <1458844281-13107-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Thu, 24 Mar 2016 19:31:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7DE5AFA0-F1FA-11E5-B818-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289791>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---

Hmph, the reason why this is a good thing to do is because an
overlong $sha1 would push $rest too far to the right (possibly
making it overflow to the next line)?


>  git-rebase--interactive.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 4cde685..9ea3075 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -548,7 +548,8 @@ do_next () {
>  
>  		mark_action_done
>  		do_pick $sha1 "$rest"
> -		warn "Stopped at $sha1... $rest"
> +		sha1_abbrev=$(git rev-parse --short $sha1)
> +		warn "Stopped at $sha1_abbrev... $rest"
>  		exit_with_patch $sha1 0
>  		;;
>  	squash|s|fixup|f)

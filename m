From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/4] rebase -i: suggest using --edit-todo to fix an
 unknown instruction
Date: Wed, 19 Sep 2012 12:52:28 -0700
Message-ID: <7vvcf9g58j.fsf@alter.siamese.dyndns.org>
References: <CANiSa6j2zA5P6yDaR7VU416Bzes6xbWuHbU83=BGN67Wo9j_Cw@mail.gmail.com>
 <1347931690-20625-1-git-send-email-andrew.kw.w@gmail.com>
 <505969AA.1070509@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Sep 19 21:52:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEQKA-0006ae-PU
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 21:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271Ab2ISTwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 15:52:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62175 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014Ab2ISTwb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 15:52:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC8AF806C;
	Wed, 19 Sep 2012 15:52:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hW2Vb3SbXI+n0iOjkkaKa+WCG6s=; b=bmcmQ5
	xn8VuLnqokEzXPp+vv+Od6wK1F6YOmKiaSJA0unho4/Ip4I78+Q63yiS22Y2JNqg
	988zXHGHL/I9udtQuXeeYBAnvkBSZA4m/+owSMIJ3MpUYiyzE00NNdToIpyPXpZi
	c8/hL2gfVGXpNBooU9TFo8OuSx4VkjhgMi0ss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f2575zxaZ/KFf/KSAxwHWw7/2hKehP1j
	k3MzgLc0NUTbeorxfnwJ39NY29z5CsUU4iq7TRsny3/bf9f/xFlm5z6bjIFnW7xa
	6jd82NTfKjGPS6f2vzJNo7LFeSAFXBzDIFbdSX9v+33AW+GsVf0iDNIocc8TizuU
	GqfVY9uFahA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8CF5806B;
	Wed, 19 Sep 2012 15:52:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D983806A; Wed, 19 Sep 2012
 15:52:30 -0400 (EDT)
In-Reply-To: <505969AA.1070509@viscovery.net> (Johannes Sixt's message of
 "Wed, 19 Sep 2012 08:43:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8BAC0F30-0293-11E2-97BC-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205985>

Johannes Sixt <j.sixt@viscovery.net> writes:

> From: Johannes Sixt <j6t@kdbg.org>
>
> We have now an explicit UI to edit the todo sheet and need not disclose
> the name of the file.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  git-rebase--interactive.sh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 2b8f2a9..4b2ef11 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -575,11 +575,12 @@ do_next () {
>  		;;
>  	*)
>  		warn "Unknown command: $command $sha1 $rest"
> +		fixtodo="Please fix this using 'git rebase --edit-todo'."
>  		if git rev-parse --verify -q "$sha1" >/dev/null
>  		then
> -			die_with_patch $sha1 "Please fix this in the file $todo."
> +			die_with_patch $sha1 "$fixtodo"
>  		else
> -			die "Please fix this in the file $todo."
> +			die "$fixtodo"
>  		fi
>  		;;
>  	esac

Good thinking. Makes sense to me.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] rebase -i: Add the "ref" command
Date: Mon, 27 Jun 2011 11:46:52 -0700
Message-ID: <7vd3hzxgbn.fsf@alter.siamese.dyndns.org>
References: <cover.1309133817.git.greg@quora.com>
 <186680ca6febeb231e9a4fb44cee1e6aff58db6c.1309133817.git.greg@quora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Greg Price <price@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Jun 27 20:49:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbGsX-0002zg-CB
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 20:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526Ab1F0StA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jun 2011 14:49:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38807 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368Ab1F0Sqz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 14:46:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D13536B23;
	Mon, 27 Jun 2011 14:49:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kVI5djzr3V19HJQW/SZEraSXtZI=; b=soIDDV
	/5YN6QpSC9IdLqantpZ0/uBN3fCr8s1Jdk0hL2x00tm8lVWTdpc0GDsjZv6TOxs8
	h6sNtjgS+RCNJvINbnQheioCPZ/yL+aNnc3fLKvzGf5zRTj+TF8+EmUVyhyWekCa
	RdaJXRK4X/ciy8ibBO/vBvFKxkXy76Cye/sa4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L7Ecc+55C4PMmFVquIsfGCxSxBqGdCRb
	hJm8O14nUSdD7piqnOg0w4fEbau/ca205DRoIUQkKsLCZtk1Pkliwh9u0cfRJaCQ
	4rsqNCpf1YG6bdBGoNvFIomagxHRSNGqOaun0p83YUMa0IZ0KReZgbNsnZjK96Tu
	irYWWWtFZi4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A2A6B6B22;
	Mon, 27 Jun 2011 14:49:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C2FCC6B21; Mon, 27 Jun 2011
 14:49:05 -0400 (EDT)
In-Reply-To: <186680ca6febeb231e9a4fb44cee1e6aff58db6c.1309133817.git.greg@quora.com>
 (Greg Price's message of "Fri, 9 Oct 2009 22:52:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 223B0FFE-A0EE-11E0-BB15-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176361>

Greg Price <price@MIT.EDU> writes:

> ...
> +		if ! grep -Fq " $refname" "$state_dir"/oldrefs 2>/dev/null
> +		then
> +			echo "$sha1 $refname" >> "$state_dir"/oldrefs

(Style) Extra SP between ">>" and "$state_dir/oldrefs"

> diff --git a/git-rebase.sh b/git-rebase.sh
> index d7855ea..1bfe6a8 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -118,6 +118,8 @@ read_basic_state () {
>  		strategy_opts="$(cat "$state_dir"/strategy_opts)"
>  	test -f "$state_dir"/allow_rerere_autoupdate &&
>  		allow_rerere_autoupdate="$(cat "$state_dir"/allow_rerere_autoupdate)"
> +	test -f "$state_dir"/oldrefs &&
> +		oldrefs="$(cat "$state_dir"/oldrefs)"
>  }
>  
>  write_basic_state () {
> @@ -332,6 +334,15 @@ skip)
>  abort)
>  	git rerere clear
>  	read_basic_state
> +	[ -n "$oldrefs" ] && echo "$oldrefs" | while read sha1 ref

(Style) I think almost everybody else spells out "test".  Also please
break line before the while, like this:

	test -n "$oldrefs" &&
	echo "$oldrefs" |
	while read sha1 ref
        do
        	...

> +	do
> +		if test "(null)" = $sha1

Who is giving you "(null)"???

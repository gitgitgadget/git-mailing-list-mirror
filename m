From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] git-mergetool--lib: Make vimdiff retain the current
 directory
Date: Mon, 23 May 2011 12:59:34 -0700
Message-ID: <7vipt1ur15.fsf@alter.siamese.dyndns.org>
References: <7vwrhjxn4t.fsf@alter.siamese.dyndns.org>
 <1306058229-93800-1-git-send-email-davvid@gmail.com>
 <1306058229-93800-3-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?RnLDqWTDqXJpYw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 22:00:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QObIB-0001Wn-Ds
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 21:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757259Ab1EWT7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 15:59:47 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48983 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757251Ab1EWT7q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 15:59:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5624051F0;
	Mon, 23 May 2011 16:01:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BFCTlw7xPbSHqiHBiwkJB+2WBwE=; b=G08Wa1
	XFq1WoQDsOtpfH88gCqtVHc6mXrc8euFEGgV1CpRdtV4rHlHH71YEPgNP+EPz5Tz
	JPqw6ncukAr3ehz2AMattVJJcwtp/tGLT8OzHATOdDEO0FF1PivyqV3zYlgqggFT
	FAuW7bcyr4HO5y8jwYPzSyJU7+pZrmZV0Of/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AKLLyTKPR13Us2riAeDkCoDjd6T7AxwM
	/nD3xZOVYXXIWMY3JaNEnW73wg1ujj17Yfn4nMZR1HhK64Ubc0MBAXE9/+eywzY0
	a2avVu0du8c41nBEHH/i9hZ0lGKdhK17V75o41as45mPoJIJbuHzDkX4J0xkfY3B
	FcnQOkANHJA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 10B4551EF;
	Mon, 23 May 2011 16:01:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C109651E3; Mon, 23 May 2011
 16:01:44 -0400 (EDT)
In-Reply-To: <1306058229-93800-3-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Sun, 22 May 2011 02:57:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7F066770-8577-11E0-9A00-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174263>

David Aguilar <davvid@gmail.com> writes:

> +resolve_git_prefix() {
> +	# If GIT_PREFIX is empty then we cannot use it in tools
> +	# that expect to be able to chdir() to its value.
> +	if test -z "$GIT_PREFIX"; then
> +		GIT_PREFIX=.
> +		export GIT_PREFIX
> +	fi
> +}

Does this "export" have to be conditional?  Otherwise, it would be simpler
to do this upfront at the beginning:

    : GIT_PREFIX=${GIT_PREFIX:-.}

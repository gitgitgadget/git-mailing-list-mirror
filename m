From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Failure to extra stable@vger.kernel.org addresses
Date: Mon, 19 Nov 2012 11:27:45 -0800
Message-ID: <7vk3thxuj2.fsf@alter.siamese.dyndns.org>
References: <20121119095747.GA13552@arwen.pp.htv.fi>
 <20121119151845.GA29678@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Balbi <balbi@ti.com>, git@vger.kernel.org,
	Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Mon Nov 19 20:28:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaX0l-00046s-Mo
	for gcvg-git-2@plane.gmane.org; Mon, 19 Nov 2012 20:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754320Ab2KST1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 14:27:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44676 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754206Ab2KST1s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 14:27:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E95339FF8;
	Mon, 19 Nov 2012 14:27:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4QKGRhSDLQfhrW9zNeas65R5xaE=; b=fu7xft
	Bno5ei1J6VOM/TETNTb+unpzWPlNw2UwqAzGOO73a8DE83TgK6wgskYa4daPvrNx
	vfYX5bLB0fq7Ndtgg+I+W0daBw+Hn96/LE3NZdlbdQB9JLtSptA3qPlWr1V5A5fe
	PNurFCMki72JINHw9QlDojJZ3nCYSiAcI9yHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bqqydPW+0l0uP+VJ/GzndigBAjZWaGk4
	CgL9nqoEu1FqklAt7aHqvULWYHLapRhyHytmLkbYduHqMCE9v1VHfNoL8hgC1gRE
	rdaBn8Z6ipeQGloOPpg+b4VegCeEcdD5WMh5hELO/zrqEiVX+z6MsmKKJ5W6aRG/
	A29aPQHNyBU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D67C99FF7;
	Mon, 19 Nov 2012 14:27:47 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3BA3B9FF3; Mon, 19 Nov 2012
 14:27:47 -0500 (EST)
In-Reply-To: <20121119151845.GA29678@shrek.podlesie.net> (Krzysztof Mazur's
 message of "Mon, 19 Nov 2012 16:18:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3301DD6C-327F-11E2-B7A9-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210049>

Krzysztof Mazur <krzysiek@podlesie.net> writes:

> On Mon, Nov 19, 2012 at 11:57:47AM +0200, Felipe Balbi wrote:
>> Hi guys,
>> 
>> for whatever reason my git has started acting up with
>> stable@vger.kernel.org addresses. It doesn't manage to extract a valid
>> adress from the string:
>> 
>>  Cc: <stable@vger.kernel.org> # v3.4 v3.5 v3.6
>> 
>> Removing the comment at the end of the line makes things work again. I
>> do remember, however, seeing this working since few weeks back I sent a
>> mail to stable (in fact the same one I'm using to test), so this could
>> be related to some perl updates, who knows ?!?
>
> You probably just installed Email::Valid package.
>
> The current git-send-email works a little better and just prints an error:
>
> W: unable to extract a valid address from: <stable@vger.kernel.org> #v3.4 v3.5 v3.6
>
>
> This patch should fix the problem, now after <email> any garbage is
> removed while extracting address.
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 5a7c29d..bb659da 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -828,7 +828,7 @@ sub extract_valid_address {
>  	# check for a local address:
>  	return $address if ($address =~ /^($local_part_regexp)$/);
>  
> -	$address =~ s/^\s*<(.*)>\s*$/$1/;
> +	$address =~ s/^\s*<(.*)>.*$/$1/;
>  	if ($have_email_valid) {
>  		return scalar Email::Valid->address($address);
>  	} else {

Given that the problematic line

	Stable Kernel Maintainance Track <stable@vger.kernel.org> # vX.Y

is not even a valid e-mail address, doesn't this new logic belong to
sanitize_address() conceptually?

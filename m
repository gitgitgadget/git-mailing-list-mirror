From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: automatic envelope sender
Date: Thu, 26 Nov 2009 18:34:31 -0800
Message-ID: <7vfx80zoeg.fsf@alter.siamese.dyndns.org>
References: <1259262269-23937-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 03:34:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDqfV-0003by-53
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 03:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbZK0Cec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 21:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753617AbZK0Cec
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 21:34:32 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60998 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbZK0Ceb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 21:34:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E5DE83103;
	Thu, 26 Nov 2009 21:34:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=96ueHiGnuydW3eHqiE7NJAe7WDE=; b=RNt7V5
	1OXGH2wmieodaH3KYjcuOMlCSrfzIEt7RFgoiMDKLhWIzaMhJT+y5FQrEg7Gnbvv
	LAK2AZzewUYF1aQ4eidSQxTrUPlds6uNZJHmAaHdVr10dWOd65hkcjzmK14ORFi9
	vKOgHhppuwsX/JgUbyjkuZ/BFFO1QTB2p2k2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D7TiJNzlf4buyMWD7EgRSeueq09aPtTc
	WZC+IZK8gr/tz85rzdWlmhcmPdE0t8UPU9l4x+ezD2Q7Cmp5WmzEZhjpU9tlSbRY
	S/ANiuJJ7r3qtfucTsk5vZf4Air6kaGu0G3T6q5pdRXE9Lt72eV8eZFQYvh6SR0j
	NxdvcqUUF+g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CD8483102;
	Thu, 26 Nov 2009 21:34:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85CF483101; Thu, 26 Nov
 2009 21:34:32 -0500 (EST)
In-Reply-To: <1259262269-23937-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Thu\, 26 Nov 2009 21\:04\:29 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 66BBC8F2-DAFD-11DE-802F-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133852>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> diff --git a/git-send-email.perl b/git-send-email.perl
> index 4f5da4e..da2e56e 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -862,7 +862,11 @@ X-Mailer: git-send-email $gitversion
>  
>  	my @sendmail_parameters = ('-i', @recipients);
>  	my $raw_from = $sanitized_sender;
> -	$raw_from = $envelope_sender if (defined $envelope_sender);
> +	if (defined $envelope_sender) {
> +		if (not $envelope_sender eq "auto") {
> +			$raw_from = $envelope_sender;
> +		}
> +	}

Thanks.

I'd rewrite this to 

	if (defined $envelope_sender && $envelope_sender ne "auto") {
        	...
	}

but otherwise the patch looks quite straightforward.

Tests?

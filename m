From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] test/send-email: add to-cover test
Date: Thu, 03 Apr 2014 11:44:29 -0700
Message-ID: <xmqq61mqqmlu.fsf@gitster.dls.corp.google.com>
References: <1396548814-27278-1-git-send-email-mst@redhat.com>
	<1396548814-27278-2-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 20:44:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVmcu-0003wD-TB
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 20:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbaDCSod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2014 14:44:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46168 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752812AbaDCSoc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2014 14:44:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C80777AE5D;
	Thu,  3 Apr 2014 14:44:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RGt2c238gydxlAAMfvBixbE2ywY=; b=DOuBiu
	k1Bm0igW3uiJisZ51GZNT05mkOJR6JF8+5RIZHF/lK1STK6F334VV7mxeSSJ7fAm
	PA9oM25WLXl6vRceKWakMtYIDBl3BzBYMTelw3fv9zRLMBJVVb/JPe2a9o3NPZK8
	PZpm8/RPnl1CzqDW2/0048DSGurOMzF3oayBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VX3YgbrdndPFfYqxUI1vue6Q1Nhbk8FG
	KfWgxWaoOER7t66zr6iLpMPNMvI+Bxo3afi5WxPQ2pKh60b3Az0zKd9+D/UzH6DV
	qvzr/w37zMkDDEKafdiZwaF7nUdT866wufpj9BXK1UE+Xcu+MplGnsJjVlgSKaqb
	1eaHRklcF/4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6D6E7AE5C;
	Thu,  3 Apr 2014 14:44:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E19AB7AE5A;
	Thu,  3 Apr 2014 14:44:30 -0400 (EDT)
In-Reply-To: <1396548814-27278-2-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Thu, 3 Apr 2014 21:14:11 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FE0634E4-BB5F-11E3-BB8B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245749>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Does it work? I am not sure.

Then why was it sent here?

> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 3119c8c..3b17884 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -1334,6 +1334,22 @@ test_expect_success $PREREQ '--force sends cover letter template anyway' '
>  	test -n "$(ls msgtxt*)"
>  '
>  
> +test_expect_success $PREREQ 'to-cover adds To to all mail' '
> +	clean_fake_sendmail &&
> +	rm -fr outdir &&
> +	git format-patch --cover-letter -2 -o outdir &&
> +	git send-email \
> +	  --force \
> +	  --from="Example <nobody@example.com>" \
> +	  --to=nobody@example.com \
> +	  --smtp-server="$(pwd)/fake.sendmail" \
> +	  outdir/0002-*.patch \
> +	  outdir/0000-*.patch \
> +	  outdir/0001-*.patch \
> +	  2>errors >out &&
> +	! grep "SUBJECT HERE" errors &&
> +	test -n "$(ls msgtxt*)"
> +'

Is this a copy of an existing "--force can disable the safety to
catch a mistake to send a cover letter template without any update"?

How are you checking if you are propagating to/cc from the cover to
other messages with this test?

Puzzled.

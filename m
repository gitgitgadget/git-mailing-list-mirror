From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] t9810: Do not use sed -i
Date: Tue, 01 Jan 2013 14:12:40 -0800
Message-ID: <7v38yk8sdj.fsf@alter.siamese.dyndns.org>
References: <201301012240.37769.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pw@padd.com
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 01 23:13:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqA51-0007RC-A8
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 23:13:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467Ab3AAWMo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jan 2013 17:12:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63024 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752448Ab3AAWMn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jan 2013 17:12:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D9AAA2F5;
	Tue,  1 Jan 2013 17:12:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cIsjmGffYddP
	/fhOVjr92X4LFE4=; b=nADNYoLt3m319sjK/NEH0YdOUijflgeFne91z4PN8oBW
	JmF9N3bd8IEf9PggFYuWsxEE6G+syL9ZfXJiNsdKzmMGkdfOsxooE8du4idTpLTH
	DUhqOX+o58ZsLCMZ3+B9UtzyszYynnhBI2VIVrWBgqF3kx7xnAdoQrMPCLxJm3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LXMNtg
	CXj55WSJuhImNbNSA30cnZcZeaX7+6px/7+jEQw29zAOei+nk2VYIPwXVCWpNGrF
	UwRQKRyBm16cjS6RLNfAIUhRJ/cr3KCRkFKDVSTd+vX1Rbka9pJdj+hceigEQpHJ
	qsoppMIGnHmUoYwIsi/mnH/XZK/kZPO8Xlvw0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8ECCBA2F4;
	Tue,  1 Jan 2013 17:12:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA01BA2F3; Tue,  1 Jan 2013
 17:12:41 -0500 (EST)
In-Reply-To: <201301012240.37769.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?= message of "Tue, 1 Jan 2013 22:40:37
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5C7060BC-5460-11E2-B4A6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212459>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> sed -i is not portable on all systems.
> Use sed with different input and output files.
> Utilize a tmp file whenever needed
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  t/t9810-git-p4-rcs.sh | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
> index 0c2fc3e..5bf9291 100755
> --- a/t/t9810-git-p4-rcs.sh
> +++ b/t/t9810-git-p4-rcs.sh
> @@ -26,10 +26,8 @@ test_expect_success 'init depot' '
>  		line7
>  		line8
>  		EOF
> -		cp filek fileko &&
> -		sed -i "s/Revision/Revision: do not scrub me/" fileko
> -		cp fileko file_text &&
> -		sed -i "s/Id/Id: do not scrub me/" file_text
> +		sed <filek "s/Revision/Revision: do not scrub me/" >fileko
> +		sed <fileko "s/Id/Id: do not scrub me/" >file_text

Making it shorter and more correct ;-), which is good, but you are
losing the && chaining.  Also it is more customary to have
redirection at the end, unless it is to redirect a numbered file
descriptor (e.g. "echo >&2 error message").  I.e.

	sed "s/Revision/Revision: do not scrub me/" <filek >fileko &&
	sed "s/Id/Id: do not scrub me/" <fileko >file_text

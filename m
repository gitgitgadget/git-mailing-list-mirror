From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Add a command "fix" to rebase --interactive.
Date: Fri, 04 Dec 2009 09:40:22 -0800
Message-ID: <7v638mskmx.fsf@alter.siamese.dyndns.org>
References: <cover.1259934977.git.mhagger@alum.mit.edu>
 <6d779d2c244bf5d5b7924cdc5daf66a8186e4bc7.1259934977.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 04 18:40:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGc8y-0006zR-QJ
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 18:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbZLDRk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 12:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbZLDRkZ
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 12:40:25 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39999 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932251AbZLDRkY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 12:40:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 14524A4869;
	Fri,  4 Dec 2009 12:40:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SiiL6F/3oRex1rXEShqexxd4S6c=; b=RgZEkD
	w9EW30wGsixNAgDUSjXaD27/yz6w0KLA1+FduW1IT84cC0M3ZrS3f9Uxllp0TBQA
	Qe71xwcoebXjo3SajOseLXZdv5yCpseQvo5LGdO6ZJ7/cMaY5Qj4oOy1dfruG8Xn
	AO0P1ClMyq7jPMq68U5tdPJN/S760kzx80UcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WMpRK8/TpH5ewDFZJzFmsjazMBdSQCdo
	d/W98LfX1C4gq4zpBYzbOcKzck44wOipb7zprEsM450lfg7h0xChUEo0oxlXo5Au
	eL9pOi9ViJIArYNt5pecoI8hBZ5aImUTn//HQpEZIkRsc8bN9DaqP5cu+5qilu/o
	k/nUXAAb0GQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D76F9A4868;
	Fri,  4 Dec 2009 12:40:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 96342A4862; Fri,  4 Dec 2009
 12:40:23 -0500 (EST)
In-Reply-To: <6d779d2c244bf5d5b7924cdc5daf66a8186e4bc7.1259934977.git.mhagger@alum.mit.edu> (Michael Haggerty's message of "Fri\,  4 Dec 2009 15\:36\:30 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1C453ED4-E0FC-11DE-BDE4-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134553>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 0bd3bf7..539413d 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -302,7 +302,7 @@ nth_string () {
>  
>  make_squash_message () {
>  	if test -f "$SQUASH_MSG"; then
> -		COUNT=$(($(sed -n "s/^# This is [^0-9]*\([1-9][0-9]*\).*/\1/p" \
> +		COUNT=$(($(sed -n "s/^# Th[^0-9]*\([1-9][0-9]*\)\(th\|st\|nd\|rd\) commit message.*:/\1/p" \
>  			< "$SQUASH_MSG" | sed -ne '$p')+1))

This sed replacement worries me.  I don't have a time to check myself
today but do we use \(this\|or\|that\) alternates with our sed script
already elsewhere in the codebase (test scripts do not count)?

Otherwise this may suddenly be breaking a platform that has an
implementation of sed that may be substandard but so far has been
sufficient to work with git.

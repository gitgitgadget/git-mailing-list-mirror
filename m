From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: Provide an empty file when no base exists
Date: Thu, 19 Jan 2012 23:22:23 -0800
Message-ID: <7v7h0mhm8g.fsf@alter.siamese.dyndns.org>
References: <7vhazqhn8u.fsf@alter.siamese.dyndns.org>
 <1327043453-80965-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, jcwenger@gmail.com, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 08:22:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ro8nu-0002lY-56
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 08:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961Ab2ATHW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 02:22:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49855 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353Ab2ATHWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 02:22:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CB972810;
	Fri, 20 Jan 2012 02:22:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=31cNFhgcE3XtStUXwNKOkPUQXK0=; b=rP4FBK
	8ucQ6dXn8x0CuwUuGaGRqytMxssapfSlMlptoSPSBT7g8dtN7pL976YlGv4rOm7D
	zdYEGbyCXBSBnl1VNnldaw7Y2xOqibpwuLly/SSLW4dc/S4L0leZwJCjzjTyAdxj
	JNrDaDOxALlffUvo1MhlSxnjmUFeGuLA2+yI8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oycy0jlPpvptld8DINp+glSxE4GYtPCP
	6kvi7TPgD7nDOJfpcHWQeuT767zMkJaFuFh4kp+k5bs7Qo9VRMhRhi7QzOAWGd7l
	9sTRWQJejpJt7qGfqIR78AhzO042DpzEYtvxlassjrCoX/ERwHPbaARMaB+NRkMt
	b/20GtO4tXY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 144E6280F;
	Fri, 20 Jan 2012 02:22:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 876E5280C; Fri, 20 Jan 2012
 02:22:24 -0500 (EST)
In-Reply-To: <1327043453-80965-1-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Thu, 19 Jan 2012 23:10:53 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7FE2D6FA-4337-11E1-978D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188861>

David Aguilar <davvid@gmail.com> writes:

> +    if base_present; then
> +	checkout_staged_file 1 "$MERGED" "$BASE"
> +    else
> +	:>"$BASE"

Just a style, but please write this as either one of the following:

	>"$BASE"
        : >"$BASE"

I tend to prefer the former, but if you have to write a command, we want
to see a SP before the redirection (and no SP before the redirect target).

> +    fi
>      local_present  && checkout_staged_file 2 "$MERGED" "$LOCAL"
>      remote_present && checkout_staged_file 3 "$MERGED" "$REMOTE"

Sorry to be ping-pong-ing like this, but wouldn't we have a similar issue
when LOCAL or REMOTE does not exist (e.g. "they modified, we removed")?

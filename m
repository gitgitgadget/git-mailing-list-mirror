From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: prevent a segv when -L given start > EOF
Date: Mon, 08 Feb 2010 19:55:49 -0800
Message-ID: <7vtytrrrju.fsf@alter.siamese.dyndns.org>
References: <1265687293-11168-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 04:56:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NehCm-00058P-8w
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 04:56:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742Ab0BIDz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 22:55:58 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39728 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447Ab0BIDz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 22:55:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A2289605A;
	Mon,  8 Feb 2010 22:55:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WtUp9ERo3B6GGYZfwBBv7EnqplI=; b=ff+NCs
	zLUgdnMwKvXMA14prHfAZcgFpsU6w52E52aRnNVmBiTPJiCgbAIuqHo8+JiwqQaB
	tdA9w2Sg2wkU/FCG+QtXrQrvqShoI8V7pXy+ySLtU/wlXY+IfWzh1pEUKyeFLYtn
	cNhlgS7ylwwmUkB/aqXq2wV/aRCyhbVnQPvNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yNfYCfyC5rm7Izu79nxqAtZdixEPQJnb
	gAdM84ytEzhtpdV0ye1FAV1TbTiH8OirtSPy26AZ02imYFxskImAch+5o+zWTUH/
	8PJ+wPNVhtskk8l8xRLnRWc8dY/yUMxYG62VTEdFwrr/4epuZumJwJsW47qtGeiZ
	oEPc2J39dEM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EC2A396059;
	Mon,  8 Feb 2010 22:55:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52DC896057; Mon,  8 Feb
 2010 22:55:51 -0500 (EST)
In-Reply-To: <1265687293-11168-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Mon\,  8 Feb 2010 22\:48\:13 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 05349E44-152F-11DF-A6A2-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139357>

Jay Soffian <jaysoffian@gmail.com> writes:

> -	if (lno < top)
> +	if (lno < top || lno < bottom)
>  		die("file %s has only %lu lines", path, lno);

Thanks; I think we make sure that "bottom < top" always hold true before
we reach this point, so checking with bottom alone should suffice, no?

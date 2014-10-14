From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [kernel] completion: silence "fatal: Not a git repository" error
Date: Tue, 14 Oct 2014 11:29:41 -0700
Message-ID: <xmqqfveqzeqy.fsf@gitster.dls.corp.google.com>
References: <1413283785-505-1-git-send-email-john@szakmeister.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Tue Oct 14 20:29:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xe6r0-0006jU-Kt
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 20:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755392AbaJNS3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 14:29:46 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59076 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755357AbaJNS3p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 14:29:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E809F15F1F;
	Tue, 14 Oct 2014 14:29:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g6zoNodgCpC2jEKg3wc4c+2R7tw=; b=qfDYYr
	4784scAxb1+d8yEbtCjYs/qr/q+z5OVPEjmU3dq8M1l5m/BOXXBygxk4GsE4NMFQ
	Gw8VN9vC90xUrxbXqRekywJFmYRNuUatHuRBR5IdIqJ7jyYHzgV8qR3lYK4DBjYT
	ZhpVbQtKsubpuzmR8ZeRm/IUHWW2cJL6bazGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U3Rxn33m/K7ko1RnX63S78ruA9x2eqUb
	/44/l4J+8ZPecpPQ61RNCMTxutJel7/fOmkDdkLKIGuVG3w1dTE585LUXLobq5Pl
	K6fbwdJrgI79wLpQttt9oh6Zf+hoCK08IobAeB+hvzag4S85xaLxuoNyuR5Bm7X9
	XqzMnD99rj8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DE98E15F1D;
	Tue, 14 Oct 2014 14:29:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 61F4F15F1C;
	Tue, 14 Oct 2014 14:29:43 -0400 (EDT)
In-Reply-To: <1413283785-505-1-git-send-email-john@szakmeister.net> (John
	Szakmeister's message of "Tue, 14 Oct 2014 06:49:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 11280D46-53D0-11E4-8824-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Szakmeister <john@szakmeister.net> writes:

> It is possible that a user is trying to run a git command and fail to realize
> that they are not in a git repository or working tree.  When trying to complete
> an operation, __git_refs would fall to a degenerate case and attempt to use
> "git for-each-ref", which would emit the error.
>
> Let's fix this by shunting the error message coming from "git for-each-ref".

Hmph, do you mean this one?

    $ cd /var/tmp ;# not a git repository
    $ git checkout <TAB>

->

    $ git checkout fatal: Not a git repository (or any of the parent directories): .git
    HEAD 

I agree it is ugly, but would it be an improvement for the end user,
who did not realize that she was not in a directory where "git checkout"
makes sense, not to tell her that she is not in a git repository in
some way?

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Avoid file descriptor exhaustion in ref_transaction_commit()
Date: Fri, 24 Apr 2015 21:28:39 -0700
Message-ID: <xmqqvbgk25mw.fsf@gitster.dls.corp.google.com>
References: <1429875349-29736-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Apr 25 06:28:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ylrhv-0003mN-7w
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 06:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbbDYE2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2015 00:28:42 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50732 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750840AbbDYE2l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2015 00:28:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 02E744CD10;
	Sat, 25 Apr 2015 00:28:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4UK6f6pQSCfs0DAWWX/Kr2EutSY=; b=Z1I4nF
	1AlDcpL/er0HCC53tQfU6C+x8HsM2hXGIHZJo+FDOquUKpt4lUAvnfVnsACQEPuW
	IZXuDgM135WzxB+ywKPG1X38zp3AHcbzNDTOwgw0HAQrwqIJNF/UUQBc+g3nbwr8
	uzRQefT98KpexXXkVkOQ6wellyHVAjSzPA/dA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rLpxwRF/7bTD1TbXz53vN36m7u/IrbQ5
	7UbczZ07mbx91H3PV3FHB0VUMf0idNyyPHJgaj4r5S069uTMJXL4pI8jKBVg2nJW
	1L38uWk9YDDywiwEo3xUkt5UjCsvu6UthbjFGXp8UsdKV67FVJa/o7XE8xfHHAFO
	GwMs1RAxvzE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F01D74CD0F;
	Sat, 25 Apr 2015 00:28:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 774954CD0E;
	Sat, 25 Apr 2015 00:28:40 -0400 (EDT)
In-Reply-To: <1429875349-29736-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Fri, 24 Apr 2015 13:35:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8CA5950E-EB03-11E4-ABC0-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267769>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> In ref_transaction_commit(), close the reference lockfiles immediately
> to avoid keeping too many file descriptors open at a time. This is
> pretty easy, because in the first loop (where we create the locks) we
> already know what, if anything, has to be written into the lockfile.

Nicely analysed and beautifully executed.  I like it.

> This patch series applies on top of Stefan's
>
>     c1f0ca9 refs.c: remove lock_fd from struct ref_lock (2015-04-16)
>
> and it fixes two tests that Stefan introduced earlier in that series.

Thanks.

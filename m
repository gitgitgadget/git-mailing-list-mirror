From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] ignore unknown color configuration
Date: Sat, 12 Dec 2009 13:45:45 -0800
Message-ID: <7vzl5nn9x2.fsf@alter.siamese.dyndns.org>
References: <20091212122524.GA17547@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 13 02:29:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJdHL-0005Q8-JJ
	for gcvg-git-2@lo.gmane.org; Sun, 13 Dec 2009 02:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933404AbZLMB2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2009 20:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933427AbZLMB2n
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Dec 2009 20:28:43 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46425 "HELO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933404AbZLMB2l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2009 20:28:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5418CA629C;
	Sat, 12 Dec 2009 16:45:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=dshc3M4q1jT/8TqItY2MzwHk96s=; b=awUUhVLMwJ0T/3xzYJqjmbJ
	k70wnghXENpkRet5y+7H7Ay0aifeO38dWLCQyZV78RiN0DeTfzKGx+3MwJqXZfjF
	xvoJvkDPcG5IdwJ/9nXGawNlmrzDoG4gH7lvtvX1FtcYLcErcPZ9JH0S7AEbMl00
	HAaULZWzHBf3w+GbFIVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=mr5pAbFP/V5S3hQr8QVtz8Baa5MtjZMvlqewXqpKo+5z/DGyw
	jmjNNlOmshrh+DRarXJOTA/FDjSUzh4C0ibaoH2d1CRqvnMzXI45bHiWSQGIidpS
	3ZhVrpD0dKnA+trZMt/YJ8Rd5oO0NGJ0aNB0nzFgCVZaBPSPtMRCOK+0CI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 32A5DA629B;
	Sat, 12 Dec 2009 16:45:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0DDD5A629A; Sat, 12 Dec 2009
 16:45:46 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B6AFDAEE-E767-11DE-B781-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135141>

Jeff King <peff@peff.net> writes:

> When parsing the config file, if there is a value that is
> syntactically correct but unused, we generally ignore it.
> This lets non-core porcelains store arbitrary information in
> the config file, and it means that configuration files can
> be shared between new and old versions of git (the old
> versions might simply ignore certain configuration).
>
> The one exception to this is color configuration; if we
> encounter a color.{diff,branch,status}.$slot variable, we
> die if it is not one of the recognized slots (presumably as
> a safety valve for user misconfiguration).

This reminds me of the issue an earlier patch with a good intention but a
horrible consequence wanted to address.

  http://thread.gmane.org/gmane.comp.version-control.git/125925/focus=127629

> This patch loosens the check to match the rest of
> git-config; unknown color slots are simply ignored.

I am of two minds, even though I am slightly in favor than against the
change.

This is a sane thing to do, as "slot" is part of the name of the variable,
and we generally do not warn upon seeing a misspelled variable name (it
makes it worse that "func" is not even misspelled but merely unknown to
older version of git in your scenario).

On the other hand, I suspect that most people would apprecfiate if their
git pointed out "diff.color.finc?  What do you mean?"  before they waste
30 minutes wondering why the new feature in 1.6.6 does not work for them.

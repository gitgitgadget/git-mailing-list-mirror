From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: turn on network daemon tests by default
Date: Wed, 12 Feb 2014 11:06:43 -0800
Message-ID: <xmqq61oknoak.fsf@gitster.dls.corp.google.com>
References: <20140210191521.GA3112@sigill.intra.peff.net>
	<20140210212931.GA16154@sigill.intra.peff.net>
	<xmqqa9dxpgw9.fsf@gitster.dls.corp.google.com>
	<20140211200445.GA27946@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 12 20:06:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDf93-0007Ft-CI
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 20:06:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769AbaBLTGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 14:06:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36650 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752204AbaBLTGs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 14:06:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5D026B599;
	Wed, 12 Feb 2014 14:06:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zG0KD689ONFvagWpeQ5rGss37Ls=; b=rRtnXC
	JeiIMZjCrvZt4RHbWEOgeTl3xczW6h2r9IGh0+vmSUTgQs+xXfyOT2CamnNnWhN2
	w9tGubpYoJZdzDYvAIPB6h9Zl/1dtYAmh6kXWc0xnldO5SSwR9l6ONjX42cUCTdM
	4MsTh8tZbGMaYNHovBaHEwy5ut4p77Lbc14Rc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NXVggsmBwjDiMMqDRUHLcE+UF6uv5Kl8
	/dQHxc0b+AeflsbICboZ4Y/DblolGOQYHmZpH7j6eTTGR56WTUuBYsR8mnT6Xbjk
	cjP2itIrfqPeenS/Tk8TXHGg0/6GK8wUt0aorF3xUKCEQhXPdoZ0bzhlCLKtM44g
	RpJRjOXF958=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F65D6B596;
	Wed, 12 Feb 2014 14:06:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CAA4C6B594;
	Wed, 12 Feb 2014 14:06:46 -0500 (EST)
In-Reply-To: <20140211200445.GA27946@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 11 Feb 2014 15:04:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D1A16A5E-9418-11E3-B3FF-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242013>

Jeff King <peff@peff.net> writes:

> Agreed, but I think the only way to know the size of those fallouts is
> to try it and see who complains.  I would not normally be so cavalier
> with git itself, but I think for the test infrastructure, we have a
> small, tech-savvy audience that can help us iterate on it without too
> much pain.

There is another.

$ GIT_TEST_HTTPD=false sh t5537-fetch-shallow.sh 
ok 1 - setup
ok 2 - setup shallow clone
ok 3 - clone from shallow clone
ok 4 - fetch from shallow clone
ok 5 - fetch --depth from shallow clone
ok 6 - fetch --unshallow from shallow clone
ok 7 - fetch something upstream has but hidden by clients shallow boundaries
ok 8 - fetch that requires changes in .git/shallow is filtered
ok 9 - fetch --update-shallow
error: Can't use skip_all after running some tests

Under 'prove' test target, the way it exits causes:

*** prove ***
t5537-fetch-shallow.sh .. Dubious, test returned 1 (wstat 256, 0x100)
All 9 subtests passed

which leads to:

Test Summary Report
-------------------
t5537-fetch-shallow.sh (Wstat: 256 Tests: 9 Failed: 0)
  Non-zero exit status: 1
  Parse errors: No plan found in TAP output


On the 'master' branch without these "auto opt-in" patches,

$ GIT_TEST_HTTPD= sh t5537-fetch-shallow.sh 
ok 1 - setup
ok 2 - setup shallow clone
ok 3 - clone from shallow clone
ok 4 - fetch from shallow clone
ok 5 - fetch --depth from shallow clone
ok 6 - fetch --unshallow from shallow clone
ok 7 - fetch something upstream has but hidden by clients shallow boundaries
ok 8 - fetch that requires changes in .git/shallow is filtered
ok 9 - fetch --update-shallow
skipping remaining tests, git built without http support
# passed all 9 test(s)
1..9

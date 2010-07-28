From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] checkout, commit: remove confusing assignments to
 rev.abbrev
Date: Wed, 28 Jul 2010 10:23:03 -0700
Message-ID: <7vhbjj5xmw.fsf@alter.siamese.dyndns.org>
References: <19531.65276.394443.190317@winooski.ccs.neu.edu>
 <20100725130935.GA22083@LK-Perkele-V2.elisa-laajakaista.fi>
 <20100725221539.GA21813@burratino> <7vbp9uaii2.fsf@alter.siamese.dyndns.org>
 <20100726190448.GA32367@burratino> <7vzkxc7rpn.fsf@alter.siamese.dyndns.org>
 <20100727182942.GB5578@burratino> <20100727183706.GD5578@burratino>
 <1280261936.4462.6.camel@walleee> <20100727210908.GA11317@burratino>
 <1280311304.2378.64.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 19:23:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeALn-0002jS-6D
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 19:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591Ab0G1RXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 13:23:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43567 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755296Ab0G1RXT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 13:23:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A2ED9C8C2A;
	Wed, 28 Jul 2010 13:23:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=i46knOUC7J9gCIv4644AINs7If0=; b=AGzrf6T5d1d9fOvel2Ph9hy
	eH2jCmOxjEybBWuntaTHXSsgBxDji2jFwpyMUCyM6On7mfshal/BuL7nbmXV/17N
	f+SkOJzCf0j268+W+qmEfJUPj5q5YxY2lqpwItHwFsNscv4hCoLINYvd5fSop3U3
	3n3m5D4rJFILCOdV+OOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=uilVu5SgdBYjBIb4f5x/BSrOckdhlHCQUZny3uFd7BjpNBt6x
	N/EgGO0rOex2i+NmGJ7OeVlt8yD1Z2iIpn2jmaffjRt+1c3cnquEwvQZTGaK+eoG
	/tWPIhqOsbmGXEwIqAY6n4nLTaZwfIk+/6sQ7fEz/okSfyZlfrm+pe3MPY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A959C8C27;
	Wed, 28 Jul 2010 13:23:12 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2BD62C8C26; Wed, 28 Jul
 2010 13:23:05 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CC83F586-9A6C-11DF-BF5C-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152104>

Will Palmer <wmpalmer@gmail.com> writes:

> Here's what I propose:
>  - #define NO_ABBREV 40
>  - replace all instances of revs->abbrev = 40 and revs->abbrev = 0 with
> revs->abbrev = NO_ABBREV
>
> That will at least make it explicit and consistent.

That is a good idea.  I think abbrev == 0 in the early days used to mean
"use the compiled-in default, whatever it is" but somehow some codepaths
mistakenly used it to mean "please do not abbreviate" (my fault).

> ... And an
> undefined value should (I think obviously) be interpreted as
> DEFAULT_ABBREV, since that's what the word "DEFAULT" actually comes
> from.

We would probably need to be a bit careful here.  By default plumbing
commands do not abbreviate, while we do want the default abbreviation
in our Porcelains.

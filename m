From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] fetch-pack: match refs exactly
Date: Thu, 15 Dec 2011 13:46:22 -0800
Message-ID: <7vaa6tmrtd.fsf@alter.siamese.dyndns.org>
References: <20111213003925.GA28403@sigill.intra.peff.net>
 <20111213004808.GC3699@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kevin Sawicki <kevin@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 15 22:46:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbJ8I-00011n-I2
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 22:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759527Ab1LOVq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 16:46:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44951 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754146Ab1LOVqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 16:46:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C803674E;
	Thu, 15 Dec 2011 16:46:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=scs5DqGZH+HrZqg1OfCW51hEHnU=; b=DKmp33B78XYgBPGVBeDv
	S3iSizP5FguANYn/G/dN98ndAkApIktTiQz6+E/I/5pR+TXqYWOIY6D7tDdOBlQ7
	xFkqsQozXp/eeSeLRaxBsxmUThS5ATmaVR3CsStsF1KM8dS/82eEja0ow8AOYkuS
	ZqoXb56TCm3oxRItCHl4Rio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Q8tKi7Wdl17Hd/xKvmvSsyngHLP43JXdSWKdLw7FVZRccD
	KCxJsxMy+orrEDqmQzk6j9dcYsL5vIb4JNrAyNCxDAj3ehms4cAKuMWxVkG32D7Y
	zMducwFdmDRgwgVRQ1o303jbmFjDB8XlhaDXpxRq4C5I6SBPgu3wraduV7TzY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 241F6674D;
	Thu, 15 Dec 2011 16:46:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40D25674C; Thu, 15 Dec 2011
 16:46:24 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3BE3F7AA-2766-11E1-916E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187242>

Jeff King <peff@peff.net> writes:

> This is obviously the one that can break existing fetch-pack users. I
> doubt they exist. If they do, there are a few alternatives:
>
>   1. Come up with some more sane rules for path_match (e.g., try full
>      strings first, use full-string matching for things starting with
>      "refs/", etc).
>
>   2. Leave the matching in-place for git-fetch-pack, but use exact
>      matching for internal users that will always provide qualified refs
>      (i.e., "git fetch").

I think the latter is the sane thing to do _if_ this becomes an issue, and
as you mention, it is in line with what "git fetch" wrapper already
does.

Given that fetch-pack was meant to be driven by "git fetch" wrapper that
turns the command line and other refspecs into full refnames on the remote
end before calling it, and also as you mentionied that it is clearly
documented as "relative to $GIT_DIR", I do not think we should support the
tail-match semantics at all in the first place.

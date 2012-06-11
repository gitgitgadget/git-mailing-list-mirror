From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Mon, 11 Jun 2012 08:40:57 -0700
Message-ID: <7vd35597qu.fsf@alter.siamese.dyndns.org>
References: <E1SdhJ9-0006B1-6p@tytso-glaptop.cam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 11 17:42:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se6jw-0003o1-HG
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 17:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755871Ab2FKPlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 11:41:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56158 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755710Ab2FKPlA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 11:41:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96BDB947C;
	Mon, 11 Jun 2012 11:40:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+wcW/42t6vh5M/k947sTDudIpTw=; b=MdJMud
	jKCENt44nvvyCGCTVKFA5kGIV2+H1tKl/YpStGRkAn1Gh/FoCcIRGvfiyNrAvSo9
	F7IC5+DRlB6T8hsHju+r/VM51aRjMMGs4DWBzYQ65oZOKXerLPdCw5sbQBQKnnI7
	dTaRbAANLwcYeIoo+ZjG2Yq4b1XBhRWX6fRcU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CK5uzVSmr/rUsNPnYF03xge5ofTaxIiG
	1RdHNzKMdzaN8l73sLlIn3JGN9lJWJcx44FQkzYOQPfo+Qd2CbcHWfR6NMJQoGXZ
	sR0kcpvYr8Adwf2AFsjnuRizvVJXgxTIev3TLmXHyZrzHYIu635ha2bzE+9n0PZd
	JXfQyaV3t6Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E1FB947B;
	Mon, 11 Jun 2012 11:40:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2630B947A; Mon, 11 Jun 2012
 11:40:59 -0400 (EDT)
In-Reply-To: <E1SdhJ9-0006B1-6p@tytso-glaptop.cam.corp.google.com> (Theodore
 Ts'o's message of "Sun, 10 Jun 2012 08:31:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D772E3F0-B3DB-11E1-908E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199664>

"Theodore Ts'o" <tytso@mit.edu> writes:

> Which got me thinking.... the whole point of leaving the objects loose
> is to make it easier to expire them, right?   But given how expensive it
> is to have loose objects lying around, why not:
>
> a)  Have git-pack-objects have an option which writes the unreachable
>     objects into a separate pack file, instead of kicking them loose?
>
> b)  Have git-prune delete a pack only if *all* of the objects in the
>     pack meet the expiry deadline?
>
> What would be the downsides of pursueing such a strategy?  Is it worth
> trying to implement as proof-of-concept?

I do not offhand see a downside; as a matter of fact, there has
already been the first-step change in the direction in v1.7.10.2
and newer that avoids exploading the unreachable ones into loose
object if we know they are going to be immediately pruned.

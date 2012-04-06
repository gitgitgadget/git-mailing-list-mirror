From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] argv-array: Add argv_array_pop function [v2]
Date: Thu, 05 Apr 2012 23:55:18 -0700
Message-ID: <7v4nsx2vu1.fsf@alter.siamese.dyndns.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-2-git-send-email-nhorman@tuxdriver.com>
 <7vd37m5458.fsf@alter.siamese.dyndns.org>
 <20120405232429.GA8654@hmsreliant.think-freely.org>
 <7vobr53bbe.fsf@alter.siamese.dyndns.org>
 <20120406022058.GA16264@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neil Horman <nhorman@tuxdriver.com>, git@vger.kernel.org,
	Phil Hord <phil.hord@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 08:55:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG34y-0004NJ-E9
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 08:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889Ab2DFGzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 02:55:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42697 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799Ab2DFGzW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 02:55:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A74BD7393;
	Fri,  6 Apr 2012 02:55:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=bCp//YlovMK4qXjEyAu9ilXHzHQ=; b=ClFA+yU87pbivrJ5Qp0/
	tE/G4KCYSgn9pQAmn1BPEQ1yqRiG17tnnv7+RSm17KVWQMa1Sdf9L76OX/4/xDTF
	O9h371ZPKkHXBc/8nkd+CFJiuAP2mnHNGFUfFMPnSgwjbWDTKZTZQuu7UFNzcit0
	4IhSHsD5QIDx4eYvWt9hjaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=KqVnfzbwR4AvGObnBRFZeH2hbUik0LnsSdi76ZpHUBrK+Y
	/xq1w3EoR4+iCWu6bfGTPD6XTg8HVQXfl3LddwAO94aFstc834NQRg9dd5s+IH6Q
	GrgZQwMhJAAy9CU7D/g4VVHCHm/aqN9jUTzL5Sh905m8taNbIYtRkp8u8abUc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DD437392;
	Fri,  6 Apr 2012 02:55:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1311C7390; Fri,  6 Apr 2012
 02:55:19 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 796E21D4-7FB5-11E1-8F4A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194851>

Jeff King <peff@peff.net> writes:

> So from the maintainer's and the project's perspective, those cc lines
> are useless noise.
> ...
> So it is a piece of information that is useful to the submitter, but not
> to the maintainer.

... nor the user of the project history, as you said earlier.

I agree that submitters would benefit from an automated way to propagate
these addresses from reroll to reroll, and in a larger workflow "tweak and
record while amending a commit for reroll" would be a natural place to do
so, so I can see why it is tempting to abuse Cc: in the body of the
message, but not knowing other ways is not a good excuse for such an
abuse.  A workable solution is already available [*1*]: commit with a
"---" line followed by Cc: and whatever extra junk while amending.

Even if it did not work to write "---" before the extra Cc:, I do not
think it is such a big deal, though.  As the output file from format-patch
is meant to be read into an editor for final proof-reading, it shouldn't
be too much extra burden to move those Cc: at the end of the log message
to the header part of the message while doing so anyway.


[Footnote]

*1* Here is a trivial demonstration.

I amended the 1.7.10-rc4 on a throw-away branch to make "git show -s" show
this:

-- >8 --
commit aaac56582ce1820551d48bf2b2364cb00f0345cb
Author: Junio C Hamano <gitster@pobox.com>
Date:   Tue Apr 3 09:25:49 2012 -0700

    Git 1.7.10-rc4
    
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    ---
    Cc: Test user <junio@pobox.com>
    
    This is a cover letter for small one.
-- 8< --

Feeding output from "git format-patch -1 HEAD" for this patch to send-email
does add the "Test user" to the list of recipients, like so:

-- >8 --
0001-Git-1.7.10-rc4.txt
(body) Adding cc: Test user <junio@pobox.com> from line 'Cc: Test user <junio@pobox.com>'
Dry-OK. Log says:
Sendmail: /usr/bin/msmtp -f gitster@pobox.com -i git@vger.kernel.org junio@pobox.com
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Test user <junio@pobox.com>
Subject: [PATCH] Git 1.7.10-rc4
Date: Thu,  5 Apr 2012 23:47:09 -0700
Message-Id: <1333694829-4295-1-git-send-email-gitster@pobox.com>
X-Mailer: git-send-email 1.7.10.rc4.54.g1d5dd3

Result: OK
-- 8< --

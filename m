From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag: add -i and --introduced modifier for --contains
Date: Thu, 17 Apr 2014 10:05:57 -0700
Message-ID: <xmqq8ur3ga2y.fsf@gitster.dls.corp.google.com>
References: <1397681938-18594-1-git-send-email-mcgrof@do-not-panic.com>
	<xmqqppkhexw3.fsf@gitster.dls.corp.google.com>
	<mvm8ur42zn6.fsf@hawking.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, git@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@suse.com>, Jiri Slaby <jslaby@suse.cz>,
	Jan Kara <jack@suse.cz>
To: Andreas Schwab <schwab@suse.de>
X-From: git-owner@vger.kernel.org Thu Apr 17 19:06:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaplN-0007ZM-NR
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 19:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbaDQRGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 13:06:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62454 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751196AbaDQRGF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 13:06:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79170758AD;
	Thu, 17 Apr 2014 13:06:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=HYgJkDh1zusruca9TqrK2X5IRVo=; b=FQeDZzUGz12zQkW+Jfu0
	LE0SIZB63lgZmXi+4m0CoF/ePaBhZfPQr/olMIlqNSDrcsPvwV3iyw1UUhUnYOA9
	tcxamCAAKVoLM6ST/dbSOjiuPTMS+E1bB6SdbZcmwLWoolMFEb5T58JbiETn5aR9
	mP5rB7AEdMZb4eo582u4dwM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=oPf8H7SHVYOk02XCIlQncEaCiu7yG+tcBcNmZKRC3iTZ5b
	iWMNV5MN0Sv3oweIaadJDz7DVFUd+6TQwZvizyu5nhP4biTcad2o8pWipaE7QZpk
	t+OfPsp2ayPjlDra92F/nqddDOZcAraIFzHtjzFfsjLq30acgmCaAEg/ROr6I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C7C6758AC;
	Thu, 17 Apr 2014 13:06:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6FE8B758A8;
	Thu, 17 Apr 2014 13:05:59 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8C523B10-C652-11E3-BDDE-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246424>

Andreas Schwab <schwab@suse.de> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> And you are right that the commit is contained in v3.4, so we also
>> should be able to describe it as v3.4~479^2~9^2 as well.
>
> IMHO it should be described as v3.4-rc1~192^2~9^2, which is what git
> describe --contains --match=v3.4\* returns.  This path is only a few
> commits longer than v3.5-rc1~120^3~76^2.

Sure. In my response to Luis, I assumed that rc tags are not as
desirable as the final release points for his purpose for whatever
reason, as Luis compared between v3.4 and v3.5-rc1~120^3~76^2, not
with v3.4-rc1 or any later rc.

I also think this illustrates my earlier point. Depending on the
project and the expectation of the users, which tags are good
candidates as anchor points differ.  Your example using --match
probably shows a good direction to go in---somehow tell Git which
tags to base the description on, to reject names that the users do
not want.

When your project does not mind basing the description on rc tags,
between v3.4-rc1~192^2~9^2 and v3.5-rc1~120^3~76^2, I am not sure if
we would want to say that "the former is not so longer than the
latter, so use that", or what kind of heuristics to employ to reach
that conclusion.  Date-based selection (i.e. earliest first) is one
possibility.  Tagname-based selection has the issue of having to
configure "whose version numbering convention would you use when
sorting tags, and how you would tell Git that sorting order rule?"

For a possible cleaner alternative semantics, see the other message
I just sent to the thread.

Thanks.

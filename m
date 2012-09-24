From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: configure submodules
Date: Sun, 23 Sep 2012 22:57:41 -0700
Message-ID: <7vmx0g0xpm.fsf@alter.siamese.dyndns.org>
References: <1348385867-17359-1-git-send-email-orgads@gmail.com>
 <7vr4pt16ep.fsf@alter.siamese.dyndns.org> <505F5151.2080208@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Orgad Shaneh <orgads@gmail.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Sep 24 07:58:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TG1g5-0008LT-J8
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 07:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314Ab2IXF5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 01:57:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38055 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752080Ab2IXF5p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 01:57:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35DF59A91;
	Mon, 24 Sep 2012 01:57:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cmFB/p/qlyhD2tcBnwu4aPPCXIA=; b=hTrnys
	7lf24LBRfGffpXJBuFRJIlVX1AoqKzyZoAKYQW2RevLHYN3sOuvGzrApH0hjKFr0
	mIKVAop2gM5p4p7zD3y+DZbAU+QE7/a+oj9MbDSoJI4g0/BGpC8sCrRSGA3Dsx+L
	NIOsHRPkrkrW2jJPr9wpoY/ax2oiVUjhYGtkk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dIuiLZwqzlGm+Rxjrks2AsOAFaq67GTs
	ybFzhZbNU0v4UI+EbxfPRpN2P3iBiviScYoBNYY3biLI1kYrPg5QixakSvqAI8iM
	iGQmPq8xbDVnhGxaI7I6YrzG9NpQOEjpj957jAGx+UlaxZiRicgTC4Xu6XCd8eWT
	Lpr8281W1mI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2234B9A90;
	Mon, 24 Sep 2012 01:57:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D3FC9A8F; Mon, 24 Sep 2012
 01:57:43 -0400 (EDT)
In-Reply-To: <505F5151.2080208@web.de> (Jens Lehmann's message of "Sun, 23
 Sep 2012 20:13:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C1CAD3FE-060C-11E2-96C8-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206254>

Jens Lehmann <Jens.Lehmann@web.de> writes:

>> Jens, what do you think?  I see no reason for anybody other than
>> "submodule init" to call gitmodules_config() that reads from the
>> in-tree .gitmodules file.
>
> I think the copying on init is not what we should do here because
> it sets the user's customization to what ever happened to be in
> .gitmodules at the time he initialized the submodule.

Hrm, why does the user have submodule.$name.$whatever customized
before saying "submodule init $whategver" for that copying to be
problematic?

> So I think Orgad's change is sane and should go in.

Matching what cmd_commit() does to what cmd_status() does, i.e. grab
submodule.$name.ignore from somewhere, is not something I questioned.
The patch is a good change to make them consistent.

What I was wondering was if that is a consistently wrong thing to do
to read from .gitmodules not $GIT_DIR/config.

In any case, the log message I suggested in the review needs to be
updated in the reroll to make it clear that this is about reading
from .gitmodules, not "configuration".  AFAICS, gitmodule_config()
does not even read from $GIT_DIR/config, right?

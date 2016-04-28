From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config settings
Date: Thu, 28 Apr 2016 15:44:50 -0700
Message-ID: <xmqqwpnh2w0t.fsf@gitster.mtv.corp.google.com>
References: <20160428134953.GB25364@sigill.intra.peff.net>
	<CA+P7+xq-_D2Mszyjd11CyYLiKBBh9A2e1exaZQVmWz1qVKv7ug@mail.gmail.com>
	<20160428153902.GF31063@sigill.intra.peff.net>
	<CAGZ79kZFLTARQ25h4u4SGgNn=Q4TQi-kxFLN3sQvOmejsRmAWA@mail.gmail.com>
	<20160428165031.GA31421@sigill.intra.peff.net>
	<xmqq1t5p5z8v.fsf@gitster.mtv.corp.google.com>
	<20160428191038.GA10574@sigill.intra.peff.net>
	<xmqqwpnh4joq.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYoRP=rkfaL+rLapmvouUdPxXGBr-KWOLhL94bYB1B2-w@mail.gmail.com>
	<xmqqoa8t4il8.fsf@gitster.mtv.corp.google.com>
	<20160428210342.GB12268@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 29 00:45:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avugU-0001iB-19
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 00:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbcD1WpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 18:45:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55511 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752194AbcD1Woy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 18:44:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D3F4917C93;
	Thu, 28 Apr 2016 18:44:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5SVdOhRB+ApZU8rRZvwklmGh2d4=; b=uAZpTj
	bo4Xi0OCO3SCW8hBQw0JpPAdEav3N2xp7gAxBqFirxRGO6xYrIvjadOYll4lsvTc
	+a5XAC+uvlELZOHKPLUzwnoBhsV/9zS/6FPeFgtikBTw35z/FVCkzmI9WeQWJClG
	4RiVNiyfkt9Wd8AABcDyCiIxBYAiLE623qg4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bCk53WVcd0z4gSO1O5hmoXvNECxgNfTF
	6oW655WqTAMtAppvNxeQx7Yt7Z2soJCYd0pxF/R365rMBcJc3a4TJOPdglQJn6Gn
	L8xULpgqltU+cxoj8jQUTipdGc/5LpKspGQ04DNDYVDUSsdMhdRrEBZQ5tEUvWcK
	G/hkxLgWvnQ=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CB43D17C91;
	Thu, 28 Apr 2016 18:44:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3CC2517C8F;
	Thu, 28 Apr 2016 18:44:52 -0400 (EDT)
In-Reply-To: <20160428210342.GB12268@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 28 Apr 2016 17:03:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D219139C-0D92-11E6-A1E9-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292958>

Jeff King <peff@peff.net> writes:

> Keep in mind that submodule interactions may be triggered from other
> non-submodule commands. So "git fetch", for instance, may end up caring
> about whether you pass "http.*" or "credential.*" down to the
> submodules.

> I do not think "fetch" should grow submodule-specific
> options,...

The updated "git fetch" needs to grow submodule-specific options to
at least either enable or disable "recurse into submodules", and
that is true even if the default behaviour in the future were to
recurse into submodules in a top-level project repository that has
submodules (i.e. you must have "git fetch --no-recurse-submodules"
option).  "Please use these configuration when you do recurse into
them" options are very much submodule specific in the same way.

If anything, with Stefan's "submodule groups" thing, I would expect
more commands (like "git diff") to become aware of the possibility
of descending into submodules (and even "selected subset of
submodules"), and they need command line options to tell which ones
to descend into.  "Here is the set of submodules I want you to
descend into" and "By the way, I want you to use these settings
while working in them" would go naturally hand in hand, I would
imagine, so I strongly disagree with the statement "fetch should not
grow submodule specific options".

Of course, we can stop teaching --recurse-submodules to non "git
submodule" commands and concentrate on improving "git submodule" as
the end-user facing command, or cover usecases to work on subset of
submodules with "git submodule foreach".  But I do not think that is
what you are advocating for.

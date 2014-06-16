From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] verify-commit: scriptable commit signature verification
Date: Mon, 16 Jun 2014 13:34:20 -0700
Message-ID: <xmqqk38gpp9v.fsf@gitster.dls.corp.google.com>
References: <cover.1402063795.git.git@drmicha.warpmail.net>
	<cc5fd1d554e0357dfb514e3f9ad100d98c16d4d5.1402063796.git.git@drmicha.warpmail.net>
	<20140613080229.GJ7908@sigill.intra.peff.net>
	<539ACA8A.90108@drmicha.warpmail.net>
	<20140613110901.GB14066@sigill.intra.peff.net>
	<xmqqbntw4u4d.fsf@gitster.dls.corp.google.com>
	<20140616195428.GB24376@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 16 22:34:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwdbq-0002fl-Rs
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 22:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440AbaFPUe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 16:34:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63367 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751945AbaFPUe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 16:34:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EBBFE20880;
	Mon, 16 Jun 2014 16:34:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6BH/6r0EOUx+PodAWaMRxXnkA3g=; b=YVbiiv
	yW1Ks1GK7J+znBfwwHQ0TTVxHdvyC1aylDs01Rwjn6p9WD9av9W2hW9OnZj40Aq6
	NMnyS/EHn+yGaN7Mc0m5toL2QQgXKNYaAYm9rGse6DQmaH12Ub26Iy9NfLlnTRkC
	11m0bWVZ+OJs5HL6tOXKc4GDZpvuxo2qns+WI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xVrJVZ0/zGDabduHhXfDlM0rTIHtljor
	N0qtmhE/FZlaLEeFpp0JQqgjOeVpVNqOHqq9fgu7DNQnxEYE2EXiqaaFYOtOnJiP
	Y/aQv8V9HLg4TlAvmPyLyCRuupmJ1DCHYqbfDm9zMfG6CAdSHgtmqVtDX86umsyR
	wXTxKIu4HWE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E290E2087E;
	Mon, 16 Jun 2014 16:34:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B1C6F20875;
	Mon, 16 Jun 2014 16:34:19 -0400 (EDT)
In-Reply-To: <20140616195428.GB24376@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 16 Jun 2014 15:54:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 97D36942-F595-11E3-AA1A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251822>

Jeff King <peff@peff.net> writes:

> On Fri, Jun 13, 2014 at 10:06:10AM -0700, Junio C Hamano wrote:
> ...
>> and more, perhaps?
>
> That is certainly the direction I was thinking of when I suggested "git
> verify".
>
> However, I do not think it is too bad a thing to add a verify-commit
> that matches verify-tag, as long as they do the exact same thing
> (namely, check the gpg signature). We may find it is later obsoleted by
> "git verify --gpg-signature", but given that verify-tag is already there
> and will remain for compatibility, I don't think we are increasing the
> cognitive load too much.

Yup, I think we are exactly on the same page.

Thanks for sanity-checking.

> Your middle example above did make me think of one other thing, though.
> As you noted, we actually have _three_ signature types:
>
>   1. signed tags
>
>   2. signed commits
>
>   3. merges with embedded mergetag headers
>
> We already have a tool for (1). Michael is adding a tool for (2). How
> would one check (3) in a similar way?

Hmph, somehow I misread the patch that it was for both 2 & 3 X-<.

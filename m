From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] logging branch deletion to help recovering from mistakes
Date: Tue, 07 Dec 2010 11:21:46 -0800
Message-ID: <7v7hflqth1.fsf@alter.siamese.dyndns.org>
References: <7vlj42siu5.fsf@alter.siamese.dyndns.org>
 <AANLkTikbsyFUzZeu8R6yAND6spV6OnvYL08gYZ+ZgJCh@mail.gmail.com>
 <7vmxoiqeoq.fsf@alter.siamese.dyndns.org>
 <20101207170623.GB21749@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 07 20:22:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ36w-0003MA-2W
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 20:22:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905Ab0LGTV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 14:21:56 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43152 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480Ab0LGTVz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 14:21:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D1A342F82;
	Tue,  7 Dec 2010 14:22:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6XqdmMdHK8a73EKvK7bBgZXTZBc=; b=CRPwwD
	N63BTssnXsM5E2HRE9Jxn9g/hvj+8Dip4lF3eF2v0U/F6UYuIdGOkS78ktsqxSzZ
	5PrhrMSPclr93sPSPNApqsUNwQQ7qV47gPeWrSsZTC+e/IVHF20fCnGRVFpQUtcs
	neQp5GvQQ2v0qgabKcis0w1g/GTaNjNLzGbi0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XKUO7QvuU5JYA+V/65Ykh3MPlKWsd1tp
	doSKzrZXQehlkEXK1uvQbWFD0AlVg3urfrvhTfeeL6B/dlzOmCSqR6lUhY5wp3La
	JC1mgheT2R1YH7DvRlK5KrpXkjiWnyYwR/4fGxUGITy95CL+Ic1xP6V7YpUndMMc
	RaNFhY/NQNc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9A8092F81;
	Tue,  7 Dec 2010 14:22:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 666542F7F; Tue,  7 Dec 2010
 14:22:10 -0500 (EST)
In-Reply-To: <20101207170623.GB21749@sigill.intra.peff.net> (Jeff King's
 message of "Tue\, 7 Dec 2010 12\:06\:23 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4C326920-0237-11E0-9474-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163116>

Jeff King <peff@peff.net> writes:

> On Mon, Dec 06, 2010 at 10:28:53PM -0800, Junio C Hamano wrote:
>
> Yeah, I think this is not _quite_ what people want in this area. A base
> requirement from past discussions, I think, is that the whole reflog of
> the deleted branch be saved rather than just the tip. And then "reflog
> show" would make a lot more sense on such saved reflogs.

I am more worried about stuff in branch.<name>.* that are discarded upon
"branch -d".  Without the config items, you won't have a working:

    $ branch -d frotz
    $ branch --undelete frotz
    $ git checkout frotz
    $ git pull

I would say it is fine to discard old reflog for "frotz" branch and tell
users of --undelete that even though their branch is undeleted, the reflog
for it is already expired when they deleted it the first time, but it is
impossible to implement "branch --undelete" without stashing away stuff
other than reflog.

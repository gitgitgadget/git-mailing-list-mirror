From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Multiple fetches when unshallowing a shallow clone
Date: Fri, 04 Dec 2015 14:45:22 -0800
Message-ID: <xmqqh9jxrfy5.fsf@gitster.mtv.corp.google.com>
References: <CACs8u9STLLHr3c3O9kQKGEN52DLfJ2LatjWkeaeeLA-xP=gC5Q@mail.gmail.com>
	<CAGZ79ka=RxVZ49D0wkqTRqspKb=Ce5Ay01muBt_Gk6_rDbH6KA@mail.gmail.com>
	<20151204212712.GA22493@sigill.intra.peff.net>
	<CACs8u9Qvqn4KDMKo+RHsQaf+dw+CGtWrOpoUJzaZAqD1rFRiuw@mail.gmail.com>
	<20151204215158.GA27987@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jason Paller-Rzepka <jasonpr@google.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGg=?= =?utf-8?B?w6FpIE5n4buNYw==?= Duy 
	<pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 04 23:45:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4z6b-0002YE-Ui
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 23:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755226AbbLDWpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 17:45:30 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59136 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755162AbbLDWp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 17:45:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E33D72EBEE;
	Fri,  4 Dec 2015 17:45:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xWAsmrseH81Jfy2/HPPAUe1tHBg=; b=uAq5Sv
	x/yeRBbcoot/Knop3OeZWT6hLDCnNTiXmPRs1YvCTZqa6iYLj2BCLBTgcEjNfujN
	wWODReeRLpbJsb1bnsHHDjri8kK3Ro/+wpZL7bx257ESHknFYEiHTQSFfAuD3unN
	7OOOMoaAIQWzuuKSnjmpK8ns5G0ssGfVrIFKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q42SzGDx9GFTgf5+ITGWJgaLPiC2VPL/
	KcOEqIH8dbokh9SKJe2pSvKI2ePAGLlwrrp7vp9df+DY3kRXmUjtiypApyQcsNql
	WHkX8ZEaYxHhOgUEpA69CpCblB8Nwy9lXDJDfgj9E/mGnT+uEazqdMfyyl5ltBKZ
	QQxsHcVhQ4c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CF9B42EBED;
	Fri,  4 Dec 2015 17:45:26 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 073492EBEC;
	Fri,  4 Dec 2015 17:45:25 -0500 (EST)
In-Reply-To: <20151204215158.GA27987@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 4 Dec 2015 16:51:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B5ECA79C-9AD8-11E5-9FF8-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282014>

Jeff King <peff@peff.net> writes:

>> But why would fetching a tag (or set of tags) merit a depth of zero?
>> Doesn't depth 1 mean "give me the the objects, and none of their
>> descendants"?  Why use 0?
>
> That comes from this line:
>
>   transport_set_option(transport, TRANS_OPT_DEPTH, "0");
>
> That line blame back to b888d61 (Make fetch a builtin, 2007-09-10),
> which isn't incredibly helpful.

Hmm, "0" means "no depth limitations", which is exactly what we want
in this "unshallow" case, I would think.  The behaviour observed is
just like a regular fetch that auto-follows tags, where it has to
make a second fetch if the primary fetch fails to include everything
that is needed for propagating the tag for whatever reason.

Having said that, IIRC, these days a depth limited clone is created
implicitly with --single-branch option, and I am not sure what the
right behaviour for the auto-following of tags in such a repository.

> I think that comes from the original git-fetch.sh, which had:
>
>   ?*)
>           # do not deepen a shallow tree when following tags
>           shallow_depth=
>
> Which makes sense. I think the code at that point is not aware that we
> just "unshallowed" and can therefore drop the depth parameter
> altogether. But I admit I am not all that familiar with the shallow
> code.
>
> +cc Duy, who can probably say something way more intelligent about this
> off the top of his head. :)
>
> -Peff

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config
 permission problems as errors" busted git-daemon
Date: Fri, 12 Apr 2013 12:51:19 -0700
Message-ID: <7vr4ifcytk.fsf@alter.siamese.dyndns.org>
References: <7vvc7sfkwn.fsf@alter.siamese.dyndns.org>
 <20130412043501.GA12942@sigill.intra.peff.net>
 <7vr4igfj9w.fsf@alter.siamese.dyndns.org>
 <20130412050550.GA15724@sigill.intra.peff.net>
 <20130412112636.GC20178@odin.tremily.us>
 <20130412144855.GA17968@sigill.intra.peff.net>
 <7vk3o7g29s.fsf@alter.siamese.dyndns.org>
 <20130412161600.GA20492@sigill.intra.peff.net>
 <20130412170505.GA2383@sigill.intra.peff.net>
 <7vbo9jehfx.fsf@alter.siamese.dyndns.org>
 <20130412190152.GB4108@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "W. Trevor King" <wking@tremily.us>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Mike Galbraith <bitbucket@online.de>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 12 21:51:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQk0N-00035x-Vn
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 21:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538Ab3DLTvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 15:51:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62555 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752523Ab3DLTvW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 15:51:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07677153F3;
	Fri, 12 Apr 2013 19:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mZTlFyeaP+f2e5qjipJRwon1C0U=; b=K86jM0
	sXnKGm3u04LAL1h+7MYc/EniFjEwvLR+oebB8DToy151uX1NTbRncm/E3f33Qz86
	QZT8zjQ00A/nmuB2kxVfjge3QzzAcp516fxsfZNLCkZxQA6LcfMNFHFKPm1v4LBn
	LcmZPDHsJ/+JeHvESFeRnrZ670bOobJsnpieM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ocMF+Kytu2E+TKqxwSI1xeE1fBfPlUw+
	ou+9wu/vhIWG5SpXjfMTK3oQI8knxPbMlOJu561gfxlt2Av+F7h3emFroINuaHFN
	qfV7R+KOL8t37POx8Lf5ZtR2BKD9dsQ29UKILQg+iGlGeYQC/yQJNmBV3BqI932L
	VHdoo6rN+m8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE638153F2;
	Fri, 12 Apr 2013 19:51:21 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59FA8153F1; Fri, 12 Apr
 2013 19:51:21 +0000 (UTC)
In-Reply-To: <20130412190152.GB4108@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 12 Apr 2013 15:01:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59607C42-A3AA-11E2-A46D-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221021>

Jeff King <peff@peff.net> writes:

>> If the access() failed due to ENOENT, the caller will get a negative
>> return from this function and will treat it as "ok, it does not
>> exist", with the original or the updated code.  This new case is
>> treated the same way by the existing callers, i.e. pretending as if
>> there is _no_ file in that unreadable $HOME directory.
>
> Exactly.

The explanation you are replying to was meant to illustrate how this
is not "inaccessible is OK", but is "treat inaccessible as missing",
by the way.

>> That semantics sounds sane and safe to me.
>
> Thanks. I'll re-roll with a proper commit message and the fixups I
> mentioned above. I think we should still do the documentation for
> git-daemon. But it is no longer about "oops, we broke git-daemon", but
> "you may want know that we do not set HOME in case you are doing
> something tricky with config". I'll submit that with the re-roll, too.

Well, at least to me, the documentation update was never about
"oops, we broke it", but was about "be careful where the HOME you
are using actually is" from the beginning of the suggestion.  I was
actually planning to apply it to maint-1.8.1 that predates the xdg
stuff, and that is why the text only suggests to set HOME for the
config.

> Do you have an opinion on just dropping the environment variable
> completely and behaving this way all the time? It would "just fix" the
> cases people running into using su/sudo, too.

With the tightening, people who used --user=daemon, expecting that
they can later tweak the behaviour by touching ~daemon/.gitconfig,
got an early warning that they need to set HOME themselves, but with
any variant of the patch under discussion, as long as loosening is
on by default, will no longer get that benefit.

I am not yet convinced if that is a real "fix/cure".

So, no, I have not even reached the point where I can form an
opinion if this behaviour should be the default.

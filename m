From: Junio C Hamano <gitster@pobox.com>
Subject: Re: what are the chances of a 'pre-upload' hook?
Date: Sat, 26 Nov 2011 23:51:29 -0800
Message-ID: <7vmxbivw8u.fsf@alter.siamese.dyndns.org>
References: <CAMK1S_jaEWV=F6iHKZw_6u5ncDW0bPosNx-03W9bOLOfEEEY1Q@mail.gmail.com>
 <CAMK1S_gh_CsWc-DnbOuUwn+H1i3skm99xzDbWe-wxsKKS0Qw-w@mail.gmail.com>
 <20111125144007.GA4047@sigill.intra.peff.net>
 <7v7h2my0ky.fsf@alter.siamese.dyndns.org>
 <20111126225519.GA29482@sigill.intra.peff.net>
 <7vr50uwk7x.fsf@alter.siamese.dyndns.org>
 <20111126233133.GA31129@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 27 08:53:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUZYD-0002pb-GA
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 08:53:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865Ab1K0Hvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Nov 2011 02:51:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45110 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751348Ab1K0Hvg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2011 02:51:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B63D2DF3;
	Sun, 27 Nov 2011 02:51:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8CGgNiS1bwf/Ub6fbrnz2NOY0II=; b=jW2/c9
	B8KwMitdAIxFMSB0JDJj3Fa40E10X5uTclsLijB8b5xgIuJJhM/Ed1CzkLUwToqb
	PGDENfS9QpYG1jPZ8iKa9QtwutCg/PY4t9bqdLEyyvGUWLIqe18X6XXqvWMlS4NT
	KW8TnqlbzWZMlSinXxHSNpyHCb2V+UZnhnwT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G4gPE0J+bBcNUWwk3n3pqhSBYupTRW/2
	5kVKXWsZozTEGdUPpj77SeJ3DwmPYi3nKYGyhiRSurKiUr4Zw/fPEa2B5loNxNIc
	kUbruNDcOe/XvtB9OTmYVq0g5er+AMi3eiL8KbGmwY9Fosz4ou8x1cvIPU4mFbd9
	4x/dMTBPFwI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41EEF2DF2;
	Sun, 27 Nov 2011 02:51:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B31CC2DF1; Sun, 27 Nov 2011
 02:51:34 -0500 (EST)
In-Reply-To: <20111126233133.GA31129@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 26 Nov 2011 18:31:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A0C45E4C-18CC-11E1-9424-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185967>

Jeff King <peff@peff.net> writes:

> It depends on what you want your hook to do. I thought Sitaram's
> use-case was putting something like "git fetch upstream" into a hook
> that runs before upload-pack, to create a transparent proxy. That has
> nothing to do with the accessing user.
>
> At GitHub, we run a pre-upload-pack hook to keep statistics. That has
> nothing to do with the accessing user. We have to patch git to provide
> the hook.

I personally have a huge problem with shipping an inherently unsafe
mechanism that is disabled by default even if it is marked with big red
letters saying that it is unsafe and should not be enabled casually. It
makes it up to the system administrator to decide what is casual and what
is not, but when end users are get harmed by a clueless administrator's
decision, the repercussion will come back to the Git software, not to the
clueless administrator who enabled an unsafe mechanism in an environment
where it was not designed to support.

It may merely be a matter of perception. After all, the pre-upload-pack
hook I did in a8563ec (upload-pack: add a trigger for post-upload-pack
hook, 2009-08-26) in response to GitHub's stat request was so trivial that
even clueless admins could trojan it back into the current upload-pack
source to use in their own site, without letting their users know that
their fetch request may be opening their account to a random hook
script. So in that sense, it might not be worth my effort to fight for Git
users' safety to find a better solution and instead go with the big red
letter approach which is easy. I know perfect is an enemy of good, but
when I do not think an easy Quick-and-Dirty solution is even less than
good, I need to point out that not having less than bad is better than
having it.

If the mechanism to notify the external machinery (i.e. counting accesses,
learning the true destination of a new fetch request and have the fetcher
wait while the real fetch goes to the origin site) were not via a hook
that runs as the fetcher but were via something else that runs as the
owner of that external service (i.e. counting accesses, maintaining the
proxy object pool), I wouldn't have trouble with the proposal.

For example, upload-pack could write the details of the original request
to a named pipe to ask the "service" process listening on the other end,
and wait for its response.

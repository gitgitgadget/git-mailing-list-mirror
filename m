From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Hiding some refs in ls-remote
Date: Sun, 20 Jan 2013 10:19:09 -0800
Message-ID: <7vip6rn2ea.fsf@alter.siamese.dyndns.org>
References: <1358555826-11883-1-git-send-email-gitster@pobox.com>
 <CACsJy8C4qx0P621imj5B+HdoJkow0_jaGLVDRvdCDw3YRnK98g@mail.gmail.com>
 <7v38xxnfv3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org, mfick@codeaurora.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 19:20:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwzV0-0004ON-HH
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 19:20:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325Ab3ATSTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 13:19:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38328 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751503Ab3ATSTM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 13:19:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A99DDB665;
	Sun, 20 Jan 2013 13:19:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ez+/m3Ek9YeOsYKZYTOHJ6ktUhs=; b=KnthgP
	9MHXyLgWGlBM0aP6mp14albx3wD7W0F7i4ROhY6cLJCxLf69IFReI3+AzGxVVBUG
	G1MktlKF/K06LoC35p2vhHhZ+Ies3i4jCqOiLLwn+EZ2cdbP+ru7AudD5qLhryVW
	Z+Cee6x8VFqhOf+bJ0qnGXVsPKcrXT0HQ/JiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rQmzJe0W1kV8hyn6hjVf2zAAO90ez/EZ
	zCUAJYASjUs3B40n1f+30+KFXVgcMg9tG2R2ws0qO/u0Nq3XcEPlY8Pfrh6j0lkX
	EeWQLscz3BuNwJa63y7+mVSoifYGM8JPPerS8KVAH7r+vmdslQ+H8Q5broTLAhJd
	dgXo+XT/xhM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DE55B664;
	Sun, 20 Jan 2013 13:19:11 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1823DB663; Sun, 20 Jan 2013
 13:19:11 -0500 (EST)
In-Reply-To: <7v38xxnfv3.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 19 Jan 2013 11:16:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E3343EC6-632D-11E2-B383-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214026>

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> Should the client side learn how to list hidden refs too? I'm thinking
>> of an extreme case where upload-pack advertises nothing (or maybe just
>> refs/heads/master) and it's up to the client to ask for the ref
>> selection it's interested in. upload-pack may need more updates to do
>> that, I think.
>
> What you are talking about is a different goal.
>
> Look at this as a mechanism for the repository owner to control the
> clutter in what is shown to the intended audience of what s/he
> publishes in the repository.  Network bandwidth reduction of
> advertisement is a side effect of clutter reduction, and not
> necessarily the primary goal.

As a separate and follow-up topic, I can see a future where we also
have .delayref (in addition to .hideref) configuration, that causes
the upload-pack to:

 * omit refs that are marked as "delayed";

 * advertise "allow-expand-ref=<value>" where the value is the
   pattern used to specify which refs are omitted via this mechanism
   (e.g. "refs/*" in your extreme example, or perhaps "refs/tags/"
   if you only advertise branches in order to limit the bandwidth);

and then a fetch-pack that is interested in fetching "refs/foo/bar",
after seeing that it matches one of the "allow-expand-ref" patterns,
to ask "expand-ref refs/foo/bar", expect the upload-pack to respond
with "refs/foo/bar <value of that ref>" (or "refs/foo/bar does not
exist"), before going into the usual "want" exchange ("ls-remote"
would of course do the same, and pattern-less "ls-remote" may even
ask to expand everything by saying "expand-ref refs/*" (where the
capability said "allow-expand-ref=refs/*" in your extreme example)
to grab everything discoverable).

That is _primarily_ for trading network bandwidth with initial
latency; as far as the end-result is concerned, delayed ones to be
expanded on demand are just as discoverable as the ones advertised
initially.

I think we'd want to have both in the end.  It just happens I just
posted the beginning of clutter-reduction one, as I think developing
both in parallel would be messy and hideref is probably less
involved than the delayref.

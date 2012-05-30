From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] clone: allow --no-local to turn off local
 optimizations
Date: Wed, 30 May 2012 16:33:10 -0700
Message-ID: <7vipfd8csp.fsf@alter.siamese.dyndns.org>
References: <20120530110305.GA13445@sigill.intra.peff.net>
 <20120530111016.GB15550@sigill.intra.peff.net>
 <7vzk8pziuk.fsf@alter.siamese.dyndns.org>
 <20120530215912.GC3237@sigill.intra.peff.net>
 <7vmx4pxqua.fsf@alter.siamese.dyndns.org>
 <20120530232116.GA5007@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Emeric Fermas <emeric.fermas@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 31 01:33:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZsOV-00015p-Iy
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 01:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163Ab2E3XdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 19:33:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57770 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751935Ab2E3XdN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 19:33:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A72E97FF;
	Wed, 30 May 2012 19:33:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KyDh+sHQPwM8VCZ2td65a4JLDmE=; b=EKup70
	tHGX99jLO9OWVnSZ3hjBnrFXfP25FC6QwDIAAtHj+qSCu++MgGhbhJMk0KZNSoFy
	rjSSo9wDegRZHtsoZYEU0vN4hJ712EZKxlWSIiafa6eygelVxqisoAiAbuwo8VMF
	D5yMc1uCK4RbEUUAiY/ibzCiPP2y2eZ9rSg0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n77Co9suJm1//5I0H/uLgn8FSybGqI0F
	MV/niD573G1+NupBbvpiVwPGfdnRGQFhHV0lRksY2Qs8uRxv8gpmM2RHQqYmy9qq
	G7CscT9Loi9kRa7olrTT8sAK9Ma59h8fLv/3sQN4rTod+72LO2tfz1BgoBT7N0al
	9Zy/h2wt+uY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 901A197FE;
	Wed, 30 May 2012 19:33:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E96FA97FD; Wed, 30 May 2012
 19:33:11 -0400 (EDT)
In-Reply-To: <20120530232116.GA5007@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 30 May 2012 19:21:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D2281B84-AAAF-11E1-84B0-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198850>

Jeff King <peff@peff.net> writes:

> On Wed, May 30, 2012 at 03:10:37PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > Similarly, I find it a little odd that "git clone file:///foo.git" will
>> > actually find a file named "file:/foo.git" before checking the URL (IOW,
>> > the argument is a path first, and then fallback to URL). I suspect
>> > nobody actually cares about either, as they are very unlikely corner
>> > cases.
>> 
>> Yeah, if anything, I would have expected --no-local to mean "I might
>> have a local file that happens to be the same as this URL, but I am
>> not cloning from there; just go straight to the URL using transports".
>
> But that would not be the opposite of "--local", which you have just
> argued is not about interpreting the URL syntax at all, but is about
> turning off the local optimization code path when the origin repo is
> local.

What I meant to say was that promoting "--local" like your original
series did and giving it a new meaning did not make much sense in
the context of the current semantics (i.e. if the path exists, it is
a path and you do not have to tell "--local" about it), but the
semantics _instead_ needs "--no-local" to be complete; without
"--no-local" that is defined as such, the funny corner case that a
path with the same as $URL prevents you from going to where you want
to go.

> Interestingly, it seems that we don't handle this case well at all,

Yes, isn't it interesting?  It is not just we feed it to transport,
but we also store it in the config so later "git fetch" will also do
something inconsistent.  "<scheme>://", primarily because it has
doubled slashes, I wouldn't worry too much about them, but I would
not be surprised if somebody saw scp-style <host>:<path> conflict
with a local path and wished we handled such a case a bit more
sanely.

> ... Again, these are such silly corner
> cases that I suspect it is simply the case that nobody has run into them
> or cared.

;-)

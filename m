From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v3 00/12] several notes refs, post-rewrite, notes
 rewriting
Date: Sun, 21 Feb 2010 16:18:32 -0800
Message-ID: <7vy6imcecn.fsf@alter.siamese.dyndns.org>
References: <cover.1266361759.git.trast@student.ethz.ch>
 <cover.1266703765.git.trast@student.ethz.ch>
 <7vhbpb2qsm.fsf@alter.siamese.dyndns.org>
 <201002210714.02408.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 22 01:37:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjM0v-0000eb-A7
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 01:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753857Ab0BVASv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 19:18:51 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36814 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748Ab0BVASu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 19:18:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FDC99CAF8;
	Sun, 21 Feb 2010 19:18:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=y8i51/liARqpw8f8lN17lpyrj+A=; b=KvWvYW5v6pbXuMpjhD+jSxr
	rIUGVsR0x40iY9Lm08cyPNHOHAfdEdTgSp65v7E98W2T091Iv5mUHuQzADROqf40
	uy3jGT5X4Vm1PMGR2V2Dm36ENHN1sbieskevi0QFjP41vxt4ScnHBqv0ca76c8yM
	ZNlmDQLEth6tvTXO+nsY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=UGWxfx6JG/d9Hu1w4nGor9HJOKF73LT079eSWcRd1GdSaXtA/
	xbMrAJzzItOMIDDxDn3xIZjM55tqNyBhlfp2PG31kQ5Syk6WXg6tBRVHQI2yjQsC
	HzQAzDOVqAGo3OjMxd1luI9/D++msOQqHSkxb3TqRuC9hQ3a6Ba+C0YVZk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CEB639CAF7;
	Sun, 21 Feb 2010 19:18:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 656AA9CAF6; Sun, 21 Feb
 2010 19:18:34 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D38EFFB0-1F47-11DF-B746-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140621>

Thomas Rast <trast@student.ethz.ch> writes:

> On Sunday 21 February 2010 04:47:37 Junio C Hamano wrote:
>> 
>> I like the general direction in which this series is going, but a config
>> that does not have any command line counterpart is a design mistake.
>
> I hate[1] to point out that according to the same criterion, the
> *current* notes are a design mistake.  Unless you count GIT_NOTES_REF,
> in which case in my opinion...

With "--no-notes" the caller can explicitly say "please do not show any
notes at all" to the log family.  "git notes" command itself is about
manipluating the notes, and at least with GIT_NOTES_REF the caller can
explicitly say what notes tree to work with even when configured value
is not appropriate.  I also thought there was a work in progress to allow
overriding GIT_NOTES_REF from the command line?

Having _only_ configuration option is practically no better than having
only hardcoded defaults with _no_ way to override it per invocation.  What
if a user wants to usually see notes from set A (hence it is configured as
the value to display-notes-ref configuration) but wants to see notes from
a different (maybe overlapping, maybe not) set B during another task?  As
far as I can see, the _only_ way the current round of RFC lets me do this
is by resetting the configuration in the repository.

It is not a contrived example.  I've been adding the info about the
original mailing list message with a patch to commits made with "am" in
notes/amlog, and would want to keep test result summary in notes/test.
I'd want to see the test notes just before merging topics to integration
branches as a final safety check but not all the time.  I'd want to see
amlog notes when bisect points at a commit in not so near future to be
able to dig up the archive with, but not all the time.  There needs a
per-invocation way to specify which sets of notes to show, and a command
line option is the usual way for commands to allow users to do so [*1*].

> I don't really want to go the other way and patch every command that
> could conceivably have notes in its output.

It is Ok that the series may not be perfect during the RFC period (which
the patches were clearly marked as), but I've already said "I like the
general direction", wanted to see this series advance from RFC to 'next'
material sooner rather than later, and was pointing out what needs to
happen for that.


[Footnote]

*1* We could also use an environment variable, but that is an inferiour
alternative to options and configuration variables from the point of view
of UI design.  Users can export GIT_AUTHOR_NAME, which can serve as an
alternative to user.name.  This can be overridden per-invocation by
"GIT_AUTHOR_NAME=myothername git commit", which can serve as an
alternative to --author option.

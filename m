From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Working with remotes with (too) many branches
Date: Sun, 19 Feb 2012 13:36:35 -0800
Message-ID: <7v7gzipkt8.fsf@alter.siamese.dyndns.org>
References: <CAKHWUka763XRWyMz2Xq1qQ2rfKqSYdTX0xtdVFm8zWJ_+6tGqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Philip =?utf-8?Q?J=C3=A4genstedt?= <philip@foolip.org>
X-From: git-owner@vger.kernel.org Sun Feb 19 22:36:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzER1-0003hM-VJ
	for gcvg-git-2@plane.gmane.org; Sun, 19 Feb 2012 22:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755259Ab2BSVgj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Feb 2012 16:36:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58954 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755115Ab2BSVgi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Feb 2012 16:36:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5DA06997;
	Sun, 19 Feb 2012 16:36:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FY1+5ObzB5BI
	8eRkqIuR04EVtDg=; b=iWOIsxIs9wgt28LcPS0c5NB8q7G+6kXGPY658iVUZ2rj
	qpwvL45wLggod2POs+/+Lbk1nyr+FgP0Jbb2XNDHXo+jciKO8Hm4Km/qf7mGabiN
	DVkvbs6nsm1PqYP9aIRm/HOjcf3GPHZWRH0BzJOP2qkUiMNqu0OJSxgl1jpgZGM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=b96Yt0
	DuKfXZcD/evy4ywXDc0ss6KKtx3KWsXbU87vP7QxqEngElcpgYR03oB74MCD7Qx5
	FPP37BgVXjB87et3kbEYrxfF+31cJn0h0L5UbCpN5Hk0jCPIIPzUKqXE8nsRe+4l
	psw0ZY+gX4zX8OQ3R/obOy3KHsgvZwrPdMBnM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6E616995;
	Sun, 19 Feb 2012 16:36:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14DBA6992; Sun, 19 Feb 2012
 16:36:36 -0500 (EST)
In-Reply-To: <CAKHWUka763XRWyMz2Xq1qQ2rfKqSYdTX0xtdVFm8zWJ_+6tGqA@mail.gmail.com> ("Philip
 =?utf-8?Q?J=C3=A4genstedt=22's?= message of "Sun, 19 Feb 2012 16:29:57
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CD2ACDC4-5B41-11E1-9CAC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191030>

Philip J=C3=A4genstedt <philip@foolip.org> writes:

> 1. If I make a typo with remote set-branches, fetch will fail with
> "fatal: Couldn't find remote ref refs/heads/typotopic" and not fetch
> anything at all.

At that point you can notice the earlier typo and remove or fix the fet=
ch
refspec you have.

Alternatively, set-branches could run ls-remote against the remote and
notice that there is no such branch over there. However, even if you go=
t
the branch name right when you did "set-branches", you would still see =
the
same "Couldn't find" when the branch gets removed over there, so you wo=
uld
need a way to remove or fix the fetch refspec you have *anyway*.

So, assuming that there is no easy way to remove one branch from the se=
t
of branches tracked from a given remote, it is much more important to a=
dd
such a way.  Checking against a typo when "set-branches" is run is "nic=
er
to have" but lack of it is not a show-stopper.

Wouldn't "git config --unset remote.origin.fetch '/typotopic'" be
sufficient in the meantime even if a user fears "vi .git/config"?

> 2. If I forget that I've previously worked with footopic and
> set-branches --add it again, I'll get a duplicate line in my config.

I do not know the duplicate hurts anything, but I agree that it would b=
e
more aescetically pleasing if "--add" noticed what you already had and
avoided duplicates.

> 3. When I don't care about footopic anymore, there's no clear way to
> stop fetching it and remove refs/remotes/main/footopic.

Isn't the lack of "set-branches --delete" the same as #1 above?  The
latter would be "branch -r -d main/footopic" but I could imagine
"set-branches --delete" would do that for you once implemented.

> 4. If set-branches --delete existed one could end up with no fetch
> lines in the remote config, at which point fetch falls back to
> fetching HEAD, instead of the expected nothing.

Don't do that, then ;-)

I could imagine a new preference "fetch.$remote.default=3Dnothing" that
causes "git fetch" to fail with "You have fetch.$remote.default=3Dnothi=
ng
set, so I am not fetching anything from there without any configured
refspec".  The default would be fetch.$remote.default=3DHEAD, I would g=
uess.

The preference can be set automatically when you use "set-branches"
without "--add" for a given remote, as use of "set-branches" is a clear
indication that you want to deviate from the built-in default behaviour
when interacting with that remote.

> I'd appreciate feedback on these issues so that I don't waste time
> trying to patch the wrong problems. Suggestions for an alternative
> work flow is of course also most welcome!

Admittedly I wouldn't use "set-branches" myself (it is far easier to tw=
eak
with "vi .git/config", and I wasn't involved in), but looking at the wh=
ole
history of the feature with "git log --grep=3Dset-branch builtin/remote=
=2Ec",
I have a feeling that not many people used, cut by its still-unrounded
edges, and polished the subcommand by rounding them out yet, and it has=
 a
large room for improvement.

It would have saved you time to wait for a round-trip if you did the ab=
ove
"git log" yourself to find out from whom this subcommand came from, and
looked at list archive to see if the original author is still active he=
re
(in this case he is), and Cc'ed him before posting the message I am
responding to.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2014, #01; Fri, 1)
Date: Wed, 06 Aug 2014 10:12:25 -0700
Message-ID: <xmqq1tsto83q.fsf@gitster.dls.corp.google.com>
References: <xmqqy4v7uax0.fsf@gitster.dls.corp.google.com>
	<20140806081102.GA1646@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 06 19:12:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF4lc-0007Vg-1A
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 19:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757226AbaHFRMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 13:12:44 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64815 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755586AbaHFRMn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 13:12:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 542712E0B0;
	Wed,  6 Aug 2014 13:12:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5nc1VMN4PGJ53BMpPqTUc3al/Cg=; b=uZx8xI
	BIEHAeQ2iw4RdnTn3i6EMG/dFIRCHcDOlZ1dSkd8Xd1q/4KMJ0sDEweueb3GR/JY
	C8np2Gf5iwAXTK0TmxULreISbYJsgr0dXgw3aTMh/IDSe+L1GtuyyNTYTY2adCX8
	U+ZSZMtfAtuI8znDFsHJD9P4xUdNZfDKwVok0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pry26fHCJAfJYyNOuBLnXEyaqO5IDMSu
	M9fvD4y/iDyLV3xpChGI1Q8gATBMUfL1Wjs4sUIXCoM8sAq8Zmzx8rgAmTDmeIUe
	gAvtNpmzVzupqbAYiX6d8B0VyZn+AUIR0PG5wHbT7tMHcmWKYPwhvC5MPSif48G5
	fe/y2OZWGUI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 48A1D2E0AF;
	Wed,  6 Aug 2014 13:12:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A1C682E09A;
	Wed,  6 Aug 2014 13:12:28 -0400 (EDT)
In-Reply-To: <20140806081102.GA1646@peff.net> (Jeff King's message of "Wed, 6
	Aug 2014 04:11:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D822DE1E-1D8C-11E4-B2F2-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254877>

Jeff King <peff@peff.net> writes:

> On Fri, Aug 01, 2014 at 03:01:31PM -0700, Junio C Hamano wrote:
>
>> * jk/stash-list-p (2014-07-30) 7 commits
>>  - SQUASH??? future-proof, log --cc should imply -p without being told
>>  - stash: show combined diff with "stash show"
>>  - stash: default listing to "--cc --simplify-combined-diff"
>>  - add --simplify-combined-diff option
>>  - pretty: make empty userformats truly empty
>>  - pretty: treat "--format=" as an empty userformat
>>  - revision: drop useless string offset when parsing "--pretty"
>> 
>>  Teach "git stash list -p" to DWIM to "git stash list -p --cc", with
>>  even nicer twist to collapse combined diff from identical two
>>  parents into a regular diff.
>
> What do you want to do with this topic?
>
> I think we want to drop the "stash show" patch, based on the discussion
> we had.  The first three patches are nominally prep for that final
> patch, but actually are things I've often wanted over the years. I'd be
> glad if they made it in separately, but there were some compatibility
> questions.

I am not sure what compatibility you are worried about.  The empty
format one looks like a pure bugfix to me, and I agree that they
are good changes regardless of the remainder of the series.

> As clever as I find the --simplify-combined-diff patch, I think we came
> to the conclusion that "--first-parent" is probably the reasonable
> choice. It matches "stash show", and it's simple and obvious. Do we just
> want a patch to specify "--first-parent" to stash-log? That would make
> "-p" just work. The only downside is that there isn't a good way to turn
> it off.

Perhaps we can add --no-first-parent to countermand it?

> Is it enough to say "if you want to do something clever, use
> git-log"?

> Or do we want to scrap the whole thing and try to update the
> documentation to make it more clear why "-p" by itself doesn't do
> anything?

The latter is the most conservative, but it may be too conservative
to be useful ;-).  Unless we stop advertising that "stash list" is a
thin wrapper around "log -g" with options that would be useful to
view the stash, which is a strange ref with useful reflog entries,
the "--first-parent" approach would be the most sensible, I would
say.  If we can dissociate "stash list" from "log" (in other words,
the set of options "stash list" takes does not have anything to do
with the underlying "log", even though both may have "-p" to tell
them to give patches, etc.), it would be a totally different matter,
and it might give us a better future, but I suspect it might be a
bit too late for that.

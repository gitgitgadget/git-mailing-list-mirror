From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then slowest to fastest
Date: Thu, 28 Jan 2016 13:32:30 -0800
Message-ID: <xmqqk2mtmlu9.fsf@gitster.mtv.corp.google.com>
References: <20160122060720.GA15681@sigill.intra.peff.net>
	<20160124143403.GL7100@hank>
	<xmqqd1sqd9sq.fsf@gitster.mtv.corp.google.com>
	<xmqq8u3ed45r.fsf@gitster.mtv.corp.google.com>
	<20160125144250.GM7100@hank>
	<xmqqk2mxa7ug.fsf@gitster.mtv.corp.google.com>
	<xmqqegd5fht9.fsf@gitster.mtv.corp.google.com>
	<20160127151602.GA1690@ecki.hitronhub.home>
	<xmqqd1sm9730.fsf@gitster.mtv.corp.google.com>
	<xmqqmvrq7nok.fsf@gitster.mtv.corp.google.com>
	<20160128070959.GA6815@ecki.hitronhub.home>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gummerer <t.gummerer@gmail.com>, Jeff King <peff@peff.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Jan 28 22:32:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOuBD-0004NQ-Cp
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 22:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161300AbcA1Vcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 16:32:36 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50233 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161033AbcA1Vce (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 16:32:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2D3D73EC4F;
	Thu, 28 Jan 2016 16:32:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KfEAylD6blbg9ZESM4KiSeDn4C0=; b=JSddpo
	wJqI1+F/EoBbFIxkBsgyLXi2IAOYc4bA91EDbuBdTsOf0ChL2VOjI4ZyHA8PSEPE
	VDrJ6n1wzOSMJVlHVT2NBORZYno02lJ2BX1vVegJY3ROIoHdfkXcQejQiMQbTyB6
	SbhV55VCoGfZsgvGoB2RENYRpNcRb0NWEMCFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BBOclHEmvs1mMsDPPwOlwahokNt8bzr3
	iMs0b9PT/91/46Zvh53d9CoF98MGVszpUn+hsqCBG/82/LHhbuJJxYQ6bjEk4rYr
	aWBxrWHk8+l9nyKmV5kyYx1zISfUSZ8IpNYoCXEYN1SjIHtQkk9Az18R8qh0nQMp
	eCWUQzKXafw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 23BB93EC4E;
	Thu, 28 Jan 2016 16:32:33 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8D3953EC4D;
	Thu, 28 Jan 2016 16:32:32 -0500 (EST)
In-Reply-To: <20160128070959.GA6815@ecki.hitronhub.home> (Clemens Buchacher's
	message of "Thu, 28 Jan 2016 08:10:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A3E6F56C-C606-11E5-B5C5-B4986AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285033>

Clemens Buchacher <drizzd@aon.at> writes:

> On Wed, Jan 27, 2016 at 12:49:31PM -0800, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > I wonder what would break if we ask this question instead:
>> >
>> >     We do not know if the working tree file and the indexed data
>> >     match.  Let's see if "git checkout" of that path would leave the
>> >     same data as what currently is in the working tree file.
>
> If we do this, then git diff should show the diff between
> convert_to_worktree(index state) and the worktree state.

I agree with you that, when ce_compare_data(), i.e. "does the index
match the working tree?", says "they match", "git diff" (show me the
change to go from the index to the worknig tree) should show empty
to be consistent, and for that to happen under the above definition
of ce_compare_data(), "git diff" needs to be comparing the data in
the index after converting it to the working tree representation
with the data in the working tree.

And that unfortunately is a very good reason why this approach
should not be taken.  "git diff" (show me the change to go from the
index to the working tree) is a preview of what we would see in "git
diff --cached" (show me the change to go from HEAD to the index) if
we did "git add", and it is a preview of what we would see in "git
show" (show me the change of what the last commit did) if we did
"git commit -a".  It is crazy for these latter comparisons to happen
in the working tree (aka "smudged") representation of the data, IOW,
these two must compare the "clean" representation.  It also is crazy
for "git diff" to be using different representation from these two.
This alone makes the above idea a non-starter X-<.

Besides, I do not think the above approach really solves the issue,
either.  After "git reset --hard" to have the contents in the index
dumped to the working tree, if your core.autocrlf is flipped, "git
checkout" of the same path would result in a working tree
representation of the data that is different from what you have in
the working tree, so we would declare that the working tree is not
clean, even though nobody actually touched them in the meantime.
This is less of an issue than having data in the index that is
inconsistent with the convert_to_git() setting (i.e. eol and clean
filter conversion that happens when you "git add"), but it still is
fundamentally the same issue.

Oh, bummer, I thought it was a nice approach.

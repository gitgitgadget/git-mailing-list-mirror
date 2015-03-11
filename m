From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] rev-list: refuse --first-parent combined with --bisect
Date: Wed, 11 Mar 2015 13:13:48 -0700
Message-ID: <xmqqsidb5m2r.fsf@gitster.dls.corp.google.com>
References: <1425827005-9602-1-git-send-email-me@ikke.info>
	<1425934575-19581-1-git-send-email-me@ikke.info>
	<xmqqa8zkzeq5.fsf@gitster.dls.corp.google.com>
	<20150310225509.GA5442@vps892.directvps.nl>
	<xmqqoao0xx9p.fsf@gitster.dls.corp.google.com>
	<20150311184512.GB5442@vps892.directvps.nl>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Kevin Daudt <me@ikke.info>
X-From: git-owner@vger.kernel.org Wed Mar 11 21:13:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVn0u-0002LY-NV
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 21:13:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbbCKUNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 16:13:52 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58949 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750740AbbCKUNv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 16:13:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3EC5A3E90B;
	Wed, 11 Mar 2015 16:13:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pf6E2BC7tDNinEghUJj65t9hLeo=; b=QpzY3h
	EYQQ/+sWsJ8tEhvcQy5fPamHr9ReNp6w4U2ce94qGUYUQpY5U/v8bKqOiUbFz+jt
	jc+/KwvfCxdRiP/pKZ7SMQFZkSf11PWssll02/g2NOidQzRXBfVenc/f3q5dLdAZ
	qrMe7nAWPSQI9oFazvgwRw0vu16AM3rGbr5to=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EWM3BDLiRFqSePJETPkxya+wGKsE9q+v
	Fa02slsQ+XCOa4nUXilKi3WGVSP/RmConb8gYx+Z5M8DIBQkQDGDQnmtCSEiw0EW
	RYHphDEza5pjxbWDeNCcGt49lWaSWgJ9NzHCCLDopbRFBGAUFb1lhm+zKmM44iDh
	iZFfNvH+65c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 372B63E909;
	Wed, 11 Mar 2015 16:13:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AC10F3E907;
	Wed, 11 Mar 2015 16:13:49 -0400 (EDT)
In-Reply-To: <20150311184512.GB5442@vps892.directvps.nl> (Kevin Daudt's
	message of "Wed, 11 Mar 2015 19:45:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2161E2B6-C82B-11E4-9A96-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265333>

Kevin Daudt <me@ikke.info> writes:

> On Tue, Mar 10, 2015 at 04:12:18PM -0700, Junio C Hamano wrote:
>
>> What does such a command line _mean_?  It tells us this:
>> 
>>     Define a set by having the "bad" ref as a positive end, and
>>     having all the "good" refs as negative (uninteresting) boundary.
>> 
>> That is a way to show commits that are reachable from the bad one
>> and excluding the ones that are reachable from any of the known-good
>> commits.  The area of the graph in the current bisection that
>> contains suspect commits.
>> 
>> Now, what does it mean to pull only the first-parent chain starting
>> from the bad one in such a set in the first place?  What does the
>> resulting set of commits mean?
>
> In that case it will leave out any merged in branches.

Needs a bit more thinking (hint: branches merged into *what*?).

> I recalled reading something about this. Searching found me the GSoC
> idea:
>
>     When your project is strictly "new features are merged into trunk,
>     never the other way around", it is handy to be able to first find a
>     merge on the trunk that merged a topic to point fingers at when a
>     bug appears, instead of having to drill down to the individual
>     commit on the faulty side branch.
>
> So there is definitely a use case for --bisect --first-parent, which
> would show you those commits that would be part of the bisection.

Step back and think why "git bisect --first-parent" is sometimes
desired in the first place.

It is because in the regular bisection, you will almost always end
up on a commit that is _not_ on the first-parent chain and asked to
check that commit at a random place on a side branch in the first
place. And you mark such a commit as "bad".

The thing is, traversing from that "bad" commit that is almost
always is on a side branch, following the first-parent chain, will
not be a useful history that "leaves out any merged in branches".

When "git bisect --first-parent" feature gets implemented, "do not
use --first-parent with --bisect" limitation has to be lifted
anyway, but until then, not allowing "--first-parent --bisect" for
"rev-list" but allowing it for "log" does not buy our users much.
The output does not give us a nice "show me which merges on the
trunk may have caused the breakage to be examined with the remainder
of this bisect session".

So, yes, there is a use case for "log --bisect --first-parent", once
there is a working "bisect --first-parent", but not until then, the
command is not useful, I would think.

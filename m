From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2013, #06; Tue, 27)
Date: Tue, 27 Aug 2013 14:05:01 -0700
Message-ID: <xmqqbo4ic0ap.fsf@gitster.dls.corp.google.com>
References: <xmqqsixvaqh5.fsf@gitster.dls.corp.google.com>
	<20130827205125.GA23783@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 27 23:05:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEQRt-0002HI-9b
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 23:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753657Ab3H0VFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 17:05:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55304 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752639Ab3H0VFF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 17:05:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2E9C3D034;
	Tue, 27 Aug 2013 21:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0leUNfTb6TKLib6lw0FYChnaimI=; b=hML+ud
	znZPwawak9dsdE4+QhcPC3opXWFhUYN7i+cKnILF+n00GNJ0p5oBlno9I0F9MyP4
	KLtgjgUPIxI6RaG7A8ZEjio1CUNeTlfe4AH+zS+MaD8+MlfA/1BbohAHrLgN68nx
	Slw08gaz1TfvdU6yfPOlHIeD2kis/aIKoqZAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=inCuV1+8BnXhQdWTHYfzaMmxatSaDT3Q
	LjNcAMqaMeSUx4Jknn4fIgAF9KA5jMN54h2a4XeKyBHikPJ4GI1aLdE4blfIGrMZ
	MESDI7B7uItYOpNlT40J3z9Mi3oSNvUmkF+H8BzbI5wfCuBsDu3/eQvUw/YC0rJV
	ha9RVQY4a/A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 963813D031;
	Tue, 27 Aug 2013 21:05:04 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EF14B3D02C;
	Tue, 27 Aug 2013 21:05:03 +0000 (UTC)
In-Reply-To: <20130827205125.GA23783@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 27 Aug 2013 16:51:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 580CC63E-0F5C-11E3-BD82-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233161>

Jeff King <peff@peff.net> writes:

> On Tue, Aug 27, 2013 at 12:22:30PM -0700, Junio C Hamano wrote:
>
>> * jk/config-int-range-check (2013-08-21) 2 commits
>>   (merged to 'next' on 2013-08-22 at 465efb3)
>>  + teach git-config to output large integers
>>  + config: properly range-check integer values
>> 
>>  Originally merged to 'next' on 2013-08-22
>> 
>>  "git config --int section.var 3g" should somehow diagnose that the
>>  number does not fit in "int" (on 32-bit platforms anyway) but it
>>  did not.
>> 
>>  Will cook in 'next'.
>
> I think Jonathan had some concerns about the test in the first one, and
> there was an open question in the second of whether we wanted to add
> something like --ulong, call it something more agnostic like
> --file-size, or simply teach --int to use 64-bit integers everywhere for
> simplicity.
>
> Thoughts?

Are the scripts that use "git config --<type>" expected to know the
representation type used by C binaries on the platform?  If so,
letting them say "git config --ulong 3g" when setting a new value,
and "git config --ulong" when asking the current value with range
checking does make sense.  When the underlying code uses "int" (as
opposed to "int32_t") to read the value for a variable on any
platform, then "git config --int 3g" that does not warn only because
it is running on 64-bit platform may not help very much.  The users
can protect themselves by learning to use "config --int32 3g", but I
am not sure that is a sensible approach---rather, "config --int"
that makes sure that the current value or the value being set is
within range on any sensible platform may be a lot more user-friendly.

>> * jk/mailmap-incomplete-line (2013-08-25) 2 commits
>>  - mailmap: avoid allocation when reading from blob
>>  - mailmap: handle mailmap blobs without trailing newlines
>> 
>>  Will merge to 'next'.
>
> Did you want me to squash these? The second one more or less eradicates
> the changes made to the first one. I mainly did them separately in case
> we were going to only do the first half on maint.

Hmm, perhaps.  Is reading mailmap from a blob commonly done and
deserves a maint update down for 1.8.3/1.8.2 series?

I'll be rewinding the 'next' soonish (either tomorrow or Thursday),
so I'll try to remember not to merge this (yet).

>> * jk/write-broken-index-with-nul-sha1 (2013-08-26) 1 commit
>>  - write_index: optionally allow broken null sha1s
>> 
>>  Am I waiting for another reroll?
>
> Yep, just sent v3.

Thanks.

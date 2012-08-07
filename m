From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 0/16] Introduce index file format version 5
Date: Tue, 07 Aug 2012 16:26:52 -0700
Message-ID: <7vboimuvur.fsf@alter.siamese.dyndns.org>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344263760-31191-1-git-send-email-pclouds@gmail.com>
 <7vehnjzzfd.fsf@alter.siamese.dyndns.org> <87393yz64x.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	"Thomas Gummerer" <t.gummerer@gmail.com>, <git@vger.kernel.org>,
	<mhagger@alum.mit.edu>, <robin.rosenberg@dewire.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Aug 08 01:27:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SytBG-0002CV-HY
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 01:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932860Ab2HGX1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 19:27:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63571 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932886Ab2HGX04 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 19:26:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D7F0902A;
	Tue,  7 Aug 2012 19:26:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mVlLCMqcbi4z7wel7XjeFyf5noM=; b=wEvELg
	qgjzzR0vccYopQeFMBGfeZ1zbZ1IRigqpnKvFB5fjy+kGWyJPNczZ+eEp89OEbM9
	EVG+R/ka/hlVdlHCMeLW3MlAFHh4vzWOAYGwOrL287jhsXiTa3AhSGBM/9AWRwfY
	xx7BtQ7gAvWhERSD/5oSL23LQGwNqU0+nmdlE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=awlpncqlz1oFQCk+fvxFNnFQ0gs/rmWu
	hsDK/t0dgS+kbU0Ry254eDt2XJpXZVYwvsWfIuJQA5eMTf2iz8DF5wzQ+eaPg+WW
	BX7yuHDv8T5edleOZ62y2B84ng2YK6TpB56cS78BEaclKoTvB4oA53Vg+AA8l3Cs
	pfbWK5EgGgU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE43C9029;
	Tue,  7 Aug 2012 19:26:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 489FF9028; Tue,  7 Aug 2012
 19:26:54 -0400 (EDT)
In-Reply-To: <87393yz64x.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Wed, 8 Aug 2012 00:31:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5F8E6948-E0E7-11E1-8518-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203057>

Thomas Rast <trast@student.ethz.ch> writes:

> I like the general idea, too, but I think there is a long way ahead, and
> we shouldn't hold up v5 on this.

We shouldn't rush, only to keep some deadline, and regret it later
that we butchered the index format without thinking things through.
When this was added to the GSoC idea page, I already said upfront
that this was way too big a topic to be a GSoC project, didn't I?

> It would open some interesting possibilities.

It is unclear why the current format is less easier to get the same
kind of enhancement compared to the proposed v5 for the same kind of
"possibilities."

"This codepath currently does things this way because it is limited
by the flat in-core index.  That codepath does a similar thing, and
that other one has the same issue.  They all can benefit if we give
them this API, and the implementation of the API could benefit if
the underlying on-disk format is changed that way.  And the other
codepaths that use the current API won't be broken by the on-disk
format change, as all the accesses are encapsulated with this patch
without losing performance, readability nor modifiability" is very
much acceptable [*1*], but "The new on-disk format is different from
the current one, and as it is different from the current one, we can
easily enhance it even more by hooking anything interesting to it!"
does not sound like a valid argument.  

> For example, for v5 it
> would be far better if conflicted and resolve-undo entries were a
> property of the normal index entry, instead of something that so happens
> to be consecutive entries and in a completely different place,
> respectively.

I am not sure I am convinced.  Conflicts are already expressed by an
attribute on a normal index entry (it is called "stage"), and
because we check for "is the index fully merged" fairly often, it
makes sense to have it in each entry.  Actually having an unmerged
entry is a rare event (happens only during a mergy operation that
gave control back to you), so we do not lose much by expressing them
as consecutive entries.  Resolve-undo is far less often used, and is
not an essential feature, so it makes perfect sense to have it as an
optional index extension to allow versions of Git that are unaware
of it to still use an index file that has it.

I do not find your "For example" argument particularly convincing
rationale to go to the proposed v5, even if I thought resolve-undo
were one of the more important things in the index (which I don't).


[Footnote]

*1* Duy's "'ls-files $path' would benefit from a path-limited index
file reader, and the function to do so would be an obvious new API
that would benefit from tree-shaped on-disk format" suggestion is a
design going in the right direction, as long as it is accompanied
with "for the remaining users that need the whole index as a linear
array, reading such a tree-shaped on-disk format can be supported
without loss of performance with this patch".

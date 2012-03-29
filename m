From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC] Designing a faster index format
Date: Thu, 29 Mar 2012 14:06:55 -0700
Message-ID: <7vk423qfps.fsf@alter.siamese.dyndns.org>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com>
 <CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com>
 <8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com>
 <CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com>
 <871uomrubl.fsf@thomas.inf.ethz.ch>
 <8901F6B5-7396-44E1-9687-20BF95114728@gmail.com>
 <871uomq64c.fsf@thomas.inf.ethz.ch>
 <BDFA27C9-C999-4C95-8804-5E7B3B3D1BFD@gmail.com>
 <878virfx11.fsf@thomas.inf.ethz.ch>
 <2A61C352-5C71-4EDF-9DBE-01CC09AE03A5@gmail.com>
 <87r4we9sfo.fsf@thomas.inf.ethz.ch>
 <5CE5AEC7-22C8-4911-A79E-11F2F3D902A2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	<git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 23:07:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDMYj-0008Fq-9H
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 23:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759340Ab2C2VHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 17:07:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60710 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752705Ab2C2VG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 17:06:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E24DB7A3E;
	Thu, 29 Mar 2012 17:06:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Un6L5YH5cUR+A7lgScwOZJlR6ik=; b=pSwWFj
	Wg2TYS5x7jw3CZiqrY/0xJ2OShCMUYALxUlIN3UdTvEP8WKTRJxq8s0GmjtY1+63
	qD3Hyi/VXm3dFJskCe7JvUDYCqjRZf+Vq+GRWdjNuJiqCeJ0pyIpvZzBsf2SEJUZ
	juB/hKsqo5RTpsozqmbBdhJyPjTnpjKa7TBEE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L+/J3k1/nndsxeo9FSpv54vkwxQ9Y1qq
	4ZoTbQpOtvHzz4QQAaWc5JfAhLtjpWorfUGp00+RrcTGsMKEmBa25CepraGcZSuR
	ZqYGtilBUaQFRWUXgSG9Hidq8WQh88SaizDW2AFy3ygdP2ieN93h5jyq4ka52q4i
	+RFSeAaniY0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D830D7A3D;
	Thu, 29 Mar 2012 17:06:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0BBBC7A3C; Thu, 29 Mar 2012
 17:06:56 -0400 (EDT)
In-Reply-To: <5CE5AEC7-22C8-4911-A79E-11F2F3D902A2@gmail.com> (Thomas
 Gummerer's message of "Thu, 29 Mar 2012 17:21:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E4B06FA-79E3-11E1-AC95-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194292>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> After the discussion on IRC and the taking your suggestions into account
> I've rewritten my proposal draft as follows.

Just a few comments after a cursory review over the draft.

> -- Problem --
> The current git index is pretty slow when working with large git repositories,
> because the whole index has to be rewritten for nearly every operation. For
> example for adding a single file with git add, even though logically only one 
> single blob sha-1 is changed in the index, git has to recompute the hash over 
> the whole index and rewrite the index file.

Is it really the time consuming part in the overall picture?  Do you have
vital statistics for various pieces to justify that you are solving the
right problem?  E.g. (not exhaustive)

 - read_index(): overhead to
   - validate the checksum of the whole index;
   - extract entries into the_index.cache[] array;

 - write_index(): overhead to
   - serialize entries into the on-disk format;
   - compute the checksum over the entire index;
   - write the whole index to disk;

 - frequency of the above two operations.  

I think the current code tries to do the checksumming, in both read and
write directions, in line with the actual I/O operation, not as a separate
phase.  You may have to instrument (read: butcher) the current code to
replace the streaming checksum code with no-op to measure the checksum
overhead.  In other words, running "time git update-index foo" from the
command line and subtracting "time sha1sum .git/index" would not be a
right way to compute it (it subtracts both disk I/O and checksum
overhead).

Also, optimizing the write codepath by penalizing the read codepath is a
wrong trade-off if the index is read far more often than it is written
during a single day of a developer.

> -- Proposed solution --
> The proposed solution is to rework the index, using a append-only data
> structure. That shall allow for changes to the index in O(k) time, with k being
> the number of files that changed. To reach this goal, the first part of the
> index will be sorted and changes will always be written to the end, in the order
> in which the changes occured. This last part of the index will be merged with
> the rest using a heuristic, which will be the execution of git commit and git
> status.
>
> To make sure the index isn't corrupted, without calculating the sha-1 hash for
> the whole index file every time something is changed.

This is not a sentence. "do Z" in "To do X without Y, do Z" is missing.

> The hash is always
> calculated for the whole index when merging, but when a file is changed the
> sha-1 hash is only calculated for the last entry.

I know this is still a loosely written draft, but "only calculated for the
last entry" is very disturbing.  When we say "entry" in the context of
index we always mean a single cache entry, but obviously that is not what
you are using this word for.  You mean the last "batch" of entries in a
log structured index file format.

The new batch in the log structured file, if it were to be protected with
the checksum, should take the checksum of the previous part into account
when computing the checksum of the new part, by chaining.  Imagine an
index file that was written twice, consisting of parts A and B, in an
append-only fashion. Somewhere in part A (probably near the end but it
does not have to be), there is a checksum to verify part A's consistency.
If the checksum for B is derived solely on the data in B, a bug could
replace the part B with different data C that satisfy its self consistency
check, but when you take A followed by C together, the result may not make
sense. One technique to avoid such mistakes is to use checksum in A and
data in B to compute checksum for B.

> This has some cost when
> reading the index, but the performance improvements when writing the index
> should more then make up for that. 

Obviously, "should more than make up" needs substanciation.

> ... In addition to that it
> can also give the index a structure, which in turn makes it easier to search
> through.

I do not think you are saying "The current index does not have a structure
so it is hard to search through. Let's give it a structure to make it easy
to search.", but then it becomes unclear what the purpose of saying "give
the index a structure" here.  The sentences in this paragraph may need to
be reworked somewhat.

> In order to be able to only rewrite a part the way the lock file currently works
> has to be changed. Currently the new index is always written into the lock file,
> which then is renamed once the writing is complete. Since we now change to an
> append only format, if the operation fails, only the last record in the index
> is corrupted and we can easily recover by removing the corrupt record.

Careful.

Two processes trying to append to the same index at the same time still
needs to be coordinated via some kind of lock.

> When the
> is merged the old lock file algorithm will be used.

-ECANNOTPARSE.

> To maintain the speed even if a file is already in the index, git will always
> append a new record on the end, instead of finding the record in the index and
> changing it.

This makes it sound as if you think you can append without reading, but I
do not think that is what you meant. You would need to know what is in the
index to deal with D/F conflicts, so you need to "find" the entry (and
paths related to it) first. The append-only arrangement allows you to
avoid updating in place, which is the plus (i.e. "changing it" part in the
above sentence is valid, "finding" is not).

> This will give us a lot of benefit in terms of speed, since
> otherwise we would have to search the record (log(n)), change it (1) and update
> the sha-1 hash over the whole file (n).

See the comment about on "search the record" part.

Of course the reader suffers because it needs to read more to learn what
the end result of replaying all the log records. The question is by how
much.

Also you would need to worry about the case where an index entry is
removed (your log record needs to be able to express "remove this path").

> Backward compatibility will be broken (at least for write) once the in-memory
> structure is changed.

That is totally backwards, isn't it?

The in-memory structure can be improved in new implementation without any
compatibility issues as long as the on-disk format is not changed.

> Git could still keep compatibility for reading the index
> and converting it to the new in-memory format, but keeping write compatibility
> would slow down the operation and mess up the code.

The new on-disk format is poorly designed if that has to happen.

> -- Timeline --
> 24/04 - 29/04: Document the new index format.
> 30/04 - 15/05: Map the current internal structure to the new index format.

That sounds very aggressive, as I am assuming that by Apr 29 you will have
all the data that justifies the "new index format" will solve whatever
problem you are solving and also justifies the "problem" you are solving
is really what we want to solve (e.g. optimizing for writers by penalizing
readers, when readers are predominant, is not solving the right problem).

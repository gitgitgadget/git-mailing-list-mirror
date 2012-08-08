From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 0/16] Introduce index file format version 5
Date: Wed, 08 Aug 2012 09:31:37 -0700
Message-ID: <7vvcgttkeu.fsf@alter.siamese.dyndns.org>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344263760-31191-1-git-send-email-pclouds@gmail.com>
 <7vehnjzzfd.fsf@alter.siamese.dyndns.org>
 <CACsJy8CepAQr4r-c_hzwgT2-_bpFV-=VmOsFaBcDZqBpG52reQ@mail.gmail.com>
 <7v7gtaups3.fsf@alter.siamese.dyndns.org>
 <CACsJy8DfJJpwidfUQFDeqM=5uPpGF6rZ6C1pS0H6mSNHUqOkbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
	trast@student.ethz.ch, mhagger@alum.mit.edu,
	robin.rosenberg@dewire.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 18:31:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz9Ah-0008GV-5c
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 18:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030399Ab2HHQbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 12:31:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46424 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758873Ab2HHQbk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 12:31:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF38D9C1F;
	Wed,  8 Aug 2012 12:31:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BWg7HM41nU582MHzBjeqy303Cpg=; b=E9CRVt
	IVuM0kJQVSXZEgEZp+eVqkapd50kvHbUzI9qsBbCtNtVe8HlDR3fdvlS4drvE03v
	S8V/SsUwQyJpnlohPGIG5Aj1n+53HqbEbagnFoMAqksxeaCK/2rmUhpa5N0J64/e
	m0d/5zkmnob3xS99/m0LTTUXwIrjRi0gBuZqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QtyMxYmlF/pXXIk6GGvyVTjtY4KI3Wjl
	6oYhQOSE26RUg40ICvfMdLoZg1aDmJNqV664q7mWITBBoW8hYKM9Zmr3mgoEarWK
	oZ4+qKnDDVtSG1p7OYiXugMgjbNfmXuH38vBG7jIb927pAhep4h7uiNvc+Iy/vjR
	jN//7EhPgMQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BF639C1E;
	Wed,  8 Aug 2012 12:31:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BBA809C1C; Wed,  8 Aug 2012
 12:31:38 -0400 (EDT)
In-Reply-To: <CACsJy8DfJJpwidfUQFDeqM=5uPpGF6rZ6C1pS0H6mSNHUqOkbg@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 8 Aug 2012 20:54:09 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 872C5D86-E176-11E1-995F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203096>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> OK how about this. The general idea is preserve/extend current flat
> index API and add a new (tree-based) one. Index users can use either.
> They can even mix them up (which they do because we can't just flip
> the API in one day for about 200 source files).
>
> The day that unpack_trees() is converted to tree API, I will declare
> v5 victory ;)

s/API, /API and benchmark says tree-shaped index is an overall win, /;

> = Cleanup =
>
> struct cache_entry becomes partly opaque. ce_ctime..ce_gid are hidden
> in -v2.c and -v5.c. We only expose ce_size, ce_flags, ce_namelen, name
> and sha1 to index users. Extra v5 fields like ce_stat_crc, next and
> dir_next are also hidden. These fields can be put in a real struct in
> read-cache.h, which is supposedly included by -v2.c and -v5.c

I do not particularly see a reason to keep different in-core
cache_entry representations even in an early round of the API
updates.  If v2 needs ctime and gid and v5 needs crc, keep both
fields for simplicity.  When coming from the filesystem, ctime, gid
and friends are immediately available and crc needs to be computed
only immediately before it is written out or it is compared with an
existing entry.

I also do not see a reason to keep two representations of in-core
index_state representations for that matter.

The current code that access nth entry from the index->cache[nth]
would need to be updated to use an accessor function, whether the
"nth" comes from index_name_pos() or from the for-loop that iterates
over the entire index.  For the latter, you would need to give the
users a function that returns a cursor into the in-core index to
allow iterating over it.

When you use an in-core representation that is not a flat array, the
type of "nth", which is essentially a cursor, may have to change to
something that is richer than a simple integer, in order to give the
implementation of the in-core index a more efficient way to access
the entry than traversing the leaves of the tree depth first, and
you would need to update index_name_pos() to return such a "cursor".
That design and development cost is part of updating the in-core
data structure. In the end result, the runtime cost to manipulate an
index entry that the cursor refers to should be minimum, as that
would be the cost paid by all the users of the API anyway, even if
we _were_ starting from an ideal world where there weren't any flat
in-core index in the first place.

Because the v2 on-disk format forces us to scan the whole thing at
least once, with a properly designed in-core representation, the
overall system would not suffer performance penalty when reading
from v2, as both the current code and the updated code have to read
everything, and accesses based on the cursor given by either
index_name_pos() or the index iterator has to be fast anyway (if the
latter does not hold true, your updated in-core representation that
is not a flat array needs to be rethought).

On top of such a solid foundation, we can map the updated in-core
representation to an on-disk representation with confidence, as any
performance improvement or degradation from that point on must be
solely attributable to the on-disk format difference.

Without such a foundation, it is hard to justify a different on-disk
format without handwaving, no?

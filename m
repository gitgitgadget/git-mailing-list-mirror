From: Junio C Hamano <gitster@pobox.com>
Subject: Re: {bug} warning: unable to access 'RelNotes/.gitattributes'
Date: Thu, 13 Sep 2012 18:28:32 -0700
Message-ID: <7vobl94clb.fsf@alter.siamese.dyndns.org>
References: <7vpq5qa0w9.fsf@alter.siamese.dyndns.org>
 <20120913123740.GB4287@sigill.intra.peff.net>
 <7vy5kd7lu0.fsf@alter.siamese.dyndns.org>
 <20120913211512.GA16968@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 14 03:28:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCKi4-00037W-Pg
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 03:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329Ab2INB2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 21:28:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58834 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200Ab2INB2f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 21:28:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63CFA86FF;
	Thu, 13 Sep 2012 21:28:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dnTVWWZVcb656xKptxgbEjGtiOQ=; b=i1YujZ
	CGbuAdWSMKTsgQ3ItKrHP2doNzr1M2/IAvwDIOzmE2oZ1A6KmFwS5TzBqTawUiCW
	SY9/vVJUjUcli0/U1wZUQAFTgB0exXes5tx9VDuoEkcS6gQCcjheqTCYFkAsqgTS
	rHKZhBQGS98os5D0CLD6PV9aAxJ+hEc3HPb9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SDhgfMjK+JVWZZ+gEaZ6e++II7wT+Ta8
	je3idUA+pLVvwVuiB9WXcTBARTIKKCezO494l4o9XRdPVjEO8EWxcbxsaptZFu3n
	1Xp+A62se4bOI93hUFFCvYvhCC3tHDD8uxXB/FILYlnCI+wHik+M2/X02MlBfxAq
	IDLCXn9YEvs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5143986FD;
	Thu, 13 Sep 2012 21:28:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 820F886FA; Thu, 13 Sep 2012
 21:28:34 -0400 (EDT)
In-Reply-To: <20120913211512.GA16968@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 13 Sep 2012 17:15:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 801E67BC-FE0B-11E1-B0AC-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205443>

Jeff King <peff@peff.net> writes:

> On Thu, Sep 13, 2012 at 12:40:39PM -0700, Junio C Hamano wrote:
>
>> > Interesting. I don't get any such warning on repack. And RelNotes points
>> > to a file, so I'm not sure why stat() would make us think it was a dir.
>> 
>> Interesting.  The command in question is
>> 
>>  git-pack-objects --keep-true-parents --honor-pack-keep --non-empty \
>>     --all --reflog --delta-base-offset </dev/null .junk-pack
>
> Weird. I don't see any problems with that command, either (I tried it
> with the current 'next'). Thinking that maybe delta reuse was getting in
> the way, I also tried it with --no-reuse-delta.
>
>>  - "rev-list --object --all" does not produce "Relnotes/1.7.4.txt"
>>    (it does have "Documentation/RelNotes/1.7.4.txt", of course).
>>    Somebody in this callchain is screwing the name up.
>
> Yeah, that sounds like a pretty huge bug. But since I can't reproduce,
> you're on your own for tracking it down.

I have a remote tracking branch refs/remotes/repo/html that has the
path RelNotes/1.7.4.txt at the top ;-)  Depending on how traversal
goes, if the tree that represents that RelNotes directory in the html
tree is found before the tree that represents Documentation/RelNotes 
directory in the main history at the corresponding commit, it is
perfectly normal that we discover the blob as RelNotes/1.7.4.txt, so
there is no bug.

So among the three points I raised, the first one was a false issue,
the second one is real (we do look for attributes in the working
tree for historical commit, or for a commit that does not belong to
the same lineage as the one that is currently checked out, hence we
must ignore ENOTDIR), and the third one is unrelated.

> I think that this:
>
>> diff --git i/attr.c w/attr.c
>> index f12c83f..056d702 100644
>> --- i/attr.c
>> +++ w/attr.c
>> @@ -353,7 +353,7 @@ static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
>>  	int lineno = 0;
>>  
>>  	if (!fp) {
>> -		if (errno != ENOENT)
>> +		if (errno != ENOENT && errno != ENOTDIR)
>>  			warn_on_inaccessible(path);
>>  		return NULL;
>>  	}
>
> is the right thing to do. It's cool that it uncovered a bug in this
> case, but it is easy to construct a non-bug case that would exhibit the
> same bogus warning (just convert a directory into a file).

Yes.

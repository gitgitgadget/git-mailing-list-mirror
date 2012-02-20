From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status: small difference between stating whole repository
 and small subdirectory
Date: Mon, 20 Feb 2012 12:08:03 -0800
Message-ID: <7vfwe5l13w.fsf@alter.siamese.dyndns.org>
References: <20120216192001.GB4348@sigill.intra.peff.net>
 <CAA01Csq6vSekW=Fa236bB0H3LVtN43Gb2aLMVE+A1wVyUqYJ7A@mail.gmail.com>
 <20120217203755.GA30114@sigill.intra.peff.net>
 <7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
 <20120217222912.GC31830@sigill.intra.peff.net>
 <CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
 <20120220140653.GC5131@sigill.intra.peff.net>
 <87ty2l38ay.fsf@thomas.inf.ethz.ch> <20120220143644.GA13938@do>
 <20120220143952.GA8387@sigill.intra.peff.net>
 <20120220151134.GA13135@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 21:08:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzZWu-0006Ic-Ql
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 21:08:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518Ab2BTUII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 15:08:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61790 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752076Ab2BTUIF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 15:08:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 207AA7E38;
	Mon, 20 Feb 2012 15:08:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DDe7ObccPsjAk2RVLOPP8jvkRs0=; b=wPQ8HI
	Jvoa7dmO+w/vtN+EIKB3c5WzqIFEALZROninSZrY/Rlnq9My+utr/QXbd5Pu4fmW
	ZkrtfKFeyRX2+pj7HwA51ZX2JADSmt5soWTp8aBdvLREbwUeZK/W4cgxaAV9Ggrx
	VwORaW7tReFjc8cTriyZOX/gduXF7G5u+VqFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UFr4TC1R2umEBzROdXoUb2rEfu8NIOxQ
	/GQ/+EHwmHO5wB0N3ajw9HKvLTHP2oIw6ANZOrOzt9TEvR/bN/5VeE8WTD/IDpNg
	SknznZKi6Af2k0hzbrHm+GsT0MyM8WBxReRsMjJ5aoPtixCdb8Bncdli4Bp3z82w
	Mcs9f9Y/Hgo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 133437E37;
	Mon, 20 Feb 2012 15:08:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 996C17E36; Mon, 20 Feb 2012
 15:08:04 -0500 (EST)
In-Reply-To: <20120220151134.GA13135@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 20 Feb 2012 10:11:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 991C37A8-5BFE-11E1-9725-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191096>

Jeff King <peff@peff.net> writes:

>   4. At the end of unpack_trees, we forget about src_index, and copy
>      o->result into *o->dst_index byte for byte. I.e., we overwrite
>      the_index.cache_tree, which has been properly updated the whole
>      time,

I strongly suspect that "properly updated" part needs to be thoroughly
audited.  I wouldn't be surprised that this behaviour is what we did when
we split src_index vs dst_index when he rewrote unpack_trees() in order to
emulate the original "unpack-trees is beyond salvation because it does not
maintain cache tree correctly, just nuke it" behaviour.

> But it does not actually insert the _destination_ tree into the cache
> tree. Which we can do in certain situations, but only if there were no
> paths in the tree that were left unchanged (e.g., you modify "foo", then
> "git checkout HEAD^", which updates "bar". Your tree does not match
> HEAD^, and must be invalidated).  While it would be cool to be able to
> handle those complex cases,...

It may look cool but it may not be a good change. You are spending extra
cycles to optimize for the next write-tree that may not happen before the
index is further updated.

> I think this implementation matches the intent of the original calls to
> cache_tree_invalidate_path sprinkled throughout unpack-trees.c.

Yes, and as long as we invalidate all the directories that need to be
invalidated during the unpack-tree operation, I think it is a correct
thing to do.

> But I
> have to say that it seems a little odd for us to be modifying the
> o->src_index throughout the whole thing.

Yes, that part is logically *wrong*.  I think it is a remnant from the
days when there was no distinction between src_index and dst_index.

> I would think the right thing
> would be to make a deep copy of o->src_index->cache_tree into
> o->result.cache_tree as the very first thing, and then update
> o->result.cache_tree throughout the tree traversal.

Yes.

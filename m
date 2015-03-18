From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] diff-lib.c: adjust position of i-t-a entries in diff
Date: Wed, 18 Mar 2015 13:30:53 -0700
Message-ID: <xmqqtwxikpz6.fsf@gitster.dls.corp.google.com>
References: <1425910445-27383-2-git-send-email-pclouds@gmail.com>
	<1426514206-30949-1-git-send-email-pclouds@gmail.com>
	<5506F3A9.1020704@drmicha.warpmail.net>
	<xmqqa8zdrkpy.fsf@gitster.dls.corp.google.com>
	<20150317140704.GA7248@lanh>
	<xmqq1tknpkwd.fsf@gitster.dls.corp.google.com>
	<CACsJy8Beoz=qcHrOG=akCR+gOQRjBcsQHaXdL_=PW70BOf4q3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 23:58:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYMuv-0000ud-LT
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 23:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbbCRW6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 18:58:21 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61401 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751563AbbCRW6U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 18:58:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5158D428AC;
	Wed, 18 Mar 2015 18:58:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JFiZCZkBnl+Grhe26ib1IYMzJTc=; b=D3PbMc
	/xRDx3EGnVE8tSsEE7f2uIwxTHvjuvS5gleUBA2bXfN0TayRdrfZ1vqNd1/hORvr
	tXrB7pzYCfXG6qFVnQcKbGSBbS9ZOHfMmgI7GrkHjz+CNSGRnpxZnu5WhT+JxE7/
	Ccmyk+0GtPCjjTY5jWvH6qFhUYGRX9Dtm9cd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PTTS3oB/C4i/5M8w9NeBVXkK/r9VAQ0b
	tWGNlTgckGmEqs6DkEKGkWpWv5PbrVZqZZonxxJ0IVkIbh9Cm+WOJrAQ95dMfWjZ
	1BzO6H+qa23JYYNQKSzpbRa+SsFHvbWGN81AgAc0OxVDe00s8HFkNROVvWKKDrCc
	NO+mebK4kcM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 48B59428AB;
	Wed, 18 Mar 2015 18:58:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A256B43890;
	Wed, 18 Mar 2015 16:30:54 -0400 (EDT)
In-Reply-To: <CACsJy8Beoz=qcHrOG=akCR+gOQRjBcsQHaXdL_=PW70BOf4q3g@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 18 Mar 2015 19:47:11 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AD32C7C4-CDAD-11E4-89B9-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265772>

Duy Nguyen <pclouds@gmail.com> writes:

> Right. I missed this but I think this is a less important test
> because I added a new test to make sure "diff --cached" ("git
> status" to be exact) outputs the right thing when i-t-a entries
> are present.

OK.

>> If on the other hand the tests show the same result from these two
>> "diff --cached" and the result is different from what the test
>> expects, that means your patch changed the world order, i.e. an
>> i-t-a entry used to be treated as if it were adding an empty blob to
>> the index but it is now treated as non-existent, then that is a good
>> thing and the only thing we need to update is what the test expects.
>> I am guessing that instead of expecting dir/bar to be shown, it now
>> should expect no output?
>
> Yes, no output.

Good, as that means your changes did not break things, right?

> But still, if I revert the change in cache-tree.c and force write-tree
> to produce valid cache-tree when i-t-a entries are present, this test
> still passes incorrectly.

This is worrysome.

Doesn't that suggest that the diff-cache optimization is disabled
and cache-tree that is marked as valid (because you "revert" the
fix) is not looked at?  That is the only explanation that makes
sense to me---you write out a tree omitting i-t-a entries in the
index and update the index without your earlier fix eec3e7e4
(cache-tree: invalidate i-t-a paths after generating trees,
2012-12-16), i.e. marking the cache-tree entries valid.  A later
invocation of diff-cache *should* trust that validity and just say
"the tree and the index match" without even digging into the
individual entries, at which point you should see a bogus result.

If that is the case, it would be a performance regression, which may
be already there before your patches or something your patches may
have introduced.

Ah, wait.

I suspect that it all cancels out.

 * You "add -N dir/bar".  You write-tree.  The tree is written as if
   dir/bar is not there.  cache-tree is updated and it is marked as
   valid (because you deliberately broke the earlier fix you made at
   eec3e7e4).

 * You run "diff-cache".  It walks the HEAD and the cache-tree and
   finds that HEAD:dir and the cache-tree entry for "dir" records
   the same tree object name, and the cache-tree entry is marked
   "valid".  Hence you declare "no differences".

But for the updated definition of "diff-cache", there indeed is no
difference.  The HEAD and the index matches, because dir/bar does
not yet exist.

OK, so I think I can see how the result could work without
invalidating the cache-tree entry that contains i-t-a entries.

It might be even the right thing to do in general.  We can view that
invalidation a workaround to achieve the old behaviour of diff-cache,
which used to report that dir/ are different between HEAD and index.

We can even argue that it is the right thing to mark the cache-tree
entry for dir/ as valid, no matter how many i-t-a entries are in
there, as long as writing out the tree for dir/ out of index results
in the same tree as the tree that is stored as HEAD:dir/.  And from
that viewpoint, keeping the earlier fix (invalidation code) when
these patches are applied _is_ introducing a performance bug.

Now, as you mentioned, there _may_ be codepaths that uses the same
definition of "what's in the index" as what diff-cache used to take
before your patches, and they may be broken by removing the
invalidation.  If we find such codepaths, we should treat their old
behaviour as buggy and fix them, instead of reintroducing the
invalidation and keep their current behaviour, as the new world
order is "i-t-a entries in the index does not yet exist."

Thanks for straightening my confusion out.

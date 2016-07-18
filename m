Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D1482018B
	for <e@80x24.org>; Mon, 18 Jul 2016 18:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbcGRSBL (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 14:01:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56856 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751591AbcGRSBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 14:01:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EC37A2C149;
	Mon, 18 Jul 2016 14:01:07 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2eGdecwYjfd6Ndk0+wVayV4DZkw=; b=VaNWTI
	c76YmPlbWcN35ZAu22ajlqRi/1Ail4PZTnR/VcAxQ5rbfJFJx4Txg2TmwHYqdWBp
	BCEEOtI4kyUVCC7U6fdS86+gTjoekhZ7mwOsnVfbd6L6pLnqWc9/qsHABXwbliGs
	LuIBJc9rLgDf8ehL7K5cIbimq+R5Z0V6j3f6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o4xpArd2PyQe4JO2pvO1Lt1k94bYGsV8
	K25e1d8Mw2McoeQwfV3JCEQuJPuTR6RN21gNiQVUY6oGtiDJAtnhGuexRMuwpxhN
	jK6+ALjKOouI2lBZ1R5pk/hn5nO2cjOGQSMVy5GKM9JPXvQZnmAhtVILuSnB7gAF
	cmNxEZhCIhQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E2E7A2C148;
	Mon, 18 Jul 2016 14:01:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 620BC2C145;
	Mon, 18 Jul 2016 14:01:07 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	"brian m. carlson" <sandals@crustytoothpaste.net>
Cc:	Theodore Ts'o <tytso@mit.edu>, Duy Nguyen <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Herczeg Zsolt <zsolt94@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Git and SHA-1 security (again)
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
	<20160716201313.GA298717@vauxhall.crustytoothpaste.net>
	<alpine.DEB.2.20.1607170949360.28832@virtualbox>
	<20160717142157.GA6644@vauxhall.crustytoothpaste.net>
	<CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com>
	<20160717154234.GC6644@vauxhall.crustytoothpaste.net>
	<20160717162349.GB11276@thunk.org>
	<20160717220417.GE6644@vauxhall.crustytoothpaste.net>
Date:	Mon, 18 Jul 2016 11:00:35 -0700
In-Reply-To: <20160717220417.GE6644@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Sun, 17 Jul 2016 22:04:17 +0000")
Message-ID: <xmqq4m7mltbw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 99F51312-4D11-11E6-8A33-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I will say that the pack format will likely require some changes,
> because it assumes ...
> The reason is that we can't have an unambiguous parse of the current
> objects if two hash algorithms are in use....
> So when we look at a new hash, we need to provide an unambiguous way to
> know what hash is in use.  The two choices are to either require all
> object use the new hash, or to extend the objects to include the hash.
> Until a couple days ago, I had planned to do the former.  I had not even
> considered using a multihash approach due to the complexity.

Objects in Git identify themselves, but once you introduce the
second hash function (as opposed to replacing the hash function to a
new one), you would allow people to call the same object by two
names.  That has interesting implications.

Let's say you have a blob at path F in a top-level tree object and
create a commit.  You have three objects in total, the tree knows
the blob as one name based on SHA-1 and the commit knows the tree as
one name based on SHA-1.  The same contents of the blob and the tree
could have different names based on SHA-256 in the future Git.

Let's further say you have a future Git and clone from the above
repository with three objects.  You get a pack stream, containing
the data for one commit, tree and blob each.  These objects do not
carry their own name as extra pieces of information.  You only get
their contents, and it is up to you to name them by hashing.  .idx
files are created by running index-pack while receiving the pack
data stream.  You _somehow_ need to know that these three objects
need to be hashed with SHA-1, even though you are SHA-256 capable,
because otherwise the object name recorded in the tree object for
the blob would not match what your .idx file would call the blob
data.  Also the object name recorded in the ref to point at the
commit would not match the commit object's object name, unless you
hash with SHA-1.  It is a possibility to always hash these objects
twice and record _both_ hashes in the updated .idx file; after all,
.idx files are strictly local matter.

Now let's further say that you update the file F in the working
tree, and do "git commit -a" with updated version of Git.  What
should happen?  Assuming that we are trying to migrate to a
different hashing algorithm over time, we would want to create a new
blob under object name based on SHA-256, add that to the index and
write a new tree out, named by hashing with SHA-256.  We then record
that longer-named tree in a commit whose parent commit is still
named with SHA-1 based hash, and the new commit in turn is named by
hashing with SHA-256.

Then you push the result back.  Let's assume by now the place you
cloned from is also SHA-256 capable.  You look at the tips of refs
at your clone-source and discover that you would need to only send
the new commit, its tree and the updated blob.  You send data in
these three objects.  The receiving end would now need to do the
same "magically choose hash to make sure the new blob gets the name
that is recorded in the new tree (and the new tree the new commit)"
thing.  The same discussion applies if somebody else clones from you
at this point.  The objects introduced by the second commit all need
to be hashed with the new hash to be named, while the other objects
need to be hashed with the old hash.

Continuing this thought process, I do not see a good way to allow us
to wean ourselves off of the old hash, unless we _break_ the pack
stream format so that each object in the pack carries not just the
data but also the hash algorithm to be used to _name_ it, so that
new objects will never be referred to using the old hash.

It matters performance-wise that the weaning process go as quickly
as possible, once the system becomes capable of new hash algorighm,
because during the transition period, we'd have to suffer the full
tree-diff becoming inefficient (Note: don't limit your thinking to
just "git diff" and "git log"; the same inefficiency hits "git
checkout" to switch branches and "git merge" to walk three trees in
parallel), because we cannot skip descending into subdirectories
based on the tree object name being equal, which guarantees that
everything under the hierarchy is equal.



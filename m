Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0463BC433F5
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 19:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbiBFTZe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 14:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiBFTZd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 14:25:33 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC3DC06173B
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 11:25:31 -0800 (PST)
Received: from host-92-7-140-211.as13285.net ([92.7.140.211] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nGnA8-0007wd-Cg; Sun, 06 Feb 2022 19:25:29 +0000
Message-ID: <eca83634-ee91-89bd-567e-6b0807b5ff79@iee.email>
Date:   Sun, 6 Feb 2022 19:25:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Commit SHA1 == SHA1 checksum?
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Gamblin, Todd" <gamblin2@llnl.gov>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <ED97E252-CABA-41BB-B18C-819A5EF305E3@llnl.gov>
 <121ce485-bea8-3168-aa35-d11eb13022da@iee.email> <xmqq1r0gjo6h.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqq1r0gjo6h.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/02/2022 10:15, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>> The tag contains the sha1 hash of the release commit, which in turn
>> contains the sha1 hashes of the tree that is being released, and the 
>> previous commit in the git history, and onward the hashes roll...
> That's how a signed tag protects the commit it points at, and
> everything reachable from it. 

I was highlighting to Todd that the tag has a PGP signature which
extends the web of trust to a source of external verification. While it
is implied by 'signed', it maybe hadn't jumped out what that meant for
verifying any clone used by Todd and LLNL.

I did notice that the GitHub page
[https://github.com/git/git/releases/tag/v2.35.1] merely provides the
pretty green-bordered 'Verified' icon (management style), but doesn't
show the signature, while the
[https://git.kernel.org/pub/scm/git/git.git/tag/?h=v2.35.1] does show
the signature (technocrat style) for direct inspection. I expect for the
`.gov` inspection, the latter give more immediate confidence before
their internal checks of the signature.

>  As much or as little trust you have
> in SHA-1 in validating tarball.tar with its known SHA-1 checksum,
> you can trust to the same degree that the commit that is pointed by
> a tag is what the person who signed (with GPG) the tag wanted the
> tag to point at, and in turn the trees and blobs in that commit are
> what the signer wanted to have in that tagged commit, ad infinitum,
> in the space dimension.  At the same time, a commit object records
> the hash of the commit objects that are its parents, the whole
> history of the project going back to inception can be trusted to the
> same degree in the time dimension.

Thanks, I'd perhaps over simplified my description.
>
>> https://lore.kernel.org/git/xmqqh7n5zv2b.fsf@gitster.c.googlers.com/ is
>> a recent discussion on the refreshing of the PGP key. the post
>> https://lore.kernel.org/git/YA3nwFcYz4tbhrlO@camp.crustytoothpaste.net/
>> in the thread notes "The signature is .. over the uncompressed
>> .tar ... You therefore need to uncompress it first with gunzip."
> That thread has very little to do with the way how Git objects are
> cryptographically protected, which I discussed earlier in this
> message.

My understanding was that Todd does use the tarballs, and wanted to see
how their signature/sha1 value related to the git clone tag and commit
sha1's.
>
> Instead, it was a discussion about how the checksum files and
> tarballs at
>
>     https://www.kernel.org/pub/software/scm/git/
>
> relate to each other.  A typical release tarball for Git version
> $VERSION has multiple tarballs git-$VERSION.tar.{gz,bz2,xz,...} and
> they all uncompresses back to the same git-$VERSION.tar tarball.

Reading the thread makes clear that the signature is after expansion. It
was that aspect that I was highlighting. As the thread indicates, not
everyone is aware of that.
>
> There is git-$VERSION.tar.sign file next to them in the same
> directory.  

Our announcements don't actually mention that. The usage of a sign file
isn't always immediately obvious, such as, the question
https://stackoverflow.com/questions/30699989/how-to-verify-the-integrity-of-a-linux-tarball.

> The file is supposed to contain a detached signature
> over the uncompressed version of the archive.
>
I think part of Todd's question was how the tag and uncompressed archive
'checksums' (e.g. hashes) relate to each other and where those
guarantees come from.

As you explained, the tag's PGP signature, and the contained sha1 hash
of the tip commit, recursively guarantee the full repo. But what it
doesn't have, as far as I understand, is a copy of the appropriate
`hash`/signature for the archive, which would provide the strong link
between the two different views of the release, dispelling any doubt
that they are of the same checked out release.

Hopefully Todd will be able to clarify if that 'archive vs tag' cross
check was part of the question, or whether it was primarily focussed on
the internally Git checks during for correctness during clone and fsck.

Philip

aside, for Todd, given the mention of sha256: The Git sha256 transition
plan is https://git-scm.com/docs/hash-function-transition/ and
experimental support is available.
 

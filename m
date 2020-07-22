Return-Path: <SRS0=ybwr=BB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41394C433E3
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 21:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 164F722B3F
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 21:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732324AbgGVVOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgGVVOH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 17:14:07 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5BBC0619DC
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 14:14:07 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jyM3w-009G4p-HY; Wed, 22 Jul 2020 23:14:04 +0200
Message-ID: <ab8993fc6840765895ad39c59af1e536582e76d7.camel@sipsolutions.net>
Subject: Re: [PATCH v2] doc: remove misleading documentation on pack names
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Date:   Wed, 22 Jul 2020 23:14:03 +0200
In-Reply-To: <xmqq5zaf5ka6.fsf@gitster.c.googlers.com>
References: <20200722202629.109277-1-johannes@sipsolutions.net>
         <xmqq5zaf5ka6.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2020-07-22 at 14:09 -0700, Junio C Hamano wrote:
> 
> Please avoid "seems to be" and spend a bit of effort digging the
> history especially when we are not in a hurry to get to the definite
> answer.

I did ... but between all the file renames and moves, and not
understanding the code very well, I didn't really understand what was
going on.

Ok, so maybe "seems to be" was a bit of a cop-out because I do
understand that's what git does *now* (having just replicated it in
bup), but I have no idea how it got there.

> We can go "less explicit", or be a bit more informative by
> saying that it is the trailer hash that is standard practice shared
> across our binary files like the index and the packfile.
> 
> I think this is 1190a1ac (pack-objects: name pack files after
> trailer hash, 2013-12-05).

Indeed, that makes sense. Somehow I didn't come across this commit, but
perhaps that's because I was looking too much at index-pack.c (and its
various renames).

>   It forgot to update the comment before
> write_idx_file() function when it did this change:
> 
>  /*
>   * On entry *sha1 contains the pack content SHA1 hash, on exit it is
>   * the SHA1 hash of sorted object names. The objects array passed in
>   * will be sorted by SHA1 on exit.
>   */
>  const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects,
>  			   int nr_objects, const struct pack_idx_option *opts,
> -			   unsigned char *sha1)
> +			   const unsigned char *sha1)
>  {
> 
> Obviously, after it turned *sha1 into 'const', it no longer is
> possible for it to have anything different from what was passed in
> upon exit.

Indeed :-)

> > +Once the index has been created, the hash that goes into the name of
> > +the pack/idx file is printed to stdout. If --stdin was also used then
> > +this is prefixed by either "pack\t", or "keep\t" if a new .keep file
> > +was successfully created. This is useful to remove a .keep file used
> > +as a lock to prevent the race with 'git repack' mentioned above.
> 
> The change is good---I made sure that among these filve lines, what
> changed was only the first one and half lines.  I however would have
> preferred not to see the line rewrapping.

Ok, fair - the text all seemed wrapped "nicely" so I preserved that
rather than have one line significantly shorter than the others, but if
you prefer that it's fine by me.

Really all I was trying to do is be a *little* more helpful than just
point out "the documentation is wrong"...

johannes


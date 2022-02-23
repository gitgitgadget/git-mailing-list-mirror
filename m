Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD961C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 23:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244726AbiBWXfD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 18:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242135AbiBWXfC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 18:35:02 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2412959A57
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 15:34:34 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id c14so728704ioa.12
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 15:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WaUnf1oPNUGakiOTcsSMeCoauofpHd1EUcZAmkJ6mt0=;
        b=X8XMtBCfAZ75baISoiEt6M3JZaDgVqq2E/+g5RYc8xA2zMint6VkYgx50Jlw3yWD53
         CRdL9qCA8e15lkHWPU3Sb0WKn01zkKmZq9Z6HY04tJa5mAbbD/3fH/7rCpxNCYEofmY3
         CIFizEANdPwQr+60vhRqho0TuU2mGs8mAf+ovPIaKyAygQS9T92Jwt4H+WAIcm2weyto
         wDumulhIBx0TJeRBOMH9W8nX5Vq43SBsM1DQHyvUV0z2Xaq1k/dtsm2gbyUIbbs4DIf6
         dxnb6Or1v9AymG//OJbZM6zIggozvgB691otU9X3gkSwyYSHRIfpWhKe2fIO2JEwQJrI
         yvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WaUnf1oPNUGakiOTcsSMeCoauofpHd1EUcZAmkJ6mt0=;
        b=13l/nQQv7bEjfcaYXNIeoXkrr3UrlKmL8QQPx6oS3RzZG8EpyecuZiQ+ao0VyslnAW
         6XRQTHOMtDb2TiPRVe1btmkjTQB09VTzMkMDyEN+WUgWrz2F2BWfkcB+ku/Xc/qfq1fL
         G+7IgEm1Vbddl/p75DEfiur7+btTlLwfV/EzGweSP2SjpDrGpSmpfuSMcfIme9aj8yRU
         IUiOdWC1Cp/uV8t1UrNirUKMS+n62/JSyhfe1yacVXmBCyeQ5oqTtCyfBuEShl6qzV4T
         YYa3nIq2jKZKW0AF3LfHb3XzDOoTKa1yfi/5qgWNvELmvrUaeOfVspT7buKPt+SO0T7R
         kFlg==
X-Gm-Message-State: AOAM531iIGrQ3NcS6wrUlb6DZ+8Vnv6GyZkyWtLTUuj3gPFzhG+0X/yj
        ncmBScCBW8YnHtMnj9LfnTZl4w==
X-Google-Smtp-Source: ABdhPJzOXET1GRA89/bka05VbgSrcr1FcKIpDJyg8Tm8tmzqcAXc4C0VLMM8Hh4x2dicJpXSDSYVHQ==
X-Received: by 2002:a5d:8a07:0:b0:640:cfb1:423 with SMTP id w7-20020a5d8a07000000b00640cfb10423mr54306iod.8.1645659273395;
        Wed, 23 Feb 2022 15:34:33 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e6sm680706ile.49.2022.02.23.15.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 15:34:32 -0800 (PST)
Date:   Wed, 23 Feb 2022 18:34:32 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, larsxschneider@gmail.com,
        peff@peff.net, tytso@mit.edu
Subject: Re: [PATCH 08/17] builtin/pack-objects.c: --cruft without expiration
Message-ID: <YhbEiLAX06LekNiR@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <66165917a4660f63ce60b820d178d52a51304d20.1638224692.git.me@ttaylorr.com>
 <38198f38-ca06-1ab3-344b-29e7b6857ed0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38198f38-ca06-1ab3-344b-29e7b6857ed0@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 07, 2021 at 10:17:28AM -0500, Derrick Stolee wrote:
> On 11/29/2021 5:25 PM, Taylor Blau wrote:
> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > +static int add_cruft_object_entry(const struct object_id *oid, enum object_type type,
> > +				  struct packed_git *pack, off_t offset,
> > +				  const char *name, uint32_t mtime)
> > +{
> > +	struct object_entry *entry;
> > +
> > +	display_progress(progress_state, ++nr_seen);
>
> I don't love the global nr_seen here, but it is pervasive through the
> file. OK.

Yeah; this is how all of the existing progress code works in
pack-objects.

> > +	entry = packlist_find(&to_pack, oid);
> > +	if (entry) {
> > +		if (name) {
> > +			entry->hash = pack_name_hash(name);
> > +			entry->no_try_delta = name && no_try_delta(name);
>
> This is already in an "if (name)" block, so "name &&" isn't needed.

Thanks; this is a copy-and-paste from add_object_entry(), where we
aren't in a conditional on "name". We could also fold the conditional on
whether or not name is NULL into no_try_delta itself, since all existing
calls look like "name && no_try_delta(name)".

So adding something like:

    if (!name)
      return 0;

to the beginning of no_try_delta()'s implementation would allow us to
get rid of the handful of "name &&"s. But I'm trying to avoid touching
other parts of pack-objects as much as I can, so I'll hold off for now.

> > +		}
> > +	} else {
> > +		if (!want_object_in_pack(oid, 0, &pack, &offset))
> > +			return 0;
> > +		if (!pack && type == OBJ_BLOB && !has_loose_object(oid)) {
> > +			/*
> > +			 * If a traversed tree has a missing blob then we want
> > +			 * to avoid adding that missing object to our pack.
> > +			 *
> > +			 * This only applies to missing blobs, not trees,
> > +			 * because the traversal needs to parse sub-trees but
> > +			 * not blobs.
> > +			 *
> > +			 * Note we only perform this check when we couldn't
> > +			 * already find the object in a pack, so we're really
> > +			 * limited to "ensure non-tip blobs which don't exist in
> > +			 * packs do exist via loose objects". Confused?
> > +			 */
> > +			return 0;
> > +		}
> > +
> > +		entry = create_object_entry(oid, type, pack_name_hash(name),
> > +					    0, name && no_try_delta(name),
> > +					    pack, offset);
> > +	}
> > +
> > +	if (mtime > oe_cruft_mtime(&to_pack, entry))
> > +		oe_set_cruft_mtime(&to_pack, entry, mtime);
> > +	return 1;
>
> I was confused at this "return 1" here, while other cases return 0.
>
> It turns out that there are multiple methods in this file that have
> different semantics: add_loose_object() and add_object_entry_from_pack()
> are both called from iterators where "return 1" means "stop iterating"
> so they return 0 always. add_object_entry_from_bitmap() is used to
> iterate over a bitmap and "return 1" means "include this object".
>
> However, the return code for add_cruft_object_entry() is never used,
> so it should probably return void or swap the meanings to have nonzero
> mean an error occurred.

Yes, exactly. And thanks for tracing out both of the different
meanings/interpretations of these add_xyz_entry() functions. As you can
imagine, this implementation is copy-and-pasted from add_object_entry(),
which was specialized for this use here. At the time, I gave some effort
towards trying to share more code with add_object_entry() for this
special case, but it ended up being pretty awkward, hence the separate
implementation.

Ironically, add_object_entry()'s return code is also unused, so we could
probably clean that up, too. But like the above, I'll avoid it for now
in an effort to touch as little of pack-objects in this patch as I can.

> > +static void mark_pack_kept_in_core(struct string_list *packs, unsigned keep)
> > +{
> > +	struct string_list_item *item = NULL;
> > +	for_each_string_list_item(item, packs) {
> > +		struct packed_git *p = item->util;
> > +		if (!p)
> > +			die(_("could not find pack '%s'"), item->string);
>
> Interesting that this is a potential issue. We are expecting the pack
> to be loaded before we get here. Is this more because some packs might
> not actually load, but it's fine as long as we don't mark them as kept?

Not quite "loaded" (though any pack structures that we look at by this
point will be fully "loaded"). Instead, we're making sure that all of
the packs names we read from stdin could be matched to packs that we
found in the repository (i.e., that we produce an appropriate error
message if we found "pack-does-not-exist.pack" on stdin).

This is all because we process input from stdin in two phases:

  - First, read all of the input into two string_lists, one for the
    packs we're about to discard (anything that start with '-'), and
    another for all of the "fresh" packs (i.e., anything that we're not
    going to discard).

  - Then, loop through all of the packed_git structs we have, querying
    both of the aforementioned string lists for input that matches each
    pack's `pack_name` field, and setting the `->util` pointer of the
    matching string_list_entry appropriately.

Following those two steps, any list entries that have a NULL util
pointer correspond with bogus input, so we want to call die() there.

> > +		p->pack_keep_in_core = keep;
> > +	}
> > +}
> ...
> > +static void read_cruft_objects(void)
> > +{
> > +	struct strbuf buf = STRBUF_INIT;
> > +	struct string_list discard_packs = STRING_LIST_INIT_DUP;
> > +	struct string_list fresh_packs = STRING_LIST_INIT_DUP;
> > +	struct packed_git *p;
> > +
> > +	ignore_packed_keep_in_core = 1;
>
> Here is a global that we are suddenly changing. Should we not be
> returning it to its initial state when this method is complete?

We could, although it won't matter in practice, because we'll want to
keep that setting around for our traversal, after which point
pack-objects will exit.

> > +static int option_parse_cruft_expiration(const struct option *opt,
> > +					 const char *arg, int unset)
> > +{
> > +	if (unset) {
> > +		cruft = 0;
>
> This unassignment of 'cruft' when cruft-expiration is unset with
> --no-cruft-expiration seems odd. I would expect
>
> 	git pack-objects --cruft --no-cruft-expiration
>
> to still make a cruft pack, but not expire anything. It seems that
> your code here makes --no-cruft-expiration disable the --cruft option.

Hmm. I could see compelling reasoning that goes both ways. On the one
hand, `--no-cruft-expiration` (to me, at least) seems to imply "set
`--cruft-expiration` to "never"). On the other hand, it also matches our
convention of `--no`-prefixed options to unset some value. This
implementation takes the latter approach, though we could easily change
it to set the cruft expiration to "never".

I don't have a strong opinion about which is better, so I'm happy to do
either if you have a better sense about which has more expected
behavior.

> > +		cruft_expiration = 0;
> > +	} else {
> > +		cruft = 1;
> > +		if (arg)
> > +			cruft_expiration = approxidate(arg);
> > +	}
> > +	return 0;
> > +}
> ..
> > +		OPT_BOOL(0, "cruft", &cruft, N_("create a cruft pack")),
> > +		OPT_CALLBACK_F(0, "cruft-expiration", NULL, N_("time"),
> > +		  N_("expire cruft objects older than <time>"),
> > +		  PARSE_OPT_OPTARG, option_parse_cruft_expiration),
>
> > -static int has_loose_object(const struct object_id *oid)
> > +int has_loose_object(const struct object_id *oid)
> >  {
> >  	return check_and_freshen(oid, 0);
> >  }
>
> I'm surprised this hasn't been modified to use a repository pointer.
> Adding another caller here isn't too much debt, though.

Yeah, check_and_freshen() doesn't have a variant that takes a
repository pointer. Good #leftoverbits, I guess!

> > +int has_loose_object(const struct object_id *);
> > +
> >  void assert_oid_type(const struct object_id *oid, enum object_type expect);
>
> ...
>
> > +	test_expect_success "unreachable packed objects are packed (expire $expire)" '
> > +		git init repo &&
> > +		test_when_finished "rm -fr repo" &&
> > +		(
> > +			cd repo &&
> > +
> > +			test_commit packed &&
> > +			git repack -Ad &&
> > +			test_commit other &&
> > +
> > +			git rev-list --objects --no-object-names packed.. >objects &&
> > +			keep="$(basename "$(ls $packdir/pack-*.pack)")" &&
> > +			other="$(git pack-objects --delta-base-offset \
> > +				$packdir/pack <objects)" &&
> > +			git prune-packed &&
> > +
> > +			test-tool chmtime --get -100 "$packdir/pack-$other.pack" >expect &&
>
> I am missing how this test creates _unreachable_ objects. I would expect removal of
> some refs or a 'git reset --hard' somewhere. What am I missing?

For this and the other tests the so-called "unreachable" objects are
technically reachable, but we can treat them as unreachable by putting
them in the "discard" packs list (or by not mentioning them at all to
`git pack-objects --cruft`).

> > +			# remove the unreachable tree, but leave the commit
> > +			# which has it as its root tree in-tact
>
> nit: "intact" is one word.

Thanks; fixed here and in the other test which was added by this commit.

Thanks,
Taylor

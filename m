Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC49C4727C
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 21:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 320C923A60
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 21:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7YBZze6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgIUVyN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 17:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgIUVyM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 17:54:12 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50BAC061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 14:54:12 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x22so5667789pfo.12
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 14:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VPh/YvayaRXrO+PNnwNEXOO1kHCZ6NsENl3tBtKPRuQ=;
        b=h7YBZze6DjZSSv/R3ltHnN36qFrkJGidde2d0nTzzAyW9wIbZjXjqxvAwwv5oEpg9p
         JZnbjZzHGj2ZDAIaQ5wHsiWwbDEY7rGvK55XgdegBuF1gVMV5ophPVYhwfzdlc+PEaB5
         IN4jOu9o+VStWLJ7kgn5hM0wEmL7RsHMKRwtMToUOT6oIUjy+hDdQ1Nonq19ddn7yf+J
         y0Ppl6hsTauxjTM/prExyV+A6JsRdepYb9wfKixzfv309Uoe4nHr2n4yr2J2RGLgFEW8
         Sx9XhRhs+yAOlhIAflrn/manmwJdP+L8tUK49Ef8qk+Xhe50BYivduD8MvJWHIcGVJJY
         wr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VPh/YvayaRXrO+PNnwNEXOO1kHCZ6NsENl3tBtKPRuQ=;
        b=VmY7NNB2jVQ68eEvSfxdTIOLxXZX+VOCNlG/HVdzpfRlJ434axAjbEHl5O+zdpg9fr
         lz5tIp9K8rh0XFoib4vTelTE+fqu2CoyhcyDZjjFg+U/xd2WPY+i/sGj7kxJjoJm8M3K
         hagG4o2osr9Ij+FodAFahMca+mDG3B1YvdTJbU68I3wB/3yfph9EiFmAjaMffNJgvkqC
         U9QJJpaJyC8t3Cey4ozJlkTKJLc+965eIuOg8WcxJdujpPvsb+uxleWkwEXabi1X4KWW
         6TTQr5ts7ptkqKh/gkaQUqj0dTDn2la2GU0dBwANddqH/B2u1zxRAbhXXXXj03JaVdeP
         FA/w==
X-Gm-Message-State: AOAM5335HIkhgFqwO3nNXwhEUQdUst1or9TpFuRlQ9p4TQtg6GT7K1Sa
        5CNFmqnmRTrw2TzKVhri49m2DqF2f04=
X-Google-Smtp-Source: ABdhPJzpCvCqABYB1uhpak7dj/VpgeSw5zu35S7kCS1H7iBggDc3rvO1WaNYKtIMW0Iaogf2d5bW1g==
X-Received: by 2002:a63:725d:: with SMTP id c29mr1215623pgn.234.1600725252048;
        Mon, 21 Sep 2020 14:54:12 -0700 (PDT)
Received: from generichostname ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id n28sm4658174pgd.18.2020.09.21.14.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 14:54:11 -0700 (PDT)
Date:   Mon, 21 Sep 2020 14:54:09 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 09/10] builtin/diff-tree: learn --merge-base
Message-ID: <20200921215409.GA1018675@generichostname>
References: <cover.1599723087.git.liu.denton@gmail.com>
 <cover.1600328335.git.liu.denton@gmail.com>
 <c0d27b125e969e13c52b0fa806a8e3caa8c20ac6.1600328336.git.liu.denton@gmail.com>
 <xmqq363gs1mt.fsf@gitster.c.googlers.com>
 <20200918104833.GB1874074@generichostname>
 <xmqqy2l7m3hk.fsf@gitster.c.googlers.com>
 <20200920110148.GA227771@generichostname>
 <xmqqzh5jf73t.fsf@gitster.c.googlers.com>
 <20200921172740.GA946178@generichostname>
 <xmqqwo0met17.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwo0met17.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, Sep 21, 2020 at 02:09:24PM -0700, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > @@ -165,7 +175,12 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
> >  	case 2:
> >  		tree1 = opt->pending.objects[0].item;
> >  		tree2 = opt->pending.objects[1].item;
> > -		if (tree2->flags & UNINTERESTING) {
> > +		if (merge_base) {
> > +			struct object_id oid;
> > +
> > +			diff_get_merge_base(opt, &oid);
> > +			tree1 = lookup_object(the_repository, &oid);
> > +		} else if (tree2->flags & UNINTERESTING) {
> >  			SWAP(tree2, tree1);
> >  		}
> >  		diff_tree_oid(&tree1->oid, &tree2->oid, "", &opt->diffopt);
> 
> OK.  Handling this in that "case 2" does make sense.
> 
> However.
> 
> The above code as-is will allow something like
> 
>     git diff --merge-base A..B
> 
> and it will be taken the same as
> 
>     git diff --merge-base A B

This does not happen because at the top of diff_get_merge_base(), we
have

	for (i = 0; i < revs->pending.nr; i++) {
		struct object *obj = revs->pending.objects[i].item;
		if (obj->flags)
			die(_("--merge-base does not work with ranges"));
		if (obj->type != OBJ_COMMIT)
			die(_("--merge-base only works with commits"));
	}

which ensures that we don't accept any ranges at all. This is why I
considered the SWAP and merge_base cases to be mutually exclusive.

> Another possibility is to error out when "--merge-base A..B" is
> given, which might be simpler.  Then the code would look more like
> 
> 
> 	tree1 = ...
> 	tree2 = ...
> 
> 	if (merge_base) {
> 		if ((tree1->flags | tree2->flags) & UNINTERESTING)
> 			die(_("use of --merge-base with A..B forbidden"));
> 		... get merge base and assign it to tree1 ...
> 	} else if (tree2->flags & UNINTERESTING) {
> 		SWAP();
> 	}

This is the route I picked, although the logic for this is in
diff_get_merge_base().

> While we are at it, what happens when "--merge-base A...B" is given?
> 
> In the original code without "--merge-base", "git diff-tree A...B"
> places the merge base between A and B in pending.objects[0] and B in
> pending.objects[1], I think.  "git diff-tree --merge-base A...B"
> would further compute the merge base between these two objects, but
> luckily $(git merge-base $(merge-base A B) B) is the same as $(git
> merge-base A B), so you won't get an incorrect answer from such a
> request.  Is this something we want to diagnose as an error?  I am
> inclined to say we should allow it (and if it hurts the user can
> stop doing so) as there is no harm done.

I think that we should error out for all ranges because this option
semantically only really makes sense on two endpoints, not a range of
commits. Since the check is cheap to protect users from themselves, we
might as well actually do it.

Worst case, if someone has a legimitate use case for --merge-base and
ranges, we can allow it in the future, which would be easier than
removing this feature.

Thanks,
Denton

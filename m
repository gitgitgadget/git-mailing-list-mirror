Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0411CC433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 07:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD5D12072D
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 07:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BO8qWK5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgHXH0n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 03:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgHXH0m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 03:26:42 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703FDC061573
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 00:26:42 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id n3so2826100pjq.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 00:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1g0mWIaZ8NIxnq0FIl2SjwgyQxKCMyf54VqpVK/B5rU=;
        b=BO8qWK5di6H2iRqRjOK98oa4hdCe1PdTAWUfLgOVEZy2uqpjwXGW9mp/hoWmwLukqY
         fl8kdGbjstAtU3wh8+fPvncRaqefW/V1g4ChzJVpbDlcm1UseAU3qwx4k7SOWs3ak/fq
         yL7DxeTSwaeRxsHwjpnbXOOianKZUHOZGlOcYR0+NbabWLrNx9xcTIGJrFGrx9nH4BTu
         Lpp9NAEEqSh5Gvcm1SH2QqMunlU5MwXvTMOKSAwhOfsEu+MRRcc7g6nhL/pQ3S7d8n9X
         9hyhidv+n4H3v0TepUUZz8CfOk1EssU0vSMGD8nyqH2FAp7mdEjSIU5MReREQY2FY09C
         uojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1g0mWIaZ8NIxnq0FIl2SjwgyQxKCMyf54VqpVK/B5rU=;
        b=RUhlLxNFJKUoQQa5OmIXmXh3RGtwAnMPjziiBJSQqdaRgV5veSnBQmY0m2c07UCxGb
         yQ1h21PO5WMtxEnVxLMEvyXbIXGbz1KbgfYoFwfuwv4FG6+TONTpdDhKxwHKnlycbIKA
         WqQMgT8W0krn/SN6Bzw2K6wM/AbfafQIZYE7LzPzse3D9CHG1tqtYhj0P4NqZGbgTVrq
         iOIbN2oqHkz8TU6O68aqE0jBL1Z129Bu0Cy/Wz8/Aohyi7D0R0mLXeY0Iv3McczUUpxS
         pwdiaIWipSvhN1+/wV13jTxy5MSE+xo1VrEJHdfaxoIVxCr3+GSbCDVhrRpM2r28kadk
         rwMg==
X-Gm-Message-State: AOAM530KVajEdXGTe+TkdpaqKuOX3zRE5z1hdnbESTjKDmy0ferJN3Db
        68hrSBZ9XsH8sGn7gY0dzoU=
X-Google-Smtp-Source: ABdhPJx07z5HLL3FqzTtBSDyIHVbcy5Wlv2mHeg85S0HXTGZPNnesMPTlHhQhUbuiwymQSma/jZp3w==
X-Received: by 2002:a17:90a:f593:: with SMTP id ct19mr2014737pjb.36.1598254001785;
        Mon, 24 Aug 2020 00:26:41 -0700 (PDT)
Received: from konoha ([27.7.229.188])
        by smtp.gmail.com with ESMTPSA id k20sm4945588pfu.197.2020.08.24.00.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 00:26:40 -0700 (PDT)
Date:   Mon, 24 Aug 2020 12:56:33 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        liu.denton@gmail.com, kaartic.sivaraam@gmail.com,
        Johannes.Schindelin@gmx.de, gitster@pobox.com, pc44800@gmail.com,
        stefanbeller@gmail.com
Subject: Re: [PATCH v3 4/4] submodule: port submodule subcommand 'summary'
 from shell to C
Message-ID: <20200824072633.GA38870@konoha>
References: <20200821171705.GA16484@konoha>
 <xmqq5z9ban27.fsf@gitster.c.googlers.com>
 <377b1a2ad60c5ca30864f48c5921ff89b5aca65b.camel@gmail.com>
 <xmqqa6yn93ll.fsf@gitster.c.googlers.com>
 <5b6ed82f3ab58a194bf51c0e2905214f64246ad8.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b6ed82f3ab58a194bf51c0e2905214f64246ad8.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/08 01:33, Kaartic Sivaraam wrote:
> > Or the caller of verify_submodule_committish() should refrain from
> > calling it for the path?  After all, it is checking sm_path is a
> > path to where a submodule should be before calling the function
> > (instead of calling it for every random path), iow its criteria to
> > make the call currently may be "the path in the index says it is a
> > submodule", but it should easily be updated to "the path in the
> > index says it is a submodule, and the submodule actually is
> > populated", right?
> > 
> 
> Ah, this reminds me of the initial version of the patch which did
> exactly that. Quoting it here for reference:
> 
> +	strbuf_addstr(&sm_git_dir_sb, p->sm_path);
> +	if (is_nonbare_repository_dir(&sm_git_dir_sb))
> +		is_sm_git_dir = 1;
> +
> +	if (is_sm_git_dir && S_ISGITLINK(p->mod_src))
> +		missing_src = verify_submodule_object_name(p->sm_path,
> +							   oid_to_hex(&p->oid_src));
> +
> +	if (is_sm_git_dir && S_ISGITLINK(p->mod_dst))
> +		missing_dst = verify_submodule_object_name(p->sm_path,
> +							   oid_to_hex(&p->oid_dst));
> +
> 
> Note: `verify_submodule_object_name` is now renamed to
> `verify_submodule_committish`.
> 
> That does sound like a sane approach to me. There's not much point in
> invoking `rev-parse` in a non-populated (a.k.a. de-initialized) or non-
> existent submodule but we removed that check as we thought it was
> unnecessary redundant because `capture_command` would fail anyway.
> Looks like we failed to notice the additional `fatal` message fallout
> then.

This is what I have tried to implement after your suggestion:

-----8<-----
strbuf_addstr(&sb, p->sm_path);
	if (is_nonbare_repository_dir(&sb) && S_ISGITLINK(p->mod_src)) {
		src_abbrev = verify_submodule_committish(p->sm_path,
							 oid_to_hex(&p->oid_src));
		if (!src_abbrev) {
			missing_src = 1;
			/*
			 * As `rev-parse` failed, we fallback to getting
			 * the abbreviated hash using oid_src. We do
			 * this as we might still need the abbreviated
			 * hash in cases like a submodule type change, etc.
			 */
			src_abbrev = xstrndup(oid_to_hex(&p->oid_src), 7);
		}
	} else {
		/*
		 * The source does not point to a submodule.
		 * So, we fallback to getting the abbreviation using
		 * oid_src as we might still need the abbreviated
		 * hash in cases like submodule add, etc.
		 */
		src_abbrev = xstrndup(oid_to_hex(&p->oid_src), 7);
	}

	if (is_nonbare_repository_dir(&sb) && S_ISGITLINK(p->mod_dst)) {
		dst_abbrev = verify_submodule_committish(p->sm_path,
							 oid_to_hex(&p->oid_dst));
		if (!dst_abbrev) {
			missing_dst = 1;
			/*
			 * As `rev-parse` failed, we fallback to getting
			 * the abbreviated hash using oid_dst. We do
			 * this as we might still need the abbreviated
			 * hash in cases like a submodule type change, etc.
			 */
			dst_abbrev = xstrndup(oid_to_hex(&p->oid_dst), 7);
		}
	} else {
		/*
		 * The destination does not point to a submodule.
		 * So, we fallback to getting the abbreviation using
		 * oid_dst as we might still need the abbreviated
		 * hash in cases like a submodule removal, etc.
		 */
		dst_abbrev = xstrndup(oid_to_hex(&p->oid_dst), 7);
	}
----->8-----

That is, add another check along with the 'S_ISGITLINK()' one. Now, the
thing is that 'rev-list' (called just after this part) starts to bother
and comes up with its own 'fatal' that the directory rev-list does not
exist.

The thing is that 'missing{src,dst}' should be set to 1 in two cases:

    1. If the hash is not found, i.e, when 'verify_submodule..()'
       returns a NULL. Something which is happening right now as well.

    2. If the SM is not reachable for some reason (maybe it does not
       exist like in our case). Something which is NOT happening right
       now.

Or if having the same variable denote two things does not please you,
then we can create another variable for the second check BUT, we will
have to incorporate checking of that variable in the 

-----8<-----
if (!missing_src && !missing_dst) {
		struct child_process cp_rev_list = CHILD_PROCESS_INIT;
		struct strbuf sb_rev_list = STRBUF_INIT;

		strvec_pushl(&cp_rev_list.args, "rev-list",
			     "--first-parent", "--count", NULL);
                 .........
----->8-----

check.

This way, we hit two birds with one stone:

    1. Bypass the 'verify_submodule..()' call when the SM directory does
       not exist. We can then remove the is_directory() test from the
       'verify_submodule_..()' function.

    2. Avoid a 'rev-{parse,list}' fatal error message and thus pass all
       the tests successfully.

Therefore, the final outcome is something like this:

-----8<-----
	if (is_directory(p->sm_path) && S_ISGITLINK(p->mod_src)) {
		src_abbrev = verify_submodule_committish(p->sm_path,
							 oid_to_hex(&p->oid_src));
		if (!src_abbrev) {
			missing_src = 1;
			/*
			 * As `rev-parse` failed, we fallback to getting
			 * the abbreviated hash using oid_src. We do
			 * this as we might still need the abbreviated
			 * hash in cases like a submodule type change, etc.
			 */
			src_abbrev = xstrndup(oid_to_hex(&p->oid_src), 7);
		}
	} else {
		missing_src = 1;
		/*
		 * The source does not point to a submodule.
		 * So, we fallback to getting the abbreviation using
		 * oid_src as we might still need the abbreviated
		 * hash in cases like submodule add, etc.
		 */
		src_abbrev = xstrndup(oid_to_hex(&p->oid_src), 7);
	}

	if (is_directory(p->sm_path) && S_ISGITLINK(p->mod_dst)) {
		dst_abbrev = verify_submodule_committish(p->sm_path,
							 oid_to_hex(&p->oid_dst));
		if (!dst_abbrev) {
			missing_dst = 1;
			/*
			 * As `rev-parse` failed, we fallback to getting
			 * the abbreviated hash using oid_dst. We do
			 * this as we might still need the abbreviated
			 * hash in cases like a submodule type change, etc.
			 */
			dst_abbrev = xstrndup(oid_to_hex(&p->oid_dst), 7);
		}
	} else {
		missing_dst = 1;
		/*
		 * The destination does not point to a submodule.
		 * So, we fallback to getting the abbreviation using
		 * oid_dst as we might still need the abbreviated
		 * hash in cases like a submodule removal, etc.
		 */
		dst_abbrev = xstrndup(oid_to_hex(&p->oid_dst), 7);
	}
----->8-----

Or if is_directory() does not please you then we can make it
'is_nonbare_..()' too. The outcome will be unchanged.

What are your opinions on this?

> Also, I think it would be better to something like the following in
> t7421 to ensure that `fatal` doesn't sneak up accidentally in the
> future:
> 
> -- 8< --
> diff --git t/t7421-submodule-summary-add.sh t/t7421-submodule-summary-add.sh
> index 59a9b00467..b070f13714 100755
> --- t/t7421-submodule-summary-add.sh
> +++ t/t7421-submodule-summary-add.sh
> @@ -58,7 +58,7 @@ test_expect_success 'submodule summary output for submodules with changed paths'
>         git commit -m "change submodule path" &&
>         rev=$(git -C sm rev-parse --short HEAD^) &&
>         git submodule summary HEAD^^ -- my-subm >actual 2>err &&
> -       grep "fatal:.*my-subm" err &&
> +       test_must_be_empty err &&
>         cat >expected <<-EOF &&
>         * my-subm ${rev}...0000000:
>  
> -- >8 --

Yes, this I will do.


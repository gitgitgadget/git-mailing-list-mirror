Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DD1C2D0E5
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 20:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F0A2074D
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 20:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KkAdrUPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgCYUul (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 16:50:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38801 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgCYUul (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 16:50:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id c21so996698pfo.5
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 13:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3Dsgoe5hodJd2Oc37VxIQfrhWazdtL3YlcBC6m1GLvs=;
        b=KkAdrUPEz8moQjzjkvGCMEQbfA+KKi0cFHTid7nZ8RmE1whVvaSQdARiJu6RUE1Uwe
         4md4+zQ93zleBYOKknEyuWndtbVxv/aQB4O7ib77oRXX86CdqufQ9OzHLFLhBC1uWcsf
         GUzAchk9Nhcf7KRoyNib/XluOvVpDovTN6IKKwvIfaQYiTgxT+WmSDaApaajW5db7NNj
         MbUdZoiuS2DFhM+I1o26K/RF0bpyReu+ukwdoUP3NGcpcs/OyxwLqFOHpDg82KaAyJRS
         BRG8g+CZuSi8/NoP4gdrqWwKUPn5pl96KQa446gVodklW42P99hDgpBhy3ZvcvzrEC0U
         2sNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Dsgoe5hodJd2Oc37VxIQfrhWazdtL3YlcBC6m1GLvs=;
        b=HTBle6ULWwhUCaF54y1K8+jCggwl88x7Za8XdhwgE9JP1ql8wneygpgPBy3edmp6+U
         oDDTUHGK+Weg6NXi+S3GuMNZbSgDfHKkiAfvkkW2zCVzvcVqiDLFIBB1VwtC83Hfk2c4
         z5JgaxcChtb1uE8oPxxGF1QZ6QqsAy7eeIyFxw5frWtdO67E6zSxFXzpiwfOqst42llk
         GkZsWS5coiUCWRPDmeaV1FJp1iIUcj7wUCDGRjeAssGv5IT0JIwP3wl7N1i3SPjvcRAG
         3dGQYv4Hyc7Wiu52vSvxStbGPjSj7CATh5OnThIr3NDeWiJBsWqZoXglOx4MZuJQWNmV
         b+hA==
X-Gm-Message-State: ANhLgQ1GI1nf6IXvch/3niBXaI0XiFKtvd7Eu+ejUYNxF4Xkc0udf3PT
        iWk/4SWLmHoDApRLMFAqSfFcrQ==
X-Google-Smtp-Source: ADFU+vv98EnqQIrIWxjO49dCs7Y24LCXaatbyOiOwbQ5wYqyVMa8hV7DyvHESHZ1rLDdupVZPOjXBw==
X-Received: by 2002:aa7:9af7:: with SMTP id y23mr5677393pfp.1.1585169440299;
        Wed, 25 Mar 2020 13:50:40 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id b25sm21640pfd.185.2020.03.25.13.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 13:50:39 -0700 (PDT)
Date:   Wed, 25 Mar 2020 13:50:35 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [PATCH v3 2/2] revision: un-regress --exclude-promisor-objects
Message-ID: <20200325205035.GB53368@google.com>
References: <20191228003430.241283-1-jonathantanmy@google.com>
 <cover.1578781770.git.jonathantanmy@google.com>
 <af19f5486f87f23e2a0c390de2d8710cdbad2d49.1578781770.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af19f5486f87f23e2a0c390de2d8710cdbad2d49.1578781770.git.jonathantanmy@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 11, 2020 at 02:34:56PM -0800, Jonathan Tan wrote:
> Before commit 4cf67869b2 ("list-objects.c: don't segfault for missing
> cmdline objects", 2018-12-06),
> 
>   git rev-list --exclude-promisor-objects $A_MISSING_PROMISOR_OBJECT
> 
> succeeds. But after that commit, this invocation produces a non-zero
> result.
> 
> Restore this functionality: since get_reference() already does what we
> need, we can just use its return value; skip the arg if the return value
> is NULL, and use it otherwise (if the arg is invalid, get_reference()
> already dies). With this commit, --exclude-promisor-objects treats both
> promisor objects passed through the CLI and promisor objects found
> through traversal in the same say: it excludes them, so it does not
> matter whether they're missing or not.

Since the return code is changing I'm kind of worried about what other
impacts this will have. What's the call tree for handle_revision_arg
look like?

It looks like it's called in a couple places by revision.c and by
builtin/pack-objects.c, but because of the way args are packed up in
struct rev_info, it's hard to tell when those callers will be affected
or not.

> ---
>  revision.c               |  2 +-
>  t/t0410-partial-clone.sh | 12 +++---------
>  2 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/revision.c b/revision.c
> index 91ca194388..0659a09b02 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1917,7 +1917,7 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
>  		verify_non_filename(revs->prefix, arg);
>  	object = get_reference(revs, arg, &oid, flags ^ local_flags);
>  	if (!object)
> -		return revs->ignore_missing ? 0 : -1;
> +		return 0;
>  	add_rev_cmdline(revs, object, arg_, REV_CMD_REV, flags ^ local_flags);
>  	add_pending_object_with_path(revs, object, arg, oc.mode, oc.path);
>  	free(oc.path);
> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index a3988bd4b8..b251985e82 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -397,7 +397,7 @@ test_expect_success 'rev-list stops traversal at promisor commit, tree, and blob
>  	grep $(git -C repo rev-parse bar) out  # sanity check that some walking was done
>  '
>  
> -test_expect_success 'rev-list dies for missing objects on cmd line' '
> +test_expect_success 'rev-list accepts missing and promised objects on command line ' '
>  	rm -rf repo &&
>  	test_create_repo repo &&
>  	test_commit -C repo foo &&
> @@ -416,15 +416,9 @@ test_expect_success 'rev-list dies for missing objects on cmd line' '
>  	git -C repo config extensions.partialclone "arbitrary string" &&
>  
>  	for OBJ in "$COMMIT" "$TREE" "$BLOB"; do
> -		test_must_fail git -C repo rev-list --objects \
> +		git -C repo rev-list --objects \
>  			--exclude-promisor-objects "$OBJ" &&
> -		test_must_fail git -C repo rev-list --objects-edge-aggressive \
> -			--exclude-promisor-objects "$OBJ" &&
> -
> -		# Do not die or crash when --ignore-missing is passed.
> -		git -C repo rev-list --ignore-missing --objects \
> -			--exclude-promisor-objects "$OBJ" &&
> -		git -C repo rev-list --ignore-missing --objects-edge-aggressive \
> +		git -C repo rev-list --objects-edge-aggressive \
>  			--exclude-promisor-objects "$OBJ"

It seems to me the -ignore-missing tests should still pass and therefore
shouldn't be removed, no? But then I looked a little harder, and it
looks like before the test said, "This call fails, but with
--ignore-missing it does not fail" - and now the test just says "This
call does not fail". So it looks OK to me.

>  	done
>  '
> -- 
> 2.25.0.rc1.283.g88dfdc4193-goog
> 

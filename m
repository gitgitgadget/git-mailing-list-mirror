Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44E2C433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 01:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A8326117A
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 01:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhDOBFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 21:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhDOBFU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 21:05:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160F4C061574
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 18:04:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p75so1042272ybc.8
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 18:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FB8SEt27bj+MGTOn62FfrhWFQ8y64XJPFFe0UFm/Tn4=;
        b=Cdv5w9pw/VCeDo0sBBHudRkm3Q+b8XDRuc0XjkS62W/n10oxoCtGCv8tnWLggRKs8r
         VoAHzYIPnyGoUjpTDvR+PDFFbOHsFyOS8I03gZJ8z5gGlqQMN3GsEI/38y+EFT15WaAw
         6g92XTsWpZtyx6USMzvh1MadYNqHnVzpckNiqUONXmzp/6jUAF0n0jow4FD6AaVvRNYL
         Y8KnM65Jv+LIG8xK8bA6hWCiHGM2FEro6x7i3GyTcw9oUXDdJ+Jxe0P01QUaRHZRv+yq
         1Yz1O7h9YTR87wjr3pYhXhdFHcSB/iATHn3fyK0Ru664xyWrDxqNScDv42YQYthISHKa
         OLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FB8SEt27bj+MGTOn62FfrhWFQ8y64XJPFFe0UFm/Tn4=;
        b=g2j8i3m72fYe8DfS/n3Eb86VXJo6e1i6wv+PuIps6V/qwKN1N+VvODTdwR5slugfY5
         xcR/rW5WOiiArP/GVNKqkeqbmGtf7INdaDfYPzt/6dLWLPLJ47uPh3n0kYtr0jIAS+gu
         Hb2T4g1XoYsq2jEmYNdT2XjtCAUYknYCFxzSp2+Y3HUc6pBdfRMIi1tGDTyLNmlz7Yjl
         yf292lpYeg9tsp5OpInhM/8FXJpt1T7+5EcyYUNqqAZvSaG8y7U8Vn+4fJ4A8JRu3E1W
         7lX+NOBm33ZBMAZNidvU3Yke2N4iatxKIxlts49JlmZ6YRDGV2HW07V7RRtXUfVUcXIs
         CqNA==
X-Gm-Message-State: AOAM532nfGBvcy8TebW3H2A9F7gmlsyhPLkuB/FBTJT/feXw7Ohr1jCx
        rqeLPfWPSFZbf7Kh3y1/nXVxta6aaaa2P8vGL49+
X-Google-Smtp-Source: ABdhPJzZtjBN5zP8TbAdlnr0DanPnVjQmyXODtvxtZtGIi2RHtu5Tkq3P3gxeDE8/kiNMc6GGSep/Mwdkp+DbqYXSA4L
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:ef52:: with SMTP id
 w18mr1041309ybm.365.1618448696749; Wed, 14 Apr 2021 18:04:56 -0700 (PDT)
Date:   Wed, 14 Apr 2021 18:04:54 -0700
In-Reply-To: <20210414191403.4387-3-rafaeloliveira.cs@gmail.com>
Message-Id: <20210415010454.4077355-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20210414191403.4387-3-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: Re: [PATCH 2/2] repack: avoid loosening promisor pack objects in
 partial clones
From:   Jonathan Tan <jonathantanmy@google.com>
To:     rafaeloliveira.cs@gmail.com
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, peff@peff.net,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> When `-A` and `-d` are used together, besides packing all objects (-A)
> and removing redundant packs (-d), it also unpack all unreachable
> objects and deletes them by calling `git pruned-packed`.

I still think of these objects as not unreachable, even though I know
that pack-objects calls them that (the argument is called
--unpack-unreachable). So I would say "it also loosens all objects that
were previously packed but did not go into the new pack", but perhaps
this is OK too.

> For a partial
> clone, that contains unreferenced objects, this results in unpacking
> all "promisor" objects and deleting them right after, which
> unnecessarily increases the `repack` execution time and disk usage
> during the unpacking of the objects.

I think that the commit message also needs to explain that we're
deleting the promisor objects immediately because they happen to be in a
promisor pack. So perhaps this whole part could be written as follows:

  When "git repack -Ad" is run in a partial clone, "pack-objects" is
  invoked twice: once to repack all promisor objects, and once to repack
  all non-promisor objects. The latter "pack-objects" invocation is with
  --exclude-promisor-objects and --unpack-unreachable, which loosens all
  unused objects. Unfortunately, this includes promisor objects.

  Because the "-d" argument to "git repack" subsequently deletes all
  loose objects also in packs, these just-loosened promisor objects will
  be immediately deleted. But this extra disk churn is unnecessary in
  the first place.

> For instance, a partially cloned repository that filters all the blob
> objects (e.g. "--filter=blob:none"), `repack` ends up unpacking all
> blobs into the filesystem that, depending on the repo size, makes
> nearly impossible to repack the operation before running out of disk.
> 
> For a partial clone, `git repack` calls `git pack-objects` twice: (1)
> for handle the "promisor" objects and (2) for performing the repack
> with --exclude-promisor-objects option, that results in unpacking and
> deleting of the objects. Given that we actually should keep the
> promisor objects, let's teach `repack` to tell `pack-objects` to
> --keep the old "promisor" pack file.

It's not this call (2) that results in any deleting of the objects, but
the later call to prune_packed_objects(). Also, promisor objects are
kept regardless of what we pass to "pack-objects" here (the keeping is
done separately). Maybe write (continuation from my suggestion above):

  In order to avoid this extra disk churn, pass the names of the
  promisor packfiles as "--keep-pack" arguments to this
  second invocation of "pack-objects". This informs "pack-objects" that
  the promisor objects are already in a safe packfile and, therefore, do
  not need to be loosened.

> @@ -533,7 +533,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	packdir = mkpathdup("%s/pack", get_object_directory());
> -	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
> +	packtmp_name = xstrfmt(".tmp-%d-pack", (int)getpid());
> +	packtmp = mkpathdup("%s/%s", packdir, packtmp_name);
>  
>  	sigchain_push_common(remove_pack_on_signal);
>  

Normally I would be concerned that packtmp_name is not freed, but in
this case, it's a static variable (same as packtmp).

> @@ -576,6 +577,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  		repack_promisor_objects(&po_args, &names);
>  
>  		if (existing_packs.nr && delete_redundant) {
> +			for_each_string_list_item(item, &names) {
> +				strvec_pushf(&cmd.args, "--keep-pack=%s-%s.pack",
> +					     packtmp_name, item->string);
> +			}

Git style is to not have braces for single-statement loops.

> +test_expect_success 'repack does not loose all objects' '
> +	rm -rf client &&
> +	git clone --bare --filter=blob:none "file://$(pwd)/srv.bare" client &&
> +	test_when_finished "rm -rf client" &&
> +	git -C client repack -A -l -d --no-prune-packed &&
> +	git -C client count-objects -v >object-count &&
> +	grep "^prune-packable: 0" object-count
> +'

s/loose all objects/loosen promisor objects/

Also, add a comment describing why we have "--no-prune-packed" there
(probably something about not pruning any loose objects that are already
in packs, so that we can verify that no redundant loose objects are
being created in the first place).

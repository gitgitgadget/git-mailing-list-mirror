Return-Path: <SRS0=l3cg=AX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBBDC433E3
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 11:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0562070B
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 11:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V//fmw7C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgGLLWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 07:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbgGLLWv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jul 2020 07:22:51 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2800EC061794
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 04:22:51 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id rk21so11022870ejb.2
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 04:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=jju6/31c+l3E38CmdGe7oExW7r8JIsx5LdCZm1va6lw=;
        b=V//fmw7C4hZNwog05kOa6o/hTbW4htNFfJ5svbPlsMyLWbczY2z+Po81pPpHAXVQR+
         lbjx79pq1LHuXLhAFBANgaVfV7GIs2UUt6lxPckjbMfhXXDvxK5j8hUmzGVFafsE+ECn
         SOgwiDAlBkYFAbXOBgfNtxQgUlqCnA2PQemI7B31LXT/hYqJMjg2vL3dx/9jCQzSy3o3
         AohBBorzo0msAk8liaCxADSiy62Q28NmIBXVOZUOiRP6XcwisH6T2WGEbRsUAgjKQlUd
         MLLYAOMtKeiTJZy+qjXYaSSbYzVTYr8qvNvfCT5Hdt86ZQbHHfgFWKVjWIqPAMtOpkz7
         RJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=jju6/31c+l3E38CmdGe7oExW7r8JIsx5LdCZm1va6lw=;
        b=bygUYsRqX3ZbSRmck9SUCkyuC7BfVNI/vXNfiYvMF3dECbckSdUxTzbJHwC7VYqb30
         ajzn7bnPgP3mmT2dM9saU8YGMivtFAOSERthb1aCNvcCcSNOZ/PIxPtlUcWKm/Vzz5bV
         RjJYKSTU1bVOfdskry3j8Hx6y66PKH1MCMRYPH6a6ZHWqrz8BnMVD9gcW5p7/rF+F27L
         oHVtXplQF+juK+W6kNafrZCi/NIb2xevYs03/n/88r0snK10pQ8mkWJB6hafi5sZnp2c
         9w52CgSiFPRKepBe7eHXluyGyaWGewixm4G6bhLYFCllK6bweodeALTS3xikiXOGjls7
         d1yQ==
X-Gm-Message-State: AOAM530rRW+L0gGsOZWqcTXNXb6GKEY8E72FTSINyTTkTF9FhYw1EluH
        hpO728GzwowONBLmy33IBh73z3hi+Q4=
X-Google-Smtp-Source: ABdhPJwGNk4PYOKn2HfcozVbOJp1Rbz+o928nCgmaRTYSYWTRsJSH4T6xuP8mxQRloXvil2oJfOPSA==
X-Received: by 2002:a17:906:e0c7:: with SMTP id gl7mr64985297ejb.264.1594552969831;
        Sun, 12 Jul 2020 04:22:49 -0700 (PDT)
Received: from andromeda.lan ([80.215.156.54])
        by smtp.gmail.com with ESMTPSA id o16sm4794531ejj.106.2020.07.12.04.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 04:22:48 -0700 (PDT)
Date:   Sun, 12 Jul 2020 13:22:26 +0200 (CEST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v1 02/17] merge-one-file: rewrite in C
In-Reply-To: <80af2da7-d943-94ef-999a-7035bbec0f0d@gmail.com>
Message-ID: <alpine.LFD.2.21.2007121311490.17922@andromeda.lan>
References: <20200625121953.16991-1-alban.gruin@gmail.com> <20200625121953.16991-3-alban.gruin@gmail.com> <80af2da7-d943-94ef-999a-7035bbec0f0d@gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463785727-1942544268-1594552968=:17922"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463785727-1942544268-1594552968=:17922
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi Phillip,

Phillip Wood (phillip.wood123@gmail.com) a écrit :

> Hi Alban
> 
> I think this series is a great idea
> 
> On 25/06/2020 13:19, Alban Gruin wrote:
> -%<-
> > diff --git a/builtin/merge-one-file.c b/builtin/merge-one-file.c
> > new file mode 100644
> > index 0000000000..4992a6cd30
> > --- /dev/null
> > +++ b/builtin/merge-one-file.c
> > @@ -0,0 +1,275 @@
> > +/*
> > + * Builtin "git merge-one-file"
> > + *
> > + * Copyright (c) 2020 Alban Gruin
> > + *
> > + * Based on git-merge-one-file.sh, written by Linus Torvalds.
> > + *
> > + * This is the git per-file merge script, called with
> > + *
> > + *   $1 - original file SHA1 (or empty)
> > + *   $2 - file in branch1 SHA1 (or empty)
> > + *   $3 - file in branch2 SHA1 (or empty)
> > + *   $4 - pathname in repository
> > + *   $5 - original file mode (or empty)
> > + *   $6 - file in branch1 mode (or empty)
> > + *   $7 - file in branch2 mode (or empty)
> 
> nit pick - these are now argv[1] etc rather than $1 etc
> 

I'll change that, and replace "script" by "utility".

> > + *
> > + * Handle some trivial cases.. The _really_ trivial cases have
> > + * been handled already by git read-tree, but that one doesn't
> > + * do any merges that might change the tree layout.
> > + */
> > +
> > +#define USE_THE_INDEX_COMPATIBILITY_MACROS
> > +#include "cache.h"
> > +#include "builtin.h"
> > +#include "commit.h"
> > +#include "dir.h"
> > +#include "lockfile.h"
> > +#include "object-store.h"
> > +#include "run-command.h"
> > +#include "xdiff-interface.h"
> > +
> > +static int create_temp_file(const struct object_id *oid, struct strbuf
> > *path)
> > +{
> > +	struct child_process cp = CHILD_PROCESS_INIT;
> > +	struct strbuf err = STRBUF_INIT;
> > +	int ret;
> > +
> > +	cp.git_cmd = 1;
> > +	argv_array_pushl(&cp.args, "unpack-file", oid_to_hex(oid), NULL);
> > +	ret = pipe_command(&cp, NULL, 0, path, 0, &err, 0);
> > +	if (!ret && path->len > 0)
> > +		strbuf_trim_trailing_newline(path);
> > +
> > +	fprintf(stderr, "%.*s", (int) err.len, err.buf);
> > +	strbuf_release(&err);
> > +
> > +	return ret;
> > +}
> 
> I know others will disagree but personally I'm not a huge fan of rewriting
> shell functions in C that forks other builtins and then converting the C to
> use the internal apis, it seems a much better to just write the proper C
> version the first time. This is especially true for simple function such as
> the ones in this file. That way the reviewer gets a clear view of the final
> code from the patch, rather than having to piece it together from a series of
> additions and deletions.
> 

I understand -- I'll squash the "rewrite" and "use internal APIs" patches 
together as a last step for the v2, so I'd be able to get them back with 
all the changes made in the v2 if needed.

> -%<-
> > +static int do_merge_one_file(const struct object_id *orig_blob,
> > +			     const struct object_id *our_blob,
> > +			     const struct object_id *their_blob, const char
> > *path,
> > +			     unsigned int orig_mode, unsigned int our_mode,
> > unsigned int their_mode)
> > +{
> > +	int ret, source, dest;
> > +	struct strbuf src1 = STRBUF_INIT, src2 = STRBUF_INIT, orig =
> > STRBUF_INIT;
> > +	struct child_process cp_merge = CHILD_PROCESS_INIT,
> > +		cp_checkout = CHILD_PROCESS_INIT,
> > +		cp_update = CHILD_PROCESS_INIT;
> > +
> > +	if (our_mode == S_IFLNK || their_mode == S_IFLNK) {
> > +		fprintf(stderr, "ERROR: %s: Not merging symbolic link
> > changes.\n", path);
> > +		return 1;
> > +	} else if (our_mode == S_IFGITLINK || their_mode == S_IFGITLINK) {
> > +		fprintf(stderr, "ERROR: %s: Not merging conflicting submodule
> > changes.\n",
> > +			path);
> > +		return 1;
> > +	}
> > +
> > +	create_temp_file(our_blob, &src1);
> > +	create_temp_file(their_blob, &src2);
> > +
> > +	if (orig_blob) {
> > +		printf("Auto-merging %s\n", path);
> > +		create_temp_file(orig_blob, &orig);
> > +	} else {
> > +		printf("Added %s in both, but differently.\n", path);
> > +		create_temp_file(the_hash_algo->empty_blob, &orig);
> > +	}
> > +
> > +	cp_merge.git_cmd = 1;
> > +	argv_array_pushl(&cp_merge.args, "merge-file", src1.buf, orig.buf,
> > src2.buf,
> > +			 NULL);
> > +	ret = run_command(&cp_merge);
> > +
> > +	if (ret != 0)
> > +		ret = 1;
> > +
> > +	cp_checkout.git_cmd = 1;
> > +	argv_array_pushl(&cp_checkout.args, "checkout-index", "-f",
> > "--stage=2",
> > +			 "--", path, NULL);
> > +	if (run_command(&cp_checkout))
> > +		return 1;
> > +
> > +	source = open(src1.buf, O_RDONLY);
> > +	dest = open(path, O_WRONLY | O_TRUNC);
> > +
> > +	copy_fd(source, dest);
> > +
> > +	close(source);
> > +	close(dest);
> > +
> > +	unlink(orig.buf);
> > +	unlink(src1.buf);
> > +	unlink(src2.buf);
> > +
> > +	strbuf_release(&src1);
> > +	strbuf_release(&src2);
> > +	strbuf_release(&orig);
> 
> The whole business of creating temporary files and forking seems like a lot of
> effort compared to calling ll_merge() which would also mean we respect any
> merge attributes
> 
> > +
> > +	if (ret) {
> > +		fprintf(stderr, "ERROR: ");
> > +
> > +		if (!orig_blob) {
> 
> I think the original does if (ret || !orig_blob) not &&

Good catch.

> > +			fprintf(stderr, "content conflict");
> > +			if (our_mode != their_mode)
> > +				fprintf(stderr, ", ");
> 
> sentence lego, in any case the message below should be printed regardless of
> content conflicts. We should probably mark all these messages for translation
> as well.
> 

Yeah, I think I will replace them with two calls to `error()'.

> -%<-
> > +int cmd_merge_one_file(int argc, const char **argv, const char *prefix)
> > +{
> > +	struct object_id orig_blob, our_blob, their_blob,
> > +		*p_orig_blob = NULL, *p_our_blob = NULL, *p_their_blob = NULL;
> > +	unsigned int orig_mode = 0, our_mode = 0, their_mode = 0;
> > +
> > +	if (argc != 8)
> > +		usage(builtin_merge_one_file_usage);
> > +
> > +	if (!get_oid(argv[1], &orig_blob)) {
> > +		p_orig_blob = &orig_blob;
> > +		orig_mode = strtol(argv[5], NULL, 8);
> 
> It would probably make sense to check that strtol() succeeds (and the mode is
> sensible), and also that get_oid() fails because argv[1] is empty, not because
> it is invalid.
> 

Checking that `orig_mode' and friends are lower than 0800, and that 
`*argv[1]' is not equal to '\0' should be enough, right?

> Thanks for working on this

As always, thank you for your reviews.

> Best Wishes
> 
> Phillip
> 
> 

Cheers,
Alban

---1463785727-1942544268-1594552968=:17922--

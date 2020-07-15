Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C9CC433E1
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 18:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A52782065F
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 18:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyDw/szD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgGOSmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 14:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgGOSmC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 14:42:02 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D452C061755
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 11:42:02 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ch3so3494636pjb.5
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 11:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=lLH/diCRhS6Apsm0Sirvsykxl4iin4XCU46kCYSk+Mw=;
        b=TyDw/szDJsWqV/fwG+LI4yEBf0gmtHzcryQ/glZaKNxxAt/qpauz3X0kQNbyYMBUY6
         uV2FoMvLrnVBSsoX11c8LgCI80wOMBwS4sqVPSWp53PI2gxbY1zCDK+pf3TmY5YCV/It
         v9L56q3yGW8aBrU9cc8Y6fiXjaW2JTSzbciFRRu0p3B7qgCVlgwiWXhCfr2VXpP6Cikj
         bsxI7w70+4saTh6dTcrQXvQl3rto7DNgLzpsgyW6zJh3I6R6u0V8RJnI4ZiWXZYp78nS
         VUbhN7q9rw0H6o692VttkFPYQRZUA8fjXyQUN4e9H2I0Z4nnljfsLa5urOQsC16/q7Z3
         3BdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=lLH/diCRhS6Apsm0Sirvsykxl4iin4XCU46kCYSk+Mw=;
        b=AFS8l86mV4sBTagDuJjptT9P/PUBhv8mgLpW4f6LZysu+vintrX8AeCiRiKDJJcnJg
         GtfHH0K3iUiJtAM6K7AyzkAOMB4h4v/GridFAFOh5u1CJdc0NxI648fOP7H6OH24iiqz
         PQ7IA8/bYI1zHi1Vqr8Xb+0fckif5Sfbjnc1OMBdGuwT+dWOfBoX5VNGblZ8uHDSv3Da
         8pdS9t0XenKUznmU5zB3LqRnj8JNF1MK08/yyVt0wM6khZpH5YJvC4ABM/kYnvFLYywW
         pdN+zBR5SeGEhst2qrL+PNVN6JR/fM+m4Daii16Vxqooht+RlYDvrQ9ZZm28PUmxhpYK
         babA==
X-Gm-Message-State: AOAM532AdysbIwvpUqNSipOtoikhx2gRJSZ9Cnv/GcZsluebaAAWacm0
        SOOOIl14Ry3YLB9DIZLXYfkIEmGTF9U=
X-Google-Smtp-Source: ABdhPJxATJid9ChZ3OdvSli2x6gqLW9aPPPeTwifhxTKA2jvShlL5tGXKiro61uvVHtPYJ49VdLYhg==
X-Received: by 2002:a17:902:c252:: with SMTP id 18mr661892plg.39.1594838521415;
        Wed, 15 Jul 2020 11:42:01 -0700 (PDT)
Received: from konoha ([45.127.46.26])
        by smtp.gmail.com with ESMTPSA id cl17sm2703016pjb.50.2020.07.15.11.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 11:42:00 -0700 (PDT)
Date:   Thu, 16 Jul 2020 00:11:53 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     shouryashukla.oo@gmail.com
Cc:     Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com, pc44800@gmail.com, stefanbeller@gmail.com
Subject: Re: [PATCH 4/4] submodule: port submodule subcommand 'summary' from
 shell to C
Message-ID: <20200715184153.GA52607@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715145336.GA18071@konoha>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ignore the above mail I sent, I am a big dimwit. I have tried to do this
and this works

---------------8<--------------
module_summary() {
struct object_id head;
....
....
if (!get_oid(argc ? argv[0] : "HEAD", &head_oid)) {
		if (argc) {
			argv++;
			argc--;
		}
	} else if (!argc || !strcmp(argv[0], "HEAD")) {
		/* before the first commit: compare with an empty tree */
		oidcpy(&head_oid, the_hash_algo->empty_tree);
		if (argc) {
			argv++;
			argc--;
		}
	} else {
		get_oid("HEAD", &head_oid);
	}
....
....
ret = compute_summary_module_list((diff_cmd == DIFF_FILES) ? NULL : &head_oid,
					   &info, diff_cmd);
	return ret;
}

compute_summary_module_list() {
....
....
if (head_oid)
		argv_array_push(&diff_args, oid_to_hex(head_oid));
....
....
}
--------------->8--------------

Obviousy I was making the grave mistake of declaring the aforementioned
struct as 'struct object_id *' which caused all these weird errors.

All tests pass now.

BTW in your review of my patch,
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2007031712160.50@tvgsbejvaqbjf.bet/
you said this:
--------------->8--------------
> +			 */
> +			struct child_process cp_rev_parse = CHILD_PROCESS_INIT;
> +			struct strbuf sb_rev_parse = STRBUF_INIT;
> +
> +			cp_rev_parse.git_cmd = 1;
> +			cp_rev_parse.no_stderr = 1;
> +			cp_rev_parse.dir = p->sm_path;
> +			prepare_submodule_repo_env(&cp_rev_parse.env_array);
> +
> +			argv_array_pushl(&cp_rev_parse.args, "rev-parse",
> +					 "HEAD", NULL);
> +			if (!capture_command(&cp_rev_parse, &sb_rev_parse, 0)) {
> +				strbuf_strip_suffix(&sb_rev_parse, "\n");
> +				get_oid_hex(sb_rev_parse.buf, &p->oid_dst);
> +			}
> +			strbuf_release(&sb_rev_parse);
> +		} else if (S_ISLNK(p->mod_dst) || S_ISREG(p->mod_dst)) {
> +			struct child_process cp_hash_object = CHILD_PROCESS_INIT;
> +			struct strbuf sb_hash_object = STRBUF_INIT;
> +
> +			cp_hash_object.git_cmd = 1;
> +			argv_array_pushl(&cp_hash_object.args, "hash-object",
> +					 p->sm_path, NULL);
> +			if (!capture_command(&cp_hash_object,
> +					     &sb_hash_object, 0)) {
> +				strbuf_strip_suffix(&sb_hash_object, "\n");
> +				get_oid_hex(sb_hash_object.buf, &p->oid_dst);
> +			}
> +			strbuf_release(&sb_hash_object);

It would probably be shorter, less error-prone, and quicker to use
`index_fd()` directly.
--------------->8--------------

What exactly did you mean here and where should the index_fd() be used?

Regards,
Shourya Shukla

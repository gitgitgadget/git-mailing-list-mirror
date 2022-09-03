Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8291FC38145
	for <git@archiver.kernel.org>; Sat,  3 Sep 2022 04:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiICEjP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Sep 2022 00:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiICEjM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2022 00:39:12 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD348E0FF1
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 21:39:11 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o2-20020a17090a9f8200b0020025a22208so79288pjp.2
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 21:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=wqglncWgXBH2LqTD59Zqc5aGUlEeeY0P2e8GrGeymro=;
        b=XohjKrx+NZbn9L7tD8eXxEj9b/BFWqbjWYk2bEiH6/WNaT8rqKxozh4kpnameGePXM
         QALB+dBVn3NGxpYsJOxccua72CrrLD8NntFzDd1GpUGtZQVV5mlGpnjAP3Qc8kbGpFuA
         g2v9/4AQ25/44zBvVrFwylfPXfPe4tNJf2+OWdLgtZyoQHGKKMMPeSLjeyxU9LKuuuDI
         lJ+CyQZQzZY7wpE6UlVH76LGA6JMHqo7z7bDmAEeWvbx1TTZqpBz8jvILnNpf6iTmHdJ
         8eBflrLdrKEOSCBPWs9aKS1rztaH8xKkzRZ5HrOJiysR6Zash6mH/BMLQbDxHrSuPsp/
         7x0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=wqglncWgXBH2LqTD59Zqc5aGUlEeeY0P2e8GrGeymro=;
        b=YEXioB6/hvc3qVvuB9nfFd22/06choJdlDP5dYbQQ97pf3lHaEyd1nAYpc6EJypHHZ
         uqjhh+dhpUtmOsVTjKiuvhkUzX1gM4bU1Pj8ABGz1sOBS43psl/jb+HHz6qUiq9HId3E
         Z7cXVSLBoDyCqsQcA3PV6x7gfPg9OrSwQON3Ro3J14IPvNvjNjTIw29YxhSTvUHTa79E
         W6PF199SH7ONWQZTiWcsqTbgp8gbQ4rLozPr74DsJYxaWjxUzm0vDHRGYGsgR1oQOdA+
         v4wP+VgPSHakfIY1wKeUAJ+OzSKu+5GXGq05zFXkOKoYxnnt+JBBp5PK3NeetyuMMFX0
         V7pw==
X-Gm-Message-State: ACgBeo1P6GyRqmPHCq92dEekLtk4EXFRyMFsEimNC/pJGe2ATlSIkbf9
        K2iKgTDEH/b7WwtEq5mPZ1U=
X-Google-Smtp-Source: AA6agR52f9aF+D8rUqQymFldZTrsg+GWolNxE8lixpcsQYLlIvbq9C/hhyGKMbhtO+oAeTNQjpPepg==
X-Received: by 2002:a17:902:e80e:b0:174:b2e1:8b5c with SMTP id u14-20020a170902e80e00b00174b2e18b5cmr26708629plg.20.1662179951056;
        Fri, 02 Sep 2022 21:39:11 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h12-20020a62830c000000b005381b69a7cesm2792341pfe.64.2022.09.02.21.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 21:39:10 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, vdye@github.com
Subject: Re: [PATCH v4 3/3] builtin/grep.c: walking tree instead of
 expanding index with --sparse
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
        <20220903003623.64750-1-shaoxuan.yuan02@gmail.com>
        <20220903003623.64750-4-shaoxuan.yuan02@gmail.com>
Date:   Fri, 02 Sep 2022 21:39:09 -0700
In-Reply-To: <20220903003623.64750-4-shaoxuan.yuan02@gmail.com> (Shaoxuan
        Yuan's message of "Fri, 2 Sep 2022 17:36:23 -0700")
Message-ID: <xmqqczcd1382.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:

> @@ -537,8 +534,20 @@ static int grep_cache(struct grep_opt *opt,
>  
>  		strbuf_setlen(&name, name_base_len);
>  		strbuf_addstr(&name, ce->name);
> +		if (S_ISSPARSEDIR(ce->ce_mode)) {
> +			enum object_type type;
> +			struct tree_desc tree;
> +			void *data;
> +			unsigned long size;
> +
> +			data = read_object_file(&ce->oid, &type, &size);
> +			init_tree_desc(&tree, data, size);
>  
> -		if (S_ISREG(ce->ce_mode) &&
> +			hit |= grep_tree(opt, pathspec, &tree, &name, 0, 0);
> +			strbuf_reset(&name);

Is this correct?

I would have expected that this would chomp to name_base_len, just
like what the code before this if/elseif cascade did.

There needs a test that is run with repo->submodule_prefix != NULL
to uncover issues like this, perhaps?

> +			strbuf_addstr(&name, ce->name);
> +			free(data);
> +		} else if (S_ISREG(ce->ce_mode) &&
>  		    match_pathspec(repo->index, pathspec, name.buf, name.len, 0, NULL,
>  				   S_ISDIR(ce->ce_mode) ||
>  				   S_ISGITLINK(ce->ce_mode))) {
> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
> index fce8151d41..3242cfe91a 100755
> --- a/t/perf/p2000-sparse-operations.sh
> +++ b/t/perf/p2000-sparse-operations.sh
> @@ -124,5 +124,6 @@ test_perf_on_all git read-tree -mu HEAD
>  test_perf_on_all git checkout-index -f --all
>  test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
>  test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
> +test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/*"
>  
>  test_done
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 63becc3138..56e4614276 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -1987,7 +1987,15 @@ test_expect_success 'grep is not expanded' '
>  
>  	# All files within the folder1/* pathspec are sparse,
>  	# so this command does not find any matches
> -	ensure_not_expanded ! grep a -- folder1/*
> +	ensure_not_expanded ! grep a -- folder1/* &&
> +
> +	# test out-of-cone pathspec with or without wildcard
> +	ensure_not_expanded grep --sparse --cached a -- "folder1/a" &&
> +	ensure_not_expanded grep --sparse --cached a -- "folder1/*" &&
> +
> +	# test in-cone pathspec with or without wildcard
> +	ensure_not_expanded grep --sparse --cached a -- "deep/a" &&
> +	ensure_not_expanded grep --sparse --cached a -- "deep/*"
>  '
>  
>  test_done

Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1979C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 21:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3B32077B
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 21:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5DQIP+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfLDVFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 16:05:20 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45195 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbfLDVFU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 16:05:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id b9so46263pgk.12
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 13:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0zG0OKHGhOGmkKZ0D8EKBWDXXW8lrvUaVQQYqsT0y94=;
        b=d5DQIP+aYmUCHpMDyDawNGckiRbxu/Yjt94cJGK2dcI5CBPJKVQ02Uq1TV2STVe8dR
         9bBFqwaJ7KeJsg8lkTKHr6amxduRHlJYJAuLVbhGlvLKIF09+8DMyfaZ0tKyPUY9CMz7
         HiBYjRTJO1ISl2o9LwBVicxzP3FW9wDNP8JnXIXTHXMFMPTbHpuji8VbRdOnh2sLVWHU
         Vs+8byUg8pCeKKEnFHX7/bDQsFraCGc54cVzpi0ftemKjCH4JtEdmAnS7GoXvgSMuTJl
         Z2KLFHb9ExeRGlQs/vfOCNiH1usafV0kQiw7JewaaRTu/DyieXsaKCxHRMZaG5HU7O3c
         eIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0zG0OKHGhOGmkKZ0D8EKBWDXXW8lrvUaVQQYqsT0y94=;
        b=OkSvxhvqROyLJeeeUD0t/1RsP+80aKpWHuhkOuck1uiqm3pI83YS2TqUbjiljaxhOM
         i6yglp30Kq+afKyE3Jej3peI+MtTnSnualPuffhgwloztZFVU6Qt1zv7VuKGMqbW6EmI
         gcPglKXI9p5y7hOoD5nGBptsYwKQ1Lo1E9Pso16ayQVxeUX4j/EEs5SeSll+SYNuaqpi
         XhGYHNnIW6PyaDBpO4M6YsQaN2pjmYcsdW0U9pxW3qIkCaVB6Vw1EuZtPD9qEzY07tgB
         ge6/Q4HYMTidAko3bGkriBJcBLt/9CuDTqVnPYW+tSBJUF6wxXew7AafGPxIcZNksFYX
         U9LA==
X-Gm-Message-State: APjAAAU/UcrVFzIdrB+lsBeW9A9ziFnG5Of83gMFsExThPOevJnfEHmW
        jad/OQUB4GJHxcztuu4gjZs=
X-Google-Smtp-Source: APXvYqy5zIc02Jb/fSwYRHvUOhIzyFKXzLe+VLQb6o++i2YevWKvfHnCm3H+DMsXmLiJeVkJ1TsxLg==
X-Received: by 2002:a62:33c6:: with SMTP id z189mr5518932pfz.246.1575493519557;
        Wed, 04 Dec 2019 13:05:19 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id s27sm9284289pfd.88.2019.12.04.13.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 13:05:18 -0800 (PST)
Date:   Wed, 4 Dec 2019 13:05:14 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] grep: support the --pathspec-from-file option
Message-ID: <20191204210514.GA89300@generichostname>
References: <20191122011646.218346-1-emilyshaffer@google.com>
 <20191204203911.237056-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204203911.237056-1-emilyshaffer@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Wed, Dec 04, 2019 at 12:39:11PM -0800, Emily Shaffer wrote:
> @@ -289,6 +293,20 @@ In future versions we may learn to support patterns containing \0 for
>  more search backends, until then we'll die when the pattern type in
>  question doesn't support them.
>  
> +--pathspec-from-file <file>::
> +	Read pathspec from <file> instead of the command line. If `<file>` is
> +	exactly `-` then standard input is used; standard input cannot be used
> +	for both --patterns-from-file and --pathspec-from-file. Pathspec elements
> +	are separated by LF or CR/LF. Pathspec elements can be quoted as
> +	explained for the configuration variable `core.quotePath` (see
> +	linkgit:git-config[1]). See also `--pathspec-file-nul` and global
> +	`--literal-pathspecs`.
> +
> +--pathspec-file-nul::
> +	Only meaningful with `--pathspec-from-file`. Pathspec elements are
> +	separated with NUL character and all other characters are taken
> +	literally (including newlines and quotes).

Does it make sense to have a corresponding --patterns-file-nul option?
As in, is it possible for patterns to contain inline newlines? If it's
not possible, then that option probably isn't necessary.

> +
>  -e::
>  	The next parameter is the pattern. This option has to be
>  	used for patterns starting with `-` and should be used in

> @@ -1125,6 +1129,44 @@ test_expect_success 'grep --no-index descends into repos, but not .git' '
>  	)
>  '
>  
> +test_expect_success 'setup pathspecs-file tests' '
> +cat >excluded-file <<EOF &&
> +bar
> +EOF
> +cat >pathspec-file <<EOF &&
> +foo
> +bar
> +baz
> +EOF
> +cat >unrelated-file <<EOF &&
> +xyz
> +EOF
> +git add excluded-file pathspec-file unrelated-file
> +'

Could you please change these here-docs to be <<-\EOF and then indent
the test case?

> +
> +cat >pathspecs <<EOF
> +pathspec-file
> +unrelated-file
> +EOF
> +
> +cat >expected <<EOF
> +pathspec-file:bar
> +EOF

In an earlier email, I was wondering aloud why these two blocks were
outside of the test case above. I think the answer to that is that
you're following the existing style of the test case.

In that case, could I pester you to do some test clean up while you're
at it? I think it'd be nice to move the cats into their respective test
cases (with <<-\EOF) and also rename the files from 'expected' to
'expect'. But otherwise, I think it's fine as is as well.

Thanks,

Denton

> +
> +test_expect_success 'grep --pathspec-from-file with file' '
> +	git grep --pathspec-from-file pathspecs "bar" >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'grep --pathspec-file with stdin' '
> +	git grep --pathspec-from-file - "bar" <pathspecs >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'grep with two stdin inputs fails' '
> +	test_must_fail git grep --pathspec-from-file - --patterns-from-file - <pathspecs
> +'
> +
>  test_expect_success 'setup double-dash tests' '
>  cat >double-dash <<EOF &&
>  --
> -- 
> 2.24.0.393.g34dc348eaf-goog
> 

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8FEC7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 21:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjDVVZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 17:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjDVVZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 17:25:16 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470CC10DF
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 14:25:15 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7606ce9bfdeso296401639f.0
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 14:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682198714; x=1684790714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOkqc1OmZmrEjzhnemqjY4V9V1NkBdV/8/aof63oLbI=;
        b=qYx0Ld4WWPa157jwWMpmnmsQDU8HmQeRXi8vp7O68zaJPuk6obnBD6xw8hNswTnoPF
         y34Em+pIYAM3MXjYzUQsjhy1vaBduwgHU4u5FgbhdeXI4h5g7vVGTgIKYaFeNqFArFgh
         Y91lVamrN2LtphK4nCr3FmWZLfugV4EUE5A7tWPBiOLdyfyZGNh2Vl0SFr2P9SFHHnBI
         PJI8sU404zaLuOgVMQyaDIBhG5RcN4xVOUGtMj2wEeUMIfxStfmFNLIJviARUwOY0kzV
         CX8wM90au5q5lDGqbzgb9lQ0+wUkaXea5Qwjh6e2mxmujd9A2mWK4nUp57rP9UDig8NZ
         DwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682198714; x=1684790714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOkqc1OmZmrEjzhnemqjY4V9V1NkBdV/8/aof63oLbI=;
        b=WvlfkclellaZJ5SjSepm39ViCTb+r+/57gmuyYir8V2qL+RSqD3qXR6pJUyomA1c7K
         y41PGAdu+acRSB279FBHVvOQljOMh5H2dr+Zl76GMWewpTGKPI31OnifPcLopd3L2Uio
         Cj3Lilaq6IsEv4jcSkgqVGCv3aDQAmKbRqg45LKObDNIizmOucqP7Gre+gHxww0kULGC
         DVKyW8/5QlowWPXRhXCD1I0qbovgJPMsOzLhzyZK7rOrDe8fcEmzyaHi3BLr4LIwDfDN
         gU76z8w8aJ69sCItYpo33yzaKq/s0t6Q1O0Jexu2siDTVIPlVXYmOzv2dRBrfsICM2o/
         3aHw==
X-Gm-Message-State: AAQBX9doY6u10nZ7Kbk3OqVvtLS5m2PSbYGa3C/p4idDPgaFS6ox4eAd
        dIhHvCmthk+yG0ozuBt2ZqKWqQhYrwjT+w==
X-Google-Smtp-Source: AKy350bqY61PUt15egZZ8sAQEcrvwyJE/m0PqzzJPuYqHVfC/NDLn+PAyzJo3rF/r/nHc5wcq1fR9w==
X-Received: by 2002:a5d:9486:0:b0:763:7e7d:9fdb with SMTP id v6-20020a5d9486000000b007637e7d9fdbmr2169923ioj.3.1682198714225;
        Sat, 22 Apr 2023 14:25:14 -0700 (PDT)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id x20-20020a6bda14000000b007635e44126bsm1979500iob.53.2023.04.22.14.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 14:25:13 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: Re: [GSOC][PATCH v2] diff-index: enable sparse index
Date:   Sat, 22 Apr 2023 17:25:00 -0400
Message-Id: <20230422212500.476955-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <CAPnUp-=3aoG9WwCcLnMZ4UL90j+snL8qUePPmm02WQK9tUkCzw@mail.gmail.com>
References: <CAPnUp-=3aoG9WwCcLnMZ4UL90j+snL8qUePPmm02WQK9tUkCzw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> Re: my last review [2] - did you look into the behavior of 'diff' with
>> pathspecs and whether this 'pathspec_needs_expanded_index()' could be
>> centralized (in e.g. 'run_diff_index()')? What did you find?

>I hadn't understood the review properly. I just thought you wanted to
>make sure the function was added to diiff-index itself. I have read
>through some of it, but I am still not 100% sure of the behaviour.
>Will run through it more to get more definitive answers


Hello Raghul!

I hope this email finds you well. I recently came across your patch and 
noticed that you might be facing some difficulties with a specific issue.
I've reviewed your patch and thought I'd share a few suggestions that 
might help you overcome the issue.The code below I've already test it.
But there must have many detail I did not handle.

In the builtin/diff.c file, the cmd_diff() function can call either 
'run_diff_files()' or 'run_diff_index()' depending on the situation.
when you run 'git diff',run_diff_files() is called to find differences
between the working directory and the index. when you run 
'git diff --cached'. 'run_diff_index()' is called to find difference 
between the indexand the commit.

Both the "diff-index" and "diff" commands share the "run_diff_index" 
function. So, we can handling of pathspecs in one place(run_diff_index).
Doing this we can simplify the codebase and make it easier to maintain.

1.add test for diff in t1092. We will find the test will fail.

test_expect_success 'git diff with pathspec expands index when necessary' '
	init_repos &&

	echo "new" >>sparse-index/deep/a &&
	git -C sparse-index add deep/a &&

	# pathspec that should expand index
	ensure_expanded diff --cached "*/a" &&

	write_script edit-conflict <<-\EOF &&
	echo test >>"$1"
	EOF

	run_on_all ../edit-contents deep/a &&
	ensure_expanded diff HEAD "*/a"
'


2."run_diff_index" is in 'diff-lib.c'.We can add 
'pathspec_needs_expanded_index' in front of 'do_diff_cache()'(process
the index before the start of the diff process).

int run_diff_index(struct rev_info *revs, unsigned int option)
{
	......
	......
	if (merge_base) {
		diff_get_merge_base(revs, &oid);
		name = oid_to_hex_r(merge_base_hex, &oid);
	} else {
		oidcpy(&oid, &ent->item->oid);
		name = ent->name;
	}


	if (pathspec_needs_expanded_index(revs->diffopt.repo->index, &revs->diffopt.pathspec))
		ensure_full_index(revs->diffopt.repo->index);


	if (diff_cache(revs, &oid, name, cached))
		exit(128);

	.......
	......
	.......
}


3.Delete 'the pathspec_needs_expanded_index' function you have in your 
'builtin/diff-index.c' in last patch.

4.Run the test again, then the test for 'git diff' and your test for 
'git diff-index'will all pass!

I hope these suggestions prove helpful to you. If you have any questions
or would like to discuss further, please don't hesitate to reach out.

-----------------------------------------------------------------------
Best,
Shuqi



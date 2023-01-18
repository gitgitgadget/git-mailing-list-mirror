Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C593C004D4
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 06:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjARGz1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 01:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjARGyc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 01:54:32 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1808D5F3B1
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 22:28:30 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id y3-20020a17090a390300b00229add7bb36so1184191pjb.4
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 22:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/MNS9kiiFDS2yficCopMgcRB8XUmRqhGgkhye3bUTI=;
        b=Ls/Dkzx3PwyTRrzfzwLKZJdY+/4OUFAhprR4fXj4pwqnfg3nXtnGhDLdyd1wMXQsWB
         E35h6lpz0f5aQ3DnJlmIf4Wfk+ZMckl9wcHaKSIjbVeNLxQ8V3VPQwnIS0DAg5F554VE
         sLp5L9EnJbMjERva9hziSt4tmyBdINEkVKNfApqF/wDkP7MS5xdRt4sRbWc3gJAYC97e
         trzTc/PzJcMstD9u6RAvqw1aj32yH2BJyX1++ZO9tcu9Oo6IgnqwbR3PBJdKtfAZ0HxE
         y9eG5CS1bTCW9h4m/C8VUvqs3qEvpEwJt9mKJUjl042WbEgdThsjpawWBKHUaZMHQ4WX
         4+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/MNS9kiiFDS2yficCopMgcRB8XUmRqhGgkhye3bUTI=;
        b=Y3mgiB7zLx5aVbOsVdpIBeqsaFVhni3tH0j8fmiVETT9ae6SvmgX07G4jsNDGv99ka
         6tKmtSRhzshnPxoALILOTRMWddBbb5PC8Hd5Evl+h/BSwl/M0bSuUek2gtcmWdSSBkVO
         ky9PIUKifESxMFfRuzHMQV4oGO9KEKpuTAqLAv00QvOWqhldKtqrnc8aLKcD3IKLsE/G
         8HQaAqqt/1D0h5bCE7ysh4I4DV6VEvuM9wvbMqnveJ52/d2KQH/7aGTf0u1PeC7WJEIQ
         GPdmQn9Pt+6Ejv6UqjjstTUfDu9MuJVSwxWAvBm8yA6x2wa8+RYdcwtDc7WIkieMRrZp
         6rvg==
X-Gm-Message-State: AFqh2krPjj79eSN94FRc8woclydfAWKXWWdj2NV6dyZeINIPRZaPre+E
        dsfhGV/SQij353qMAOOc2N4=
X-Google-Smtp-Source: AMrXdXsCV5ANuyxeZW/Zwdq8XOMz0xDfDpbDfhFFps8HDaNqi97mFYfkiUW0VJLYVDGa0AMVg2VozA==
X-Received: by 2002:a05:6a21:1646:b0:ad:6305:a4 with SMTP id no6-20020a056a21164600b000ad630500a4mr6267013pzb.48.1674023309298;
        Tue, 17 Jan 2023 22:28:29 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id m9-20020a654c89000000b004a281fb63c3sm18457121pgt.87.2023.01.17.22.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 22:28:28 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 08/19] worktree: fix a trivial leak in prune_worktrees()
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
        <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
        <patch-v4-08.19-1fe25bc6981-20230117T151202Z-avarab@gmail.com>
Date:   Tue, 17 Jan 2023 22:28:28 -0800
In-Reply-To: <patch-v4-08.19-1fe25bc6981-20230117T151202Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 17 Jan
 2023 18:11:13
        +0100")
Message-ID: <xmqqedrs8igj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> We were leaking both the "struct strbuf" in prune_worktrees(), as well
> as the "path" we got from should_prune_worktree(). Since these were
> the only two uses of the "struct string_list" let's change it to a
> "DUP" and push these to it with "string_list_append_nodup()".
> ...
> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index d34d77f8934..ba8d929d189 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -1,6 +1,8 @@
>  #!/bin/sh
>  
>  test_description='git branch display tests'
> +
> +TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-terminal.sh

This is wrong, isn't it?

t3203 uses --points-at, which populates filter.points_at by calling
parse_opt_object_name().  Various members of the ref-filter
structure is never freed (and there is no API helper function in
ref-filter subsystem).

Other tests that use --points-at (e.g. t6302 and t7004) are not
marked with "passes_sanitize_leak", and this one shouldn't be,
either.

With the following squashed in, the branch seems to pass, but I am
not sure which is lessor of the two evils.  From the point of view
of the code maintenance, UNLEAK() to mark this singleton variable is
far cleaner to deal with than selectively running the leak checks
with the "passes_sanitize_leak" mechanism (which always feels like a
losing whack-a-mole hack).

 builtin/branch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git c/builtin/branch.c w/builtin/branch.c
index f63fd45edb..4fe7757670 100644
--- c/builtin/branch.c
+++ w/builtin/branch.c
@@ -742,6 +742,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (filter.abbrev == -1)
 		filter.abbrev = DEFAULT_ABBREV;
 	filter.ignore_case = icase;
+	UNLEAK(filter);
 
 	finalize_colopts(&colopts, -1);
 	if (filter.verbose) {


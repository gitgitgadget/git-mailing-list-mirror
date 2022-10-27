Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E2AFA3740
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 18:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbiJ0Syu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 14:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbiJ0Sys (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 14:54:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CE51A07E
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 11:54:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h4-20020a5b02c4000000b006bc192d672bso2284688ybp.22
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 11:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O9pKFc/kew6uvdQm/SNbTVUPgprqeiKF3NqXraS9MTI=;
        b=fSSqSZLsKmZqAHMYgcafZ0zTP5z7FwDtx+/SYaRLYGtJ9ugdehG2BAwiZeUt38LQ6F
         A+Ptnh5sJd0TiIK4HjMMZLT7YB6o8q7WocFXq/oYK+rua7iE24tDQGK9PAco1pnBsllt
         0YSOMxNgJ8vlq3TTNtOKUQQ187pP7X7IH46Oddq2ytgmx8DM9ePGElo9uCIrs413I80L
         tHFC+GbMBcryEQUsBPA2YRd9oRxS+xjgNWZ73VO7mia/7NG+gL3qamH+sdecPi443Dwl
         UHFGBGXN9GOArjTnfzp/CZBx4oP4sYkdkocnzz18SUj+6Mt+RdgFMYPV9kYqQ7LdPLyB
         YA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O9pKFc/kew6uvdQm/SNbTVUPgprqeiKF3NqXraS9MTI=;
        b=RZAeF9iAwhyI9mXJglCjJZ/vLvEW+y8Rxf0hfKw/Q5w/SxjleCDmpfmKfBloxU+Y3r
         ll87vHukANxX0RTYCSPN76Wlaa9ntIzyP4oPCSATg/LCzifnEc6Bbjs8NXmxK1uKVJ74
         4UbL+JYqaStFFGOxtnxXrrMuCIHJlkc2915vsGLanHjJNs6pz4RMu+vaa/mRCaB60+2m
         m18+/88mH1K8nkf8MzK5w4EfNOzaW1q9tdevCCwjHiV0d3MqVhQyFR+eIsniItpp3NJJ
         Rht/vt29qFIj/lpuDE6kk7WOCYnz5vZZk/sCPTcG834PbhKECScv8i6VX/DjB0JL517H
         0RUA==
X-Gm-Message-State: ACrzQf0hePXs7+1ZzbOV1V4EN/3mrZ7m0UIXajL/yxCd4c0j/LIIM+Ef
        bMsBFCi9eyZAQDRiAN581fuiafL8gkEfEYtJ574y
X-Google-Smtp-Source: AMsMyM7IuGwcCyjm7MFGchYOMbLrwcj8wL1FwOZP//pht5/BSSUrTQDmzgrn/XlIWKN3txcwBZ3OmognrVHEpeKDUO3r
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:1141:b0:6ca:aa68:7729 with
 SMTP id p1-20020a056902114100b006caaa687729mr9586939ybu.26.1666896881072;
 Thu, 27 Oct 2022 11:54:41 -0700 (PDT)
Date:   Thu, 27 Oct 2022 11:54:37 -0700
In-Reply-To: <f88ebbaf17cbf1a0b57336430bd43ade94406f38.1665973401.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221027185437.1842331-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 9/9] archive: add tests for git archive --recurse-submodules
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Heather Lapointe via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        "=?UTF-8?q?Ren=C3=A9=20Scharfe?=" <l.s.r@web.de>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heather Lapointe via GitGitGadget" <gitgitgadget@gmail.com> writes:
> diff --git a/archive.c b/archive.c
> index f81ef741487..b0a3181f7f5 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -179,7 +179,7 @@ static int write_archive_entry(
>  		err = write_entry(repo, args, oid, path.buf, path.len, mode, NULL, 0);
>  		if (err)
>  			return err;
> -		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
> +		return READ_TREE_RECURSIVE;

Should this change be in the previous commit, if this commit is about 
tests? 

> +check_tar() {
> +	tarfile=$1.tar
> +	listfile=$1.lst
> +	dir=$1
> +	dir_with_prefix=$dir/$2
> +
> +	test_expect_success ' extract tar archive' '
> +		(mkdir $dir && cd $dir && "$TAR" xf -) <$tarfile
> +	'
> +}

In the Git test codebase, there is a mix of styles in that some people 
want each test_expect_success block to be individually runnable (I am 
one of them), and to some, that's not as important. But this is 
extremely in the other direction. It would be better if each 
test_expect_success block tests one thing, but inspecting the resulting 
archive should all go into the same test_expect_success block that 
originally created the archive; we should not split each step of 
inspection into its own block. 

Also, I don't think we need to extract the tar to check it; using "tf" 
and inspecting the resulting list with "grep" and "! grep" should do. 


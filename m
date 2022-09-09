Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C66C6FA82
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 14:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiIIOOG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 10:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiIIOOF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 10:14:05 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E2FA99F2
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 07:14:04 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id z18so1341293qts.7
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 07:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=HQiHBxRaIaIMAqXLNMP+E12mHJT2XOObAK8TnHyWSUU=;
        b=FBg2RWO5Jdqfh30gt1CyAF+q6tl8NElyDXAizfiQgrsPzji2lt+ySn40zX2fafluSF
         FKLNJgDdev5JBYAM0rKyQXy1foYtoq3jmJJV8hynVBVuhsppU3Cm/ojOAKJEA4eCiqYp
         jd8hpktj9NfEa9lRRIK8Mbd4Sat1ni+RAl8cUJsisqgUN8ZG1F9vvoPjY1Vz919Cp3Kn
         zmyZl5rimtXP2bOll7yoEgza7NWULxoub+VXXLAm/ILCo27QA8Jh3SU0p6A8PqR4IkHX
         FO/c6RE5q3asydIsed0u/XqxPlPipDolksaKvvzh7rkpLM/RJOp8d0nj+xhYeZdvHVU2
         Jmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HQiHBxRaIaIMAqXLNMP+E12mHJT2XOObAK8TnHyWSUU=;
        b=f4aI+xsZk+4S9j6blXYr9SsM0PapSuPhUjfV0aHnDPyb73jpSx5KVMOZlPIQ3ABunH
         PVttr9M2oDwup0gn0oa3jn7BpQs25ETWrwtIdSbhHuQ7A1tbFlpWlGHFIYpOzCtjCVn2
         PiUtTc6x6/1Wdsx761lvmWkBSql12VwyUxbxl9EcfSbUoMWijmnR+Co+O3nY54yZBTq5
         yoLQdlGXUBNmZbLhCkjb72B10iSuDzhr3bJO5alOTSIrVhjHShLddYyioCbXBlc8Opk+
         wUCi7KukpBDYQINVju33zjTd/ZP1BhV6e1Uf9Be8t2Li5/asYHOXI6Df9o9qcGljBqi1
         PJvQ==
X-Gm-Message-State: ACgBeo1MrpPhLL+y6MTfu8/IseencCN6dyNYcrkLKLGdDgsURzJdp0kY
        Tjh9bZnsAiKhV10W6h/uv8ZL
X-Google-Smtp-Source: AA6agR6pdEFLZfZku8H4mzeQUsKae6D3wHp07oe1mex0vSook1ixlXngQRBkcf/ze5CUKm2Gjn5QDQ==
X-Received: by 2002:ac8:5f4d:0:b0:344:7745:b1ad with SMTP id y13-20020ac85f4d000000b003447745b1admr12839382qta.169.1662732843372;
        Fri, 09 Sep 2022 07:14:03 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id bp11-20020a05622a1b8b00b0031f36cd1958sm479234qtb.81.2022.09.09.07.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 07:14:02 -0700 (PDT)
Message-ID: <3cbfd1b4-7699-1301-042c-fdadea649066@github.com>
Date:   Fri, 9 Sep 2022 10:14:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] builtin/mv.c: fix possible segfault in add_slash()
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org,
        peff@peff.net
Cc:     gitster@pobox.com, vdye@github.com
References: <20220908230223.239970-1-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220908230223.239970-1-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/8/2022 7:02 PM, Shaoxuan Yuan wrote:
> A possible segfault was introduced in c08830de41 (mv: check if
> <destination> is a SKIP_WORKTREE_DIR, 2022-08-09).
> 
> When running t7001 with SANITIZE=address, problem appears when running:
> 
> 	git mv path1/path2/ .
> or
> 	git mv directory ../
> or
> 	any <destination> that makes dest_path[0] an empty string.
> 
> The add_slash() call segfaults when dest_path[0] is an empty string,
> because it was accessing a null value in such case.

It doesn't _always_ seg fault, since we have tests that cover this
case. Adding this change will cause t7001-mv.sh to start failing
in many places:

diff --git a/builtin/mv.c b/builtin/mv.c
index 2d64c1e80fe..8216680ad3c 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -71,6 +71,10 @@ static const char **internal_prefix_pathspec(const char *prefix,
 static const char *add_slash(const char *path)
 {
 	size_t len = strlen(path);
+
+	if (!len)
+		die("segfault?");
+
 	if (path[len - 1] != '/') {
 		char *with_slash = xmalloc(st_add(len, 2));
 		memcpy(with_slash, path, len);

I suppose it is better to say "could segfault". Running the test
under --valgrind also causes a failure. It covers both cases, "."
and "../".

This is all to say that there is some subtlety to the situation, which
helps justify the lack of a new test case (the tests cover this case,
but require extra steps to show a failure).

> Change add_slash() to check the path argument is a non-empty string
> before accessing its value.
> 
> The purpose of add_slash() is adding a slash to the end of a string to
> construct a directory path. And, because adding a slash to an empty
> string is of no use here, and checking the string value without checking
> it is non-empty leads to segfault, we should make sure the length of the
> string is positive to solve both problems.

I agree that the code change is correct.

Thanks,
-Stolee

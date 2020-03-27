Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DD6C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 13:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F54206DB
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 13:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhwqU6fo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgC0NWL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 09:22:11 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45945 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0NWK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 09:22:10 -0400
Received: by mail-qk1-f194.google.com with SMTP id c145so10651771qke.12
        for <git@vger.kernel.org>; Fri, 27 Mar 2020 06:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h+dv3Umvs2OlkMxjnrrRk3BhkFxtpRNS+HqkQ8u08dw=;
        b=nhwqU6fovY0Hwa6xaNGL47pa38/svVKkjy2j821CqKGdGCbWgvZHCVg69kJswJInco
         OV8Ou08HTuuVmKdRrDUpLQZZSEhITWEPmmDiOJMajIlOZlEDwTgTfqaDjm/TL9CmLbM6
         vVFlygTFwsKlBSOYoJalihhWH/C3XCdx0EaUxCkoIl1rRkuWvqvGbYyUSHlXdtp9fCqE
         lk3JyXLic5IiLCjjAW5irSoLAMGidVp+YtFYl2tgx89+za8aHXiT89ET6O1gOuG/JZ5n
         GlkwEnR5tT1r4DOF1pU2uvw/oXHAhiyLXGih2Bo2STJUbOBsNNwF7LvqqMe5SS2UTBrw
         8++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h+dv3Umvs2OlkMxjnrrRk3BhkFxtpRNS+HqkQ8u08dw=;
        b=oX4d/ydNMwnWFYmBKH2rWP/9UhrO+ThDe44XMuHgsQLrFLTfwsVjurZBAhULS4ZLlm
         4zUr+0/rv15hreYZKHeiIPyYGk5khvc/qst1n4EsT9QYwzjE2JNyaSrle1c/nDsEHqon
         sEXo/Pe4xaZcCVVIf8TwQTHwTtYzdUlg78vK/tvf3Ek/jqvBYMs6MlARK2ZSpr/LpR6c
         qOC+Af0apERIIVPMT/z+/c6+sXwCESHdvmHl+5pAFJEFsYi4B6d3HaiKIU75Jb9OtvmO
         uFQQcJtsDgmbM3r4yhGda/l20ZA0vkCmv1MaLrivGjUkK7Lp4WOXN7jBK7ePWdsRhyAp
         jXag==
X-Gm-Message-State: ANhLgQ37drSsPP5LkMPluVZfhC6IcK8woVCZnHrT16Ai+o+tfQYOM0uX
        RG+oREJowdvFi+S895ZT14ywj2fJfmM=
X-Google-Smtp-Source: ADFU+vvSLYI2qr2kecUdrnux5Lk9oZthogp+3utGQv5e7M/JNhWhPrlLKNStFrWfXmJY4mTRvkiA5A==
X-Received: by 2002:a37:9f58:: with SMTP id i85mr13411959qke.196.1585315329783;
        Fri, 27 Mar 2020 06:22:09 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id x89sm3782361qtd.43.2020.03.27.06.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 06:22:09 -0700 (PDT)
Subject: Re: [PATCH v3 00/18] Sparse checkout improvements -- improved
 sparsity updating
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
 <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9f33833a-43e3-8878-859d-1c116a54de97@gmail.com>
Date:   Fri, 27 Mar 2020 09:22:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/26/2020 8:48 PM, Elijah Newren via GitGitGadget wrote:
> This series provides a replacement for the sparsity updating in
> sparse-checkout that is based on the logic from git read-tree -mu HEAD. The
> most important bit is patch 9 and its lengthy commit message explaining the
> current state and rationale for most the series, though patches 16 and 17
> have additional related directions and rationale for the series. Those three
> patches are the most important to review.
> 
> Changes since v2:
> 
>  * addressed Stolee's cleanups and added his Reviewed-by to the series
>    (hopefully the next two changes don't invalidate that)

The other changes below look good to me. My Reviewed-by stands.

>  * added a test for the new 'reapply' subcommand (noticed it was missing
>    with Stolee's test coverage report)
>  * fix a minor issue with two of the other tests I modified -- when I'm
>    grepping through stderr for a command, I need to make sure to actually
>    record stderr from that command (otherwise my grep is looking through the
>    stderr of a previous command that was recorded). Also, since I messed
>    this up, I added one or two more sanity checks while I was at it.
Thanks!

-Stolee

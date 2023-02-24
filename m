Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11F6C7EE23
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 17:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjBXRvv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 12:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBXRvu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 12:51:50 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED671FE6
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 09:51:49 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id bm20so16023468oib.7
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 09:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J+cc0kw/F9okQcIaB4TBOEZMclg/VcUBHH8ghrqmNiQ=;
        b=Ng5p2vWOyoQOiRmvibr2ZFd7Xe+NKvmETGzmvkK8pBDqdlaZ5CiITEfoHpPJtE04Ye
         ksaQqiujOqvAltbF/aRO4EPEeVMv1CfIqDT4739V1+e+L+7r/CYyzifQ9Dh7q0+75Asq
         IamFlFZUPPqq02J74DMBVTDbIruOY+yr6lAFU5l0+gUmD8AXgYZaUxOVmbHhJU7SWKsg
         VJWYymZRk0VuNh1mkRl59HvD6UiTt1U5wmL+LlENhmunktIAVQtMz/5+XrOhDmPYA96x
         A3I1ii6E+hca/bAjCLhcfededCdmYWeQP4y0igtitFTmHdKOJQEAFnlIQSgNU2tYEvWs
         SKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J+cc0kw/F9okQcIaB4TBOEZMclg/VcUBHH8ghrqmNiQ=;
        b=Iq64YUwuJc0uDNIdZ4iRt8BzvlTnwH1EjCFsObwPuj2VGy//PBGAwEAxy6eVWmcaoC
         /dsEBTEuzSRxMeX5h8M1YH5wE8YQg3vHIeUcdeFMTtoJWuXSb1qEWC80YZ6DgGZLZCVD
         FfPnHayDwsj9SSpaiQ45r806vHTb+HulniiKrKyS/oLVDeiiCQk6iaZ1+BBhGb56Rh2T
         IvdO8FDYzE6PUKiidVI2pbKU6DngoLr7zJuIdhvm7tMHOmUx68c+WmsbpA7kx8f5kUL/
         4/Ox6SQ6jInsksGHNnb2ypawiAWbIO+Zf/TvYqmofqMcBhtdl+JcWwIhmcL8uk2aWFVC
         qbDQ==
X-Gm-Message-State: AO0yUKVGQV0wcSLwGnho1oiTqCsmZUUuhXlIBQBygHVmbf7+FKg4gaJr
        /uCzOXsIhOquj3/z4q971gv3uAK9QpT2FqxDjkg=
X-Google-Smtp-Source: AK7set+y2ZfDh69HeS7rZzdoOWE0jpAJAhGOytYrBSGg72GsZgnLvXYZxF3NLPx8DBgSgZw6EqHN+7cwNlhCMCmqgOY=
X-Received: by 2002:a05:6808:2a03:b0:36e:f6f5:5cf2 with SMTP id
 ez3-20020a0568082a0300b0036ef6f55cf2mr1055698oib.5.1677261109104; Fri, 24 Feb
 2023 09:51:49 -0800 (PST)
MIME-Version: 1.0
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
 <20230223053410.644503-3-alexhenrie24@gmail.com> <7ba8a92d-8c94-5226-5416-6ed3a8e2e389@dunelm.org.uk>
In-Reply-To: <7ba8a92d-8c94-5226-5416-6ed3a8e2e389@dunelm.org.uk>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Fri, 24 Feb 2023 10:51:37 -0700
Message-ID: <CAMMLpeQ98BTCGE2tcVdZ99eU6cLh4Rd_hc8C_PmKvsBkjXUWPw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] rebase: add a config option for --rebase-merges
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2023 at 7:55 AM Phillip Wood <phillip.wood123@gmail.com> wrote:

> Thanks for updating this, it is much clearer what the different settings
> mean now.

Happy to help. Thanks for the feedback.

> I not sure if having the config setting override the default
> when the user passes --rebase-merges without an argument is a good idea.

> I think this behavior is confusing for users and will break scripts that
> quite reasonably assume --rebase-merges is equivalent to
> --rebase-merges=no-rebase-cousins

In that case, we're going to need two config options: A rebase.merges
boolean for whether --rebase-merges should be on by default and a
rebase.cousins boolean for whether rebase-cousins or no-rebase-cousins
is the default.

I will try to incorporate that change and the others that you and
Johannes suggested in v5.

-Alex

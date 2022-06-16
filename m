Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B97C43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 20:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiFPUnj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 16:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiFPUni (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 16:43:38 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5CE5B8AA
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 13:43:36 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id o43so3826543qvo.4
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 13:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VDEWXdQEy7mBkD/0v5FAlkDjAAjCaEM0Z4mR2CEG5kI=;
        b=N6T6NyaUFRvJArGdMuOaQZmYmx88IRzAuIYJpK4d8mac2LMF0oSjT5cPf046CaRdtQ
         D1D5TeD/v/+z2Wr5mwmkWyEMCYwO2mpkcC6qU3iEx904ynST11SFC1uyW0ob1L5VH9T2
         zPOMwCurvEt/3ga7Uwww5Ys96BXLapAZybeSIautepW0Aq9gfJlGV0q9UcmAAA+bAfcN
         gsgn/2yZD7imIyAjsEui0HaTH9cWmb7OpWREz1lC+dkoA5kcLH+vz9KDl7exaTMUg52g
         nF1oh9qOTcRe74OI8Lh7W5SMd+RpLs+tvGJdcrbyRSOgaaxZO/w0TK1e5yQGYqinHrdS
         eXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VDEWXdQEy7mBkD/0v5FAlkDjAAjCaEM0Z4mR2CEG5kI=;
        b=Az83vNiJo+Al4qvKxwGGUKIFAPcrW4HEcjtopKOg5Yj6mzNZ0vJDat48YhuqHaa3J5
         30VUjvKK9mbmjtZIt2xeNlFTcHOHIkbTUjb1PcFI3xN+nFhDXNkAX87v7kSTkQWrq0/Y
         EGiwBf7dzyaeBsdkNtbsGCiXXrdGyudiVyiBo6iimlEp1Wa1zOIAAD1/7j06OBUu49NX
         PMyS7F80ShXaAD0rY9zRmKeQ2iTvbEYULbUywwlLxYTRL2kgdpZir2urLvw5za9QnVZ0
         0osoUNAHfEscdFkcgygAfMeDgiT1KbVo4zH0wC0SCFACT9YvyFIGhb/cCV/MyT4hQE1R
         0tcg==
X-Gm-Message-State: AJIora+6SBtaWFVjfSudYZwF0GNjrIX7Sr2jhfaIIf2LA4QIVTF/HLBD
        1Mbf9eszcfSBEa+Mr262cfzDIRbNj+VH0F3G
X-Google-Smtp-Source: AGRyM1ul4mhb5t/P4pvpNYAGAZw7hGFTd8wBYVQVQuoSwqsKEE6Hl+q/GqmWwcLeGJ+Tom+D/YNVBg==
X-Received: by 2002:ac8:58c2:0:b0:305:2ef6:3d68 with SMTP id u2-20020ac858c2000000b003052ef63d68mr5731598qta.381.1655412215724;
        Thu, 16 Jun 2022 13:43:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f19-20020ac859d3000000b002f936bae288sm2611787qtf.87.2022.06.16.13.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:43:34 -0700 (PDT)
Date:   Thu, 16 Jun 2022 16:43:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 09/11] pack-mtimes: avoid closing a bogus file descriptor
Message-ID: <YquV9oYaAPeiJec1@nand.local>
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
 <b176e5764f990fbf8c132ae1563027531bd8cc9f.1655336146.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b176e5764f990fbf8c132ae1563027531bd8cc9f.1655336146.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 15, 2022 at 11:35:43PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In 94cd775a6c52 (pack-mtimes: support reading .mtimes files,
> 2022-05-20), code was added to close the file descriptor corresponding
> to the mtimes file.
>
> However, it is possible that opening that file failed, in which case we
> are closing a file descriptor with the value `-1`. Let's guard that
> `close()` call.

Nice catch. I agree with your assessment and fix. Thanks for spotting
and fixing!

Thanks,
Taylor

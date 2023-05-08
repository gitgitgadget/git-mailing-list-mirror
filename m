Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D85C77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 15:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbjEHPHw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 11:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjEHPHv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 11:07:51 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD06C0
        for <git@vger.kernel.org>; Mon,  8 May 2023 08:07:50 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3ef35d44612so51482081cf.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 08:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683558469; x=1686150469;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lpf41MvWU2ZzsjJRdOfPUugsy26V4KX8OGQ8jsVSPIo=;
        b=eFQpLHwo4a/T2jqY9ctQqnbPKDX31lny1Pv2+lycaBhpXkCBsHq9bLmb8nW+M5Z326
         UC1TzPBxIv6PlAdXaA0JJhAAK+UZCErM9ezpXXSdNxLfj+mzAier8oji229qUe9S+nll
         HzyMlC0urJFhyF5UZKOMN//KlOE3M9yEMoCGmP/9hzduGoGKTgcFWTAhq80eOk7RGFLG
         gTHwcWpFnt6nup2Faeffeo7A9jqUp5+dp5zg2aZqiiOYogNuDLykeGQ32htKwXAPYsYK
         7GK7UQizzYadzyEYgcCLvauTewTptO+d49gIkrOxd4JLp+CO9hQprE+hOJedQa3eU9zk
         ZQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683558469; x=1686150469;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpf41MvWU2ZzsjJRdOfPUugsy26V4KX8OGQ8jsVSPIo=;
        b=QLoMbk4m0hICBB5Z9MvFoOqz5XTQF6Ko6rvqOA4CRjxmOx64ErqK5HzY8Gf3dmxNO+
         IOz5JePILr5vrvAQ6tAXEqStlBJ9IVFjpYrptTmJrYvCnTdUiUgE4BTOUhOzTWP7CUaW
         EfXOi8Xrz29Y1X5YaYYKkxuIeBH+6XbQQFlmGJOPgk4oPFcS0IfVjc+TTTKf8ZCdzD/G
         9Z1L3goNU1pxuEyS2i3BEM8mgLeT1uLxuGNDnvZGVhdsJLtrKSn2FRihn7UOguvgrIjA
         d/7lehV7CCZmJebqX364vTC3yWpP4VLWGqiVlN7T4AsFXNFTt5LenbnRhxlYj3Z8MAMW
         xWQQ==
X-Gm-Message-State: AC+VfDy28ejsxUYPuX+VKKNpWkf2gzpAnMgaA8hba+s6lXnhVhLIRUuz
        EgtzeKmJrXrl96B1AsGTWEQ=
X-Google-Smtp-Source: ACHHUZ4N7lDT6m0IXG9RZKLCK7kGrpdN1J1ZuBuverHk1OjEiICvvf8rY54muiLO10RNOAEUn2h5jA==
X-Received: by 2002:ac8:5810:0:b0:3ef:3880:9db6 with SMTP id g16-20020ac85810000000b003ef38809db6mr15770609qtg.6.1683558469514;
        Mon, 08 May 2023 08:07:49 -0700 (PDT)
Received: from hurd (dsl-10-131-119.b2b2c.ca. [72.10.131.119])
        by smtp.gmail.com with ESMTPSA id b7-20020ac801c7000000b003f364778b2bsm3050181qtg.4.2023.05.08.08.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 08:07:49 -0700 (PDT)
From:   Maxim Cournoyer <maxim.cournoyer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 0/3] send-email: add --header-cmd option
References: <xmqqcz3s3oz7.fsf@gitster.g>
        <20230501143848.19674-1-maxim.cournoyer@gmail.com>
Date:   Mon, 08 May 2023 11:07:48 -0400
In-Reply-To: <20230501143848.19674-1-maxim.cournoyer@gmail.com> (Maxim
        Cournoyer's message of "Mon, 1 May 2023 10:38:45 -0400")
Message-ID: <87r0rqvp2z.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Just checking if everything is OK with this submission?  If not, let me
know.

Thanks you,

-- 
Maxim

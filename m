Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FADBC433EF
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 20:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11E0E610A1
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 20:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbhICUeS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 16:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350334AbhICUeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 16:34:09 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F63C061575
        for <git@vger.kernel.org>; Fri,  3 Sep 2021 13:33:09 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r7so545607edd.6
        for <git@vger.kernel.org>; Fri, 03 Sep 2021 13:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :references:to;
        bh=DS5wPTXTqlpKRl7n5xvx8HLjIsf3zMA2EroW/+xXSdg=;
        b=KPnt2x2DiohlKb1AiakGDIP/O/bLw8LVxJc+Cy2bbHlLY/WK0ETJTxOSVHe+Pk5or9
         u1IVPgicnfq0ZYMH5xjeMdEKTCh+l2DOH39+WhADtrzeeSYglMhqjL8aVXus9mXa989f
         g8OQTOlsSUO7ODZTZqROoY1vCRP7BWHqolrSEQSUNyNDtoPJcKkB9RMwlBzGPgKl/Wz8
         n40czeN0H/IWLbqFeWyepUd/mGeIeyX2QMp1yH4Op24WkK1BAEyRCt+q9DOhBq2D2/TN
         CZ3+Z5xjmKU3x1hhLK2hzoIz2axRffUN7Rv2bNyuqIg15mccysd/DjGgT3gk0pJD7XnU
         EfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:references:to;
        bh=DS5wPTXTqlpKRl7n5xvx8HLjIsf3zMA2EroW/+xXSdg=;
        b=U9oR3SMAWuPnR+0+3sd+uJaHe/vJ2wnOZjsdjv8W3dQlzWkIXMAuQr4YqKQ95F/PzL
         GX2JYtYpLlOKyToiukYB7PtYL4U0P4pmuz8SCgB2uksgo+1LWce4KjdWrvGIkQNZLugj
         eqgS3WM1vE6j3hoacrn1W1mNm9SmBZCfUHVb9RfHHX1B0DQ5vzGsAV+S8MSfeY3w8K7j
         YQhq6mYGZpA+z3FBiwsYgAw6yLJStESqvtjIv83ZA6AgnyY7N7SLTzyKjWlo+gPEtXBN
         z/+UztdwF53OCHNFSu84tX2D4bqPZSbl+YSTdyK//X7i9fuLPdrqmHeU0UkLWau1mecq
         42+Q==
X-Gm-Message-State: AOAM531KqEBOP9bkSAyiYvEV9CdEud4vPikIm5c6hDs1zi+mFAoNQ+Pn
        SDo8BChE13hobB6g7x02ce3TrAURJHg=
X-Google-Smtp-Source: ABdhPJxR1/eRDN6TYNKKLO4Ugupm63Tfr//08TT14A2qXFkgKnYTvH+jEXRkzgG9Rh318GD0+yF9cw==
X-Received: by 2002:a05:6402:2210:: with SMTP id cq16mr799830edb.348.1630701187439;
        Fri, 03 Sep 2021 13:33:07 -0700 (PDT)
Received: from smtpclient.apple (ptr-gqroyxa5yqi39c76rx5.18120a2.ip6.access.telenet.be. [2a02:1812:2e06:8300:2922:40fc:61e4:39d9])
        by smtp.gmail.com with ESMTPSA id l23sm196778eds.29.2021.09.03.13.33.06
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 13:33:07 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Fedor Biryukov <fedor.birjukov@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Fri, 3 Sep 2021 22:33:06 +0200
Subject: Aborting 'rebase main feat' removes unversioned files
Message-Id: <C357A648-8B13-45C3-9388-C0C7F7D40DAE@gmail.com>
References: <CAG2t84Uaw-Kdp+EXU8CY1QYfykFQj-hGLJnTSH8MYO8Vi_yqgA@mail.gmail.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (18G82)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looks like a bug in git rebase main feat.

To reproduce:
git init
git commit -m 'init' --allow-empty
git checkout -b feat
echo 123 > readme.txt
git add readme.txt
git commit -m 'txt=3D123'
git checkout main
echo 012 > readme.txt
git rebase main feat
git rebase --abort

Expected result:
readme.txt contains 012

Actual result:
readme.txt contains 123

According to the docs, git rebase main feat is a shorthand for git checkout f=
eat followed by git rebase main. I have checked that doing checkout and reba=
se separately instead of using the shorthand does not have the same issue.

Cheers!

Fedor

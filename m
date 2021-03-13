Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A17C433DB
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 08:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E23E64EF6
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 08:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhCMIgn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 03:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhCMIgX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 03:36:23 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABFBC061574
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 00:36:23 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id w7so9513045pll.8
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 00:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gKMdSGptyeu1POggUGNuOzTA6YVb+mjNQ+fQ+lxjPY0=;
        b=lldxoas+Bsu92w1/T5AIcCxiwhA3w4PxJH7Y+O7EtMmmHQSnZ/yHvOjsNeWBQhU3UM
         NGfFDJJ+mWt4zTmr358PTVj0xFuCndDohGc6rneaG/Vho7vmksQdyGFewFStS8WQptzN
         4qC7NsdJkOu4vE3TiD9i4bV8Jy/sg41xM708Ej1fKHFCHkNy6XOV1dl8jsEvf7xK00ql
         xUkdCY860EzveyS02QvDcflH56IW/xDRhAK2Kvsv2eIxyHIUNcobaYz9Q39+2RXnCOZ7
         JUA9Mg0wXqmpqZPkA7C/g3H+4cJsIEVeAz0jdBMFrMTWgG1Xsy3ocXjClmI99wg+rZqA
         58GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gKMdSGptyeu1POggUGNuOzTA6YVb+mjNQ+fQ+lxjPY0=;
        b=St6FOan6DkutpulI9C+TTazCIGMMb01Pzn1uBdIKg2ZrM5gQhyFH5jeZUlNKd3CMd2
         Unv3HPGKH9+eMjsPVkuVKYbxRVqGIVuglx8GHR77439vgDbEZk8qAxj2mbYgOwMUimBN
         OZB/jsWuq0r4xS6QqTHmMV+dWfggP5oPGMMCoLOYDGpbM95xWkJB7H1jl6rKXvl/dEHv
         cKQt571Jmam2Yc5+fgcN8smtpGeX8FOsA9URs2U1pnXbJW/P/jxj+IDkWF6PlozST1og
         uN7nTSBXZlQiui32zdO0+WL4z7B7Fx5xsQcs8vdQ6dG3QNmDcBX/yI5MrHcg/K5Xyg82
         R+Cg==
X-Gm-Message-State: AOAM531vvoAv1tqAGmVJkq8ZZkTHmXPO2X96CWK7c4M7aYgPM+Ul5Js7
        1jQYlXKXIwBLyLRks352GMY=
X-Google-Smtp-Source: ABdhPJzSfEoiqMw+GeSBII/kiK6Ibg4eFTxD4oZOLEFizzyiJYDZfNSYZoscw64hIft1w9//1JhP+A==
X-Received: by 2002:a17:90a:458b:: with SMTP id v11mr2471289pjg.189.1615624583056;
        Sat, 13 Mar 2021 00:36:23 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:a1e7:6707:cbf6:696d])
        by smtp.gmail.com with ESMTPSA id i7sm7801201pfq.184.2021.03.13.00.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 00:36:22 -0800 (PST)
Date:   Sat, 13 Mar 2021 00:36:20 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Seth House <seth@eseth.com>,
        Dana Dahlstrom <dahlstrom@google.com>
Subject: [PATCH v2 0/2] mergetool: do not enable hideResolved by default
Message-ID: <YEx5hM/HWby3FBJv@google.com>
References: <20210130054655.48237-1-seth@eseth.com>
 <20210209200712.156540-1-seth@eseth.com>
 <20210209200712.156540-2-seth@eseth.com>
 <YEbdj27CmjNKSWf4@google.com>
 <xmqqmtvbjuvl.fsf@gitster.g>
 <xmqqzgzafo5o.fsf@gitster.g>
 <xmqqlfas55mk.fsf@gitster.g>
 <YEv5d0pGvEVpepoY@google.com>
 <xmqqh7lg54h4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh7lg54h4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>                       I should be able to send out an improved log
>> message (more concise and summarizing the supporting info from this
>> thread) later this afternoon.
>
> Thanks.  I think this is the last known regression in the -rc, and
> an update before the final happens on coming Monday is very much
> appreciated.

A little late, but here it is.  Thoughts of all kinds welcome, as
always.

Jonathan Nieder (2):
  mergetool: do not enable hideResolved by default
  doc: describe mergetool configuration in git-mergetool page

 Documentation/config/mergetool.txt | 2 +-
 Documentation/git-mergetool.txt    | 4 ++++
 git-mergetool.sh                   | 9 ++-------
 3 files changed, 7 insertions(+), 8 deletions(-)
